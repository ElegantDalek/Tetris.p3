class Ttetris extends Tetrimino {
  Ttetris() {
    this.setdefault();
    shade = purple;
  }
  void setdefault() {
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
}

class Ztetris extends Tetrimino {
  Ztetris() {
    this.setdefault();
    shade = red;
  }
  void setdefault() {
    piece[0][0] = true;
    piece[1][0] = true;
    piece[2][0] = false;
    piece[0][1] = false;
    piece[1][1] = true;
    piece[2][1] = true;
    piece[0][2] = false;
    piece[1][2] = false;
    piece[2][2] = false;
  }
}

class Stetris extends Tetrimino {
  Stetris() {
    this.setdefault();
    shade = green;
  }
  void setdefault() {
    piece[0][0] = false;
    piece[1][0] = true;
    piece[2][0] = true;
    piece[0][1] = true;
    piece[1][1] = true;
    piece[2][1] = false;
    piece[0][2] = false;
    piece[1][2] = false;
    piece[2][2] = false;
  }
}

class Ltetris extends Tetrimino {
  Ltetris() {
    this.setdefault();
    shade = orange;
  }
  void setdefault() {
    piece[0][0] = false;
    piece[1][0] = false;
    piece[2][0] = true;
    piece[0][1] = true;
    piece[1][1] = true;
    piece[2][1] = true;
    piece[0][2] = false;
    piece[1][2] = false;
    piece[2][2] = false;
  }
}

class Jtetris extends Tetrimino {
  Jtetris() {
    this.setdefault();
    shade = blue;
  }
  void setdefault() {
    piece[0][0] = true;
    piece[1][0] = false;
    piece[2][0] = false;
    piece[0][1] = true;
    piece[1][1] = true;
    piece[2][1] = true;
    piece[0][2] = false;
    piece[1][2] = false;
    piece[2][2] = false;
  }
}
