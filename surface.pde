class Surface { //through int code returns ycoords of top or bottom surface
  Surface() {}
  
  int[] getBottom(int piece, int rotateState) {
    return bottom[piece][rotateState];
  }
  
  int getBottomLength(int piece) {
    return bottom[piece].length;
  }
  
  int[] getTop(int piece, int rotateState) {
    return top[piece][rotateState];
  }
  
  int[][][] bottom = { // shows change in altidude of play surface for piece to fit
    { // T tetris
      {0, 0, 0}, {0, -1}, {0, 1, 0}, {0, 1}
    },
    { // Z tetris
      {0, 1, 1}, {0, -1}
    },
    { // S tetris
      {0, 0, -1}, {0, 1}
    },
    { // L tetris
      {0, 0, 0}, {0, 0}, {0, -1, -1}, {0, 2}
    },
    { // J tetris
      {0, 0, 0}, {0, -2}, {0, 0, 1}, {0, 0}
    },
    { // O tetris
      {0, 0}
    },
    { // I tetris
      {0, 0, 0, 0}, {0}
    }
  };
  
  int[][][] top = { // shows change in play surface after piece is placed
    { // T tetris
      {-1, -2, -1}, {-3, -1}, {-1, -2, -1}, {-1, -3}
    },
    { // Z tetris
      {-1, -2, -1}, {-2, -2}
    },
    { // S tetris
      {-1, -2, -1}, {-2, -2}
    }, 
    { // L tetris
      {-1, -1, -2}, {-3, -1}, {-2, -1, -1}, {-1, -3}
    },
    { // J tetris
      {-2, -1, -1}, {-3, -1}, {-2, -1, -1}, {-1, -3}
    },
    { // O tetris
      {-2, -2}
    },
    { // I tetris
      {-1, -1, -1, -1}, {-4}
    }
  };
    
  
}
