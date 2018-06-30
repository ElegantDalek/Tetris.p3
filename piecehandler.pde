class PieceHandler {
  Tetrimino[] piece = new Tetrimino[7];
  Tetrimino activeTetrimino;
  PieceHandler() {
    piece[0] = new Ttetris();
    piece[1] = new Ztetris();
    piece[2] = new Stetris();
    piece[3] = new Ltetris();
    piece[4] = new Jtetris();
    piece[5] = new Otetris();
    piece[6] = new Itetris();
    activeTetrimino = piece[bag.getPiece()];
  }

  Tetrimino getActive() {
    return activeTetrimino;
  }

  void nextTetris() {
    gamehandler.addScore(grid.checkLines());
    activeTetrimino = piece[bag.getPiece()];
    activeTetrimino.reset();
  }
  void rotate(boolean clockwise) {
    activeTetrimino.rotate(clockwise);
  }

  void draw() {
    activeTetrimino.draw();
  }

  void drop() {
    activeTetrimino.drop();
  }

  void move(boolean right) {
    activeTetrimino.move(right);
  }

  void reset() {
    activeTetrimino.reset();
  }
  void harddrop() {
    activeTetrimino.hardDrop();
  }
}
