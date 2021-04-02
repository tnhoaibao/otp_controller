`timescale 1ns/10ps
module efuse_model (
	CSB,
	STROBE,
	LOAD,
	Q,
	VDDQ,
	A,
	PGENB,
	VDD,
	VSS
);

input CSB;
input STROBE;
input LOAD;
output [7:0] Q;
input VDDQ;
input [9:0] A;
input PGENB;
