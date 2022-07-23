function Spikes = DetectWave(samplingRate,data)

frequence_range=[300 6000];
Wp=frequence_range/samplingRate;
[b,a] = butter(4,frequence_range/(samplingRate/2),'bandpass');   
data_filtered = filter(b,a,data); 

T = data_filtered;                   
[channel, length] = size(T); 

%% threshold
% Multiple_std = -1.3; 
%Threshold = Multiple_std * std(T);
%Thre1 = Multiple * rms(TestSignal);
Threshold_n=-4*median(abs(T'))/0.6745;
Threshold_p=4*median(abs(T'))/0.6745;
% Threshold=-4*mean(abs(T'))/0.6745;
% Threshold=-15*mean(abs(T'))/0.6745;
% ReThreshold = repmat(Threshold_n ,1,length);

Tn_timestamp = [];
spike_count = 1;
for i = 2:length

      if ( T(1,i-1) > Threshold_n && T(1,i) <= Threshold_n ) 
          if (spike_count == 1)
             Tn_timestamp(spike_count) = i;
             spike_count = spike_count + 1;
          elseif ((i - Tn_timestamp(spike_count-1))>40)                    
             Tn_timestamp(spike_count) = i;                          
             spike_count = spike_count + 1;   
          end
 
      end
      if( T(1,i-1)<Threshold_p && T(1,i) >= Threshold_p ) 
          if (spike_count == 1)
             Tn_timestamp(spike_count) = i-5;
             spike_count = spike_count + 1;
          elseif ((i-5 - Tn_timestamp(spike_count-1))>40)                     
             Tn_timestamp(spike_count) = i-5;                          
             spike_count = spike_count + 1;   
          end
      end
end
spike_count=spike_count-1;
 %% detect spike
 %peak at 11
 n = size(Tn_timestamp,2); 
 % cut
 All_point = 48;    % 48
 L_point = 10;      
 R_point = All_point - L_point -1;
 % align
length_point=32;
Spikes = zeros(n,length_point);    
Cnt = 0;
for i = 1:n  
    Spike_id =  Tn_timestamp(i);
    left=Spike_id - L_point;
    right=Spike_id + R_point;
    if (left>0 && right<length)  
        Cnt = Cnt + 1;
        spike=T( left :right );
        [npeak,idx]=min(spike(1,11:20));
        idx=idx+10;
        Spikes(Cnt,:) = spike( idx - L_point : idx + R_point-16);  %length=32
        
        Spike_id=left-1+idx;
        Tn_timestamp(i)=Spike_id;
    end
end

end

