class DiffImageMaker {
  private ArrayList<Integer> xCoor;
  private ArrayList<Integer> yCoor;
  DiffImageMaker() {
    xCoor = new ArrayList<Integer>();
    yCoor = new ArrayList<Integer>();
  }
  PImage computeDiffImage(PImage first, PImage second) {
    PImage diffImage = createImage(1480, 1080, RGB);
    first.loadPixels();
    second.loadPixels();
    diffImage.loadPixels();
    for(int x = 0; x < first.width; x++) {
      for(int y = 0; y < first.height; y++) {
        int loc = x + y * first.width;
        float rFirst = first.pixels[loc] >> 16 & 0xFF;
        float gFirst = first.pixels[loc] >> 8 & 0xFF;
        float bFirst = first.pixels[loc] & 0xFF;
        float rSecond = second.pixels[loc] >> 16 & 0xFF;
        float gSecond = second.pixels[loc] >> 8 & 0xFF;
        float bSecond = second.pixels[loc] & 0xFF;
        float rDiff = abs(rFirst - rSecond);
        float gDiff = abs(gFirst - gSecond);
        float bDiff = abs(bFirst - bSecond);
        if((rDiff != 0) && (gDiff != 0) && (bDiff != 0)) {
          xCoor.add(x);
          yCoor.add(y);
        }
        color diffColor = color(rDiff, gDiff, bDiff);
        diffImage.pixels[loc] = diffColor;
      } 
    }
    diffImage.updatePixels();
    return diffImage;
  }
  ArrayList<Integer> getXCoor() {
    return xCoor;
  }
  ArrayList<Integer> getYCoor() {
    return yCoor;
  }
}
