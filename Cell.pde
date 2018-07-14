class Cell {
  Cell() {
  }

  void draw(int xcoord, int ycoord, color colorID) {
    PImage image;
    if (colorID == gray) {
      image = cellshade;
      tint(colorID);
    } else if (colorID == bg) {
      image = bgcell; //image already right shade
      noTint();
    } else {
      image = cellimg;
      tint(colorID);
    }

    image(image, xcoord * CELL_WIDTH + ORIGINX, ycoord * CELL_WIDTH + ORIGINY);
  }
}
