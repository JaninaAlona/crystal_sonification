s.boot;
s.meter;
s.quit;


///////////////////////////original
(
SynthDef.new(\crystalsynth, {
	arg pitchX=300, pitchY=500, pitchH=700;
	var amp, sig, linen, env;
	amp = SinOsc.kr([7, 1, 2, 0.2, 6]).range(0, 0.5);
	sig = SinOsc.ar([pitchX, pitchY, pitchH]);
	linen = Env.linen(0.01, sustainTime:0, releaseTime:1);
	env = EnvGen.kr(linen, doneAction:Done.freeSelf);
	sig = sig * env * amp;
	sig = Splay.ar(sig) * 0.5;
	Out.ar(0, sig);
}).add;
)
x = Synth.new(\crystalsynth);
x.free;

(
OSCdef('crystalSonify', {
	arg msg;
	Synth(\crystalsynth, [pitchX:msg[1]]);
	Synth(\crystalsynth, [pitchY:msg[2]-1000]);
	Synth(\crystalsynth, [pitchH:msg[3]+100]);
}, "/crystalgrowth");
)
