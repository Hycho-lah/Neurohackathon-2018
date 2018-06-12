function [ spike_train ] = bin_data( in_train )
%THIS FUNCTION BINS THE SPIKE TRAIN SENT TO IT ACCORDING TO THE BIN WIDTH

in_train = squeeze(in_train);
%Converting to binned spike counts
bin_width = 250;
bin_starts = 1:bin_width:length(in_train);
bin_ends = bin_width:bin_width:length(in_train);
bin_pos = 1;
    %Pick one neuron
% for nr = 1:1:size(M3,1)
%         neuron = M3(nr,:);
%         bin_pos = 1;
    while bin_pos <= length(bin_starts)
        
       M4 =  sum(in_train(:,bin_starts(bin_pos):bin_ends(bin_pos)),2);
       
       %Number of spikes in a 500 ms bin is
       
       spike_train(:,bin_pos) = M4;
       clear M4 
       bin_pos = bin_pos + 1
       
        
    end



end

