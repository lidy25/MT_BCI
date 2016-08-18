function out = mVEP_initStim(cfg)
% initialize dot positions and velocities
out = cfg;
%if(abs(cfg.fps-120)>1)
if(abs(cfg.fps-60)>1)
    disp('only 60Hz refresh rate supported, please change the monitor settings');
    return;
end
out.nfr_disp = 9;%correspond to 150ms
out.nfr_rest = 3;%correspond to 50ms
out.trial_offset = out.nfr_disp + out.nfr_rest;%first present the matrix for 200ms without moving
out.trial_offset_post = 30;%500ms, reserved time for the trial presentation for the completion of data transmission
out.codebook = P300CodebookGen();%codebook matrix (col x row)
out.colors = {255 0 0; 0 255 0; 0 0 255; 255 0 255; 160 82 45; 100 120 100};
