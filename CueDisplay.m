function CueDisplay(cfg,col,row)
%display the attention target for the next trial

L_squL = min([cfg.rect(3)-cfg.rect(1) cfg.rect(4)-cfg.rect(2)])*0.9;
w_offset = (cfg.rect(3)-cfg.rect(1)-L_squL)/2;
h_offset = (cfg.rect(4)-cfg.rect(2)-L_squL)/2;
%the width/height of the individual squares
L_squS = round(L_squL/6/3);
word=[65 66 67 68 69 70;71 72 73 74 75 76; 77 78 79 80 81 82;83 84 85 86 87 88;89 90 48 49 50 51; 52 53 54 55 56 57];
Screen('FillRect', cfg.w, cfg.white, cfg.rect);
Screen('TextSize', cfg.w ,18);%shy
for i = 1:6
    for j = 1:6
        row_s = w_offset + L_squS + 3*(i-1)*L_squS;
        col_s = h_offset + L_squS + 3*(j-1)*L_squS;

        Screen('FrameRect', cfg.w, cfg.black, [row_s col_s row_s+L_squS col_s+L_squS], 2);
        Screen('DrawText', cfg.w, cfg.word(j,i) ,row_s+12, col_s-32 ,cfg.black);

        Screen('DrawText', cfg.w, cfg.result ,cfg.rect(1)+300,cfg.rect(4)-150 ,cfg.black);%Êä³ö½á¹û
        if(i == row && j == col)
            Screen('FillRect', cfg.w, cfg.black, [row_s col_s row_s+L_squS col_s+L_squS]);
        end
    end
end
Screen('DrawingFinished', cfg.w);
Screen('Flip', cfg.w);
