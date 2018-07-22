class Ttetris extends Tetrimino {
  Ttetris() {
    this.setdefault();
    shade = purple;
  }
  void setdefault() {
    piece[0][0] = 1;
    piece[0][1] = 0;

    piece[1][0] = 0;
    piece[1][1] = 1;

    piece[2][0] = 1;
    piece[2][1] = 1;

    piece[3][0] = 2;
    piece[3][1] = 1;
  }

  boolean isTSpin() { 
    int cornersFilled = 0;
    if (spunIn) {
      for (int i = 0; i < 3; i += 2) {
        for (int j = 0; j < 3; j += 2) {
          int[][] cellCoord = { {i + positionX, j + positionY} };
          if (!grid.testCoord(cellCoord)) {
            cornersFilled += 1;
          }
        }
      }
      if (cornersFilled >= 3) {
        return true;
      }
    }
    return false;
  }
}

class Ztetris extends Tetrimino {
  Ztetris() {
    this.setdefault();
    shade = red;
  }
  void setdefault() {
    piece[0][0] = 0;
    piece[0][1] = 0;

    piece[1][0] = 1;
    piece[1][1] = 0;

    piece[2][0] = 1;
    piece[2][1] = 1;

    piece[3][0] = 2;
    piece[3][1] = 1;
  }
}

class Stetris extends Tetrimino {
  Stetris() {
    this.setdefault();
    shade = green;
  }
  void setdefault() {
    piece[0][0] = 1;
    piece[0][1] = 0;

    piece[1][0] = 2;
    piece[1][1] = 0;

    piece[2][0] = 0;
    piece[2][1] = 1;

    piece[3][0] = 1;
    piece[3][1] = 1;
  }
}

class Ltetris extends Tetrimino {
  Ltetris() {
    this.setdefault();
    shade = orange;
  }
  void setdefault() {
    piece[0][0] = 2;
    piece[0][1] = 0;

    piece[1][0] = 0;
    piece[1][1] = 1;

    piece[2][0] = 1;
    piece[2][1] = 1;

    piece[3][0] = 2;
    piece[3][1] = 1;
  }
}

class Jtetris extends Tetrimino {
  Jtetris() {
    this.setdefault();
    shade = blue;
  }
  void setdefault() {
    piece[0][0] = 0;
    piece[0][1] = 0;

    piece[1][0] = 0;
    piece[1][1] = 1;

    piece[2][0] = 1;
    piece[2][1] = 1;

    piece[3][0] = 2;
    piece[3][1] = 1;
  }
}
