class Grid {
  boolean[][] blocks = new boolean[CELL_COLUMNS][CELL_ROWS];
  color[][] blockcolors = new color[CELL_COLUMNS][CELL_ROWS];
  Grid() {
    for( int i = 0; i < CELL_COLUMNS; i++) {
      for ( int j = 0; j < CELL_ROWS; j++) {
        blocks[i][j] = false;
        blockcolors[i][j] = color(255, 255, 255);
      }
    }
  }
  void add(int xcoord[], int ycoord[], color shade) {
    for (int i = 0; i < (xcoord.length); i++) {
      blocks[xcoord[i]] [ycoord[i]] = true;
      blockcolors[xcoord[i]] [ycoord[i]] = shade;
    }
  }
  
  void draw() {
    for(int i = 0; i < CELL_COLUMNS; i++) {
      for(int j = 0; j < CELL_ROWS; j++) {
        if (blocks[i][j]) {
          fill(blockcolors[i][j]);
        }
      rect(i * CELL_WIDTH + ORIGINX, j * CELL_WIDTH + ORIGINY, CELL_WIDTH, CELL_WIDTH);
      fill(255);
      }  
    }
  }
  
  boolean clearPath(int xcoord[], int ycoord[]) {
    //if no blocks below or floor, returns true
    for(int i = 0; i < xcoord.length; i++) {
      try {
      if (ycoord[i] == CELL_ROWS || blocks[xcoord[i]] [ycoord[i] + 1]) {
        return false;
        }
      } catch (ArrayIndexOutOfBoundsException e) {
        return false;
      }
      
    }
    return true;
  }
}
