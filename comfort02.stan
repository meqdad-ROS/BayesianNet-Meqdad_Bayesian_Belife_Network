   functions {
   // ... function declarations and definitions ...
    vector transFormBinary(array[] int input, real alfa){
        vector[num_elements(input)] output;
        
        for (n in 1:num_elements(input)){
                    if (input[n] == 1)
                        output[n] = alfa;
                    else
                        output[n] = 1-alfa;
        }
        return output;
    }

    vector transFormCategory(array[] int input, vector theta){
        vector[num_elements(input)] output;
         
        for (n in 1:num_elements(input))
                        output[n] = theta[input[n]];
        
        return output;
    }

    real ZIB_lpmf(int Y, real q_y, real q_x) {
            if (Y == 0) {
                    return log_sum_exp( bernoulli_lpmf(0 | q_y) + bernoulli_lpmf(0 | q_x), bernoulli_lpmf(0 | q_y) + bernoulli_lpmf(1 | q_x));
                        } 
            else {
                    return log_sum_exp( bernoulli_lpmf(1 | q_y) + bernoulli_lpmf(1 | q_x), bernoulli_lpmf(1 | q_y) + bernoulli_lpmf(0 | q_x));
                }
    }
   }

    //---------------------------------------------
data{
    int N; //the numeber of total observation
    int K; //number of values on likerts scale
    
    //----------------------------------------------------------Third Level----------------------------------------------------------------
    array[N] int<lower=0, upper=1> nigaLightQua; // from survey is there a nigative effect of light quality on your working performance.
    array[N] int<lower=1, upper=5> building_image; // from survey to what extent you feel comfort under current color level. 
    
    //-----------------------------------------------------------Fourth level ----------------------------------------------------------------
    // -------- acoustical comfort -------------------------------------------------------------------------
    array[N] real<lower=0>  peaople_sound; // measured voise and sound of people normal talk
    array[N] int<lower=0> noiseGenarally;  // feeling of noise level
    array[N] int<lower=0> nigaNoise; // Is thier a nigative effect of sound level and noise on your working performance?
    array[N] int<lower=0, upper=1> outNoise; // Openion, Distraction from outside noise
    array[N] int<lower=0> noiseNow;  // feeling of noise level 
    array[N] int<lower=0> ac_control; // from survey do you have controlability over AC in the space
    array[N] real<lower=0> air_speed; // measurement of air speed in the space in m/s
    array[N] int<lower=0> backgNoise; //is there any background noise in the room?
    
    // -------- Air quality comfort -------------------------------------------------------------------------
    array[N] real<lower=0> ch2o; // measured Formuldehyde from the robot (measurement devices)
    array[N] int<lower=0> odor; // from survey do you smell odor or unusual unpleasant smell?
    array[N] int<lower=0> odorUsually; // from survey do you smell odor or unusual unpleasant smell in this building usually?
    array[N] int<lower=0> vent; // feeling of vent quality of the building.
    array[N] real<lower=0> co2; // measured CO2 from the robot (measurement devices)
    array[N] real<lower=0> o2; // measured O2 from the robot (measurement devices)
    array[N] real<lower=0> voc; // measured VOC from the robot (measurement devices)
    array[N] real<lower=0> h2; // measured H2 from the robot (measurement devices)
    array[N] real<lower=0> methane; // measured methan from the robot (measurement devices)
    array[N] real<lower=0> nitric; // measured nitric from the robot (measurement devices)
    array[N] real<lower=0> co; // measured CO from the robot (measurement devices)
    array[N] real<lower=0> lpg; // measured LPG from the robot (measurement devices) 
    array[N] real<lower=0> alcohol; // measured alcohol from the robot (measurement devices)
    array[N] int<lower=0> nigaAir; // airQualityComf from survey, do you feel that air quailtiy in this building has anigative effect on work.  yes = 0.05, No = 0.95
    array[N] int<lower=0> sleepy; // from survey do you have controlability over AC in the space
    array[N] int<lower=0> airSpeedNow; // feeling of vent quality of the building.
   // -------- thermal comfort -------------------------------------------------------------------------
    array[N] real<lower=0> Rtemp; // measured radient Temperature at the space
    array[N] real<lower=0> Temp; // measured temperature from sensor
    array[N] real<lower=0> Humad; // measured humadity
    array[N] int<lower=1, upper=5> sumTemp;  // Summer Temperature acceptance level 
    array[N] int<lower=1, upper=5> wintTemp; // Summer Temperature acceptance level
    array[N] int age; // from survey the age category are [1 = (15-30), 2 = (30-45), 3 = (45-60)]
    int k_age;  // number of possible answer to the question 
    array[N] int time; // from survey the time in place are [1 to 13 category]  // should be reviewed when data entered
    int k_time;  // number of possible answer to the question
    array[N] int weight; // from survey the one weight [1-6 category]
    int k_weight;  // number of possible answer to the question
    array[N] int bodyActivity; // from survey the activity of the one who answering the it.  [1-6 category]
    int k_bodyActivity;  // number of possible answer to the question
    array[N] int clothLayer; // from survey the thikness of layers [1 = light layers, 2 = medium layers, 3 = Heavy layers]
    int k_clothlayer;  // number of possible answer to the question
    array[N] int<lower=1, upper=5> tempNow;  // Summer Temperature acceptance level 
    array[N] int nigaThermal; // Is thier a nigative effect of thermal conditions on your working performance?
    
    // -------- visual comfort -------------------------------------------------------------------------
    array[N] int<lower=0> dayLightava; // from survey do you feell the building is comfortable?
    array[N] int<lower=0>BlindOFF; // from survey Do blinds OFF in this room right now?
    array[N] int<lower=0>lightControl; // from survey do you have control over artificial light?
    array[N] int<lower=0> luminaireOFF; // from survey do is there any luminiare OFF?
    array[N] real<lower=0> lightLevel; // measured Light level from the robot (measurement devices)
    array[N] real<lower=0> lightColor; // measured Light color from the robot (measurement devices)
    array[N] int<lower=1, upper=5> colorComf; // from survey to what extent you feel comfort under current color level. 
    array[N] int<lower=0, upper=5> lightLevelFeel; // from survey to what extent you feel comfort under current color level.
 
    //******************************************************************
    //******************************************************************
    //******************************************************************
    // array[N] int visualComf; // from survey how one feel comfortable under current light situation.  [1-5 category]
    // int k_visualComf;  // number of possible answer to the question
    // vector[k_visualComf] visualComf_Theta;  // vector of possible probabilities for each
    // array[N] int thermalComf;  // Find the propability of the thermal comfort to be good
    // real thermalComfAlfa;
    }
    // transformed data{
        
        
    // }
//--------------------------------------------------------------------------------------------------------------------------------
//******************************************************************************************************************************//
//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------
//******************************************************************************************************************************//
//--------------------------------------------------------------------------------------------------------------------------------
parameters {
    //------------------------ First Level Parameters ---------------------------------------------------------------
    vector[N] bComfort; // predection of to what extent Building is comfortable
    //------------------------ Second Level Parameters ---------------------------------------------------------------
    vector<lower=-1, upper=1>[2] bAirQ_a;  // Coefficient of air qoulity comfort as a chiled of building Comfort. 
    vector<lower=-1, upper=1>[2] bAcoCo_a; // Coefficient of acoustical comfort  as a chiled of building Comfort. 
    vector<lower=-1, upper=1>[2] bTherCo_a; // Coefficient of thermal comfort  as a chiled of building Comfort.
    vector<lower=-1, upper=1>[4] bVisCo_a;// Coefficient of visual comfort  as a chiled of building Comfort.
    vector[N] metabolism;  // metabolism, is it the same as body metabolism in the data?
    vector[N] airQualityComf; // predected comfort under air quality according to calculation
    vector[N] AcousComfort; // from survey the afeeling toward acoustic level in the space.  5 category ordinal data[1 very good to 6 v. bad]
    vector[N] thermalComf; //The variable of the thermal comfort.
    vector[N] visualComf; // prediction of the comfort level of the visaul comfort.
    //-------------------------- Third Level Parametrs-------------------------------------------------------------
    vector[N] ventSystem; // Ventilation system quality
    vector[N] artLights; // is Artifitial light system OK?
    vector[N] acou_isolation; //The quality of wall aoustic Isolation
    vector[N] acSystem; // Thermal Isolation function as a wall u value
    vector[N] thermal_isolation; // Thermal Isolation function as a wall u value
    vector[N] airQuality; // predected air quality according to calculation
    vector[N] daylightSys; // predected quality of daylight system in the building.
    vector<lower=-1, upper=1>[4] nigaL_a; // coeffecienet of light having nigative effect linear regression
    vector<lower=-1, upper=1>[4] acou_iso_coef; //coeffecienet of acoustic isolation quality linear regression.
    //-------------------------- Fourth Level Parametrs-------------------------------------------------------------
    //+++++========================++++++ Fourth Level Acoustical comfort +++++===============================++++++
    vector[N] instanSound; // predected having sound on the place at this moment.
    vector<lower=-1, upper=1>[4] insSound_a; //Coeffecient of people Sound linear regresion. 
    vector<lower=-1, upper=1>[6] pSound_a; // Coeffecient of instantinouse measured voice sound linear regresion.
    real <lower=-1, upper=1> beta0_Gnoise; // constant of general noise feeling linear regression. 
    row_vector<lower=-1, upper=1>[5] beta_Gnoise; // air speed feeling coeficient of the latenet variable.
    vector<lower=-1, upper=1>[2] nigaAcou_a; // coeffecienet of Acoustics having nigative effect linear regression
    vector<lower=-1, upper=1>[2] outN_a; // coeffecienet of building having out noise source linear regression
    vector<lower=-1, upper=1>[4] acCont; // coeffecienet of space having controlability over AC linear regression
    vector<lower=-1, upper=1>[5] speed_a; // coeffecienet of the mean of measured air-spead  linear regression
    vector<lower=-1, upper=1>[5] speed_b; // coeffecienet of the standard deviation of measured air-spead  linear regression
    vector<lower=-1, upper=1>[5] backgN_a; // coeffecienet of space having loud backgraound noise linear regression
    positive_ordered[4] theta_1;  // The ranked data threshold.
    real<lower=-1, upper=1> beta10;  // constant part of linear regression of noise now latent variable.
    vector<lower=-1, upper=1>[5] beta_noisenow; // coefficient of linear regression of noise now latent variable. 
   //+++++========================++++++ Fourth Level Airquality comfort +++++===============================++++++
    vector<lower=-1, upper=1>[6] vent_coef; // coefficient of linear regression of ventilation system quality 
    vector<lower=-1, upper=1>[4] HvacSysCons; // coefficient of linear regression of Hvac system (acSystem quality)  mean.
    vector<lower=-1, upper=1>[2] acSystem_b; // coefficient of linear regression of Hvac system (acSystem quality)  standard deviation.
    vector<lower=-1, upper=1>[7] a_airQua; // coefficient of linear regression of airquality mean.
    vector<lower=-1, upper=1>[5] b_airQua; // coefficient of linear regression of airquality  standard deviation.
    vector<lower=-1, upper=1>[4] ch2oA; //coefficient of linear regression of Formaldahied mean and standard deviation.
    vector<lower=-1, upper=1>[3] a_odor; // coefficient of linear regression of odor alfa.
    vector<lower=-1, upper=1>[3] a_odorUsually; // coefficient of linear regression of odor_Usually alfa.
    real<lower=-1, upper=1> beta0_vent;  // constant coefficient of linear regression of ventilation beta.
    vector<lower=-1, upper=1>[5] beta_ventnow; // coefficient of linear regression of Describe ventilation now latent variable.
    positive_ordered[4] theta_3;  // The ranked data threshold.
    vector<lower=-1, upper=1>[4] co2_coef;// coefficient of linear regression of carbon dioxide. 
    vector<lower=-1, upper=1> [4] o2_coef; // coefficient of linear regression of Oxygen.
    vector<lower=-1, upper=1>[4] voc_coef;// coefficient of linear regression of Volatile Organic Componants.
    vector<lower=-1, upper=1>[4] h2_coef; // coefficient of linear regression of Hydrogen.
    vector<lower=-1, upper=1>[4] methane_coef; // coefficient of linear regression of Methan.
    vector<lower=-1, upper=1>[4] nitric_coef; // coefficient of linear regression of Nitric compnant.
    vector<lower=-1, upper=1>[4] co_coef; // coefficient of linear regression of Carbon Monoxide.
    vector<lower=-1, upper=1>[4] lpg_coef; // coefficient of linear regression of liquefied Petroleum Gas.
    vector<lower=-1, upper=1>[4] alcohol_coef; // coefficient of linear regression of Al_cohol. 
    vector<lower=-1, upper=1>[3] nigaAirAlfa_a; // coefficient of linear regression of nigative effect of air quality on the work performance
    vector<lower=-1, upper=1>[3] sleepyAlfa_a; // coefficient of linear regression of How you discribe air speed now? among three different values. 
    positive_ordered[2] theta_2;  // The ranked data threshold of only 3 ranks for air speed feeling discribtion (nigligable=1, littl windy =2, windy =3) 
    real<lower=-1, upper=1> beta0_speed; // constant of windows speed linear regression. 
    row_vector<lower=-1, upper=1>[3] beta_speed; // air speed feeling coeficient of the latenet variable.
    //+++++========================++++++ Fourth Level Parameters Thermal comfort +++++===============================++++++
    vector<lower=-1, upper=1>[5] thermal_isolation_coef; // coefficient of linear regression of thermal Isolation quality. 
    vector<lower=-1, upper=1>[6] Rtemp_coef; // coefficient of linear regression of measured radient temperature. 
    vector<lower=-1, upper=1>[8] humadity_coef; // coefficient of linear regression of measured relative humadity. 
    vector<lower=-1, upper=1>[7] Temp_coef;// coefficient of linear regression of measured dry bulb temperature. 
    real<lower=-1, upper=1> beta0_SummerTemp; 
    row_vector<lower=-1, upper=1>[5] beta_SummerTemp; // winter temperature feeling coeficient of the latenet variable.
    positive_ordered[4] theta_4;  // The ranked data threshold.
    real<lower=-1, upper=1> beta0_wintTemp; 
    row_vector<lower=-1, upper=1>[5] beta_wintTemp; // winter temperature feeling coeficient of the latenet variable.
    positive_ordered[4] theta_5;  // The ranked data threshold.
    simplex[k_time] timeTheta;  // vector of possible probabilities for each category
    simplex[k_weight] weightTheta;  // vector of possible probabilities for each 
    simplex[k_bodyActivity] bodyActivityTheta;  // vector of possible probabilities for each
    vector<lower=-1, upper=1>[6] agetheta_coef; // coefficient of linear regression of age theta latent variable
    simplex[k_clothlayer] clothLayerTheta; // the probability of the clothed that are used.
    vector<lower=-1, upper=1>[5] beta_metabolism; // coefficient of linear regression of body metabolism.
    real<lower=-1, upper=1> beta0_TempNow; // Temp now feeling constant (intersection) of the latenet variable.
    row_vector<lower=-1, upper=1>[5] beta_TempNow; // Temp now feeling coeficient of the latenet variable.
    positive_ordered[4] theta_6;  // The ranked data threshold.
    vector<lower=-1, upper=1>[2] a_nigaThermal; // coefecient of tempreature having nigative effect on office performance
    //+++++========================++++++ Fourth Level Parameters Visual comfort +++++===============================++++++
    vector<lower=-1, upper=1>[4] dayLight_coef; // coefecient of linear regression of daylight System quality predection
    vector<lower=-1, upper=1>[4] artLights_coef; // coefecient of linear regression of artificial light System quality predection
    vector<lower=-1, upper=1>[3] a_blindoff; //coefecient of blind being OFF at the window
    vector<lower=-1, upper=1>[3] a_lightControl; // coefecient of do you have controlability over light system.
    vector<lower=-1, upper=1>[3] a_lumOFFAlfa; //coefecient of some luminiar are OFF
    vector<lower=-1, upper=1>[N] dayLightAvaPro; // probability of that daylight have suffecient value. 
    vector<lower=-1, upper=1>[6] lightlevel_coef;
    vector<lower=-1, upper=1>[5] lightColor_coef;
    real<lower=-1, upper=1> beta0_colorComf; 
    row_vector<lower=-1, upper=1>[5] beta_colorComf; 
    real<lower=-1, upper=1> beta0_illumComf; 
    row_vector<lower=-1, upper=1>[5] beta_illumComf;
    positive_ordered[4] theta_7;  // The ranked data threshold.
    positive_ordered[4] theta_8;  // The ranked data threshold.
}
//--------------------------------------------------------------------------------------------------------------------------------
//******************************************************************************************************************************//
//--------------------------------------------------------------------------------------------------------------------------------
transformed parameters{
    // -------------------------------------- Third Level params ------------------------------------------------------------
    vector[N] nigaLightAlfa; // propability of answering yes there is a nigative effect of ighting quality; 
    // -------------------------------------- Fourth Level params ------------------------------------------------------------
    //+++++++++++++++=========================Acoustical comfort ============================================================
    vector[N] nigaNoise_Alfa; // propability of answering yes noise and sound have nigative effect; 
    vector[N] eta_noiseGenarally; // eta_1 the latenet variable of the ranked data (How you discribe noise generally in this building)
    vector[N] outNoiseAlfa; // probability of there is an exterior sound or noise 
    vector[N] acControlAlfa; // propability of answering yes in the space; 
    vector[N] backgNoise_Alfa; //probability of saying yes to the question "is there an background noise).
    vector[N] eta_noiseNow; // eta_1 the latenet variable of the ranked data (noise at this moment)
   //+++++++++++++++=========================airquality comfort ============================================================
    vector[N] odorAlfa; // propability of answering yes smell odor;
    vector[N] odorUsuAlfa; // propability of answering yes smell odor usually;
    vector[N] eta_vent; // eta_vent the latenet variable of the ranked data (Describe ventilation now)
    vector[N] nigaAirAlfa; // propability of air has nigative effect on performance ; 
    vector[N] sleepyAlfa; // propability of answering yes in the space;
    vector[N] eta_speedNow; // air speed feeling eta latenet variable. 
    //+++++++++++++++=========================Thermal comfort trnasformed Parameters============================================================
    vector[N] eta_SummerTemp; // Summer temperature feeling eta latenet variable. 
    vector[N] eta_wintTemp; // winter temperature feeling eta latenet variable.  
    // simplex[k_age] ageTheta;  // vector of possible probabilities for each category
    vector[N] agethetaprior; // Age categorial latent variable
    vector[N] ageTheta;  // vector of possible probabilities for each category
    vector[N] clothLayerTransformed = transFormCategory(clothLayer, clothLayerTheta);
    vector[N] ageTransformed = transFormCategory(age, ageTheta);
    vector[N] timeTransformed = transFormCategory(time, timeTheta);
    vector[N] weightTransformed = transFormCategory(weight,weightTheta);
    vector[N] bodyActivityTransformed = transFormCategory(bodyActivity, bodyActivityTheta);
    vector[N] eta_TempNow; // winter temperature feeling eta latenet variable.
    vector[N] nigaTheraml_Alfa; // propability of answering yes thermal have nigative effect;
    //+++++++++++++++=========================Visual comfort trnasformed Parameters=====================================================
    vector[N] BlindOFFAlfa; // propability of some blinds are OFF; 
    vector[N] lightControlAlfa; // propability of light control under control;
    vector[N] luminaireOFFAlfa; // propability of some luminair are OFF; 
    vector[N] eta_colorComf; // eta_ColorComf the latenet variable of the ranked data (How you discribe your comfort under current light color)
    vector[N] eta_illumComf; // illumination comfort latenet variable of the ranked data (How you discribe your comfort under current light level?)
    // vector[k_age] log_lik[N];
    //vector[N] log_lik;
    
    
    //---------------------------***************************************************--------------------------------------******-------
    // --------------------------------------  Sound Comfort and Noise ----------------------------------------------------------------
    eta_noiseGenarally = to_vector(beta0_Gnoise + to_row_vector(beta_Gnoise)* to_matrix(append_col(bComfort, append_col(acSystem, append_col(to_vector(outNoise), append_col(to_vector(peaople_sound), AcousComfort)))))');
    nigaLightAlfa = inv_logit(nigaL_a[1] * to_vector(building_image) + nigaL_a[2]); // alfa of the light having nigative effect on performance
    nigaNoise_Alfa = inv_logit(nigaAcou_a[1] * AcousComfort + nigaAcou_a[2]); // Alfa of the acoustiics in the space have nigative effect on working performance
    
    outNoiseAlfa = inv_logit(outN_a[1] * acou_isolation + outN_a[2]); // Alfa of the building having external noise source.
    
    acControlAlfa = inv_logit(acCont[1]*AcousComfort + acCont[2]*airQualityComf + acCont[3]*thermalComf + acCont[4]); // Alfa of the space having controlability over AC system.
    
    backgNoise_Alfa = inv_logit(backgN_a[1]*to_vector(air_speed) + backgN_a[2]*ventSystem + backgN_a[3]*acSystem + backgN_a[4]*AcousComfort + backgN_a[5]);
    // print("backgNoise_Alfa: ",backgNoise_Alfa);
    eta_noiseNow = to_vector(beta10 +  to_row_vector(beta_noisenow) * append_col(ventSystem, append_col(acSystem, append_col(to_vector(outNoise), append_col(to_vector(peaople_sound), AcousComfort))))');
    // print("eta_noiseNow: ",eta_noiseNow);
    // --------------------------------------  Air Quality transformed parametrs----------------------------------------------------------------
    odorAlfa = inv_logit(a_odor[1] + a_odor[2] * airQuality + a_odor[3] * airQualityComf); 
    odorUsuAlfa = inv_logit(a_odorUsually[1] + a_odorUsually[2]*airQuality + a_odorUsually[3]*airQualityComf);
    eta_vent = to_vector(beta0_vent + to_row_vector(beta_ventnow) * append_col(ventSystem, append_col(acSystem, append_col(to_vector(air_speed), append_col(airQuality, airQualityComf))))');
    nigaAirAlfa = inv_logit(nigaAirAlfa_a[1] + nigaAirAlfa_a[2] * airQuality + nigaAirAlfa_a[3] * airQualityComf); 
    sleepyAlfa = inv_logit(sleepyAlfa_a[1] + sleepyAlfa_a[2] * airQuality + sleepyAlfa_a[3] * airQualityComf);
    eta_speedNow = to_vector(beta0_speed + beta_speed * append_col(airQualityComf, append_col(acSystem, to_vector(air_speed)))');
    // --------------------------------------  Thermal comfort transformed parametrs----------------------------------------------------------------
    eta_SummerTemp = to_vector(beta0_SummerTemp + beta_SummerTemp * append_col(ventSystem, append_col(acSystem, append_col(acControlAlfa, append_col(thermal_isolation, thermalComf))))');
    eta_wintTemp = to_vector(beta0_wintTemp + beta_wintTemp * append_col(ventSystem, append_col(acSystem, append_col(acControlAlfa, append_col(thermal_isolation, thermalComf))))');
    agethetaprior = agetheta_coef[1] +agetheta_coef[2] * airQualityComf + agetheta_coef[3] * AcousComfort + 
                    agetheta_coef[4] *thermalComf + agetheta_coef[5] * visualComf+ agetheta_coef[6] * bComfort;
    ageTheta = softmax(agethetaprior);
    // print("age :", age);
    // print("sotmaxageprior: ", softmax(agethetaprior));
    
                   
    eta_TempNow = to_vector(beta0_TempNow + beta_TempNow * append_col(to_vector(Temp), append_col(to_vector(Humad), append_col(to_vector(Rtemp), append_col(to_vector(air_speed), metabolism))))');
    nigaTheraml_Alfa = inv_logit(a_nigaThermal[1] + a_nigaThermal[2] * thermalComf);
    // --------------------------------------  Visual comfort transformed parametrs ----------------------------------------------------------------
    BlindOFFAlfa = inv_logit(a_blindoff[1] + a_blindoff[2] * daylightSys + a_blindoff[3] * visualComf);
    lightControlAlfa = inv_logit(a_lightControl[1] + a_lightControl[2] * visualComf + a_lightControl[3] * bComfort);
    luminaireOFFAlfa = inv_logit(a_lumOFFAlfa[1] + a_lumOFFAlfa[2]* lightControlAlfa + a_lumOFFAlfa[3] * artLights);
    eta_colorComf = to_vector(beta0_colorComf + beta_colorComf * append_col(to_vector(lightColor), append_col(artLights, append_col(ageTheta, append_col(daylightSys, visualComf))))');
    eta_illumComf = to_vector(beta0_illumComf + beta_illumComf * append_col(ageTheta, append_col(to_vector(lightLevel), append_col(artLights, append_col(daylightSys, visualComf))))');

     // for (i in 1:N){
    //     log_lik[i] = normal_lpdf(airQualityComf[i] | airQualityComf_mu, airQualityComf_std) +
    //                     normal_lpdf(AcousComfort[i]| AcousComfort_mu, AcousComfort_std) +
    //                     normal_lpdf(thermalComf[i]| thermalComf_mu, thermalComf_std) +
    //                     normal_lpdf(visualComf [i]| visualComf_mu, visualComf_std) +
    //                     normal_lpdf(bComfort [i] | bComfort_mu, bComfort_std);
    // }
    //  ageTheta =  dirichlet_lpdf(log_lik | k_age)); // generate prior of theta of the age of respondent
    
     
 }
//--------------------------------------------------------------------------------------------------------------------------------
//******************************************************************************************************************************//
//--------------------------------------------------------------------------------------------------------------------------------

model{

    // -----------------################ Prior Probability #########################-------------------------------------------------------------
    //First Level --------------------------------------------------------------------------------
    bComfort ~ skew_normal(10,1,1);
    // print("bcomfort: ", bComfort);
    // Second Level --------------------------------------------------------------------------------
    airQualityComf ~ skew_normal(92,5,-1); 
    AcousComfort ~ skew_normal(92,5,-1);
    thermalComf ~ skew_normal(92,5,-1);
    visualComf ~ skew_normal(92,5,-1);
    metabolism ~ normal(100, 20);
    // print("airQualityComf: ", airQualityComf);
    // print("AcousComfort: ", AcousComfort);
    // print("thermalComf: ", thermalComf);
    // print("visualComf: ", visualComf);
    // print("metabolism: ", metabolism);

    // Third Level --------------------------------------------------------------------------------
    artLights ~ skew_normal(92,5,-1);
    acou_isolation ~ skew_normal(92,5,-1);
    acSystem ~ skew_normal(92,5,-1);
    thermal_isolation ~ skew_normal(100,15,-1);
    ventSystem ~ skew_normal(92,5,-1);
    airQuality ~ skew_normal(92,5,-1);
    daylightSys ~ skew_normal(92,5,-1);
    instanSound ~ skew_normal(35,15,-1);
    // print("artLights : ", artLights );
    // print("acou_isolation : ", acou_isolation );
    // print("acSystem: ", acSystem);
    // print("thermal_isolation: ", thermal_isolation);
    // print("ventSystem: ", ventSystem);
    // print("airQuality: ", airQuality);
    // print("daylightSys: ", daylightSys);
    // print("instanSound: ", instanSound);
    // print("Theta_1: ", theta_1);
    // print("Theta_2: ", theta_2);
    // print("Theta_3: ", theta_3);
    // print("Theta_4: ", theta_4);
    // print("Theta_5: ", theta_5);
    // print("Theta_6: ", theta_6);
    // print("Theta_7: ", theta_7);
    // print("Theta_8: ", theta_8);


    // -----------------################ Posterior Probability #########################-------------------------------------------------------------
    //First Level --------------------------------------------------------------------------------
    // Second Level --------------------------------------------------------------------------------
    nigaLightQua ~ bernoulli(nigaLightAlfa);
    // print("nigaLightAlfa :",nigaLightAlfa);
    airQualityComf ~ skew_normal(bAirQ_a[1] * bComfort + bAirQ_a[2], 1,-1);
    AcousComfort ~ skew_normal(bAcoCo_a[1] * bComfort + bAcoCo_a[2] ,1,-1);
    thermalComf ~ skew_normal(bTherCo_a[1] * bComfort + bTherCo_a[2],1,-1);
    visualComf ~ skew_normal(bVisCo_a[1] * to_vector(nigaLightQua) + bVisCo_a[2] * to_vector(building_image) + bVisCo_a[3] * bComfort + bVisCo_a[4],1,-1);
    acou_isolation ~ skew_normal(acou_iso_coef[1]+acou_iso_coef[2]*AcousComfort,abs(acou_iso_coef[3]+ acou_iso_coef[4]*bComfort), -1);
    
    
    // // Fourth Level --------------------------------------------------------------------------------
    // // --------------------------------------  Sound Comfort and Noise ----------------------------------------------------------------
    
    instanSound ~ skew_normal(insSound_a[1] * AcousComfort + insSound_a[2], abs(insSound_a[3] * bComfort + insSound_a[4]),-1); // propability of being people sound is in acceptable (comfortable) level
    // // // noiseGenarally ~ ordered_probit(eta_noiseGenarally, theta_1); // probability of the feeling of the sound level generally. 
    // print("eta_noiseGenarally :",eta_noiseGenarally);
    nigaNoise ~ bernoulli(nigaNoise_Alfa); // probability of nigative effect of  noise and sound conditions on the work performance
    // print("nigaNoise_Alfa :",nigaNoise_Alfa);
    outNoise ~ bernoulli(outNoiseAlfa); // distraction from outside sound and noise
    // print("outNoiseAlfa:",outNoiseAlfa);
    ac_control ~ bernoulli(acControlAlfa); // probability of feeling nigative effect on work performamn
    // print("acControlAlfa :",acControlAlfa);
    // air_speed ~ skew_normal(speed_a[1]*acSystem + speed_a[2]*to_vector(ac_control) + speed_a[3]*ventSystem + speed_a[4]*daylightSys + speed_a[5] , 
    //                         abs(speed_b[1]*airQualityComf +speed_b[2]*AcousComfort + speed_b[3]*thermalComf + speed_b[4]), -1); // propability of being airspeed in comfrotable level
    // print("speed_a: ", speed_a);
    // print("speed_b: ", speed_b);
    // backgNoise ~ bernoulli(backgNoise_Alfa); // probability of the answering there a background noise
    // print("backgNoise_Alfa: ", backgNoise_Alfa);
    // peaople_sound ~ skew_normal(pSound_a[1] * instanSound + pSound_a[2] * outNoiseAlfa + pSound_a[3] * backgNoise_Alfa + pSound_a[4], abs(pSound_a[5] * AcousComfort + pSound_a[6]),-1); // people instantinous noise (meaasured from device)
    // noiseNow ~ ordered_probit(eta_noiseNow, theta_1); // level of comfort under current noise and sound condition. 

    // // // --------------------------------------  Air quality ----------------------------------------------------------------
    ventSystem ~ skew_normal(vent_coef[1] + vent_coef[2]*airQualityComf + vent_coef[3]*thermalComf + vent_coef[4]*AcousComfort, abs(vent_coef[5] + vent_coef [6]*bComfort), -1);
    // acSystem ~ skew_normal(HvacSysCons[1] + HvacSysCons[2]*AcousComfort + HvacSysCons[3]*airQualityComf + HvacSysCons[4]*thermalComf,  abs(acSystem_b[1] +  acSystem_b[2]*bComfort), -1); // HVAC system condition inferred from data
    // airQuality ~ skew_normal(a_airQua[1] + a_airQua[2]*acSystem + a_airQua[3]*acControlAlfa + a_airQua[4]*ventSystem + a_airQua[5]*thermal_isolation + a_airQua[6]*daylightSys + a_airQua[7]*to_vector(air_speed),
    //                             abs(b_airQua[1] + b_airQua[2]*airQualityComf + b_airQua[3]*AcousComfort + b_airQua[4]*thermalComf),-1);  // Airquality inferred from data 
    // ch2o ~ skew_normal(ch2oA[1] + ch2oA[2]*airQuality, abs(ch2oA[3] + ch2oA[4]*airQualityComf),  -1); // Formaldehide sampling from inferred data, post probabilty
    // odor ~ bernoulli(odorAlfa); // Unusuall Odor now sampling from inferred data, post probabilty
    // odorUsually ~ bernoulli(odorUsuAlfa); // Unusuall Odor usually sampling from inferred data, post probabilty
    // vent ~ ordered_probit(eta_vent, theta_3);
    // co2 ~ skew_normal(co2_coef[1] + co2_coef[2] * airQuality, abs(co2_coef[3] + co2_coef[4] * airQualityComf),  -1);
    // o2 ~ skew_normal(o2_coef[1] + o2_coef[2] * airQuality, abs(o2_coef[3] + o2_coef[4] * airQualityComf),  -1);
    // voc ~ skew_normal(voc_coef[1] + voc_coef[2] * airQuality, abs(voc_coef[3] + voc_coef[4] * airQualityComf),  -1);
    // h2 ~ skew_normal(h2_coef[1] + h2_coef[2] * airQuality, abs(h2_coef[3] + h2_coef[4] * airQualityComf),  -1);
    // methane ~ skew_normal(methane_coef[1] + methane_coef[2] * airQuality, abs(methane_coef[3] + methane_coef[4] * airQualityComf),  -1);
    // nitric ~ skew_normal(nitric_coef[1] + nitric_coef[2] * airQuality, abs(nitric_coef[3] + nitric_coef[4] * airQualityComf),  -1);
    // co ~ skew_normal(co_coef[1] + co_coef[2] * airQuality, abs(co_coef[3] + co_coef[4] * airQualityComf),  -1);
    // lpg ~ skew_normal(lpg_coef[1] + lpg_coef[2] * airQuality, abs(lpg_coef[3] + lpg_coef[4] * airQualityComf),  -1);
    // alcohol ~ skew_normal(alcohol_coef[1] + alcohol_coef[2] * airQuality, abs(alcohol_coef[3] + alcohol_coef[4] * airQualityComf),  -1);
    // nigaAir ~ bernoulli(nigaAirAlfa); 
    // sleepy ~ bernoulli(sleepyAlfa); 
    // airSpeedNow ~ ordered_probit(eta_speedNow, theta_2); 
    
    // // // --------------------------------------  Fourth Level Model Thermal Comfort ----------------------------------------------------------------
    thermal_isolation ~ skew_normal(thermal_isolation_coef[1] + thermal_isolation_coef[2]*airQualityComf + thermal_isolation_coef[3]*thermalComf , 
                                                                abs(thermal_isolation_coef[4] + thermal_isolation_coef[5]*bComfort) , -1);                                                         
    // Rtemp ~ skew_normal(Rtemp_coef[1] + Rtemp_coef[2] * acSystem + Rtemp_coef[3] * thermal_isolation + Rtemp_coef[4] * daylightSys, 
    //                                                                               abs(Rtemp_coef[5] + Rtemp_coef[6] * thermalComf) ,-1);
    // Humad ~ skew_normal(humadity_coef[1] + humadity_coef[2]*to_vector(air_speed) + humadity_coef[3]*acControlAlfa + humadity_coef[4]*acSystem + humadity_coef[5]*ventSystem + humadity_coef[6]*daylightSys, 
    //                                 abs(humadity_coef[7]+ humadity_coef[8]*thermalComf) , -1);
    // Temp ~ skew_normal(Temp_coef[1] + Temp_coef[2]*acSystem + Temp_coef[3]*acControlAlfa + Temp_coef[4]*thermal_isolation + Temp_coef[5]*daylightSys ,
    //                         abs(Temp_coef[6] + Temp_coef[7]*thermalComf ), -1);
    // sumTemp ~ ordered_probit(eta_SummerTemp, theta_4); 
    // wintTemp ~ ordered_probit(eta_wintTemp, theta_5);
    // age ~ categorical(ageTheta); 
    // // print("Age Theta:", ageTheta);
    // // age ~ categorical(softmax(agethetaprior)); //categorical(ageTheta); //try to find a way for infering this one from softmax(Acoustic comfort, visaul comfrot 
    //                                         // thermal comfort, air quality comfort and building comfort);
    // timeTheta ~ dirichlet(rep_vector(1, k_time)); // generate prior of theta of the time in the offic of the respondent
    // time ~ categorical(timeTheta); //find out the probability of time in the office distribution from the survey answer
    // weightTheta ~ dirichlet(rep_vector(1, k_weight)); // generate prior of theta of the wieght category of the respondent
    // weight ~ categorical(weightTheta); //find out the probability of weight of different category from the survey answer
    // bodyActivityTheta ~ dirichlet(rep_vector(1, k_bodyActivity)); // generate prior of theta of the body activity category of the respondent
    // bodyActivity ~ categorical(bodyActivityTheta); // find out the probability of body activity different catigory from the survey answer
    // clothLayerTheta ~ dirichlet(rep_vector(1, k_clothlayer)); // generate prior of theta of the clothLayerTheta of respondent.
    // clothLayer ~ categorical(clothLayerTheta);  // probability of the one who answer the survey wearing specific cloth layer.
    // metabolism ~ normal(100, abs(beta_metabolism[1]*ageTheta + beta_metabolism[2]*timeTransformed + beta_metabolism[3]*weightTransformed + 
    //                             beta_metabolism[4]*bodyActivityTransformed + beta_metabolism[5] *clothLayerTransformed + beta_metabolism[5]));
    // tempNow ~ ordered_probit(eta_TempNow, theta_6); 
    // nigaThermal ~ bernoulli(nigaTheraml_Alfa); 
    
    // // // --------------------------------------  Visual Comfort ----------------------------------------------------------------
    daylightSys ~ skew_normal(dayLight_coef[1] + dayLight_coef[2]*visualComf, abs(dayLight_coef[3] + dayLight_coef[4]*bComfort),-1);
    artLights ~ skew_normal(artLights_coef[1] + artLights_coef[2]*visualComf, abs(artLights_coef[3] + artLights_coef[4]*bComfort),-1);
    // BlindOFF ~ bernoulli(BlindOFFAlfa);
    // lightControl ~ bernoulli(lightControlAlfa); 
    // luminaireOFF ~ bernoulli(luminaireOFFAlfa); 
    // //dayLightava ~ ZIB(dayLightAvaPro, BlindOFFAlfa); // find a way to infer daylight avaliabality alfa from "blinds off variable" using zero inflated 
    //                                             // system and inv_logit or inv_probit. 
    // lightLevel ~ skew_normal(lightlevel_coef[1] + lightlevel_coef[2] * dayLightAvaPro + lightlevel_coef[3] * lightControlAlfa +
    //                             lightlevel_coef[4]* artLights, abs(lightlevel_coef[5]+lightlevel_coef[6]*visualComf),-1);    
    // lightColor ~ skew_normal(lightColor_coef[1]+lightColor_coef[2]*dayLightAvaPro+lightColor_coef[3]*artLights,
    //                             abs(lightColor_coef[4]+lightColor_coef[5]*visualComf),-1); 
    // colorComf ~ ordered_probit(eta_colorComf, theta_7);
    // lightLevelFeel ~ ordered_probit(eta_illumComf, theta_8);    
         
    // //----------------------------------------------------------------------------------------- 
    // print("Theta_1: ", theta_1);
    // print("Theta_2: ", theta_2);
    // print("Theta_3: ", theta_3);
    // print("Theta_4: ", theta_4);
    // print("Theta_5: ", theta_5);
    // print("Theta_6: ", theta_6);
    // print("Theta_7: ", theta_7);
    // print("Theta_8: ", theta_8);

}
//--------------------------------------------------------------------------------------------------------------------------------
//******************************************************************************************************************************//
//--------------------------------------------------------------------------------------------------------------------------------
 generated quantities {
// // //    /* ... declarations ... statements ... *
    // real bComfort_mu;
    // real bComfort_std;
    // real airQualityComf_mu;
    // real airQualityComf_std;    
    // real AcousComfort_mu;
    // real AcousComfort_std;
    // real thermalComf_mu;
    // real thermalComf_std;
    // real visualComf_mu;
    // real visualComf_std;
    // real metabolism_mu;
    // real metabolism_sd; 
    // real artLights_mu, artLights_sd;
    // real acou_isolation_mu, acou_isolation_sd;
    // real hvacSys_mu, hvacSys_sd;
    // real thermal_isolation_mu, thermal_isolation_sd;
    // real ventSystem_mu, ventSystem_sd;
    // real airQuality_mean, airQuality_sigma;
    // real daylightSys_mu, daylightSys_sd;
    // real immediate_sound_mu, immediate_sound_sd;


    
    //  //First Level --------------------------------------------------------------------------------
    // bComfort_mu = mean(bComfort);
    // bComfort_std = sd(bComfort);

    // // Second Level --------------------------------------------------------------------------------
    // airQualityComf_mu = mean(airQualityComf);
    // airQualityComf_std = sd(airQualityComf);
    // AcousComfort_mu = mean(AcousComfort);
    // AcousComfort_std = sd(AcousComfort);
    // thermalComf_mu = mean(thermalComf);
    // thermalComf_std = sd(thermalComf);
    // visualComf_mu = mean(visualComf);
    // visualComf_std = sd(visualComf);
    // metabolism_mu = mean(metabolism);
    // metabolism_sd = sd(metabolism);

    // // Third Level --------------------------------------------------------------------------------
    // artLights_mu = mean(artLights);
    // artLights_sd = sd(artLights);
    // acou_isolation_mu = mean(acou_isolation); 
    // acou_isolation_sd = sd(acou_isolation);
    // hvacSys_mu = mean(acSystem); 
    // hvacSys_sd = sd(acSystem); //   
    // thermal_isolation_mu = mean(thermal_isolation);
    // thermal_isolation_sd = sd(thermal_isolation);
    // ventSystem_mu = mean(ventSystem);
    // ventSystem_sd = sd(ventSystem);
    // airQuality_mean = mean(airQuality);
    // airQuality_sigma = sd(airQuality);
    // daylightSys_mu = mean(daylightSys);
    // daylightSys_sd = sd(daylightSys);
    // immediate_sound_mu = mean(instanSound);
    // immediate_sound_sd = sd(instanSound);


 }
// // // End of the model



