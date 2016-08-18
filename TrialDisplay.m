function [stim_oder]=TrialDisplay(cfg)
%visualization of one epoch using Psychtoolbox
%putvalue(cfg.dio,N);

%draw all the rectangles
%the display area no larger than 90% of the max. square
L_squL = min([cfg.rect(3)-cfg.rect(1) cfg.rect(4)-cfg.rect(2)])*0.9;
w_offset = (cfg.rect(3)-cfg.rect(1)-L_squL)/2;
h_offset = (cfg.rect(4)-cfg.rect(2)-L_squL)/2;
%the width/height of the individual squares
L_squS = round(L_squL/6/3);

n_per_trial = length(cfg.codebook);  %12
nframes = n_per_trial * (cfg.nfr_disp + cfg.nfr_rest) + cfg.trial_offset;  % 156 =  12 * (9 +3) +12 
frame_cnt = 0;  %??? 12 
stim_oder = randperm(n_per_trial);
epoch_cnt = 1;
word=[65 66 67 68 69 70;71 72 73 74 75 76; 77 78 79 80 81 82;83 84 85 86 87 88;89 90 48 49 50 51; 52 53 54 55 56 57];
Screen('TextSize', cfg.w ,18);%shy

if (cfg.first_count==0)
    %draw basic structure
    Screen('FillRect', cfg.w, cfg.white, cfg.rect);
    for i = 1:6
        for j = 1:6
            row_s = w_offset + L_squS + 3*(i-1)*L_squS;
            col_s = h_offset + L_squS + 3*(j-1)*L_squS;
            Screen('FrameRect', cfg.w, cfg.black, [row_s col_s row_s+L_squS col_s+L_squS], 2);
            Screen('DrawText', cfg.w, word(j,i) ,row_s+12, col_s-32,cfg.black);
        end
    end
    Screen('DrawText', cfg.w, cfg.result ,cfg.rect(1),cfg.rect(4)-30 ,cfg.black);
    Screen('Flip', cfg.w);
    imageArray=Screen('GetImage', cfg.w);
    textureIndex=Screen('MakeTexture', cfg.w,imageArray); 
    cfg.first_count=1;
end

stim_code = cfg.codebook{1};
color_order = randperm(size(stim_code,2));

%一个trial长3.1s =186/60.一个trail有12个epoch，每个epoch是200ms，包含150ms的光标运动和50ms的时间间隔。每个trial之间的间隔为500ms，开始前静止200ms（此处并非必要）

for kk = 1:nframes+cfg.trial_offset_post  %186 = 156+30
    %read in data from TCP/IP

    [keyIsDown,secs, keyCode, deltaSecs] = KbCheck;
    if(keyIsDown)
        if(keyCode(KbName('esc')))
             Screen('closeall');
        end
    end
    
    Screen('DrawTexture', cfg.w, textureIndex);%shy    

    %draw moving bars
    frame_cnt = frame_cnt + 1;
    moving_index = mod(frame_cnt-cfg.trial_offset-1,cfg.nfr_disp + cfg.nfr_rest);  % mod(frame_cnt - 13,12)
    if(frame_cnt < cfg.trial_offset || frame_cnt > nframes)
        Screen('DrawingFinished', cfg.w);
        Screen('Flip', cfg.w);
        continue;
    elseif(moving_index < cfg.nfr_disp) %motion 9/60 = 150ms
        stim_code = cfg.codebook{stim_oder(epoch_cnt)};
        for ii = 1:size(stim_code,2)
            w_index = stim_code(1,ii);
            h_index = stim_code(2,ii);
            line_w_s = w_offset + L_squS + 3*(w_index-1)*L_squS + L_squS/2 - moving_index;
            line_h_s = h_offset + L_squS + 3*(h_index-1)*L_squS;
            Screen('DrawLine', cfg.w, cell2mat(cfg.colors(color_order(ii),:)),line_w_s, line_h_s, line_w_s, line_h_s + L_squS, 4);
        end
        if(moving_index == cfg.nfr_disp - 1) %一列或行运动完后epoch+1
            epoch_cnt = epoch_cnt + 1;
            color_order = randperm(size(stim_code,2));
        end
        if(moving_index == 0)   %trigger value is 1 for 50ms
            if(cfg.if_para)
              putvalue(cfg.dio,1);
            end
        end
        if(moving_index == 3) %trigger is 0 
            if(cfg.if_para)
                putvalue(cfg.dio,0);
            end            
        end
    end
    Screen('DrawingFinished', cfg.w);
    Screen('Flip', cfg.w);
end
