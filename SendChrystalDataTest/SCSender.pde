import oscP5.*;
import netP5.*;
class SCSender {
  private OscP5 osc;
  private NetAddress supercollider; //Empfaenger
  private OscMessage msg;
  SCSender() {
    osc = new OscP5(this, 12000);
    supercollider = new NetAddress("127.0.0.1", 57120);
  }
  void sendToSC(int x, int y, float hue) {
    msg = new OscMessage("/crystalgrowth");
    msg.add(x); 
    msg.add(y);
    msg.add(hue);
    osc.send(msg, supercollider);
  }
}
