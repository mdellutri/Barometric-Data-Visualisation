//Mason Dellutri
// CPSC 313 Assignment 2

//Sources: https://www.youtube.com/watch?v=woaR-
//         https://www.statisticshowto.datasciencecentral.com/normalized/
//         https://forum.processing.org/two/discussion/23814/limiting-floating-numbers-to-2-decimal-places

  //changing this number will give you the apparent temperature high 
  //for that each day in that month
  // ex. 1 = January, 2 = February, 12 = December...
  int monthSelected = 8;
  //changing this string value to the same variable name as one of the float values below
  //will allow you to choose the data being displayed 
  // ex. "temperatureHigh", "cloudCover", "humidity"...
  String dataToView = "temperatureHigh";

   Table weatherTable;
   int y;
   int m;
   int d;
   float apparentTemperatureHigh;
   float apparentTemperatureLow;
   float cloudCover;
   float dewPoint;
   float humidity;
   float precipAccumulation;
   float temperatureHigh;
   float temperatureLow;
   float windGust;
   float windSpeed;
   float positionChange = 10;
   float position = 0;
  
void setup() {
  
  //sets size and background color
   size(600,300);
   background(190,190,200);
  
  //load data file with a header
   weatherTable = loadTable("hw2.csv", "header");
   
   //initialize useful variables
   int count = 0;
   float highestValue = 0;
   float lowestValue = 0;
   float[] highArray = new float[31];
   
   float averageHelper = 0;
   float average = 0;
   //creates an array of values of the selected data for the selected month
   for (TableRow row : weatherTable.findRows("" + monthSelected, "m")) {
     m = row.getInt("m");
     highArray[count] = row.getFloat(""+dataToView);
     averageHelper += highArray[count];
     count++;
   }
   
   average = averageHelper/count;
   println(average);
   
   //initializes the highest and lowest values to datapoints in the set
       highestValue = highArray[0];
       lowestValue = highArray[0];

  //compares the data to the rest of the set to find 
  //the overall highest and lowest values
   for (TableRow row : weatherTable.rows()) {
     float current = row.getFloat(""+dataToView);
   if ( highestValue < current) {
      highestValue =  current;
     }
   if ( lowestValue > current) {
      lowestValue =  current;
     }
   }

   //scales the width of the bars to the closest distance
   float scaling = (width*1.0)/(count*1.0);
   positionChange = scaling;
   for (int i = 0; i<count; i++) {
     //this fun equation normalizes the height of the bars to the rest of the year
     float normalized = (highArray[i] - lowestValue)/(highestValue - lowestValue);
      rect(position, height-(height*normalized), scaling, height*normalized);
       position += positionChange;
   }
   float averageNormalized = (average - lowestValue)/(highestValue - lowestValue);
   stroke(0,0,255);
   line(0,height-(height*averageNormalized), width,height-(height*averageNormalized));
   fill(0, 0, 255);
   textSize(12);
   text(""+nf(average, 0, 2), 3, height-(height*averageNormalized) - 3);
}
