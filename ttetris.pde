class Ttetris extends Tetrimino {
  Ttetris() {
    piece[0][0] = false;
    piece[1][0] = true;
    piece[2][0] = false;
    piece[0][1] = true;
    piece[1][1] = true;
    piece[2][1] = true;
    piece[0][2] = false;
    piece[1][2] = false;
    piece[2][2] = false;
  }
  void draw() {
    for (int i = 0; i < 4; i++){
      for (int j = 0; j < 4; j++){
        if (piece[i][j]) {
          fill(purple);
          rect(ORIGINX + CELL_WIDTH * (positionX + i), ORIGINY + CELL_WIDTH * (positionY + j), CELL_WIDTH, CELL_WIDTH);
          fill(255);
        }
      }
    }
  }
}
