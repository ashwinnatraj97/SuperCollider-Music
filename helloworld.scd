Server.local.boot;
// Our Audio Sampling Rate is 44.1 KHz
Server.local.sampleRate;
(
"Kathavarayan Programming Some Algo Music".postln;
// Function are always inside {} braces
// To get the value of the function put .value at the end of the function
// Declare function to variables to have a name associated with it
// Environment values start with a ~
{PinkNoise.ar * 0.3}.play;
{SinOsc.ar * 0.3}.play;
{SinOsc.ar(LFNoise2.kr(12).range(400,2000), mul: 0.01) * 0.3}.play;
{RLPF.ar(Dust.ar([6, 10]), LFNoise0.ar([20, 35]).range(900, 30000), rq: 0.02) * 0.3}.play;
)

(
~pinksound = {arg amp = 0.5; var sig; sig = PinkNoise.ar!2 * amp};
)
x = ~pinksound.play(args:[\amp, 0.01]);

// Array of Synth Generators - Different Channels

{[PinkNoise.ar * 0.3, PinkNoise.ar * 0.5]}.play;

// To take a single variable/object and convert it into an array we use a dup
// For Synthesizers we need to use ! to duplicate across different hardware channels

{(SinOsc.ar(freq: 550) * 0.3)!2}.play;

/*Synthesizer Audio Rate - ar (Goverened by the Sampling Rate of the Server)*/
~sinsound = {arg freq = LFNoise0.kr(10).range(200, 1000), amp = 0.1; var sig; sig = (SinOsc.ar(freq) * amp)!2};
~sinsound.play(args:[\freq: 320, \amp: 0.09]);

// Dynamically change the arguments while playing
x.set(\freq, 600);
x.free;

// Nested Functions
(
~func = {
	arg amp = 0.1, freq = 440;
	~sound = {
		var sig;
		sig = (SinOsc.ar(freq: freq)!2 * amp)
	}.play;
}
)
~sinsound.play();
~func.value(0.1, 700);
~sinsound.plot(0.01);
Server.killAll;