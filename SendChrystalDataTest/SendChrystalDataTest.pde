int numOfImages = 26;
int imageCounter = 0;
int msgCounter = 0;
PImage[] sourceImages;
PImage[] pathImages;
ArrayList<PImage> destImages;
ArrayList<Integer> xCoor;
ArrayList<Integer> yCoor;
ArrayList<Float> hues;
int maxDataSize = 0;
DiffImageMaker diffMaker;
SCSender toSuperCollider;
void setup() {
  size(1480, 1080);
  colorMode(RGB);
  background(0);
  frameRate(20);
  sourceImages =  new PImage[numOfImages];
  pathImages =  new PImage[numOfImages];
  destImages = new ArrayList<PImage>();
  xCoor = new ArrayList<Integer>();
  yCoor = new ArrayList<Integer>();
  diffMaker = new DiffImageMaker();
  toSuperCollider = new SCSender();
  //Load images into Processing
  for(int i = 0; i < numOfImages; i++) {
    String imgName = "crystalgrowth_"+nf(i, 2)+".jpg";
    PImage source = loadImage(imgName); 
    sourceImages[i] = source;
  }
  for(int i = 0; i < numOfImages; i++) {
    String imgName = "crystalgrowth_paths_"+nf(i, 2)+".jpg";
    PImage source = loadImage(imgName); 
    pathImages[i] = source;
  }
  for(int i = 0; i < numOfImages - 1; i++) {
    PImage first = pathImages[imageCounter];
    PImage second = pathImages[imageCounter+1];
    PImage diffImage = diffMaker.computeDiffImage(first, second);
    diffImage.save("diffs_crystalgrowth_"+nf(imageCounter, 2)+".jpg");
    destImages.add(diffImage);
  }
  xCoor = diffMaker.getXCoor();
  yCoor = diffMaker.getYCoor();
  hues = diffMaker.getHue();
}
void draw() {
  //display original images
  if(imageCounter < numOfImages) {
    image(sourceImages[imageCounter], 0, 0);
  }
  if(imageCounter < numOfImages) {
    imageCounter++;
  }
  if(msgCounter < xCoor.size()) {
    toSuperCollider.sendToSC(xCoor.get(msgCounter), yCoor.get(msgCounter), hues.get(msgCounter));
  }
  if(msgCounter < xCoor.size()) {
    msgCounter++;
  }
}
