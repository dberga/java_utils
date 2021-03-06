Collect table;
PFont font;
int plot_x1, plot_x2, plot_y1, plot_y2;
float plot_width, plot_height, xrange, yrange;
int steps = 10;
float[][] datapoints;

/*
| Statistics available for comparison. Extend this.
*/
String[][] axes = {
  {"Points Per Game", "ppg"},
  {"Games Started", "gs"},
  {"Field Goal Percentage", "fgp"},
  {"Minutes Per Game", "mpg"}
};

// currently chosen statistic for x and y axis, respectively
int[] axis_choice = {0, 2};

float[] x_axis_area, y_axis_area;

void setup() {
  size(1200, 700);
  table = new Collect("all_players.tsv");
}

void draw() {
  background(170,170,200);
  
  /*
  | IMPORTANT:
  | the next two lines determine the dimensions of the plot area
  */
  int w = (int) (width * 0.8);
  int h = (int) (height * 0.8);
  
  /**
  | Set choice of axes, first and third statistics by default
  */
  String[] x_axis = axes[axis_choice[0]];
  String[] y_axis = axes[axis_choice[1]];
  
  /*
  | Start Drawing here.
  | Change these methods if necessary, clearly
  | commenting where any changes have been made
  */
  drawPlotArea(w, h);
  drawTitle("Career Stats for the NBA 2011");
  drawAxesLabels("< "+x_axis[0]+" >", "< "+y_axis[0]+" >");
  drawGridlines(x_axis[1], y_axis[1]);
  plotDataPoints(x_axis[1], y_axis[1]);
  cursorMode();
  inspectDataPoints();
}

/*
| IMPORTANT:
| alter this method to change positioning of plot area
*/
void drawPlotArea(int w, int h) {
  plot_x1 = (width - w) / 2;
  plot_y1 = (height - h) / 2;
  plot_x2 = plot_x1 + w;
  plot_y2 = plot_y1 + h;
  rectMode(CORNERS);
  stroke(0);
  fill(200, 200, 250);
  rect(plot_x1, plot_y1, plot_x2, plot_y2);

  // set dimensions for later use
  plot_width = plot_x2 - plot_x1;
  plot_height = plot_y2 - plot_y1;
}

void drawTitle (String t) {
  fill(0);
  textAlign(CENTER);
  textSize(28);
  text(t, width/2, plot_y1/2);
}

void drawAxesLabels (String x_axis, String y_axis) {
  textSize(14);
  
  // axis labels are centered between adjacent edge of plot area and window
  text(x_axis, width/2, (height+plot_y2)/2);
  verticalText(y_axis, -height/2, plot_x1/2);
  
  // record areas where axes lie
  x_axis_area = new float[] { (height+plot_y2)/2-7, (height+plot_y2)/2+7 };
  y_axis_area = new float[] { plot_x1/2-7, plot_x1/2+7 };
}

// draw grid lines
void drawGridlines (String xfield, String yfield) {
  // find range (rounded to nearest ten)
  xrange =  ceil(table.columnMax(table.fieldIndex(xfield)));
  yrange =  ceil(table.columnMax(table.fieldIndex(yfield)));

  // steps defined at top of document, default 10
  float x_step_size = plot_width / steps;
  float y_step_size = plot_height / steps;

  for (int n = 1; n <= steps; n++) {

    float x = plot_x1 + n * x_step_size;
    float y = plot_y2 - n * y_step_size;

    stroke(0);

    // draw grid lines
    line(plot_x1, y, plot_x2, y);
    line(x, plot_y1, x, plot_y2);

    // label grid lines as well
    text((n * yrange)/steps, plot_x1-15, y );
    text((n * xrange)/steps, x, plot_y2+15 );
  }
}

// plots column x against column y
void plotDataPoints (String x, String y) {
  datapoints = new float[table.numRows][4];
  int x_index = table.fieldIndex(x);
  int y_index = table.fieldIndex(y);
  for (int i = 0; i < datapoints.length; i++) {
    
    // load datapoints for each row
    datapoints[i][0] = table.getFloatAt(i, x_index); // value of x
    datapoints[i][1] = table.getFloatAt(i, y_index); // value of y
    datapoints[i][2] = plot_x1 + (datapoints[i][0]/xrange) * plot_width; // x-coord on plot
    datapoints[i][3] = plot_y2 - (datapoints[i][1]/yrange) * plot_height; // y-coord on plot
    
    // plot datapoint
    fill(255, 0, 0);
    
    /*
    | IMPORTANT:
    | arguments 3 and 4 determine ellipse size
    */
    ellipse(datapoints[i][2], datapoints[i][3], 5, 5);
  }
  
}

/*
| IMPORTANT: FIXME
| should allow user to see more information about a data point
| by mousing over it in the plot area.
| see near() method
*/
void inspectDataPoints () {
  for (int i = 0; i < datapoints.length; i++) {
    
    // if mouse is within hover radius of a point. note: 1 is VERY accurate
    if (near(datapoints[i], mouseX, mouseY, 2)) {
      // show tooltip with player name
      stroke(0); fill(0); textAlign(LEFT);
      text(table.getDataAt(i, table.fieldIndex("name")), mouseX + 10, mouseY - 10);
    }
  }
}

/*
| IMPORTANT: FIXME
| should allow user to change the axes being plotted
| by clicking the appropriate axis label
| see mouseClicked() method
*/
void cycle_axis (char axis) {
  switch (axis) {
    case 'X':
      axis_choice[0] = (axis_choice[0] + 1) % axes.length;
      if (axis_choice[0] == axis_choice[1]) {
        axis_choice[0] = (axis_choice[0] + 1) % axes.length;
      }
    break;
    case 'Y':
      axis_choice[1] = (axis_choice[1] + 1) % axes.length;
      if (axis_choice[0] == axis_choice[1]) {
        axis_choice[1] = (axis_choice[1] + 1) % axes.length;
      }
    break;
  }
}

void mouseClicked () {
  // TODO
  
  if (mouseX >= y_axis_area[0] && mouseX <= y_axis_area[1]) 
  {
    cycle_axis('Y');
  }else if(mouseY >= x_axis_area[0] && mouseY <= x_axis_area[1])
  {
    cycle_axis('X');
  }else{
  }
  
  

  
  
  
  
}

void verticalText (String t, int x, int y) {
  pushMatrix(); // contain text transformation
  rotate(radians(270));
  // because we rotate 270, x becomes -y, y becomes x. think cartesian coordinates
  text(t, x, y);  
  popMatrix();
}

void cursorMode () {
  if (mouseX > plot_x1 && mouseX < plot_x2 && mouseY > plot_y1 && mouseY < plot_y2) {
    // mouse in plot area
    cursor(CROSS); // use crosshair
  }
  else if ((mouseX >= y_axis_area[0] && mouseX <= y_axis_area[1]) ||
      (mouseY >= x_axis_area[0] && mouseY <= x_axis_area[1])
  ) {
    cursor(HAND);
  }
  else {
    cursor(ARROW);
  }
}

// determines whether x and y are within a radius `rad`
// of data[2] and data[3] respectively
boolean near (float[] data, float x, float y, int rad) {
  // TODO

 float distancia = sqrt(  (x-data[2])*(x-data[2]) + (y-data[3])*(y-data[3]) );

  if (distancia <= rad) {
    return true;
  }else{
    return false;
  }

}

