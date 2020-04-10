%Combine the data for the same tetrode on the same day from first 2
%epoches and plot the spectrogram for all epoch
%seperate different epoches by lines


%function spctgcombined(day,tet)
ee8_day = 3;
ee8_tet = 4;
ee8_epoch_beforeRev = 9;
ee8_epoch_afterRev = 11;

dataDir = '/media/jadhavlab/DATA/Projects/eeyd_a5GABA_Project/EE8_FF-_Experiment/EE8_direct/';
fn = sprintf('%sEEG/EE8eegref%02i-%02i-%02i.mat',dataDir,ee8_day,ee8_epoch_beforeRev,ee8_tet);
load(fn);

time_epoch1 = (eegref{ee8_day}{ee8_epoch_beforeRev}{ee8_tet}.timerange(2)-eegref{ee8_day}{ee8_epoch_beforeRev}{ee8_tet}.timerange(1))/60;

a = eegref{ee8_day}{ee8_epoch_beforeRev}{ee8_tet}.data;

dataDir = '/media/jadhavlab/DATA/Projects/eeyd_a5GABA_Project/EE8_FF-_Experiment/EE8_direct/';
fn2 = sprintf('%sEEG/EE8eegref%02i-%02i-%02i.mat',dataDir,ee8_day,ee8_epoch_afterRev,ee8_tet);
load(fn2);

b = eegref{ee8_day}{ee8_epoch_afterRev}{ee8_tet}.data;

movingwin = [1 0.1];

params.Fs = 1500;
params.fpass=[0 200];


data = [a;b];

[S,t,f] = mtspecgramc(data,movingwin,params);

figure(1);clf;
plot_matrix(S,t/60,f);
xlabel('Time(min)');
%xlim([14 17]);
ylabel('Frequency(Hz)');
title({'0-50Hz Spectrogram of LFP for EE8', sprintf('Day %i, Tet %i',ee8_day,ee8_tet')});
caxis([8 40]); colorbar;colormap jet;

hold on;
x=[time_epoch1 time_epoch1];
y=[50 200];
line(x,y,'color','k','LineWidth',2);