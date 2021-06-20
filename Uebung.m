clear all;
close all;
loadSensorReadoutParser('src/');

% #########################################################################
% # Config
% #########################################################################
SAMPLE_INTERVAL = (1/100); % 50Hz
SCREEN_SIZE = [1920, 1080];

sensorSelector = SensorSelector()...
	.useSensor(SensorType.ACCELEROMETER)...
	.useSensor(SensorType.GYROSCOPE);

% #########################################################################
% # Select File
% #########################################################################
[cutFile, cutFilePath] = uigetfile('*.csv');
assert(ischar(cutFile), 'Did not select file in dialog.');
fileName = [cutFilePath, cutFile];

% #########################################################################
% # Parse & Resample
% #########################################################################
parser = SensorReadoutParser(fileName, true);
timestampedSensorData = parser.parseSensorData();
recording = timestampedSensorData.resampleIntoDataContainer(SAMPLE_INTERVAL);

% #########################################################################
% # Render
% #########################################################################
[recordingTimestamps, recordingDataMatrix] = recording.getSensorData(sensorSelector);
PlotSignal(recordingDataMatrix, recordingTimestamps);




