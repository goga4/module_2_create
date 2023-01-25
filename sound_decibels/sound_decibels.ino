//Code by Team11: EyeHear
//This code measures the decibels picked up by the microphone, if it's above
//the assigned value we send the triangulation coordinates to the
//Processing heatmap

#include <SoftwareSerial.h>
#include <math.h>
#include <WiFi.h>
#define sensor_pin A0
const int sampleWindow = 50;  //sample window [ms] (50ms = 20Hz)
unsigned int sample;
unsigned long iP;       //treshold microphone [dB]
unsigned long cAir;     //velocity of sound in the air [m/s]
const int temp = 15;    //we take an average for the temperature [*C]
unsigned int timeKept;  //How log should the devices keep the sound [s]
unsigned long d;        //distance between microphone and the sound source [m]
const char* ssid = "iPhone van Tim";
const char* password = "123456789";
bool sound_detected = false;
int j = 0;
double Values[81] = { 0, 0, 2.3442288, 2.5, 4.33, 3.3496544, 5, 0, 3.1260794,
                      0, 0, 2.9174270, 2.5, 4.33, 3.0902954, 5, 0, 2.8510183,
                      0, 0, 2.8840315, 2.5, 4.33, 3.4673685, 5, 0, 3.2734069,
                      0, 0, 14.4543977, 10, 17.32, 15.3108746, 20, 0, 9.2257143,
                      0, 0, 16.4058977, 10, 17.32, 12.7350308, 20, 0, 12.4451461,
                      0, 0, 17.9887092, 10, 17.32, 13.3352143, 20, 0, 10.5925373,
                      0, 0, 31.2607937, 15, 25.98, 33.4965439, 30, 0, 17.3780083,
                      0, 0, 14.4543977, 15, 25.98, 9.3325430, 30, 0, 11.4815362,
                      0, 0, 29.5120923, 15, 25.98, 14.6217717, 30, 0, 13.1825674 };
WiFiClient client;

void sendEmail(boolean detected) {
  //Connecting the Arduino to the network
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to the network...");
  }
  client.connect("https://maker.ifttt.com/trigger/sound_detected/json/with/key/jcw2KHEmYZMSVHD1ZLaeyPFowfVIuYn6wSgXA7vDX_-", 80);  //sent email (port 80)
  delay(1000);                                                                                                                     //delay for 1 second
  client.stop();                                                                                                                   //close connection
  delay(1000);
  sound_detected = false;
}

int FindCircleCircleIntersections(
  float xA, float yA, float rA,    //slave
  float xB, float yB, float rB,    //slave
  float xC, float yC, float rC) {  //master

  float dx = xA - xB;                                               //distance between x-coordinate of A and x-coordiante of B
  float dy = yA - yB;                                               //distance between y-coordinate of A and y-coordiante of B
  double distAB = sqrt(dx * dx + dy * dy);                          //distance between A and B
  double a = (rA * rA - rB * rB + distAB * distAB) / (2 * distAB);  //distance between A and point P2
  double h = sqrt(abs(pow(rA, 2) - pow(a, 2)));                     //distance between point D/E and point 2


  //Find P2 (lays on line between A and B)
  double cx2 = xA + a * (xB - xA) / distAB;
  double cy2 = yA + a * (yB - yA) / distAB;

  //Get the points D and E (intersecting points between circles of the slaves)
  float xD = (cx2 + h * (yB - yA) / distAB);
  float yD = (cy2 - h * (xB - xA) / distAB);
  float xE = (cx2 - h * (yB - yA) / distAB);
  float yE = (cy2 + h * (xB - xA) / distAB);

  //Calculate which point is the point that all three circles intersect with
  double distCD = sqrt(pow((xC - xD), 2) + pow((yC - yD), 2));
  double distCE = sqrt(pow((xC - xE), 2) + pow((yC - yE), 2));

  //Calculating the difference between the original radius C and the measured distance CD/CE
  double subCDrC = distCD - rC;
  double subCErC = distCE - rC;

  //The distance CD/CE is supposed to be equal to radius C, however, because of error-margin it is not completely the same.
  //The one closed to the value is the actual radius.
  if (subCErC > subCDrC) {
    Serial.print("X ");
    Serial.println(xD, 7);  //up to 7 decimals
    Serial.print("Y ");
    Serial.println(yD, 7);
    Serial.println(".");
  }
  if (subCDrC > subCErC) {
    Serial.print("X ");
    Serial.println(xE, 7);
    Serial.print("Y ");
    Serial.println(yE, 7);
    Serial.println(".");
  }
}

void setup() {
  pinMode(sensor_pin, INPUT);  //Set the signal pin as input
  Serial.begin(9600);          //baudrate 9600
}

void loop() {
  unsigned long startMillis = millis();  //Start of sample window
  float peakToPeak = 0;                  //Peak to peak level
  unsigned int signalMax = 0;
  unsigned int signalMin = 1023;

  while (millis() - startMillis < sampleWindow) {  //We measure the sound every 50ms
    sample = analogRead(sensor_pin);
    if (sample < 1024) {
      if (sample > signalMax) {
        signalMax = sample;
      } else if (sample < signalMin) {
        signalMin = sample;
      }
    }
  }

  peakToPeak = signalMax - signalMin;  //max-min = peak-peak amplitude
  int db = map(peakToPeak, 20, 1023, 49.5, 160);
  cAir = 331.3 + 0.606 * temp;
  d = pow(2, (1 / 6 * ((peakToPeak / 2) - iP)));
  iP = (peakToPeak / 6.5) - 6 * (log(d) / log(2));
  timeKept = d / cAir;
  
  if (db >= 100) {
    sound_detected = true;
    //sendEmail(sound_detected);
    for (int i = j; i < sizeof(Values); i++) {
      FindCircleCircleIntersections(Values[i], Values[i + 1], Values[i + 2],
                                    Values[i + 3], Values[i + 4], Values[i + 5],
                                    Values[i + 6], Values[i + 7], Values[i + 8]);
      delay(1000);
      j = j + 9;
      break;
    }
    delay(500);
  }
}