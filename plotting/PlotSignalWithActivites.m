function PlotSignalWithActivites(activityChanges, recordingDataMatrix, recordingTimestamps)
SCREEN_SIZE = [1920, 1080];
activityColors = ActionType.actions2Color(activityChanges{2});

activityChangeCnt = length(activityChanges{1});

figureHandle = figure('name', 'Recording');
dimensionCnt = size(recordingDataMatrix, 1);
for d = 1:dimensionCnt
    subplot(dimensionCnt, 1, d);
    plot(recordingTimestamps, recordingDataMatrix(d,:));
    axis tight;
    if d == 1
        minY = min(recordingDataMatrix(d,:));
        maxY = max(recordingDataMatrix(d,:));
        hold on;
        for a = 1:activityChangeCnt
            plot(repmat(activityChanges{1}(a),2,1), [minY,maxY], 'Color', activityColors(a,:), 'LineWidth', 2);
        end
        hold off;
    end
end

set(figureHandle, 'Position', [0, 0, SCREEN_SIZE]);

end