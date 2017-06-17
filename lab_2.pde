/*******************************************************************/
/* Project: Memory Game
/* Author: Jacob Sifkovits
/**************************************************************/

//declare variables
int numRows=4;
int numBoxes = numRows * numRows;
int moves;
int tile_num_1, tile_num_2;
int num_clicks = 0;
int box_width, box_height;
int [] image_number= new int[numBoxes];
PImage [] pic = new PImage[numBoxes/2];
boolean [] matched = new boolean[numBoxes];
boolean reset = true;

void setup(){
  // draw layout
  size(700,750);
  
  box_width = width/numRows;
  box_height = (height- 50)/numRows;
  
  InitializeBoard(numRows);
  
  // load images
   
  for (int i=0; i < numBoxes/2; i++){
     pic[i] = loadImage("pic" + i + ".jpg");
  }
  
  //shuffle images
  shuffle();
}

void draw(){}

void InitializeBoard(int n)
{
  moves = 0;
  //board color
  fill(123,234,32);
  for(int i = 0; i <n; i++)
  {
    for (int j = 0; j < n; j++)
    {
      rect(j * width/n, i * (height - 50)/n, box_width, box_height);
    }
  }
  
  if (reset)
  {
    for(int index = 0; index < (numBoxes/2); index = index +1){
      image_number [index] = index;
      image_number[index + (numBoxes/2)] = index;
      
      matched[index] = false;
      matched[index + (numBoxes/2)] = false;
    }
  }
  
  //control panel
  fill (55,167,2);
  rect(0,700, width/3,50);
  textSize(32);
  fill(255);
  text("START GAME" , 17, 740);
  
  fill (55,167,2);
  rect(width/3, 700, width/3,50);
  textSize(32);
  fill(255);
  text("NEW GAME" , width/3+30,740);
  
  fill (55,167,2);
  rect(width*2/3, 700, width/3, 50);
  textSize(32);
  fill(255);
  text("TOTAL SCORE" , width*2/3+10, 740);
}
void shuffle() {
  for (int i = 0; i < 10; i++)
  {
    int r1 = int (random(numBoxes));
    int r2 = int(random(numBoxes));
    
    int temp = image_number[r1];
    image_number[r1] = image_number[r2];
    image_number[r2] = temp;
  }
}

void mousePressed(){
  int x = mouseX;
  int y = mouseY;
  
  if (y < 700)
  {
    num_clicks++;
    if (num_clicks == 1)
    {
      tile_num_1 = OpenTile(x,y);
    }
    else
    {
      tile_num_2 = OpenTile(x, y);
    }
    
    moves++;
  }
  else if (x < width/3){
    reset = false;
    InitializeBoard(numRows);
  }
  else if( x < 2*width/3){
    reset=true;
    InitializeBoard(numRows);
    shuffle();
  }
  else {
    displayScore();
  }
}

void mouseReleased()
{
  if (num_clicks ==2)
  {
    if (image_number[tile_num_1] == image_number[tile_num_2])
    {
      matched[tile_num_1] = true;
      matched[tile_num_2] = true;
    }
    else
    {
      if (!matched[tile_num_1]) CloseTile(tile_num_1);
      if (!matched[tile_num_2]) CloseTile(tile_num_2);
    }
    num_clicks = 0;
  }
}

int OpenTile(float x, float y)
{
  int col = int(x/box_width);
  int row = int(y/box_height);
  
  println("ROW: "+row);
  println("COL: "+col);
  
  float image_xPos = col*box_width;
  float image_yPos = row*box_height;
  int tile_number = row*numRows + col;
  image(pic[image_number[tile_number]], image_xPos, image_yPos, box_width, box_height);
  
  /* return tile number */
  return tile_number;
}

void CloseTile(int tile_num){
  //draw the box at given position
  int col = tile_num%numRows;
  int row = tile_num/numRows;
  
  float rect_xPos = col*box_width;
  float rect_yPos = row*box_height;
  
  fill(123,234,32);
  rect(rect_xPos, rect_yPos, box_width, box_height);
}

void displayScore()
{
  fill(55,167,2);
  rect(width*2/3,700,width/3,50);
  textSize(32);
  fill(255);
  text(moves,width*2/3+100,740);
}



  
