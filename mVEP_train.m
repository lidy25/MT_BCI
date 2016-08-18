function mVEP_train()
%the funtion getting the data of patients and trainning by SVM
%Editor: dy.lucien@gmail.com   Data:2015.8.24

Screen('Preference', 'SkipSyncTests', 1); %shy
%% exp parameters
cfg=[];
trial_targets_col = [1 2 3 4 5 6  ]; %the sequence of the stimulation,12 blocks
trial_targets_row = [1 2 3 4 5 6  ];
trail_per_block = 10; %the number that watching the same target
cfg.if_fullscr = 1;
cfg.if_para =1;
cfg.word = [65 66 67 68 69 70;71 72 73 74 75 76; 77 78 79 80 81 82;83 84 85 86 87 88;89 90 48 49 50 51; 52 53 54 55 56 57];
%% subject information
while 1
    sub_name=input('sub_name? ','s');    
    pass=1;
    p=dir;
    for i=1:length(p)
        if(strcmp(p(i).name,[sub_name '.mat'])==1)
            disp('name already existed, re-enter the name.');
            pass=0;
        end
    end
    if(pass)
        break;
    end
end

%% initialize parallel port
try
    cfg.dio = digitalio('parallel','LPT1');
    hline = addline(cfg.dio, 0:7, 'Out');
    putvalue(cfg.dio,0);
catch
    disp('No digitalio.');
    cfg.if_para = 0;
end

%% initialize PsychoToolbox
cfg = mVEP_initScreen(cfg);
cfg = mVEP_initStim(cfg);
cfg.result=[32];

for i = 1:length(trial_targets_col)
    %display attention cue
    CueDisplay(cfg,trial_targets_col(i),trial_targets_row(i));
    WaitSecs(2);
    %%display the stimulation
    for j = 1:trail_per_block
        [stim_order(i,j,:)]=TrialDisplay(cfg);
    end
end

Screen('closeall');
save(sub_name,'cfg','stim_order');


