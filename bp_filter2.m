function  [B A]=bp_filter2(fs,sf_start,f_start,f_end,sf_end)
%generate filter parameters for filtfilt function
fs=fs/2;

%band pass filter
Wp = [f_start/fs f_end/fs];%
Ws = [sf_start/fs sf_end/fs];%
Wn = 0;
[N,Wn] = cheb1ord(Wp,Ws,5,24);
[B,A] = cheby1(N,0.5,Wn);
%y = filtfilt(B,A,x);

% figure
% FREQZ(B,A)
