class GrabBag {
  int previewX = 12;
  int[] queue = new int[14];
  int index = 0;
  Ttetris ttetrisp = new Ttetris(); //preview pieces at right
  Ztetris ztetrisp = new Ztetris();
  Stetris stetrisp = new Stetris();
  Ltetris ltetrisp = new Ltetris();
  Jtetris jtetrisp = new Jtetris();
  Otetris otetrisp = new Otetris();
  Itetris itetrisp = new Itetris();
  GrabBag() {
    this.choose();
    this.choose(); //grabs 7 pieces
    ttetrisp.setPosition(previewX, 0);
    ztetrisp.setPosition(previewX, 0);
    stetrisp.setPosition(previewX, 0);
    ltetrisp.setPosition(previewX, 0);
    jtetrisp.setPosition(previewX, 0);
    otetrisp.setPosition(previewX, 0);
    itetrisp.setPosition(previewX, 0);
  }
  
  int getPiece() { //returns int code of next piece, removes it from list
    int nextPiece = queue[0];
    removeItem(nextPiece, queue);
    index--;
    if (index == 7) {
      this.choose();
    }
    return nextPiece;
  }
  void choose() {
    //adds 7 pieces in random order to queue, guarenteed for 1 of each
    int[] numbersleft = {0, 1, 2, 3, 4, 5, 6};
    for (int max = 7; max >= 1; max--) {
      int randomint = int(random(max));
      queue[index++] = numbersleft[randomint];
      removeItem(numbersleft[randomint], numbersleft);
    }
  }
  void removeItem(int number, int[]array) {
    boolean itemPopped = false;
    for (int i = 0; i < array.length; i++) { //removes number from array
      if (!itemPopped) {
        if (number == array[i] ) {
          itemPopped = true;
        } 
      }
      else {
          array[i - 1] = array[i];
      }
    }
  }
  Tetrimino convert(int code) {
    switch(code) {
      case 0:
        return ttetrisp;
      case 1:
        return ztetrisp;
      case 2:
        return stetrisp;
      case 3:
        return ltetrisp;
      case 4:
        return jtetrisp;
      case 5:
        return otetrisp;
      case 6:
        return itetrisp;
      default:
        return ttetrisp;
    }
  }
  void showPreview() {
    for(int i = 0; i < 5; i++) {
      convert(queue[i]).setPosition(previewX, 0 + i * 3);
      convert(queue[i]).draw();
    }
  }
}
