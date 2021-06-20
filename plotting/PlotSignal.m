function PlotSignal(recordingDataMatrix, recordingTimestamps)
SCREEN_SIZE = [1920, 1080];

figureHandle = figure('name', 'Recording');
dimensionCnt = size(recordingDataMatrix, 1);
for d = 1:dimensionCnt
    subplot(dimensionCnt, 1, d);
    plot(recordingTimestamps, recordingDataMatrix(d,:));
    axis tight;
end
set(figureHandle, 'Position', [0, 0, SCREEN_SIZE]);

end