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
    shade = purple;
  }
}
