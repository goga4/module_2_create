//map source: Google Maps


//400 pixels == 100m

//Add library controlP5
//Change distanceAC to the correct amount of meters between boxA and boxC
//To use, change the directory for the screenshots to a valid path

import processing.serial.*;
Serial port;

PImage map;
PFont font;
PFont schaallijn;
float x;
float y;
float xh;
String xValueString;
String yValueString;
int xValue;
int yValue;
int count = 1;
int savedTime;
float totalTime = 10000;
int distanceAC;
IntList xValues;
IntList yValues;


void setup() {

  size(800, 800);
  font = createFont("arial", 20);
  schaallijn = createFont("arial", 25);
  textAlign(CENTER);
  colorMode(RGB, 255, 255, 255);
  map = loadImage("map600x600.png");


  //arduino connection
  for (int i = 0; i < Serial.list().length; i++) {
    print("[" + i + "]");
    println(Serial.list()[i]);
  }
  port = new Serial(this, Serial.list()[4], 9600);
  port.bufferUntil('.');

  //IntList can hold all of the given x and y values given by the arduino, without having to define the lenght first
  xValues = new IntList();
  yValues = new IntList();

  //Input the distance in meters from box A to box B here
  distanceAC = 100;

  x = distanceAC * 4;
  xh = x / 2;
  y = sqrt(pow(x, 2) - pow(xh, 2));
  savedTime = millis();

  //Setup background + Boxes
  background(0);
  image(map, 200, 0);
  filter(GRAY);

  //Schaallijn
  strokeWeight(2);
  stroke(255);
  line(340, 535, 740, 535);
  fill(255);
  textFont(schaallijn);
  text("100m", 540, 565);

  //Boxes
  stroke(0);
  strokeWeight(1);
  fill(255, 0, 0);

  //Box A
  circle(340, 470, 10);

  //Box B
  circle(340 + (0.5 * x), 470-y, 10);

  //Box C
  circle(340+x, 470, 10);

  //Text boxes
  textFont(font);
  fill(255);
  text("BoxA", 340, 495);
  text("BoxB", 540, 495 - y);
  text("BoxC", 340 + x, 495);
}

void draw() {

  //Translate meters to pixels
  xValue = 4 * int(xValueString);
  yValue = 4 * int(yValueString);

  //draw circle to location specified in textField
  if (xValueString != " " && yValueString != " ") {

    //Add the new input x and y values to the IntLists
    xValues.append(xValue);
    yValues.append(yValue);

    //Empty the input strings after they have been converted to an integer, and have been added
    //to the IntLists
    xValueString = " ";
    yValueString = " ";
    println("X-value = " + xValue / 4 + "m --> 0m");
    println("Y-value = " + yValue / 4 + "m --> 0m");
  }

  //Draw the circles with different color and size values.
  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(200, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 50);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(190, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 48);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(180, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 46);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(170, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 44);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(160, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 42);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(150, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 40);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(140, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 38);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(130, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 36);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(120, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 34);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(110, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 32);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(100, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 30);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(90, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 28);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(80, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 26);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(70, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 24);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(60, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 22);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(50, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 20);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(40, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 18);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(30, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 16);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(20, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 14);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(10, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 12);
  }

  for ( int i = 0; i < xValues.size(); i++) {
    colorMode(HSB, 360, 100, 100, 255);
    noStroke();
    fill(0, 100, 100, 255);
    circle(340 + xValues.get(i), 470 - yValues.get(i), 10);
  }


  //Update passed time to match a certain interval
  int passedTime = millis() - savedTime;

  //Capture a .jpg image from the canvas every time interval in millis
  if (passedTime > totalTime) {
    PImage screenshot = get(200, 0, 600, 600);
    screenshot.save("C:/Users/timha/Desktop/Eyehear/geoHeatmapCP5/data/liveImage/livePicture.jpg");
    screenshot.save("C:/Users/timha/Desktop/EyeHear/geoHeatmapCP5/data/historicData/historicPicture_" + count + ".jpg");
    println("The canvas has been saved at " + day() + "-" + month() + "-" + year() + ", at " + hour() + ":" + minute() + ":" + second());
    count++;
    savedTime = millis();
  }
}


//Triggers when reset button is clicked
void Reset() {

  //Empty the IntLists for the x- and y-values
  xValues.clear();
  yValues.clear();

  //Re-draw canvas over created coordinates
  //Draw background + Boxes
  colorMode(RGB, 255, 255, 255);
  background(0);
  image(map, 200, 0);
  filter(GRAY);

  //Schaallijn
  strokeWeight(2);
  stroke(255);
  line(340, 535, 740, 535);
  fill(255);
  textFont(schaallijn);
  text("100m", 540, 565);

  //Boxes
  stroke(0);
  strokeWeight(1);
  fill(255, 0, 0);

  //Box A
  circle(340, 470, 10);

  //Box B
  circle(340 + (0.5 * x), 470-y, 10);

  //Box C
  circle(340+x, 470, 10);

  //Text boxes
  textFont(font);
  fill(255);
  text("BoxA", 340, 495);
  text("BoxB", 540, 495 - y);
  text("BoxC", 340 + x, 495);

  println("The Canvas has been reset");
}

void serialEvent(Serial p) {
  String inString = p.readString();
  inString = inString.substring(0, inString.indexOf("."));
  String pairs[] = split(inString, '\n');
  for (int i = 0; i < pairs.length; i++) {
    String positions[] = split(pairs[i], ' ');
    if (positions.length == 2) {
      String header = trim (positions[0]);
      String value = trim (positions[1]);
      if (header.equals("X")) {
        xValueString = value;
      }
      if (header.equals("Y")) {
        yValueString = value;
      }
    }
  }
}
