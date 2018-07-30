class Grid {
  boolean[][] blocks = new boolean[CELL_COLUMNS][CELL_ROWS];
  color[][] blockcolors = new color[CELL_COLUMNS][CELL_ROWS];
  Grid() {
    this.clear();
  }
  void add(int coord[][], color shade) {
    try {
    for (int i = 0; i < (coord.length); i++) {
      blocks[coord[i][0]] [coord[i][1]] = true;
      blockcolors[coord[i][0]] [coord[i][1]] = shade;
    }
    } catch (ArrayIndexOutOfBoundsException e) {
      gamehandler.setGameOver(true);
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
        cell.draw(i, j, bg);
        fill(255);
        if (blocks[i][j]) {
          cell.draw(i, j, blockcolors[i][j]);
        }
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

  void addTrash(int lines) {
    int emptyCell = int(random(CELL_COLUMNS));
    for (int j = 0; j < CELL_ROWS; j++) {
      for (int i = 0; i < CELL_COLUMNS; i++) {
        if (j < CELL_ROWS - lines) { //moves exisiting pieces upwards, TODO: keep pieces out of bounds in seperate grid?
          try {
            blocks[i][j] = blocks[i][j + lines];
            blockcolors[i][j] = blockcolors[i][j + lines];
          }
          catch (ArrayIndexOutOfBoundsException e) {
          }
        } else { //fills in the trash
          if (i != emptyCell) {
            blocks[i][j] = true;
            blockcolors[i][j] = trashgray;
          } else {
            blocks[i][j] = false;
            blockcolors[i][j] = white;
          }
        }
      }
    }
    piecehandler.getActive().updateShadow(); //updates shadow of active tetrimino
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
    for (int i = 0; i < coord.length; i++) {
      coord[i][0] = input[i][0];
      coord[i][1] = input[i][1];
    }
    while (this.testCoord(coord)) {
      for (int i = 0; i < coord.length; i++) {
        coord[i][1] += 1;
      }
    }
    for (int i = 0; i < coord.length; i++) {
      coord[i][1] -= 1; //goes back one
    }
    return coord;
  }

  int[] getSurfaceCells() {
    int[] yValues = new int[CELL_COLUMNS];
    for (int i = 0; i < CELL_COLUMNS; i++) {
      yValues[i] = 20;
      for (int j = 0; j < CELL_ROWS; j++) {
        if (blocks[i][j]) {
          yValues[i] = j;
          break;
        }
      }
    }
    return yValues;
  }
  void clearline(int line) {
    for (; line >= 0; line--) {
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

  boolean checkPerfectClear() {
    for (int i = 0; i < CELL_COLUMNS; i++) {
      for (int j = 0; j < CELL_ROWS; j++) {
        if (blocks[i][j]) {
          return false;
        }
      }
    }
    return true;
  }
}
