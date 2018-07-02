class Grid {
  boolean[][] blocks = new boolean[CELL_COLUMNS][CELL_ROWS];
  color[][] blockcolors = new color[CELL_COLUMNS][CELL_ROWS];
  Grid() {
    this.clear();
  }
  void add(int coord[][], color shade) {
    for (int i = 0; i < (coord.length); i++) {
      blocks[coord[i][0]] [coord[i][1]] = true;
      blockcolors[coord[i][0]] [coord[i][1]] = shade;
    }
  }

  void clear() {
    for ( int i = 0; i < CELL_COLUMNS; i++) {
      for ( int j = 0; j < CELL_ROWS; j++) {
        blocks[i][j] = false;
        blockcolors[i][j] = color(255, 255, 255);
      }
    }
  }
  void draw() {
    for (int i = 0; i < CELL_COLUMNS; i++) {
      for (int j = 0; j < CELL_ROWS; j++) {
        if (blocks[i][j]) {
          fill(blockcolors[i][j]);
        }
        rect(i * CELL_WIDTH + ORIGINX, j * CELL_WIDTH + ORIGINY, CELL_WIDTH, CELL_WIDTH);
        fill(255);
      }
    }
  }

  boolean testCoord(int coord[][]) {
    //if no blocks in the way of proposed change, returns true
    for (int i = 0; i < coord.length; i++) {
      try {
        if ((coord[i][1] > CELL_ROWS) || (blocks[coord[i][0]] [coord[i][1]])
          || coord[i][0] < 0 || coord[i][0] > CELL_COLUMNS) { 
          //tests if coordinate beyond L, R, and bottom boundaries, tests if block added already exists where plan to move
          return false;
        }
      } 
      catch (ArrayIndexOutOfBoundsException e) {
        return false;
      }
    }
    return true;
  }

  int checkLines() { //goes down, if coord row all true, removes lines
    int linescleared = 0;
    for (int j = 0; j < CELL_ROWS; j++) {
      boolean linefull = true;
      for (int i = 0; i < CELL_COLUMNS; i++) {
        if (blocks[i][j] == false) {
          linefull = false;
        }
      }
      if (linefull) {
        linescleared += 1;
        this.clearline(j);
      }
    }
    return linescleared;
  }
  
  int[][] hardDropCoord(int[][] input) {
    //returns coordinates if harddropped
    int [][] coord = new int[4][2];
      for(int i = 0; i < coord.length; i++) {
        coord[i][0] = input[i][0];
        coord[i][1] = input[i][1];
      }
    while(this.testCoord(coord)) {
      for(int i = 0; i < coord.length; i++) {
        coord[i][1] += 1;
      }
    }
    for(int i = 0; i < coord.length; i++) {
        coord[i][1] -= 1; //goes back one
    }
    return coord;
  }
  void clearline(int line) {
    for (; line > 0; line--) {
      for (int i = 0; i < CELL_COLUMNS; i++) {
        try {
          blocks[i][line] = blocks[i][line - 1];
          blockcolors[i][line] = blockcolors[i][line - 1];
        } 
        catch (ArrayIndexOutOfBoundsException e) {
          blocks[i][line] = false;
          blockcolors[i][line] = white;
        }
      }
    }
  }
}
