%This script reproduces two main figures of the paper titled 'Coupled Physics-Deep Learning Inversion: Application to Transient Electromagnetic Imaging'
%It illustrates the prediction improvement from the first training data set to final training data set
%Authors: Daniele Colombo, Ersan Turkoglu, Weichang Li, and Diego Rovetta
%March, 2021
%
%Load the testing (Alien) data and models
%Load pretrained neural networks
%Make predictions
%Calculate model RMS and make plots
%Load the original training data and models
%Plot histograms of training model, testing model and predictions
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This section will plot the network predictions for the test data. Here we
% are comparing the original training vs final training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
load nets.mat                                %Load pretrained networks using the original and final training data
% Above line loads pretrained neural networks: 
% original_training_network and final_training_network

%Load Test/Alien data sets here
load Test_dataAR.mat                            %5000 Apparent resistivity data with 30 samples for each data position
load Test_models.mat                            %5000 models with 50 layers, each layer is 5m thick

Pred_original_training=10.^original_training_network(RhoaLE')';
Pred_final_training=10.^final_training_network(RhoaLE')';

RMS_original_training=sqrt(sum((TDEM_model(:)-log10(Pred_original_training(:))).^2) / numel(TDEM_model(:)) );
RMS_final_training=sqrt(sum((TDEM_model(:)-log10(Pred_final_training(:))).^2) / numel(TDEM_model(:)) );

st_to_plt=randi(5000,1,9); %station numbers to plot, randomly choosing 9 test stations
figure(1);clf
for stp=1:9
    subplot(3,3,stp); semilogx(10.^TDEM_model(st_to_plt(stp),:),2.5:5:250,'r','LineWidth',2); hold on
    semilogx(Pred_original_training(st_to_plt(stp),:),2.5:5:250,'b','LineWidth',2);
    semilogx(Pred_final_training(st_to_plt(stp),:),2.5:5:250,'k','LineWidth',2);
    axis([1 100 0 250]);set(gca,'YDir','reverse');
    ylabel('Depth (m)'); xlabel('Resistivity (\Omegam)');
    if stp==9;legend('True model',['Prediction from the original training'],'Prediction from the final training');end
end
TDEM_model_test=TDEM_model;
%%%%%%%%%%%%%%%%%%%%%%%%%
% This section plots the model histograms for the first and the final
% predictions vs test data histograms
%%%%%%%%%%%%%%%%%%%%%%%%%
load Original_training_models.mat               %5000 models with 50 layers, each layer is 5m thick
TDEM_models_original_training=TDEM_model;

edges=0:0.05:3
[BC,BE]=histcounts(TDEM_models_original_training,edges);   %define bins
figure(2);clf
% plot original training histogram
histogram('BinEdges',BE,'BinCounts',BC,'Normalization','pdf'); hold on; xlabel('Resistivity (\Omegam)'); ylabel('PDF'); xlim([0 3])
set(gca,'XTick',[0 1 2 3],'XTickLabel',{'1' '10' '100' '1000'})

edges=0:0.05:3
[BC,BE]=histcounts(TDEM_model_test,edges);   %define bins
% plot test data histogram
histogram('BinEdges',BE,'BinCounts',BC,'Normalization','pdf','facecolor','g');

edges=0:0.05:3
[BC,BE]=histcounts(log10(Pred_original_training),edges);   %define bins
% plot predictions from first/original training
histogram('BinEdges',BE,'BinCounts',BC,'Normalization','pdf','EdgeColor','b','DisplayStyle','stairs','linewidth',2); hold on;

edges=0:0.05:3
[BC,BE]=histcounts(log10(Pred_final_training),edges);   %define bins
% plot predictions from final training
histogram('BinEdges',BE,'BinCounts',BC,'Normalization','pdf','EdgeColor','k','DisplayStyle','stairs','linewidth',2); hold on;

legend('Initial training data','Test/Alien data','First prediction','Final prediction');
title(['First prediction RMS: ',num2str(RMS_original_training),'   -   Final prediction RMS: ',num2str(RMS_final_training)])




