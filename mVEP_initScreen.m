function out = mVEP_initScreen(cfg)
try
    out = cfg;
%     Screen('Preference', 'SkipSyncTests', 1);
    screens=Screen('Screens'); %1;
    screenNumber=max(screens);

    %Switch the following two lines for WINDOW or FULL_SCREEN mode
    if(cfg.if_fullscr ~= 1)
        [w, rect] = Screen('OpenWindow', screenNumber, 0,[50,50,801,601],[],2);
    else
        [w, rect] = Screen('OpenWindow', screenNumber, 0,[], [], 2);
    end
    %             out.color_num=size(cfg.dot_color,1);
    if IsLinux==0
        Screen('TextFont',w, 'Courier New');
        Screen('TextSize',w, 14);
        Screen('TextStyle', w, 1+2);
    end;

    % Enable alpha blending with proper blend-function. We need it
    % for drawing of smoothed points:
    %             Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    %             [center(1), center(2)] = RectCenter(rect);
    fps=Screen('FrameRate',w);      % frames per second
    ifi=Screen('GetFlipInterval',w);
    if fps==0
        fps=1/ifi;
    end;

    out.black = BlackIndex(w);
    out.white = WhiteIndex(w);
    out.w = w;
    out.rect = rect;
    %             out.center = center;
    out.fps = fps;
    out.ifi = ifi;
    out.first_count=0;
catch
    pnet('closeall');
    Screen('closeall');
    ShowCursor;
    err = lasterror;
    disp(err.message);
    err.stack.line
%     disp(['Line: ' int2str(er.stack.line)]);
%     fprintf('%s\nline: %d\n',er.message,er.stack.line)
end
