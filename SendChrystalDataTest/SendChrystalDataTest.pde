int numOfImages = 26;
int imageCounter = 0;
int msgCounter = 0;
PImage[] sourceImages;
ArrayList<PImage> destImages;
ArrayList<Integer> xCoor;
ArrayList<Integer> yCoor;
int maxDataSize = 0;
DiffImageMaker diffMaker;
SCSender toSuperCollider;
void setup() {
  size(1480, 1080);
  colorMode(RGB);
  background(0);
  frameRate(20);
  sourceImages =  new PImage[numOfImages];
  destImages = new ArrayList<PImage>();
  xCoor = new ArrayList<Integer>();
  yCoor = new ArrayList<Integer>();
  diffMaker = new DiffImageMaker();
  //Load images into Processing
  for(int i = 0; i < numOfImages; i++) {
    String imgName = "crystalgrowth_"+nf(i, 2)+".jpg";
    PImage source = loadImage(imgName); 
    sourceImages[i] = source;
  }
  for(int i = 0; i < numOfImages - 1; i++) {
    PImage first = sourceImages[imageCounter];
    PImage second = sourceImages[imageCounter+1];
    PImage diffImage = diffMaker.computeDiffImage(first, second);
    diffImage.save("diffs_crystalgrowth_"+nf(imageCounter, 2)+".jpg");
    destImages.add(diffImage);
  }
  toSuperCollider = new SCSender();
  xCoor = diffMaker.getXCoor();
  yCoor = diffMaker.getYCoor();
  if(xCoor.size() > maxDataSize) {
    maxDataSize = xCoor.size();
  }
  if(yCoor.size() > maxDataSize) {
    maxDataSize = yCoor.size();
  }
}
void draw() {
  //display original images
  if(imageCounter < numOfImages) {
    image(sourceImages[imageCounter], 0, 0);
  }
  if(imageCounter < numOfImages) {
    imageCounter++;
  }
  if((msgCounter >= xCoor.size()) && (msgCounter < yCoor.size())) {
    toSuperCollider.sendToSC(0, yCoor.get(msgCounter));
  }
  if((msgCounter < xCoor.size()) && (msgCounter >= yCoor.size())) {
    toSuperCollider.sendToSC(xCoor.get(msgCounter), 0);
  }
  if((msgCounter < xCoor.size()) && (msgCounter < yCoor.size())) {
    toSuperCollider.sendToSC(xCoor.get(msgCounter), yCoor.get(msgCounter));
  }
  if(msgCounter < maxDataSize) {
    msgCounter++;
  }
}
