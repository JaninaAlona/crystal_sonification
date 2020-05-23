//message too long
import oscP5.*;
import netP5.*;
class SCSender {
  private OscP5 osc;
  private NetAddress supercollider; //Empfaenger
  private OscMessage msg;
  private ArrayList<PImage> data;
  private ArrayList<Float> brightnessData;
  SCSender(ArrayList<PImage> data) {
    osc = new OscP5(this, 12000);
    supercollider = new NetAddress("127.0.0.1", 57120);
    this.data = data;
    brightnessData = new ArrayList<Float>();
  }
  void extractData() {
    for(int i = 0; i < data.size(); i++) {
      PImage dataImage = data.get(i);
      dataImage.loadPixels();
      for(int x = 0; x < dataImage.width; x++) {
        for(int y = 0; y < dataImage.height; y++) {
          int loc = x + y * width;
          if(brightness(dataImage.pixels[loc]) > 0) {
            float pixelBrightness = brightness(dataImage.pixels[loc]);
            pixelBrightness = map(pixelBrightness, 0, 255, 0, 1);
            brightnessData.add(pixelBrightness);
          }
        }
      }
    }
  }
  ArrayList<Float> getBrightnessData() {
    return brightnessData;
  }
  void sendToSC(float value) {
    msg = new OscMessage("/testMessage");
    msg.add(value); //Daten hier hinzufuegen
    osc.send(msg, supercollider);
  }
}
