class DiffImageMaker {
  private ArrayList<Float> xCoor;
  private ArrayList<Float> yCoor;
  DiffImageMaker() {
    xCoor = new ArrayList<Float>();
    yCoor = new ArrayList<Float>();
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
        if(!((rDiff == 0.0) && (gDiff == 0.0) && (bDiff == 0.0))) {
          float xF = x;
          float yF = y;
          xCoor.add(map(xF, 0, width, 0, 1));
          yCoor.add(map(yF, 0, width, 0, 1));
        }
        color diffColor = color(rDiff, gDiff, bDiff);
        diffImage.pixels[loc] = diffColor;
      } 
    }
    diffImage.updatePixels();
    return diffImage;
  }
  ArrayList<Float> getXCoor() {
    return xCoor;
  }
  ArrayList<Float> getYCoor() {
    return yCoor;
  }
}
