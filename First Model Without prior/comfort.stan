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
}
    //---------------------------------------------
data{
    int N; //the numeber of total observation
    int K; //number of values on likerts scale
    int k_bodyMetab;  // number of possible answer to the question
    array[N] int age; // from survey the age category are [1 = (15-30), 2 = (30-45), 3 = (45-60)]
    int k_age;  // number of possible answer to the question 
    array[N] int time; // from survey the time in place are [1 to 13 category]  // should be reviewed when data entered
    int k_time;  // number of possible answer to the question
    array[N] int weight; // from survey the one weight [1-6 category]
    int k_weight;  // number of possible answer to the question
    array[N] int bodyActivity; // from survey the activity of the one who answering the it.  [1-6 category]
    int k_bodyActivity;  // number of possible answer to the question
    //******************************************************************
    array[N] real air_speed; // measurement of air speed in the space in m/s
    real speed_mu; // recommended measured value of the airspeed
    real speed_std;  // standard deviation of accepatble air speed in the space
    real speed_skew; // shape of the skewness of the probability normal distribution.
    array[N] real Temp; // measured temperature from sensor
    real T_mu; //recommended meausre value of dry bulb temperature. 
    real T_std; // the maximum (difference of comfortable temperature between summer and winter)/2 
    real T_skew; // Skewness of temperature (shape). 
    array[N] real Rtemp; // measured radient Temperature at the space
    real Rt_mu; // recommended value of the relative humadity.
    array[N] real Humad; // measured humadity
    real H_std; // The relative humadity standard daviation discribed as (max acciptable-mimi acceptable)/2
    real H_mu; // recomended relative humadity value for standard.  
    array[N] int<lower=1, upper=5> sumTemp;  // Summer Temperature acceptance level 
    array[N] int<lower=1, upper=5> wintTemp; // Summer Temperature acceptance level 
    array[N] int<lower=1, upper=5> tempNow;  // Summer Temperature acceptance level 
    array[N] int nigaThermal; // Is thier a nigative effect of thermal conditions on your working performance?
    array[N] int clothLayer; // from survey the thikness of layers [1 = light layers, 2 = medium layers, 3 = Heavy layers]
    int k_clothlayer;  // number of possible answer to the question
    //******************************************************************
    array[N] int lightControl; // from survey do you smell odor or unusual unpleasant smell?
    array[N] int luminaireOFF; // from survey do you smell odor or unusual unpleasant smell?
    array[N] int BlindOFF; // from survey do you smell odor or unusual unpleasant smell?
    array[N] int daylight; // from survey do you feell the building is comfortable?
    array[N] real lightLevel; // measured Light level from the robot (measurement devices)
    real lightLevel_mu; // recommended light level in the space 
    real lightLevel_std;  // acceptable standered daviation of light level in the space ()
    int lightLevel_skew; // light level shape and skewness
    //******************************************************************
    array[N] real lightColor; // measured Light color from the robot (measurement devices)
    real lightColor_std;  // acceptable standered daviation of lightColor in the space ()
    int lightColor_skew; // light Colorhape and skewness
    array[N] int<lower=0, upper=1> nigaLightQua; // from survey is there a nigative effect of light quality on your working performance.
    array[N] int<lower=1, upper=5> colorComf; // from survey to what extent you feel comfort under current color level. 
    array[N] int<lower=1, upper=5> building_image; // from survey to what extent you feel comfort under current color level. 
    array[N] int lightLevelFeel; // from survey to what extent you feel comfort under current color level. 
    //******************************************************************
    array[N] int nigaNoise; // Is thier a nigative effect of sound level and noise on your working performance?
    array[N] int<lower=0, upper=1> outNoise; // Openion, Distraction from outside noise
    array[N] int noiseNow;  // feeling of noise level 
    array[N] real peaople_sound; // measured voise and sound of people normal talk
    int p_sound_std;  // standard deviation of accepatble people sound in space 
    array[N] int noiseGenarally;  // feeling of noise level
    array[N] int backgNoise; //is there any background noise in the room?
    //******************************************************************    
    array[N] real lpg; // measured LPG from the robot (measurement devices)
    real lpg_std;  // acceptable standered daviation of LPG in the space ()
    int lpg_skew; // LPG shape and skewness 
    array[N] real alcohol; // measured alcohol from the robot (measurement devices)
    real alcohol_std;  // acceptable standered daviation of alcohol in the space ()
    int alcohol_skew; // alcohol shape and skewness
    array[N] real nitric; // measured nitric from the robot (measurement devices)
    real nitric_std;  // acceptable standered daviation of nitric in the space ()
    int nitric_skew; // nitric shape and skewness
    array[N] real ch2o; // measured Formuldehyde from the robot (measurement devices)
    real ch2o_std;  // acceptable standered daviation of Formuldehyde in the space ()
    int ch2o_skew; // Formuldehyde shape and skewness
    array[N] real voc; // measured VOC from the robot (measurement devices)
    real voc_std;  // acceptable standered daviation of VOC in the space ()
    int voc_skew; // VOC shape and skewness
    array[N] real methane; // measured methan from the robot (measurement devices)
    real methane_std;  // acceptable standered daviation of methane in the space ()
    int methane_skew; // methane shape and skewness
    array[N] int odor; // from survey do you smell odor or unusual unpleasant smell?
    //****************************************************************** 
    array[N] real co2; // measured CO2 from the robot (measurement devices)
    real co2_std;  // acceptable standered daviation of CO2 in the space ()
    int co2_skew; // CO2 shape and skewness 
    array[N] real o2; // measured O2 from the robot (measurement devices)
    real o2_std;  // acceptable standered daviation of O2 in the space ()
    int o2_skew; // O2 shape and skewness 
    array[N] real co; // measured CO from the robot (measurement devices)
    real co_std;  // acceptable standered daviation of CO in the space ()
    int co_skew; // CO shape and skewness 
    array[N] real h2; // measured H2 from the robot (measurement devices)
    real h2_std;  // acceptable standered daviation of H2 in the space ()
    int h2_skew; // H2 shape and skewness     
    //****************************************************************** 
    array[N] int ac_control; // from survey do you have controlability over AC in the space
    array[N] int sleepy; // from survey do you have controlability over AC in the space
    array[N] int odorUsually; // from survey do you smell odor or unusual unpleasant smell in this building usually?
    array[N] int vent; // feeling of vent quality of the building. 
    array[N] int airSpeedNow; // feeling of vent quality of the building.
    array[N] int nigaAir; // airQualityComf from survey, do you feel that air quailtiy in this building has anigative effect on work.  yes = 0.05, No = 0.95
    //******************************************************************
    //array[N] int selfMetabolism; // from survey the one self metabolizm [1 = low, 2 = normal, 3 = High]
    //int k_selfMetabolism;  // number of possible answer to the question
    //vector[k_selfMetabolism] selfMetabolismTheta;  // vector of possible probabilities for each 
    // array[N] int visualComf; // from survey how one feel comfortable under current light situation.  [1-5 category]
    // int k_visualComf;  // number of possible answer to the question
    // vector[k_visualComf] visualComf_Theta;  // vector of possible probabilities for each
    // array[N] int thermalComf;  // Find the propability of the thermal comfort to be good
    // real thermalComfAlfa;
    }
//--------------------------------------------------------------------------------------------------------------------------------
//******************************************************************************************************************************//
//--------------------------------------------------------------------------------------------------------------------------------
parameters {
    simplex[k_age] ageTheta;  // vector of possible probabilities for each category
    simplex[k_time] timeTheta;  // vector of possible probabilities for each category
    simplex[k_weight] weightTheta;  // vector of possible probabilities for each 
    simplex[k_bodyActivity] bodyActivityTheta;  // vector of possible probabilities for each
    vector[N] metabolism;  // metabolism, is it the same as body metabolism in the data?
    //----------------------------------------------
    real <lower=110, upper=200> speed_loc;  // recommended acceptable average air-speed value in the space
    real <lower=1, upper=15> speed_error; // air-speed sensor error (measurement error)
    real <lower=20, upper=27> T_loc; // Standard comfortable temperature 
    real <lower=18, upper=30> Rt_loc; // Standard comfortable temperature 
    real <lower=0.01, upper=2> T_error; // the Tempereture sensor error 
    real <lower=0.01, upper=2> RT_error; // the radient tempereture sensor error
    real <lower=0.01, upper=1> H_error; // the Humadity sensor error 
    real <lower=20, upper=70> H_loc; // The Standard comfortable relative humadity
    real <lower=1, upper=5> summer_Mu;  // location of the respondent mean
    real <lower=0.01, upper=1> summer_std;  // scale of the respondent answer
    real <lower=1, upper=5> winter_Mu;  // location of the respondent mean
    real <lower=0.01, upper=1> winter_std;  // scale of the respondent answer
    real <lower=1, upper=5> tempNow_Mu;  // location of the respondent mean
    real <lower=0.01, upper=1> tempNow_std;  // scale of the respondent answer
    real <lower=0, upper=1> nigaTheraml_Alfa; // propability of answering yes thermal have nigative effect; 
    simplex[k_clothlayer] clothLayerTheta; // the probability of the clothed that are used.
    vector[N] thermalComf; //The variable of the thermal comfort.
    real <lower=1, upper=30> thermalComf_std; // scale of thermal comfort; 
    //----------------------------------------------
    real <lower=0, upper=1> lightControlAlfa; // propability of light control under control;
    real <lower=0, upper=1> luminaireOFFAlfa; // propability of some luminair are OFF; 
    real <lower=0, upper=1> BlindOFFAlfa; // propability of some blinds are OFF; 
    real <lower=0, upper=1> daylightAlfa; // propability of answering yes the building is comfortable; 
    vector[N] dayLightAvaPro; // probability of that daylight have suffecient value. 
    real <lower=0.01> daylight_std; 
    vector[N] artLights; // is Artifitial light system OK?
    real <lower=5, upper=10> artLights_std;  // standard deviation of the quality of the lighting system. 
    real <lower=0, upper=10> lightLevel_error; // light level meauserment device error 
    real <lower=-1, upper=1> latentLightlevel; 
    //----------------------------------------------
    real <lower=0.1, upper=10> lightColor_error; // light Color meauserment device error 
    real <lower=2300 , upper=10000> lightColor_mu; // recommended light Color in the space
    real <lower=0, upper=1> nigaLightAlfa; // propability of answering yes there is a nigative effect of ighting quality; 
    real <lower=1, upper=5> LightFeel_mu;  // mean of the light comfort feel
    real <lower=0.1, upper=2> LightFeel_std; // standard deviation of the light comfort feel
    real <lower=1, upper=5> bImage_mu;  // mean of the building image 
    real <lower=0.1, upper=2.5> bImage_std; // standard deviation of the building image 
    real <lower=1, upper=5> colorComf_mu;  // mean of the color comfort feel
    real <lower=0.1, upper=2.5> colorComf_std; // standard deviation of the color comfort feel
    vector[N] visualComf; // prediction of the comfort level of the visaul comfort.
    // real <lower=15, upper=100> visualComf_mu;  // mean of the prediction of the comfort level of the visaul comfort.
    real <lower=1, upper=30> visualComf_std; // standard daviation of the prediction of the comfort level of the visaul comfort.
    //----------------------------------------------
    real <lower=0, upper=1> nigaNoise_Alfa; // propability of answering yes noise and sound have nigative effect; 
    real <lower=0, upper=1> outNoiseAlfa; // probability of there is an exterior sound or noise 
    real <lower=1, upper=5> noiseNow_mu;  // mean of the current sound acception 
    real <lower=0.1, upper=2.5> noiseNow_std; // standard deviation of the current sound acception 
    real <lower=15, upper=80> p_sound_mu; // accepatble average people sound 
    real <lower=0.001, upper=10> p_sound_error; // measurement error (sensor error of measured sound)
    real <lower=1, upper=5> Gnoise_mu;  // geaneral noise level in the building mean. 
    real <lower=0.1, upper=2.5> Gnoise_std;  // geaneral noise level in the building standard deviation.  
    real <lower=0, upper=1> backgNoise_Alfa; //probability of saying yes to the above question.
    vector[N] acou_isolation; //The quality of wall aoustic Isolation
    real <lower=10, upper=100> acou_isolation_mu; // mean of measured wall quality Isolation. 
    real <lower=1, upper=30> acou_isolation_std; // standard deviation of measured wall quality Isolation.
    vector[N] AcousComfort; // from survey the afeeling toward acoustic level in the space.  5 category ordinal data[1 very good to 6 v. bad]
    real <lower=1, upper=30>  AcousComfort_std; //standard visualization of the calculatd acoustic comfort.
    //------------------------------------------------
    real <lower=0.001, upper=3> lpg_error; // LPG meauserment device error 
    real <lower=0, upper=20> lpg_mu; // recommended LPG in the space
    real <lower=0, upper=1> alcohol_mu; // recommended alcohol in the space
    real <lower=0.001, upper=1> alcohol_error; // alcohol meauserment device error 
    real <lower=0, upper=10> nitric_mu; // recommended nitric in the space 
    real <lower=0.001, upper=1> nitric_error; // nitric meauserment device error
    real <lower=0, upper=2> ch2o_mu; // recommended Formuldehyde in the space
    real <lower=0.0008, upper=0.1> ch2o_error; // Formuldehyde meauserment device error 
    real <lower=10, upper=100> voc_mu; // recommended VOC in the space 
    real <lower=0.1, upper=10> voc_error; // VOC meauserment device error 
    real <lower=0, upper=10> methane_mu; // recommended methane in the space 
    real <lower=0.001, upper=1.5> methane_error; // methane meauserment device error
    real <lower=0, upper=1> odorAlfa; // propability of answering yes smell odor;
    vector[N] vocCons; // propbability of VOC consintration
    real <lower=1.2, upper=1.45> vocCons_std; // standard deviation of collective voc concentration
    real <lower=1, upper=2> vocCons_shape; // shape of collective voc concentration
    //------------------------------------------------
    real <lower=10, upper=150> co2_error; // CO2 meauserment device error 
    real <lower=700, upper=1200> co2_mu; // recommended CO2 in the space 
    real <lower=0.001, upper=1.5>  o2_error; // O2 meauserment device error 
    real <lower=20, upper=22> o2_mu; // recommended O2 in the space 
    real <lower=5, upper=60> co_mu; // recommended CO in the space 
    real <lower=0.1, upper=3.5> co_error; // CO meauserment device error
    real <lower=40, upper=70> h2_mu; // recommended H2 in the space 
    real <lower=0.001, upper=1> h2_error; // H2 meauserment device error 
    vector[N] airQuality; // predected air quality according to calculation
    real <lower = 10, upper = 80> airQuality_mu;  // predected mean of Air quality
    real <lower = 0, upper = 10> airQuality_std;  //  predected standad daviation of Air quality
    real <lower = 1, upper = 2> airQuality_skew; //  predected Skew of the shape of distribution of Air quality
    //------------------------------------------------
    real <lower=-1, upper=1> a1; 
    real <lower=-1, upper=1> a2; 
    real <lower=-1, upper=1> a3; 
    real <lower=-10, upper=10> a4; 
    real <lower=-1, upper=1> a13, a14, a15, a16, a17; 
    real <lower=0, upper=1> acControlAlfa; // propability of answering yes in the space; 
    real <lower=0, upper=1> sleepyAlfa; // propability of answering yes in the space;
    real <lower=0, upper=1> odorUsuAlfa; // propability of answering yes smell odor usually;
    real <lower=0, upper=1> nigaAirAlfa; // propability of air has nigative effect on performance ;
    real <lower = 1, upper = 5> vent_mu;  // mean of comfort feel under the current ventilation
    real <lower = 0.1, upper = 2> vent_std;  // Standard Deviation of comfort feel under the current ventilation
    real <lower = 1, upper = 5> aSpNow_mu;  // mean of comfort feel under the current air-speed
    real <lower = 0.1, upper = 2> aSpNow_std;  // Standard Deviation of comfort feel under the current air-speed
    vector[N] airQualityComf; // predected comfort under air quality according to calculation
    real <lower = 1, upper = 20> airQualityComf_std;  //  predected standad daviation of comfort under Air quality
    //------------------------------------------------ intermediate and output nodes --------------------------------------------------------
    vector[N] bComfort; // predection of to what extent Building is comfortable
    real <lower=1, upper = 40> bComfort_std; // Standard daviation of the building being comfortable, if calculated it should be equall to 0.1; 
    //real <lower = 0.2, upper = 4> bComfort_skew; // shape of the skwe normal distribution of building is comfort if its calculated should be =2;
    //--------------------------------------------------------------------------------------------------------
    real <lower =-1, upper =1> c, c1,c2; 
    real <lower =-1, upper =1> b3, b1, b2;
    vector[N] acSystem; // Thermal Isolation function as a wall u value
    real <lower=1, upper=30> acSystem_std;
    //--------------------------------------------------------------------------------------------------------
    array[N] real thermal_isolation; // Thermal Isolation function as a wall u value
    real <lower=1, upper=10> thermal_isolation_std;
    //--------------------------------------------------------------------------------------------------------
    vector[N] ventSystem; // Thermal Isolation function as a wall u value
    // real <lower=35, upper=95> ventSystem_mu; 
    real <lower=1, upper=10> ventSystem_std;
    //--------------------------------------------------------------------------------------------------------
    real posterior_log;
    //--------------------------------------------------------------------------------------------------------
    real <lower=-1, upper=1> met_a1; 
    real <lower=-1, upper=1> met_a2; 
    real <lower=-1, upper=1> met_a3;
    real <lower=-1, upper=1> met_a4;
    real <lower=-100, upper=100> met_const;

    real <lower=-1, upper=1> therm_a1; 
    real <lower=-1, upper=1> therm_a2; 
    real <lower=-1, upper=1> therm_a3; 
    real <lower=-1, upper=1> therm_a4; 
    real <lower=-1, upper=1> therm_a5; 
    real <lower=-1, upper=1> therm_a6; 
    real <lower=-1, upper=1> therm_a7;
    real <lower=-1, upper=1> therm_a8; 
    real <lower=-1, upper=1> therm_a9; 
    real <lower=-1, upper=1> therm_a10;
    real <lower=-100, upper=100> therm_const;
    real <lower=-1, upper=1> bui_a1;
    real <lower=-1, upper=1> bui_a2;
    real <lower=-1, upper=1> bui_a3;
    real <lower=-1, upper=1> bui_a4;
    real <lower=-10, upper=10> bui_const;
    // array[N] real x,b;
    real <lower=-1, upper=1> light_a1; 
    real <lower=-1, upper=1> light_a2; 
    real <lower=-1, upper=1> light_a3; 
    real <lower=-1, upper=1> light_a4; 
    real <lower=-1, upper=1> light_cons;
    //------------------------
    real <lower=-1, upper=1> visual_a1; 
    real <lower=-1, upper=1> visual_a2;
    real <lower=-1, upper=1> visual_a3;
    real <lower=-1, upper=1> visual_a4;
    real <lower=-1, upper=1> visual_a5;
    real <lower=-1, upper=1> visual_a6;
    real <lower=-1, upper=1> visual_a7;
    real <lower=-1, upper=1> visual_cons;
    //------------------------
    real <lower=-1, upper=1> acous_a1;
    real <lower=-1, upper=1> acous_a2;
    real <lower=-1, upper=1> acous_a3;
    real <lower=-1, upper=1> acous_a4;
    real <lower=-1, upper=1> acous_a5;
    real <lower=-1, upper=1> acous_a6;
    real <lower=-1, upper=1> acous_a7;
    real <lower=-1, upper=1> acous_cons;
    //------------------------
    real <lower=-1, upper=1> acoisola_alfa;
    real <lower=-1, upper=1> acoisola_const;
    real <lower=-1, upper=1> acou_isol_cons;
    //------------------------
    real <lower=-1, upper=1> aSys_a1, aSys_a2, aSys_a3; 
    real <lower=-10, upper=10> aSys_cons;
    real <lower=-1 , upper=1> speed_factor;

}
//--------------------------------------------------------------------------------------------------------------------------------
//******************************************************************************************************************************//
//--------------------------------------------------------------------------------------------------------------------------------
transformed parameters{
        vector[N] alfa_DayL;
        for (n in 1:N){
            if (daylight[n] == 0)
               if (BlindOFF[n] == 0)
                    alfa_DayL[n] = (1-daylightAlfa) * (1-BlindOFFAlfa);
                else 
                    alfa_DayL[n] = (1-daylightAlfa) * BlindOFFAlfa;
            else
                if (BlindOFF[n] == 0)
                    alfa_DayL[n] = daylightAlfa * (1-BlindOFFAlfa);
                else 
                    alfa_DayL[n] = daylightAlfa * BlindOFFAlfa;
        } 
    real vocConsintration_mu = mean(vocCons);
 }
//--------------------------------------------------------------------------------------------------------------------------------
//******************************************************************************************************************************//
//--------------------------------------------------------------------------------------------------------------------------------

model{
    ageTheta ~ dirichlet(rep_vector(1, k_age)); // generate prior of theta of the age of respondent
    age ~ categorical(ageTheta); //find out the probability of age distribution. 
    vector[N] ageTransformed = transFormCategory(age, ageTheta);
    timeTheta ~ dirichlet(rep_vector(1, k_time)); // generate prior of theta of the time in the offic of the respondent
    time ~ categorical(timeTheta); //find out the probability of time in the office distribution from the survey answer
    vector[N] timeTransformed = transFormCategory(time, timeTheta);
    weightTheta ~ dirichlet(rep_vector(1, k_weight)); // generate prior of theta of the wieght category of the respondent
    weight ~ categorical(weightTheta); //find out the probability of weight of different category from the survey answer
    vector[N] weightTransformed = transFormCategory(weight, weightTheta);
    bodyActivityTheta ~ dirichlet(rep_vector(1, k_bodyActivity)); // generate prior of theta of the body activity category of the respondent
    bodyActivity ~ categorical(bodyActivityTheta); // find out the probability of body activity different catigory from the survey answer
    vector[N] bodyActivityTransformed = transFormCategory(bodyActivity, bodyActivityTheta);
    //-----------------------------------------------------------------------------------------
    speed_loc ~ skew_normal(speed_mu , speed_std, speed_skew); // propability of being airspeed in comfrotable level
    air_speed ~ normal(speed_loc, speed_error); // propability of being air-spead measure is withen the expected value  //
    T_loc ~ skew_normal(T_mu, T_std, T_skew); // Probability of comfort knowing temperture.
    Temp ~ normal(T_loc, T_error); // Temperature propability
    Rt_loc ~ skew_normal(Rt_mu, T_std, T_skew); // Probability of comfort knowing radient temperture. 
    Rtemp ~ normal (T_mu, RT_error); // radient temperature propability normally it should be equal to the dry pulb temperature if isolation is good.
    H_loc ~ normal(H_mu, H_std); //  Probability of comfort knowing humadity
    Humad ~ normal(H_loc, H_error); // Relative humadity probability calculation
    wintTemp ~ normal(winter_Mu, winter_std);
    sumTemp ~ normal(summer_Mu, summer_std);
    tempNow ~ normal(tempNow_Mu, tempNow_std);
    nigaThermal ~ bernoulli(nigaTheraml_Alfa); // probability of nigative effect of thermal conditions on the work performance Yes // no.
    vector[N] nigaThermalTransformed = transFormBinary(nigaThermal, nigaTheraml_Alfa);
    clothLayerTheta ~ dirichlet(rep_vector(1, k_clothlayer)); // generate prior of theta of the clothLayerTheta of respondent.
    clothLayer ~ categorical(clothLayerTheta);  // probability of the one who answer the survey wearing specific cloth layer.
    vector[N] clothLayerTransformed = transFormCategory(clothLayer, clothLayerTheta);
    //-----------------------------------------------------------------------------------------
    lightControl ~ bernoulli(lightControlAlfa); // propability of responce yes on the survey question, do you have controlability over artificial light Yes / No. 
    vector[N] lightControlTransformed = transFormBinary(lightControl, lightControlAlfa);
    luminaireOFF ~ bernoulli(luminaireOFFAlfa); // propability of responce yes on the survey question, is there any of the Luminiare OFF. Yes/No.
    vector[N] luminaireOFFTransformed = transFormBinary(luminaireOFF, luminaireOFFAlfa);
    BlindOFF ~ bernoulli(BlindOFFAlfa); // propability of responce yes on the survey question, is there any of the blinds on the windows OFF
    vector[N] BlindOFFTransformed = transFormBinary(BlindOFF, BlindOFFAlfa);
    daylight ~ bernoulli(daylightAlfa); // probabiltiy of answering that day light is avialable
    vector[N] daylightTransformed = transFormBinary(daylight, daylightAlfa);
    lightLevel ~ normal(lightLevel_mu, lightLevel_error); // probabilty of the measured illumination level is correct
    //-----------------------------------------------------------------------------------------
    lightColor ~ skew_normal(lightColor_mu, lightColor_std, lightColor_skew); // probability of being light Color level is comfortabtable at this measure.
    lightColor ~  normal(lightColor_mu, lightColor_error); // probabilty of the measured light color level is correct
    nigaLightQua ~ bernoulli(nigaLightAlfa); // probability of nigative effect of light conditions on the work performance Yes // no.
    vector[N] nigaLightQuaTransformed = transFormBinary(nigaLightQua, nigaLightAlfa);
    colorComf ~ normal(colorComf_mu, colorComf_std);  // probability of degree of feeling comfort under current light color
    lightLevelFeel ~ normal(LightFeel_mu, LightFeel_std);  // probability of the feel of the level of light in the builidng. 
    building_image ~ normal(bImage_mu, bImage_std);  // probability of the feel of the level of light in the builidng.
    //-----------------------------------------------------------------------------------------
    backgNoise ~ bernoulli(backgNoise_Alfa); // probability of the answering there a background noise
    vector[N] backgNoiseTransformed = transFormBinary(backgNoise,backgNoise_Alfa);
    nigaNoise ~ bernoulli(nigaNoise_Alfa); // probability of nigative effect of  noise and sound conditions on the work performance Yes // no.
    vector[N] nigaNoiseTransformed = transFormBinary(nigaNoise,nigaNoise_Alfa);
    outNoise ~ bernoulli(outNoiseAlfa); // distraction from outside sound and noise
    vector[N] outNoiseTransformed = transFormBinary(outNoise,outNoiseAlfa);
    noiseGenarally ~ normal(Gnoise_mu, Gnoise_std);
    //-----------------------------------------------------------------------------------------
    lpg ~ skew_normal(lpg_mu, lpg_std, lpg_skew); // probability of being LPG comfortabtable at this measure.
    lpg ~ normal(lpg_mu, lpg_error); // probabilty of the measured lpg is correct
    alcohol ~ skew_normal(alcohol_mu, alcohol_std, alcohol_skew); // probability of being alcoho comfortabtable at this measure.
    alcohol ~ normal(alcohol_mu, alcohol_error); // probabilty of the measured alcoho is correct  
    nitric ~ skew_normal(nitric_mu, nitric_std, nitric_skew); // probability of being nitric comfortabtable at this measure.
    nitric ~ normal(nitric_mu, nitric_error); // probabilty of the measured mitric level is correct    
    ch2o ~ skew_normal(ch2o_mu, ch2o_std, ch2o_skew); // probability of being Formaldehyde level is comfortabtable at this measure.
    ch2o ~ normal(ch2o_mu, ch2o_error); // probabilty of the measured Formaldehyde level is correct
    voc ~ skew_normal(voc_mu, voc_std, voc_skew); // probability of being VOC level is comfortabtable at this measure.
    voc ~ normal(voc_mu, voc_error); // probabilty of the measured voc level is correct
    methane ~ skew_normal(methane_mu, methane_std, methane_skew); // probability of being methane level is comfortabtable at this measure.
    methane ~ normal(methane_mu, methane_error); // probabilty of the measured methane level is correct
    odor ~ bernoulli(odorAlfa); // probabilty of there is unusual smell right now. 
    vector[N] odorTransformed = transFormBinary(odor,odorAlfa);
    //-----------------------------------------------------------------------------------------
    noiseNow ~ normal(noiseNow_mu, noiseNow_std); // probability of the feeling of the sound level at the moment.
    noiseGenarally ~ normal(Gnoise_mu, Gnoise_std); // probability of the feeling of the sound level generally. 
    peaople_sound ~ normal(p_sound_mu, p_sound_std); // propability of being people sound is in acceptable (comfortable) level
    peaople_sound ~ normal(p_sound_mu, p_sound_error); // propability of being people sound measure is withen the expected value
    //-----------------------------------------------------------------------------------------
    odorUsually ~ bernoulli(odorUsuAlfa); // probability of smelling odor in the building most time 
    vector[N] odorUsuallyTransformed = transFormBinary(odorUsually, odorUsuAlfa);
    vent ~ normal(vent_mu, vent_std);  // probability of the quality of ventilation system feel from survey
    sleepy ~ bernoulli(sleepyAlfa); // probability of smelling odor in the building most time 
    vector[N] sleepyTransformed = transFormBinary(sleepy, sleepyAlfa);
    airSpeedNow ~ normal(aSpNow_mu, aSpNow_std);  // probability of answering three category of the air speed feel.
    nigaAir ~ bernoulli(nigaAirAlfa);  // probability of the one who answer survey feeling comfort under air quality situation. 
    vector[N] nigaAirTransformed = transFormBinary(nigaAir, nigaAirAlfa);
    ac_control ~ bernoulli(acControlAlfa); // probability of feeling nigative effect on work performamn
    vector[N] ac_controlTransformed = transFormBinary(ac_control, acControlAlfa);
    //-----------------------------------------------------------------------------------------
    co2 ~ skew_normal(co2_mu, co2_std, co2_skew); // probability of being CO2 comfortabtable at this measure.
    co2 ~ normal(co2_mu, co2_error); // probabilty of the measured CO2 is correct
    o2 ~ skew_normal(o2_mu, o2_std, o2_skew); // probability of being O2 comfortabtable at this measure.
    o2 ~ normal(o2_mu, o2_error); // probabilty of the measured O2 is correct
    co ~ skew_normal(co_mu, co_std, co_skew); // probability of being CO comfortabtable at this measure.
    co ~ normal(co_mu, co_error); // probabilty of the measured CO is correct
    h2 ~ skew_normal(h2_mu, h2_std, h2_skew); // probability of being H2 comfortabtable at this measure.
    h2 ~ normal(h2_mu, h2_error); // probabilty of the measured H2 is correct
    //-----------------------------------------------------------------------------------------
    airQuality_mu ~ normal((vocConsintration_mu + co2_mu + o2_mu + co_mu + h2_mu) + speed_factor* speed_loc, 1);  // predected mean of Air quality
    airQuality_std ~ normal(3,1); 
    airQuality_skew ~ uniform(1,3);
    airQuality ~ skew_normal(airQuality_mu, airQuality_std, airQuality_skew);  // probability of the one who answer survey discribe the current Air quality.
    // //-----------------------------------------------------------------------------------------
    thermalComf_std ~ normal(5,7);
    visualComf_std ~ normal(5, 7);
    acou_isolation_mu ~ normal(60, 10); 
    acou_isolation_std ~ normal(5, 7);
    AcousComfort_std ~ normal(5, 7);
    // //-----------------------------------------------------------------------------------------
    bComfort_std ~ normal(5, 7);
    // //-----------------------------------------------------------------------------------------
    acSystem_std ~ normal(5,7);

    //-----------------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------
    // //-------------------------------------- -1- ---------------------------------------------------
    metabolism ~ normal(met_a1 * ageTransformed + met_a2 * weightTransformed + met_a3 * timeTransformed 
                        + met_a4* bodyActivityTransformed + met_const, 10);
    //--------------------------------------------- -2- --------------------------------------------
    thermalComf ~ normal(therm_a1 * metabolism + therm_a2 * to_vector(air_speed) + therm_a3 * to_vector(Temp) + therm_a4 * to_vector(Rtemp) 
                            + therm_a5 * to_vector(Humad) + therm_a6 * winter_Mu + therm_a7 * summer_Mu + therm_a8 * tempNow_Mu 
                            + therm_a9 * nigaThermalTransformed + therm_a10 * clothLayerTransformed +therm_const, thermalComf_std);
    // //------------------------------------------ -3- -----------------------------------------------    
    latentLightlevel ~ normal(light_a1 * to_vector(lightLevel) + light_a2 * luminaireOFFTransformed + light_a3 * lightControlTransformed + 
                                    light_a4 * alfa_DayL + light_cons ,1);
    // //---------------------------------------------- -4- -------------------------------------------
    visualComf ~ normal(visual_a1 * latentLightlevel + visual_a2 * to_vector(lightColor) + visual_a3 * nigaLightQuaTransformed + visual_a4 * to_vector(colorComf) + 
                        visual_a5 * to_vector(lightLevelFeel) + visual_a6 * to_vector(building_image) + visual_a7 * ageTransformed  + visual_cons, visualComf_std);
        
    // //-----------------------------------------------------------------------------------------    
    acou_isolation_std ~ normal(acoisola_alfa* outNoiseTransformed + acoisola_const, 1) ;
    acou_isolation ~ normal(acou_isolation_mu * to_vector(outNoise) + acou_isol_cons ,acou_isolation_std);
    // //--------------------------------------------- -5- --------------------------------------------
    AcousComfort ~ normal(acous_a1 * backgNoiseTransformed + acous_a2 * nigaNoiseTransformed + acous_a3 * acou_isolation 
                            + acous_a4 * to_vector(noiseNow) + acous_a5 * to_vector(noiseGenarally) + acous_a6 * to_vector(peaople_sound)  
                            + acous_a7 * ageTransformed + acous_cons, AcousComfort_std);    
    // //-----------------------------------------------------------------------------------------
    vocCons ~ skew_normal( (to_vector(lpg) + to_vector(alcohol) + to_vector(nitric) + to_vector(ch2o) + 
                            to_vector(methane) + to_vector(voc)) .* odorTransformed, vocCons_std, voc_skew);
    // //------------------------------------------------- -6- ----------------------------------------
    airQualityComf  ~ normal(a4 + a1*airQuality + a2 * to_vector(airSpeedNow) + a3 * to_vector(vent) + a13 * bodyActivityTransformed + a14 *  odorUsuallyTransformed 
                            + a15 *  sleepyTransformed + a16 *  nigaAirTransformed + a17 * ac_controlTransformed, airQualityComf_std); 
    //---------------------------------------------Intermediate nodes--------------------------------------------
    bComfort ~ normal(bui_a1 * airQualityComf + bui_a2 * AcousComfort + bui_a2 * visualComf + bui_a3 * thermalComf + bui_const, bComfort_std);
    //-----------------------------------------------------------------------------------------
    acSystem ~ normal(aSys_a1 * airQuality  + aSys_a2 * to_vector(air_speed)  + aSys_a3 * bComfort + aSys_cons , acSystem_std);
    //---------------------------------------------Output nodes--------------------------------------------
    thermal_isolation ~ normal(b1* acSystem  + b2 * to_vector(Rtemp) + b3, thermal_isolation_std);
    //-----------------------------------------------------------------------------------------
    ventSystem ~ normal(c + backgNoiseTransformed + c1*airQualityComf  + c2 * to_vector(air_speed) , ventSystem_std);
    //-----------------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------------
    lightLevel ~ skew_normal(latentLightlevel, lightLevel_std, lightLevel_skew);
    artLights ~ normal(latentLightlevel, artLights_std);

    //-----------------------------------------------------------------------------------------
}
//--------------------------------------------------------------------------------------------------------------------------------
//******************************************************************************************************************************//
//--------------------------------------------------------------------------------------------------------------------------------
generated quantities {
//    /* ... declarations ... statements ... */
real vocCons_mu;  // mean of collective voc concentration
real airQualityComf_mu;  // predected mean of comfort under Air quality
real thermal_isolation_mu; 
real bComfort_mu;  // mean of the building is comfortable // if calculated should equal to 0.80.
real ventSystem_mu; 
real AcousComfort_mu;
real acSystem_mu;
real mean_acou_isolation_mu;
real visualComf_mu;
real thermalComf_mu;


vocCons_mu = mean(vocCons);
airQualityComf_mu = mean(airQualityComf);
thermal_isolation_mu = mean(thermal_isolation);
bComfort_mu = mean(bComfort);
ventSystem_mu = mean(ventSystem); 
AcousComfort_mu = mean(AcousComfort);
acSystem_mu = mean(acSystem);
mean_acou_isolation_mu = acou_isolation_mu;
visualComf_mu = mean(visualComf);
thermalComf_mu = mean(thermalComf);


}
// End of the model



