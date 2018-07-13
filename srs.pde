class SRS {
  int[][][] srs = {
    //Super Rotation System, a series of coordinates to test for each rotation
    //http://tetris.wikia.com/wiki/SRS
    { //3 >> 0 state, index 0
      {0, 0}, {-1, 0}, {-1, 1}, {0, -2}, {-1, -2}
    }, 
    { //0 >> 1 state, index 1
      {0, 0}, {-1, 0}, {-1, -1}, {0, 2}, {-1, -2} 
    }, 
    { //1 >> 2 state, index 2
      {0, 0}, {1, 0}, {1, 1}, {0, -2}, {1, -2}
    }, 
    { //2 >> 3 state, index 3
      {0, 0}, {1, 0}, {1, -1}, {0, 2}, {1, 2}
    }
  };
  SRS() {
  }
  
  int getSRS(int x, int y, int z) {
    try {
      return srs[x][y][z];
    } catch (ArrayIndexOutOfBoundsException e) {
      print("ERROR: " + x + " " + y + " " + z + "\n");
      return 0;
    }
  }
}
