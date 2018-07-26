class GrabBag {
  int previewX = 12;
  int[] queue = new int[14];
  Tetrimino[] preview = new Tetrimino[7];
  int index = 0;
  GrabBag() {
    preview[0] = new Ttetris();
    preview[1] = new Ztetris();
    preview[2] = new Stetris();
    preview[3] = new Ltetris();
    preview[4] = new Jtetris();
    preview[5] = new Otetris();
    preview[6] = new Itetris();
    this.reset();
    for (Tetrimino i : preview) {
      i.setPosition(previewX, 0);
    }
  }

  void reset() {
    index = 0;
    this.choose();
    this.choose();
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
  
  int getQueue(int index) {
    return queue[index];
  }
  
  void removeItem(int number, int[]array) {
    boolean itemPopped = false;
    for (int i = 0; i < array.length; i++) { //removes number from array
      if (!itemPopped) {
        if (number == array[i] ) {
          itemPopped = true;
        }
      } else {
        array[i - 1] = array[i];
      }
    }
  }
  void showPreview() {
    for (int i = 0; i < 5; i++) {
      preview[queue[i]].setPosition(previewX, 0 + i * 3);
      preview[queue[i]].draw();
    }
  }
}
