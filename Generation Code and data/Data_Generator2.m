clc
%The size of data 
count = [1;100];
N = 100
%N = 39;
%create a structure that contain all the generated data as a structure and
%pbject
ss = struct('N', N);

ss.lightLevel = normrnd(500,75,1,N); 
ss.lightColor = normrnd(3500,350,1,N); 
ss.peaople_sound = normrnd(30,3,1,N); 

ss.o2 = normrnd(20,0.3,1,N);
ss.co2 = normrnd(800,50,1,N); 
ss.lpg = normrnd(3.5,0.35,1,N); 
ss.alcohol = normrnd(0.1,0.05,1,N);  

ss.methane = normrnd(2,0.35,1,N);   
ss.co = normrnd(3,1,1,N);  
ss.h2 = normrnd(20,5,1,N);  
ss.nitric = normrnd(0.1,0.05,1,N);  
ss.ch2o = normrnd(0.2,0.06,1,N);   
ss.voc =  normrnd(6.5,1,1,N);  
ss.Temp = normrnd(22,2,1,N);
ss.Humad = normrnd(50,4.5,1,N);
ss.Rtemp = normrnd(24,3,1,N); 
ss.air_speed = normrnd(150,15,1,N); 

ss.metabolism = normrnd(0,1,1,N); 
  
ss.thermalComf_std = normrnd(10,5,1,1) ; % scale of thermal comfort; 
ss.thermalComf = pearsrnd(85,10,-1,3,1,N); 

ss.visualComf_mu =  normrnd(85,10,1,1);  % mean of the prediction of the comfort level of the visaul comfort.
visualComf_std =  normrnd(10,5,1,1); % standard daviation of the prediction of the comfort level of the visaul comfort.
ss.visualComf = pearsrnd(85,10,-1,3,1,N); % prediction of the comfort level of the visaul comfort.


ss.acou_isolation_mu  =  normrnd(0.9,0.1,1,1); % mean of measured wall quality Isolation. 
ss.acou_isolation_std =  normrnd(0.1,0.2,1,1); % standard deviation of measured wall quality Isolation.
ss.acou_isolation = pearsrnd(0.9,0.1,-1,3,1,N);  %The quality of wall aoustic Isolation

ss.AcousComfort_std =  normrnd(10,5,1,1); %standard visualization of the calculatd acoustic comfort.
ss.AcousComfort = pearsrnd(85,10,-1,3,1,N); % from survey the afeeling toward acoustic level in the space.  %5 category ordinal data[1 very good to 6 v. bad]


ss.airQualityComf_std =  normrnd(10,5,1,1);  %  predected standad daviation of comfort under Air quality
ss.airQualityComf = pearsrnd(85,10,-1,3,1,N); % predected comfort under air quality according to calculation
%------------------------------------------------ intermediate and output nodes --------------------------------------------------------

ss.bComfort_std =  normrnd(10,5,1,1); % Standard daviation of the building being comfortable, if calculated it should be equall to 0.1; 
ss.bComfort = pearsrnd(85,10,-1,3,1,N);
% predection of to what extent Building is comfortable

ss.airQuality_mu =  normrnd(85,10,1,1);  % predected mean of Air quality
ss.airQuality_std =  normrnd(10,5,1,1);  %  predected standad daviation of Air quality
ss.airQuality_skew =  normrnd(-2,0.3,1,1); %  predected Skew of the shape of distribution of Air quality
ss.airQuality  = pearsrnd(85,10,-1,3,1,N); % predected air quality according to calculation
%--------------------------------------------------------------------------------------------------------
ss.acSystem = pearsrnd(85,10,-1,3,1,N); % Thermal Isolation function as a wall u value
ss.acSystem_std  =  normrnd(10,5,1,1);
%--------------------------------------------------------------------------------------------------------
ss.thermal_isolation_std =  normrnd(10,5,1,1);
ss.thermal_isolation = pearsrnd(85,15,-1,3,1,N); % Thermal Isolation function as a wall u value
%--------------------------------------------------------------------------------------------------------
ss.ventSystem_mu =  normrnd(85,10,1,1); 
ss.ventSystem_std =  normrnd(10,5,1,1);
ss.ventSystem = pearsrnd(85,10,-1,3,1,N); % Thermal Isolation function as a wall u value
%--------------------------------------------------------------------------------------------------------
ss.artLights_std =  normrnd(10,5,1,1);  % standard deviation of the quality of the lighting system.
ss.artLights = pearsrnd(85,10,-1,3,1,N); % is Artifitial light system OK?
%--------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------
ss.outNoiseAlfa= 0.85; % probability of there is an exterior sound or noise 
ss.outNoise= rand(1,N) < ss.outNoiseAlfa; 
%------------------------------------------------------------------------------
ss.backgNoise_Alfa=0.05; %probability of saying yes to the above question.
ss.backgNoise= rand(1,N) < ss.backgNoise_Alfa; 
%------------------------------------------------------------------------------
ss.p_Noise_Alfa= 0.8;
ss.people_Noise= rand(1,N) < ss.p_Noise_Alfa; 
%------------------------------------------------------------------------------
ss.acControlAlfa= 0.99; % propability of answering yes in the space;
ss.ac_control= rand(1,N) < ss.acControlAlfa; 
%------------------------------------------------------------------------------
ss.odorUsuAlfa= 0.02; % propability of answering yes smell odor usually;
ss.odorUsually= rand(1,N) < ss.odorUsuAlfa; 
%------------------------------------------------------------------------------
ss.sleepyAlfa= 0.03; % propability of answering yes in the space;
ss.sleepy= rand(1,N) < ss.sleepyAlfa; 
%------------------------------------------------------------------------------
ss.odorAlfa= 0.05; % propability of answering yes smell odor;
ss.odor= rand(1,N) < ss.odorAlfa; 
%------------------------------------------------------------------------------
ss.daylightAlfa= 0.90; % propability of answering yes the building is comfortable; 
ss.daylight= rand(1,N) < ss.daylightAlfa; 
%------------------------------------------------------------------------------
ss.BlindOFFAlfa= 0.6; % propability of some blinds are OFF;
ss.BlindOFF= rand(1,N) < ss.BlindOFFAlfa; 
%------------------------------------------------------------------------------
ss.lightControlAlfa= 0.93; % propability of light control under control;
ss.lightControl= rand(1,N) < ss.lightControlAlfa; 
%------------------------------------------------------------------------------
ss.luminaireOFFAlfa= 0.5; % propability of some luminair are OFF; 
ss.luminaireOFF= rand(1,N) < ss.luminaireOFFAlfa; 
%------------------------------------------------------------------------------
ss.nigaTheraml_Alfa= 0.05; % propability of answering yes thermal have nigative effect; 
ss.nigaThermal= rand(1,N) < ss.nigaTheraml_Alfa; 
%------------------------------------------------------------------------------
ss.nigaNoise_Alfa=0.05; % propability of answering yes noise and sound have nigative effect; 
ss.nigaNoise= rand(1,N) < ss.nigaNoise_Alfa;
%------------------------------------------------------------------------------
ss.nigaLightAlfa= 0.02; % propability of answering yes there is a nigative effect of ighting quality; 
ss.nigaLightQua= rand(1,N) < ss.nigaLightAlfa;
%------------------------------------------------------------------------------
ss.nigaAirAlfa= 0.06; % propability of answering yes there is a nigative effect of ighting quality; 
ss.nigaAir= rand(1,N) < ss.nigaAirAlfa;
%------------------------------------------------------------------------------



ss.k_age= 3; 
ss.ageTheta= [0.6; 0.3; 0.1];  
ss.k_weight= 6; 
ss.weightTheta= [0.16; 0.17; 0.17; 0.17; 0.17; 0.16];
ss.k_bodyActivity= 6; 
ss.bodyActivityTheta= [0.25; 0.21; 0.32; 0.15; 0.07;0];
ss.k_time= 13; 
ss.timeTheta= [0.077; 0.077; 0.077; 0.077; 0.077; 0.077; 0.076; 0.077; 0.077; 0.077; 0.077; 0.077; 0.077];
%------------------------------------------------------------------------------
ss.k_summer= 5;
ss.summerTheta= [0.05, 0.05, 0.1, 0.3, 0.5];
ss.k_tempNow= 5;
ss.tempNow_Theta= [0.05; 0.05; 0.1; 0.3; 0.5];
ss.k_Gnoise=5;
ss.Gnoise_Theta=[0.05; 0.05; 0.1; 0.3; 0.5];
ss.k_noiseNow=5;
ss.noiseNow_Theta=[0.05; 0.05; 0.1; 0.3; 0.5];
ss.k_colorComf= 5; 
ss.colorComfTheta= [0.05; 0.05; 0.1; 0.3; 0.5]; 
ss.k_LightFeel= 5; 
ss.LightFeelTheta= [0.05; 0.05; 0.1; 0.3; 0.5];
ss.k_bImage= 5; 
ss.bImageTheta= [0.05; 0.05; 0.1; 0.3; 0.5]; 
ss.k_clothlayer= 5;
ss.clothLayerTheta= [0.4; 0.3; 0.2;0; 0.1]; % the probability of the clothed that are used.
ss.k_aSpNow= 3;  
ss.aSpNowTheta= [0.17; 0.33; 0.5]; 
%------------------------------------------------------------------------------
for i = 1:6:N
    weight(i:i+5) = randsample([1:6],6,true,ss.weightTheta);
    %------------------------------------------------------------------------------
    bodyActivity(i:i+5) = randsample([1:6],6,true,ss.bodyActivityTheta);
end
%------------------------------------------------------------------------------
for i = 1:3:N
   age(i:i+2) = randsample([1:3],3,true,ss.ageTheta);
   %------------------------------------------------------------------------------
   airSpeedNow(i:i+2) = randsample([1:3],3,true,ss.aSpNowTheta);
end
%------------------------------------------------------------------------------
for i = 1:13:N
    time(i:i+12) = randsample([1:13],13,true,ss.timeTheta);
end
ss.weight = weight(1:N);
ss.bodyActivity = bodyActivity(1:N);
ss.age = age(1:N);
ss.airSpeedNow = airSpeedNow(1:N);
ss.time = time(1:N);


for c = 1:5:N-4 
    ss.sumTemp(c:c+4) = randsample([1:5],5,true,ss.summerTheta);
    %------------------------------------------------------------------------------
    ss.wintTemp(c:c+4) = randsample([1:5],5,true,ss.summerTheta);
    %------------------------------------------------------------------------------
    ss.tempNow(c:c+4) = randsample([1:5],5,true,ss.tempNow_Theta); 
    %------------------------------------------------------------------------------
    ss.noiseGenarally(c:c+4) = randsample([1:5],5,true,ss.Gnoise_Theta);
    %------------------------------------------------------------------------------
    ss.noiseNow(c:c+4) = randsample([1:5],5,true,ss.noiseNow_Theta); 
    %------------------------------------------------------------------------------
    ss.colorComf(c:c+4) = randsample([1:5],5,true,ss.colorComfTheta); 
    %------------------------------------------------------------------------------
    ss.lightLevelFeel(c:c+4) = randsample([1:5],5,true,ss.colorComfTheta); 
    %------------------------------------------------------------------------------
    ss.building_image(c:c+4) = randsample([1:5],5,true,ss.bImageTheta); 
    %------------------------------------------------------------------------------
    ss.clothLayer(c:c+4) = randsample([1:5],5,true,ss.clothLayerTheta); 
end
%------------------------------------------------------------------------------
ss.thermalComfAlfa= 0.90; %Do you feel comfortable under current thermal conditions
%------------------------------------------------------------------------------
ss.k_AcousComfort= 5;
ss.AcousComfortTheta= [0.45; 0.25; 0.15; 0.1; 0.05];
%------------------------------------------------------------------------------
ss.k_visualComf= 5;
ss.visualComf_Theta= [0.45; 0.25; 0.15; 0.1; 0.05];
%------------------------------------------------------------------------------
ss.k_airQuality= 5;
ss.airQuality_Theta= [0.45; 0.25; 0.15; 0.1; 0.05];
%------------------------------------------------------------------------------
ss.k_vent= 5;  
ss.ventTheta= [0.05; 0.05; 0.1; 0.3; 0.5];

for c = 1: 4 : N
    if ((weight(c)==1 || weight(c)==2 || weight(c)==3 || weight(c)==4) && ...
        (ss.clothLayer(c)==2 || ss.clothLayer(c)==3 || ss.clothLayer(c)==4) && ...
        (ss.tempNow(c)==2 || ss.tempNow(c)==3 || ss.tempNow(c)==4) && ...
        (time(c)== 6 || time(c)==7 || time(c)==8 || time(c)==9 || time(c)==10 || time(c)==11 || time(c)==12 || time(c)==13) && ...
        (airSpeedNow(c)==1 || airSpeedNow(c)==2) && (age(c)==1 || age(c)==2) && ...
        (bodyActivity(c)==4 || bodyActivity(c)==5 || bodyActivity(c)==6) && (nigaThermal(c)==0))
        
        ss.thermalComf(c) = 1; 
     else
        ss.thermalComf(c) = rand(1,1) < ss.thermalComfAlfa;
    end 
      
     if((noiseNow(c)==1 || noiseNow(c)==2 || noiseNow(c)==3) &&  ... 
             (time(c)==6 || time(c)==7 || time(c)==8 || time(c)==9 || time(c)==10 || time(c)==11 || time(c)==12 ||time(c)==13) &&  ...
             (airSpeedNow(c)==1 || airSpeedNow(c)==2) &&  ... 
             (age(c)==1 || age(c)==2) &&  ... 
             (ss.nigaNoise(c)==0))
        
        ss.AcousComfort(c) = randi([4 5]); 
     else
        ss.AcousComfort(c) = randi([1 3]);
     end 
      
     if((time(c)==6 || time(c)==7 || time(c)==8 || time(c)==9 || time(c)==10 || time(c)==11 || time(c)==12 || time(c)==13) &&  ... 
             (age(c)==1 || age(c)==2) &&  ...  
             (bodyActivity(c)==4 || bodyActivity(c)==5 || bodyActivity(c)==6) &&  ... 
             (ss.nigaLightQua(c)==0))
        ss.visualComf(c) = randi([4 5]);  
     else
        ss.visualComf(c) = randi([1 3]);  
     end
     
      if((time(c)==6 || time(c)==7 || time(c)==8 || time(c)==9 || time(c)==10 || time(c)==11 || time(c)==12 || time(c)==13) && ... 
              (airSpeedNow(c)==1 || airSpeedNow(c)==2) && ... 
              (age(c)==1 || age(c)==2) && ...
              (bodyActivity(c)==4 || bodyActivity(c)==5 || bodyActivity(c)==6) && ...
              (ss.nigaThermal(c)==0))
        ss.VentilationAirsmell(c) = randi([4 5]);
        ss.vent(c) = randi([4 5]);
     else
        ss.VentilationAirsmell(c) = randi([1 3]);
        ss.vent(c) = randi([1 3]);
      end   
end






%------------------------------------------------------------------------------
%------------------------------------------------------------------------------
%------------------------------------------------------------------------------
ss.k_bodyMetab= 3; 
ss.bodyMetab_Theta= [0.2; 0.65; 0.15];
 
ss.lightColor_mu= 3500; % recommended light Color in the space
ss.lightColor_std= 500;
ss.lightColor_error= 10; % light Color meauserment device error 
ss.lightColor_skew= 1;

ss.k_selfMetabolism= 3; 
ss.selfMetabolismTheta= [0.33; 0.34; 0.33];

ss.bComfortAlfa= 0.99;
  
ss.k_airQualityComf= 5;
ss.airQualityComf_Theta= [0.45; 0.25; 0.15; 0.1; 0.05];  

ss.lightLevel_mu= 550; 
ss.lightLevel_std= 50;
ss.lightLevel_error= 25; % light level meauserment device error 
ss.lightLevel_skew= 2;

ss.co2_mu= 800; % recommended CO2 in the space 
ss.co2_std= 110;
ss.co2_error= 15; % CO2 meauserment device error 
ss.co2_skew= 1;
    
ss.o2_mu= 20; % recommended O2 in the space 
ss.o2_std= 0.5;
ss.o2_error= 0.1; % O2 meauserment device error 
ss.o2_skew= 1; 
  
ss.co_mu= 30; % recommended CO in the space 
ss.co_std= 5;
ss.co_error= 1.5; % CO meauserment device error
ss.co_skew= 2;
  
ss.h2_mu= 2; % recommended H2 in the space 
ss.h2_std= 1.6;
ss.h2_error= 0.01; % H2 meauserment device error 
ss.h2_skew= 1;
  
ss.lpg_mu= 3.5; % recommended LPG in the space
ss.lpg_std= 0.4;
ss.lpg_error= 0.01; % LPG meauserment device error 
ss.lpg_skew= 1;
   
ss.alcohol_mu= 0.1; % recommended alcohol in the space
ss.alcohol_std= 0.09;
ss.alcohol_error= 0.01; % alcohol meauserment device error 
ss.alcohol_skew= 2;
    
ss.nitric_mu= 3.5; % recommended nitric in the space 
ss.nitric_std= 0.4;
ss.nitric_error= 0.01; % nitric meauserment device error
ss.nitric_skew= 1;
  
ss.ch2o_mu= 0.15; % recommended Formuldehyde in the space
ss.ch2o_std= 0.09;
ss.ch2o_error= 0.005; % Formuldehyde meauserment device error 
ss.ch2o_skew= 2;
  
ss.voc_mu= 60; % recommended VOC in the space 
ss.voc_std= 10;
ss.voc_error= 5; % VOC meauserment device error 
ss.voc_skew= 2;
  
ss.methane_mu= 3.0; % recommended methane in the space 
ss.methane_std= 1.0;  
ss.methane_error= 0.5; % methane meauserment device error
ss.methane_skew= 2; 

ss.T_mu= 22; 
ss.Rt_mu= 24; 
ss.T_std= 3;  
ss.T_skew= 1; 
ss.T_error= 2;
  
ss.speed_mu= 0.2;
ss.speed_std=0.1;
ss.speed_error= 0.08;
ss.speed_skew= 1;

ss.p_sound_mu= 37;  % accepatble average people sound 
ss.p_sound_std= 5;
ss.p_sound_error= 2; % measurement error (sensor error of measured sound)

ss.bnoise_mu = 45;  
ss.bnoise_std = 5;

ss.K = 5 ;   
ss.H_mu= 53.5;  
ss.H_std= 5;  
ss.H_error= 2; 

  
ss.RT_error= 3;
%-------------------------------------------------------------------------------------
%-------------------------------------------------------------------------------------
%##dayLightAvaPro; % probability of that daylight have suffecient value. 
%##daylight_std; 
%##latentLightlevel; 
%##%----------------------------------------------
%##LightFeel_mu;  % mean of the light comfort feel
%##LightFeel_std; % standard deviation of the light comfort feel
%##bImage_mu;  % mean of the building image 
%##bImage_std; % standard deviation of the building image 
%##colorComf_mu;  % mean of the color comfort feel
%##colorComf_std; % standard deviation of the color comfort feel
%##%----------------------------------------------
%##noiseNow_mu;  % mean of the current sound acception 
%##noiseNow_std; % standard deviation of the current sound acception 
%##Gnoise_mu;  % geaneral noise level in the building mean. 
%##Gnoise_std;  % geaneral noise level in the building standard deviation.  
%##%------------------------------------------------ 
%##vocCons; % propbability of VOC consintration
%##vocCons_std; % standard deviation of collective voc concentration
%##vocCons_shape; % shape of collective voc concentration
%##%------------------------------------------------
%##
%##acControlAlfa;  
%##sleepyAlfa; 
%##odorUsuAlfa; 
%##nigaAirAlfa; % propability of air has nigative effect on performance ;
%##vent_mu;  % mean of comfort feel under the current ventilation
%##vent_std;  % Standard Deviation of comfort feel under the current ventilation
%##aSpNow_mu;  % mean of comfort feel under the current air-speed
%##aSpNow_std;  % Standard Deviation of comfort feel under the current air-speed


jsonText = jsonencode(ss);
% Write to a json file
fid = fopen('GeneratedData.json', 'w');
fprintf(fid, '%s', jsonText);
fclose(fid);
