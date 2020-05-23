s.boot;
s.reboot;
s.quit;
Server.local.boot;
//retrieve the current IP and port
NetAddr.localAddr

//TCP-Server listening on TCP-Port 11000
s = Server(\tcpServer, NetAddr("127.0.0.1", 11000));
//show open ports
thisProcess.openPorts;

(
SynthDef.new('funsynth', {
	arg pitch=200;
	var sound = SinOsc.ar(pitch, mul:0.2);
	var linen = Env.linen(0.01, sustainTime:0, releaseTime:1);
	var env = EnvGen.kr(linen, doneAction:2);
	Out.ar(0, sound * env);
}).add;
)
x = Synth.new('funsynth').play;
x.free;

{SinOsc.ar}.play;



(
OSCdef('crystalSonify', {
	arg msg;
	Synth('funsynth', [pitch:msg[1]*400+60]);
	//Synth('funsynth', [pitch:50.rrand(600)]);
}, "/testMessage");
)

(
OSCdef('crystalSonify', {
	arg msg;
	msg.do({ arg item; Synth('funsynth', [pitch:item]) });
}, "/testMessage");
)


//msg[1] is first value we send
(
OSCdef('receiveProcessing', {
	arg msg;
	//print all messages we get
	msg.do({ arg item; item.postln });
}, "/testMessage");
)

//post contents of array
(
z = Array.new(5);
z = z.add(1);
z = z.add(2);
z = z.add(3);
z = z.add(9);
z = z.add(5);
z.do({ arg item; item.postln });
//z.size.do({ arg item; item.postln }); -> size of Array
)
z.free;
"you".do({ arg item; item.postln });