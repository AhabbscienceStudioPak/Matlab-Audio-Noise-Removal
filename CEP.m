%% simulate noisy signal

% Ask the user if they want to record audio
userChoice = input('Would you like to record audio? (Type "yes" or "no" (input.m4a will be used incase of "no"): ', 's');

if strcmpi(userChoice, 'yes')
    % Set up audio recording
    fs = 44100; % Sampling rate (in Hz)
    recorder = audiorecorder(fs, 16, 1); % 16 bits per sample, 1 channel (mono)

    % Record audio for 5 seconds (adjust the time as needed)
    disp('Recording... Press any key to stop.');
    recordblocking(recorder, 5);

    % Get the recorded data
    audioData = getaudiodata(recorder);

    % Save the recorded audio to a WAV file (replace 'output_audio.wav' with your desired file name)
    outputFileName = 'recorded_audio.wav';
    audiowrite(outputFileName, audioData, fs);

    disp(['Audio recorded and saved to ' outputFileName]);

    % Load the recorded audio file
    [x, Fs] = audioread(outputFileName);
else
    % If the user chooses not to record audio, load a sample audio file
    [x, Fs] = audioread('input.m4a'); 
end

% Generate a time vector
n = (0:length(x)-1) / Fs;

b = fir1(6, 1000 / (Fs / 2), 'high'); % Design a high-pass FIR filter
filtered_noise = filter(b, 1, 0.1 * randn(size(x)));

% Add noise to the signal
y = x + 0.3 * filtered_noise; % Adjust the noise level as needed


% Play the noisy audio
% sound(y, Fs);

% Save the noisy audio as a new WAV file
audiowrite('noisy_added.wav', y, Fs);

disp("Added Noise to Audio");

% Plot the original signal and the noisy signal
subplot(2, 2, 1);
plot(n, x);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 2, 2);
plot(n, y);
title('Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');

%% Spectral analysis of the signal
L = length(y);
NFFT = 2^nextpow2(L);
y_fft = abs(fft(y, NFFT));
freq = Fs/2 * linspace(0, 1, NFFT/2+1);

% Plot single-sided amplitude spectrum.
subplot(2, 2, 3);
plot(freq, y_fft(1:NFFT/2+1));
title('Single-Sided Amplitude Spectrum of y(t)');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');

%% Design Filter and apply on the sequence
o = 7; % Decrease the filter order for reduced power
wn = [200 7000] * 2 / Fs; % Adjust the filter cutoff frequencies

[b, a] = butter(o, wn, 'bandpass');

% See frequency response of the filter
[h, w] = freqz(b, a, 1024, Fs);

subplot(2,2,3);
plot(w,20*log10(abs(h)));
title('Magnitude Response of the Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');grid on;

% Filter the signal
y_filt = filter(b, a, y);

subplot(2, 2, 4);
hold on;
plot(n, y_filt);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original', 'Filtered');

% Save the filtered audio as a new WAV file
audiowrite('filtered_audio.wav', y_filt, Fs);

% Play the filtered audio
sound(y_filt, Fs);
