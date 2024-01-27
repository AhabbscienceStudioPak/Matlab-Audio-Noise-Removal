# Signal Processing: Noisy Signal Simulation
This MATLAB script simulates a noisy signal, allowing users to choose between recording audio or using a default sample file. The generated signal is then enriched with simulated noise, and spectral and filter analysis is performed.

## Usage
Run the script in MATLAB.
Choose whether to record audio by entering "yes" or "no" when prompted.
If "yes," a 5-second audio recording will be saved as 'recorded_audio.wav'.
If "no," a default sample ('input.m4a') will be loaded.
The script adds simulated noise to the signal and plays the resulting noisy audio.
The original and noisy signals are plotted for visual comparison.
Spectral analysis is conducted, displaying the single-sided amplitude spectrum.
A bandpass filter is designed and applied to the noisy signal, and the filtered signal is plotted and played.
## Dependencies
MATLAB R2019a or later
Feel free to adjust parameters, such as filter order and cutoff frequencies, to explore different signal processing scenarios.
