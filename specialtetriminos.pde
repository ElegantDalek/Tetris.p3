
class Otetris extends Tetrimino {
  
  Otetris() {
    this.setdefault();
    shade = yellow;
  }
  void setdefault() {
    piece[0][0] = 1;
    piece[0][1] = 0;

    piece[1][0] = 2;
    piece[1][1] = 0;

    piece[2][0] = 1;
    piece[2][1] = 1;

    piece[3][0] = 2;
    piece[3][1] = 1;
  }
  void rotate(boolean clockwise) {
  }
}

class Itetris extends Tetrimino {
  Itetris() {
    this.setdefault();
    defaultY = -1;
    shade = cyan;
  }

  int[][][] rotationCoord = { //coordinates for all 4 rotation states
    { //index 0
      {0, 1}, {1, 1}, {2, 1}, {3, 1}
    }, 
    { //index 1
      {2, 0}, {2, 1}, {2, 2}, {2, 3}
    }, 
    { //index 2
      {0, 2}, {1, 2}, {2, 2}, {3, 2}
    }, 
    { //index 3
      {1, 0}, {1, 1}, {1, 2}, {1, 3}
    }
  };

  void setdefault() {
    for (int i = 0; i < 4; i++) {
      piece[i][0] = rotationCoord[0][i][0];
      piece[i][1] = rotationCoord[0][i][1];
    }
  }
  int[][] rotateCoord(int[][] piece, boolean clockwise) {
    int[][] returnCoord = new int[4][2];
    int orientation; //future orientation
    if (clockwise) {
      orientation = (rotateState + 1) % 4;
    } else {
      orientation = (rotateState + 3) % 4;
    }
    returnCoord = rotationCoord[orientation];
    return returnCoord;
  }

  int getTransX(int i, int rotateState, boolean clockwise) { //returns Xcoordinates using correct srs array
    return srs.getSRSIX(i, rotateState, clockwise);
  }

  int getTransY(int i, int rotateState, boolean clockwise) {
    return srs.getSRSIY(i, rotateState, clockwise);
  }
}
