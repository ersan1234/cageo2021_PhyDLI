clear all; close all
load Original_training_models.mat  %This loads TDEM_model variable with all the synthetic models in log10 domain
load Original_training_dataAR_5pct_noise.mat %This loads RhoaLE variable with all the synthetic model responses (ie apparent resistivity data in log10 domain)

x = RhoaLE'; %Synthetic TDEM data, log domain apparent resistivity
t = TDEM_model'; %Corresponding synthetic TDEM models, log domain apparent resistivity
trainFcn = 'trainbr';  % Training function
hiddenLayerSize = [30]; % Single hidden network with 30 neurons 
net = fitnet(hiddenLayerSize,trainFcn); %create a function fitting feedforward type neural network
net.input.processFcns = {'mapminmax'}; %intput and output pre-processing
net.output.processFcns = {'mapminmax'}; %intput and output pre-processing
net.trainParam.epochs=10;  %Number of epochs

% % % % % % % Setup Division of Data for Training, Validation, Testing
% % % % % % % For a list of all data division functions type: help nndivision
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every samplenet
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
net.performFcn = 'mse';  % Mean Squared Error performance function

% Plot Functions
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
    'plotregression', 'plotfit'};

% Train the Network
[net,tr] = train(net,x,t,'showResources','yes','useParallel','yes','CheckpointFile','MyCheckpoint.mat');
