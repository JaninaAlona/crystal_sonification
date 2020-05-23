int numOfImages = 26;
int imageCounter = 0;
int messageCounter = 0;
PImage[] sourceImages;
ArrayList<PImage> destImages;
ArrayList<Float> dataToSend;
DiffImageMaker diffMaker;
SCSender toSuperCollider;
void setup() {
  size(1480, 1080);
  background(0);
  frameRate(20);
  sourceImages =  new PImage[numOfImages];
  destImages = new ArrayList<PImage>();
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
  toSuperCollider = new SCSender(destImages);
  toSuperCollider.extractData();
  dataToSend = toSuperCollider.getBrightnessData();
}
void draw() {
  //display original images
  if(imageCounter < numOfImages) {
    image(sourceImages[imageCounter], 0, 0);
  }
  if(imageCounter < numOfImages) {
    imageCounter++;
  }
  //Send data
  if(messageCounter < dataToSend.size()) {
    toSuperCollider.sendToSC(dataToSend.get(messageCounter));
  }
  if(messageCounter < dataToSend.size()) {
    messageCounter++;
  }
}
