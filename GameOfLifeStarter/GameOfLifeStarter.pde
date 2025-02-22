final int SPACING = 5; // each cell's width/height //<>// //<>//
final float DENSITY = 0.5; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's

void setup() {
  size(1000, 800); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(7); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];

  // populate initial grid
  // your code here
  for (int i=0; i<height/SPACING; i++) {
    for (int j=0; j<width/SPACING; j++) {
      if (Math.random() < DENSITY) {
        grid[i][j] = 1;
      } else {
        grid[i][j] = 0;
      }
    }
  }
}

void draw() {
  showGrid();
  grid = calcNextGrid();
}

int[][] calcNextGrid() {
  int[][] nextGrid = new int[grid.length][grid[0].length];

  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[0].length; j++) {
      if (grid[i][j] == 1) {
        if (countNeighbors(i, j) <= 1) {
          nextGrid[i][j] = 0;
        } else if (countNeighbors(i, j)  >= 4) {
          nextGrid[i][j] = 0;
        } else if (countNeighbors(i, j) == 2 || countNeighbors(i, j) == 3) {
          nextGrid[i][j] = 1;
        }
      } else {
        if (countNeighbors(i, j) == 3) {
          nextGrid[i][j] = 1;
        } else {
          nextGrid[i][j] = 0;
        }
      }
    }
  }
  // your code here

  return nextGrid;
}

int countNeighbors(int i, int j) {
  int n = 0; // don't count yourself!

  if (i==0 && j==0) {
    n += grid[i][j+1] + grid[i+1][j] + grid[i+j][j+1];
  } else if (i == grid.length -1 && j == 0) {
    n += grid[i-1][j] + grid[i-1][j+1] + grid[i][j+1];
  } else if (i == 0 && j == grid[0].length - 1) {
    n += grid[i][j-1] + grid[i+1][j-1] + grid[i+1][j];
  } else if (i == grid.length -1 && j == grid[0].length - 1) {
    n+= grid[i-1][j-1] + grid[i-1][j] +grid[i][j-1];
  } else if (i == 0) {
    n += grid[i][j-1] + grid[i][j+1] + grid[i+1][j-1] + grid[i+1][j] + grid[i+1][j+1];
  } else if (j == 0) {
    n += grid[i-1][j] + grid[i-1][j+1] + grid[i][j+1] + grid[i+1][j] + grid[i+1][j+1];
  } else if (i == grid.length-1) {
    n += grid[i-1][j-1] + grid[i-1][j] + grid[i-1][j+1] + grid[i][j-1] + grid[i][j+1];
  } else if (j == grid[0].length-1) {
    n += grid[i-1][j-1] + grid[i-1][j] + grid[i][j-1] + grid[i+1][j-1] + grid[i+1][j];
  } else {
    n += grid[i-1][j-1] + grid[i-1][j] + grid[i-1][j+1] + grid[i][j-1] + grid[i][j+1] + grid[i+1][j-1] + grid[i+1][j] + grid[i+1][j+1];
  }
  // your code here
  // don't check out-of-bounds cells
  return n;
}

void showGrid() {
  for (int i=0; i<height/SPACING; i++) {
    for (int j=0; j<width/SPACING; j++) {
      if (grid[i][j] == 1) {
        fill(100, 0, 255);
        square(j*SPACING, i*SPACING, SPACING);
      } else {
        fill(0);
        square(j*SPACING, i*SPACING, SPACING);
      }
    }
  }
  // your code here
  // use square() to represent each cell
  // use fill(r, g, b) to control color: black for empty, red for filled (or alive)
}
