clc;
clear all;
close all;

n = 10;

[y,fs] = audioread('music_bless.m4a');
info = audioinfo('music_bless.m4a');
sound(y,fs/n);

time=(1:length(y))/(fs/n);	
plot(time, y);	