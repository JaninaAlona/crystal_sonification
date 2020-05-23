int numOfImages = 3;
int dataCounter = 0;
PImage[] sourceImages;
ArrayList<PImage> destImages;
ArrayList<Float> dataToSend;
DiffImageMaker diffMaker;
SCSender toSuperCollider;
void setup() {
  background(0);
  size(1480, 1080);
  sourceImages =  new PImage[numOfImages];
  diffMaker = new DiffImageMaker();
  for(int i = 0; i < numOfImages; i++) {
    String imgName = "crystalgrowth_"+nf(i, 2)+".png";
    PImage source = loadImage(imgName); 
    sourceImages[i] = source;
  }
  for(int i = 0; i < numOfImages - 1; i++) {
    PImage first = sourceImages[i];
    PImage second = sourceImages[i+1];
    diffMaker.computeDiffImage(first, second);
  }
  destImages = diffMaker.getDiffImages();
  for(int i = 0; i < destImages.size(); i++) {
    destImages.get(i).save("diffs_crystalgrowth_"+nf(i, 2)+".png");
  }
  toSuperCollider = new SCSender(destImages);
  toSuperCollider.extractData();
  dataToSend = toSuperCollider.getBrightnessData();
}
void draw() {
  if(dataCounter < numOfImages) {
    image(sourceImages[dataCounter], 0, 0);
  }
  if(dataCounter < dataToSend.size()) {
    toSuperCollider.sendToSC(dataToSend.get(dataCounter));
  }
  if(dataCounter < dataToSend.size()) {
    dataCounter++;
  }
  delay(1000);
}
