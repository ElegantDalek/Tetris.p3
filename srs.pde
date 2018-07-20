class SRS {
  SRS() {
  }
  int[][][] srs = {
    //Super Rotation System, a series of coordinates to test for each rotation
    //http://tetris.wikia.com/wiki/SRS
    { //3 >> 0 state, index 0
      {0, 0}, {-1, 0}, {-1, 1}, {0, -2}, {-1, -2}
    }, 
    { //0 >> 1 state, index 1
      {0, 0}, {-1, 0}, {-1, -1}, {0, 2}, {-1, 2} 
    }, 
    { //1 >> 2 state, index 2
      {0, 0}, {1, 0}, {1, 1}, {0, -2}, {1, -2}
    }, 
    { //2 >> 3 state, index 3
      {0, 0}, {1, 0}, {1, -1}, {0, 2}, {1, 2}
    }
  };

  int[][][] srsI = {
    //specific to I piece
    { //3>>0, index 0
      {0, 0}, {1, 0}, {-2, 0}, {1, 2}, {-2, -1}
    }, 
    { //0 >> 1, index 1
      {0, 0}, {-2, 0}, {1, 0}, {-2, 1}, {1, -2}
    },
    { //1 >> 2, index 1
      {0, 0}, {-1, 0}, {2, 0}, {-1, -2}, {2, 1}
    },
    { //2 >> 3, index 2
      {0, 0}, {2, 0}, {-1, 0}, {2, -1}, {-1, 2}
    }
  };

  int getSRSX(int iteration, int orientation, boolean clockwise) {
    if (clockwise) {
      return srs[(orientation + 1) % 4][iteration][0];
    } else {
      return -1 * srs[orientation][iteration][0];
    }
  }

  int getSRSY(int iteration, int orientation, boolean clockwise) {
    if (clockwise) {
      return srs[(orientation + 1) % 4][iteration][1];
    } else {
      return -1 * srs[orientation][iteration][1];
    }
  }

  int getSRSIX(int iteration, int orientation, boolean clockwise) {
    if (clockwise) {
      return srsI[(orientation + 1) % 4][iteration][0];
    } else {
      return -1 * srsI[orientation][iteration][0];
    }
  }

  int getSRSIY(int iteration, int orientation, boolean clockwise) {
    if (clockwise) {
      return srsI[(orientation + 1) % 4][iteration][1];
    } else {
      return -1 * srsI[orientation][iteration][1];
    }
  }
}
