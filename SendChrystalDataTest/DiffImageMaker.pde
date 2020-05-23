class DiffImageMaker {
  private ArrayList<PImage> diffImages;
  DiffImageMaker() {
    diffImages = new ArrayList<PImage>();
  }
  void computeDiffImage(PImage first, PImage second) {
    PImage diffImage = createImage(1480, 1080, RGB);
    first.loadPixels();
    second.loadPixels();
    diffImage.loadPixels();
    for(int x = 0; x < first.width; x++) {
      for(int y = 0; y < first.height; y++) {
        int loc = x + y * first.width;
        float redFirst = first.pixels[loc] >> 16 & 0xFF;
        float greenFirst = first.pixels[loc] >> 8 & 0xFF;
        float blueFirst = first.pixels[loc] & 0xFF;
        float redSecond = second.pixels[loc] >> 16 & 0xFF;
        float greenSecond = second.pixels[loc] >> 8 & 0xFF;
        float blueSecond = second.pixels[loc] & 0xFF;
        float redDiff = abs(redFirst - redSecond);
        float greenDiff = abs(greenFirst - greenSecond);
        float blueDiff = abs(blueFirst - blueSecond);
        color diffColor = color(redDiff, greenDiff, blueDiff);
        diffImage.pixels[loc] = diffColor;
      } 
    }
    diffImage.updatePixels();
    diffImages.add(diffImage);
  }
  ArrayList<PImage> getDiffImages() {
    return diffImages;
  }
}
