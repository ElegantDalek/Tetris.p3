class PieceHandler{
  Ttetris ttetris = new Ttetris();
  Ztetris ztetris = new Ztetris();
  Stetris stetris = new Stetris();
  Ltetris ltetris = new Ltetris();
  Jtetris jtetris = new Jtetris();
  Otetris otetris = new Otetris();
  Itetris itetris = new Itetris();
  Tetrimino activeTetrimino = convert(bag.getPiece());
  FutureTetrimino futureTetrimino = new FutureTetrimino();
  PieceHandler() {
  }
  Tetrimino convert(int code) {
    switch(code) {
      case 0:
        return ttetris;
      case 1:
        return ztetris;
      case 2:
        return stetris;
      case 3:
        return ltetris;
      case 4:
        return jtetris;
      case 5:
        return otetris;
      case 6:
        return itetris;
      default:
        return ttetris;
    }
  }
  
  Tetrimino getActive() {
    return activeTetrimino;
  }
  
  void nextTetris() {
    gamehandler.addScore(grid.checkLines());
    activeTetrimino = convert(bag.getPiece());
    activeTetrimino.reset();
    futureTetrimino.update();
  }
  void rotate(boolean clockwise) {
    activeTetrimino.rotate(clockwise);
    futureTetrimino.update();
  }
  
  void draw() {
    activeTetrimino.draw();
    futureTetrimino.draw();
  }
  
  void drop() {
    activeTetrimino.drop();
  }
  
  void move(boolean right) {
    activeTetrimino.move(right);
    futureTetrimino.move(right);
  }
  
  void reset() {
    activeTetrimino.reset();
  }
  void harddrop() {
    activeTetrimino.hardDrop();
  }
}
