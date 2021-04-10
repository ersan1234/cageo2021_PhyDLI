%train_PhyDLI.m Matlab script loads synthetic data and models to train a neural network 
%This code is executed at each PhyDLI cycles after updating the training data set with early inversion results.
%Each line of the code has comments explaining the variables and settings.



%CAGEO_PhyDLI.m Matlab script reproduces two main figures
%It illustrates the prediction improvement from the first training data set to final training data set
Data_OriginalPrediction_PhyDLI_Prediction.fig : This figure illustrates the prediction improvement with PhyDLI cycles over individual soundings
Training_testing_first_and_final_prediction.fig: This figure illustrates the prediction improvement with PhyDLI cycles over the entire test data set by histogram plots

%Script does the following steps:
%Load pretrained neural networks 
%Load the testing (Alien) data and models
%Make predictions
%Calculate model RMS and make plots
%Load the original training data and models
%Plot test models and their predictions from first training and final training
%Plot histograms of training model, testing model and predictions

nets.mat: Pretrained neural networks containing first and final networks
Test_dataAR.mat: Synthetic test data (apparent resistivity in log domain)
Test_models.mat: Synthetic test models (resistivity in log domain)
Original_training_dataAR_5pct_noise.mat: Original (first) trainin data (5% noise added apparent resistivity in log domain)
Original_training_models.mat: Original (first) training models (resistivity in log domain)
Final_trainign_dataAR_5pct_noise.mat: Final training data after PhyDLI cycles
Final_training_models.mat: Final training models after PhyDLI cycles

