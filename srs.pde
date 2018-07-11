class SRS {
  int[][][] srs = {
    //http://tetris.wikia.com/wiki/SRS
    { //3 >> 0 state, index 0
      {0, 0}, {-1, 0}, {-1, -1}, {0, 2}, {-1, 2}
    }, 
    { //0 >> 1 state, index 1
      {0, 0}, {-1, 0}, {-1, 1}, {0, -2}, {-1, 2} 
    }, 
    { //1 >> 2 state, index 2
      {0, 0}, {1, 0}, {1, -1}, {0, 2}, {1, 2}
    }, 
    { //2 >> 3 state, index 3
      {0, 0}, {1, 0}, {1, 1}, {0, -2}, {1, -2}
    }
  };
  SRS() {
  }
  
  int getSRS(int x, int y, int z) {
    return srs[x][y][z];
  }
}
