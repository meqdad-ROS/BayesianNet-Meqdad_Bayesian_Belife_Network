import pandas as pd 
import seaborn as sns 
import matplotlib.pyplot as plt
import numpy as nm
import matplotlib.pyplot as plt

# implementing PHP and MAUT methods. 
# 1- importing data
sur = pd.read_csv("/home/meqdad/Dropbox/ROS/Arch_Plans_Paper/DataSheetsCleaned/All surveys altogether-Cleaned.csv")
meas = pd.read_csv("/home/meqdad/Dropbox/ROS/Arch_Plans_Paper/DataSheetsCleaned/AllObjectiveMeasureData00.csv")
all = pd.read_csv("/home/meqdad/Dropbox/ROS/Arch_Plans_Paper/DataSheetsCleaned/AllData-Cleaned-long.csv")
minim = pd.read_csv("/home/meqdad/Dropbox/ROS/Arch_Plans_Paper/DataSheetsCleaned/ALLData-Cleaned-minimized.csv")


#2- printing data information of measured data 
#print(meas.columns)
#print('measured data number of rows is=', len(meas.axes[0]))
#print('measured data number of colums is=', len(meas.axes[1]))

#3- printing data information of all collected data mesuared and survey 
#print(all.columns)
#print('All data together number of rows is=', len(all.axes[0]))
#print('All data together number of colums is=', len(all.axes[1]))

#4- printing data information of collected survey data 
#print(sur.columns)
#print('Servuy rows is=', len(sur.axes[0]))
#print('Servuy colums is=', len(sur.axes[1]))


#5- cleaning data by converting names of all colums to a shorten ones to make them easy to be used in later process. 
meas.rename(
    columns={'Time': 'recordTime', #2
            'Illumination level (Lux)': 'lightLevel', #4
            'Color Tempreture': 'lightColor', #5
            'Average Noise level': 'peaople_sound', #6
            'O2 Concentration (%Vol)': 'o2', #7
            'CO2 at any moment (PPM)': 'co2', #8
            'LPG concen (ppm)': 'lpg', #9
            'Alcohole Concen (ppm)': 'alcohol', #10
            'Methan Concen (ppm)': 'methane', #11
            'CO concen (ppm)': 'co', #12
            'Hydrogyn Concen (ppm)': 'h2',#13
            'Netric tVOC level (ppm)': 'nitric', #14
            'VOC Formerdahied Level (ppm)': 'ch2o' , #15
            'Different VOC (CO) Level (ppm)': 'voc', #16
            'Room Temp ( C )': 'Temp', #17
            'Room reative humadity %': 'Humad', #18
            'Radiant Temp 1 (C).1': 'Rtemp', #22
            'Wind Speed (mm/s)':'air_speed'    #23
}, 
    inplace=True,
    )


all.rename(
    columns={'Time': 'recordTime', #2
             'Illumination level (Lux)': 'lightLevel', #4
             'Color Tempreture': 'lightColor', #5
             'Average Noise level': 'peaople_sound', #6
             'O2 Concentration (%Vol)': 'o2', #7
             'CO2 at any moment (PPM)': 'co2', #8
             'LPG concen (ppm)': 'lpg', #9
             'Alcohole Concen (ppm)': 'alcohol', #10
             'Methan Concen (ppm)': 'methane', #11
             'CO concen (ppm)': 'co' , #12
             'Hydrogyn Concen (ppm)': 'h2', #13
             'Netric tVOC level (ppm)': 'nitric', #14
             'VOC Formerdahied Level (ppm)': 'ch2o', #15
             'Different VOC (CO) Level (ppm)': 'voc',  #16
             'Room Temp ( C )': 'Temp', #17
             'Room reative humadity %': 'Humad',  #18
             'Radiant Temp 1 (C)': 'Rtemp',  #63
             'Wind Speed (mm/s)': 'air_speed',  #19
             'Age': 'age', #21
             'Height': 'height', #22
             'Weight ': 'weight', #23
             'Body Activity': 'bodyActivity', #24
             'Clothing Layer': 'clothLayer', #25
             'How long do you spend in the building during the day ': 'time', #26
             'Does the temperature in this part of the building have a negative effect on your work performance? ': 'nigaThermal', #27
             'How would you describe the summer indoor air temperature "most time feeling"?':'sumTemp', #28
             'How would you describe the winter indoor air temperature "most time feeling"':'wintTemp', #29
             'Do you feel comfortable under the current temperature ? ': 'thermalComf', #30
             'How you describe the current temperature in this room?': 'tempNow',  #31
             'Does the distraction from noise in this part of building have a negative effect on your work performance "most time feeling"?': 'nigaNoise', #32
             'Is there significant distraction from noise outside (in this moment) ? ': 'outNoise', #33
             'Is there significant distraction from background noise (machine and undefined noise sources)? ':'backgNoise', #34
             'How would you describe the noise in building generally "most time feeling"?': 'noiseGenarally',  #35
             'How would describe noise at this moment?': 'noiseNow', #36
             'Comfort Under current noise Level': 'AcousComfort', #37
             'Distraction from people noise': 'people_Noise', #38
             'Does the quality of air in this part of building have a negative effect on your work performance "most time feeling"?': 'nigaAir', #39
             'Do you have control over air condition system ?': 'ac_control', #40
             'How would you describe the ventilation and air quality of building  "most time feeling"?': 'vent', #41
             'Do you smell odor or unusual smell in your work-space "most time feeling"?': 'odorUsually', #42
             'Do you feel sleepy or headache when you get to your work-space "most time feeling"?': 'sleepy', #43
             'Right now, do you smell unusual smell?': 'odor', #44
             'Does the quality of light (color and light level) in this part of building have a negative effect on your work performance ?': 'nigaLightQua', #45
             'Is there availability of natural light?':'daylight', #46
             'Are there blinds or shutters blocking the natural light ? ': 'BlindOFF', #47
             'Do you have control over artificial lightning ?': 'lightControl', #48
             'Is there any luminare is OFF at this moment?': 'luminaireOFF', #49
             'Air speed at this moment': 'airSpeedNow', #50
             'Comfortable under light colour ': 'colorComf', #52
             'Comfort under the current light level': 'visualComf' , #53
             'Describe the current light level ': 'lightLevelFeel', #54
             'How would you rate the level of cleanliness of the building?': 'building_image'
            },
    inplace=True,
    )



sur.rename(
    columns={'Age': 'age',  #5
             'Height': 'height',  #6
             ' Wieght. ': 'weight',  #7
             'Your Activity ': 'bodyActivity',  #8
             'Clothing Type': 'clothLayer',  #9
             'Time in the office': 'time',  #11           
             'Does the temperature in this part of the building have a negative effect on your work performance? ': 'nigaThermal',  # 26
             'How would you describe the summer indoor air temperature (your most time feeling)?':'summTemp',  # 27
             'How would you describe the winter indoor air temperature (your most time feeling)?': 'wintTemp',  # 28
             'Do you feel comfortable under the current temperature? ': 'thermalComf',  # 29
             'How you describe the current temperature in this room?': 'tempNow',  # 30
             'Does the distraction from noise in this part of building have a negative effect on your work performance (most time feeling)?': 'nigaNoise',  #31 
             'Is there significant distraction from noise outside (at this moment)? ': 'outNoise',  #32
             'Is there significant distraction from background noise (machine and undefined noise sources) (at this moment)? ': 'backgNoise',  #33
             'How would you describe the noise in building generally?': 'noiseGenarally',  # 34
             'How would describe noise at this moment? ': 'noiseNow',  # 35
             'Comfort Under current noise Level': 'AcousComfort',  #37
             'Does the quality of air in this part of building have a negative effect on your work performance?': 'nigaAir',  #40
             'Do you have control over air condition system?': 'ac_control',  #41
             'How would you describe the ventilation and air quality of building ?': 'vent',  #42
             'Do you smell odor or unusual smell in your work-space?': 'odorUsually',  #43
             'Do you feel sleepy or headache when you get to your work-space?': 'sleepy',  #44
             'Right now, do you smell unusual smell?': 'odor',  #45
             'Does the quality of light in this part of building have a negative effect on your work performance ?': 'nigaLightQua',  #47
             'Is there availability of natural light?': 'daylight',  #48
             'Are there blinds or shutters blocking the natural light?': 'BlindOFF',  #49
             'Do you have control over artificial lightning?': 'lightControl',  #50
             'Is there any luminare is OFF at this moment?': 'luminaireOFF',  #51
             'Air speed at this moment': 'airSpeedNow',  #46
             'Distraction from people noise': 'people_Noise',
             'Comfortable under light colour ': 'colorComf',  #52
             'Comfort under the current light level': 'visualComf',  #53
             'Describe the current light level ':  'lightLevelFeel', # 54
             'How would you rate the level of cleanliness of the building?': 'building_image'
              },
    inplace = True,
)


#6- printing data information of all data frames
#print('measured data variable names are', meas.columns)
#print('------------------------------------------------------------------------------------------------------------------------------')
#print('All collected data variable names are', all.columns)
#print('------------------------------------------------------------------------------------------------------------------------------')
#print('Survey data variable names are', sur.columns)

#7- clean by dropping out the unnecessary columns from each data-set
meas_clean = meas[['lightLevel', 'lightColor','peaople_sound', 'o2', 'co2', 
                    'lpg', 'alcohol', 'methane', 'co', 'h2',
                    'nitric', 'ch2o', 'voc', 'Temp', 'Humad', 'Rtemp', 'air_speed']].copy()
#print('measured data variable names are', meas_clean.columns)

allCl = all[['lightLevel', 'lightColor',
       'peaople_sound', 'o2', 'co2', 'lpg', 'alcohol', 'methane', 'co', 'h2',
       'nitric', 'ch2o', 'voc', 'Temp', 'Humad', 'Rtemp', 'air_speed',
       'age', 'weight', 'bodyActivity', 'clothLayer',
       'time', 'nigaThermal', 'sumTemp', 'wintTemp', 'thermalComf', 'tempNow',
       'nigaNoise', 'outNoise', 'backgNoise', 'noiseGenarally', 'noiseNow',
       'AcousComfort', 'people_Noise', 'nigaAir', 'ac_control', 'vent',
       'odorUsually', 'sleepy', 'odor', 'nigaLightQua', 'daylight',
       'BlindOFF', 'lightControl', 'luminaireOFF', 'airSpeedNow',
       'Ventilation and Air smell', 'colorComf', 'visualComf',
       'lightLevelFeel', 'building_image']].copy()
#print('All collected data variable names are', allCl.columns)

surCl = sur[['age', 'weight', 'bodyActivity', 'clothLayer', 'time',
       'nigaThermal', 'summTemp', 'wintTemp', 'thermalComf', 'tempNow', 'nigaNoise',
       'outNoise', 'backgNoise', 'noiseGenarally', 'noiseNow', 'people_Noise',
       'AcousComfort', 'building_image', 'nigaAir', 'ac_control', 'vent', 'odorUsually', 
       'sleepy', 'odor', 'airSpeedNow', 'nigaLightQua', 'daylight', 'BlindOFF', 
       'lightControl', 'luminaireOFF', 'colorComf', 'visualComf', 'lightLevelFeel']].copy()
#print('Survey data variable names are', surCl.columns)

#allCl.head()

#print('type of each all data-set columns', allCl.dtypes )
#print('type of each survey data-set columns', surCl.dtypes)


#7- continueu cleaning
all_clean = allCl.copy()
all_clean['odor'] = all_clean['odor'].replace(['yes','Yes', 'Yes ','yes '],0)
all_clean['odor'] = all_clean['odor'].replace(['no','No', 'No ','no ', 'NO'],1)
all_clean['odorUsually'] = all_clean['odorUsually'].replace(['yes','Yes', 'Yes ','yes '],0)
all_clean['odorUsually'] = all_clean['odorUsually'].replace(['no','No', 'No ','no ', 'NO'],1)
all_clean['sleepy'] = all_clean['sleepy'].replace(['yes','Yes', 'Yes ','yes '],0)
all_clean['sleepy'] = all_clean['sleepy'].replace(['no','No', 'No ','no ', 'NO'],1)
all_clean['nigaNoise'] = all_clean['nigaNoise'].replace(['yes','Yes', 'Yes ','yes '],0)
all_clean['nigaNoise'] = all_clean['nigaNoise'].replace(['no','No', 'No ','no ', 'NO'],1)
all_clean['nigaThermal'] = all_clean['nigaThermal'].replace(['yes','Yes', 'Yes ','yes '],0)
all_clean['nigaThermal'] = all_clean['nigaThermal'].replace(['no','No', 'No ','no ', 'NO'],1)
all_clean['nigaAir'] = all_clean['nigaAir'].replace(['yes','Yes', 'Yes ','yes '],0)
all_clean['nigaAir'] = all_clean['nigaAir'].replace(['no','No', 'No ','no ', 'NO'],1)
all_clean['nigaLightQua'] = all_clean['nigaLightQua'].replace(['yes','Yes', 'Yes ','yes '],0)
all_clean['nigaLightQua'] = all_clean['nigaLightQua'].replace(['no','No', 'No ','no ', 'NO'],1)
all_clean['BlindOFF'] = all_clean['BlindOFF'].replace(['yes','Yes', 'Yes ','yes '],0)
all_clean['BlindOFF'] = all_clean['BlindOFF'].replace(['no','No', 'No ','no ', 'NO'],1)

sur_clean = surCl.copy()
sur_clean['odor'] = all_clean['odor'].replace(['yes','Yes', 'Yes ','yes '],0)
sur_clean['odor'] = all_clean['odor'].replace(['no','No', 'No ','no ', 'NO'],1)
sur_clean['odorUsually'] = sur_clean['odorUsually'].replace(['yes','Yes', 'Yes ','yes '],0)
sur_clean['odorUsually'] = sur_clean['odorUsually'].replace(['no','No', 'No ','no ', 'NO'],1)
sur_clean['sleepy'] = sur_clean['sleepy'].replace(['yes','Yes', 'Yes ','yes '],0)
sur_clean['sleepy'] = sur_clean['sleepy'].replace(['no','No', 'No ','no ', 'NO'],1)
sur_clean['nigaNoise'] = sur_clean['nigaNoise'].replace(['yes','Yes', 'Yes ','yes '],0)
sur_clean['nigaNoise'] = sur_clean['nigaNoise'].replace(['no','No', 'No ','no ', 'NO'],1)
sur_clean['nigaThermal'] = sur_clean['nigaThermal'].replace(['yes','Yes', 'Yes ','yes '],0)
sur_clean['nigaThermal'] = sur_clean['nigaThermal'].replace(['no','No', 'No ','no ', 'NO'],1)
sur_clean['nigaAir'] = sur_clean['nigaAir'].replace(['yes','Yes', 'Yes ','yes '],0)
sur_clean['nigaAir'] = sur_clean['nigaAir'].replace(['no','No', 'No ','no ', 'NO'],1)
sur_clean['nigaLightQua'] = sur_clean['nigaLightQua'].replace(['yes','Yes', 'Yes ','yes '],0)
sur_clean['nigaLightQua'] = sur_clean['nigaLightQua'].replace(['no','No', 'No ','no ', 'NO'],1)
sur_clean['BlindOFF'] = sur_clean['BlindOFF'].replace(['yes','Yes', 'Yes ','yes '],0)
sur_clean['BlindOFF'] = sur_clean['BlindOFF'].replace(['no','No', 'No ','no ', 'NO'],1)

all_clean['vent'] = all_clean['vent'].replace([1,2,3,4,5],[5,4,3,2,1])
all_clean['Ventilation and Air smell'] = all_clean['Ventilation and Air smell'].replace([1,2,3,4,5],[5,4,3,2,1])
all_clean['daylight'] = all_clean['daylight'].replace([1,2,3,4,5],[5,4,3,2,1])
all_clean['building_image'] = all_clean['building_image'].replace([1,2,3,4,5],[5,4,3,2,1])

sur_clean['vent'] = sur_clean['vent'].replace([1,2,3,4,5],[5,4,3,2,1])
sur_clean['daylight'] = sur_clean['daylight'].replace([1,2,3,4,5],[5,4,3,2,1])
sur_clean['building_image'] = sur_clean['building_image'].replace([1,2,3,4,5],[5,4,3,2,1])

 


all_clean = all_clean.replace(['yes','Yes', 'Yes ','yes '],1)
all_clean = all_clean.replace(['no','No', 'No ','no ', 'NO'],0)
all_clean = all_clean.replace(['may be','May be', 'Maybe','maybe'],-1)
sur_clean = surCl.replace(['yes','Yes', 'Yes ','yes '],1)
sur_clean = sur_clean.replace(['no','No', 'No ','no ', 'NO'],0)
sur_clean = sur_clean.replace(['may be','May be', 'Maybe','maybe'],-1)

#change 'age' atrebiute. For AHP method the most important age is student age01=3, Age02 and Age03 are same importance Age02 = 2, Age03 =1, (60%, 20%,20%) for BBN
all_clean['age'] = all_clean['age'].replace(['Age01','Age02', 'Age03'],[3,2,1])
sur_clean['age'] = sur_clean['age'].replace(['Age01','Age02', 'Age03'],[3,2,1])
#change 'weight' atrebiute. For AHP method the most important age is student Wieg01=5, Wieg02=6, Wieg03=4, Wieg04=2, Wieg05=3 and Wieg06=1. 
#For BBN percentage will be as follows (23%, 25%,20%,17%, 10%, 5%) respectivly
all_clean['weight'] = all_clean['weight'].replace(['Wieg01', 'Wieg02', 'Wieg03', 'Wieg04', 'Wieg05', 'Wieg06'],[5,6,4,2,3,1])
sur_clean['weight'] = sur_clean['weight'].replace(['Wieg01', 'Wieg02', 'Wieg03', 'Wieg04', 'Wieg05', 'Wieg06'],[5,6,4,2,3,1])
#change 'bodyActivity' atrebiute. For AHP method the most important bodyActivity is Walking=3, Running=3, Working=6, Stall=5, ClimbingStairs=2, Sleeping=1. 
#For BBN ('Walking', 'Running', 'Working', 'Stall', 'ClimbingStairs', 'Sleeping') percentage will be as follows (50%, 10%,25%,10%, 5%, 0%) respectivly
all_clean['bodyActivity'] = all_clean['bodyActivity'].replace(['Walking', 'Running', 'Working', 'Stall', 'ClimbingStairs', 'Sleeping'],[3,2,6,5,2,1])
sur_clean['bodyActivity'] = sur_clean['bodyActivity'].replace(['Walking', 'Running', 'Working', 'Stall', 'ClimbingStairs', 'Sleeping'],[3,2,6,5,2,1])
#change 'time' atrebiute. For AHP method the most important timePeriod is Period_03=6, Period_04=5, Period_05=4, Period_02=3, Period_01=2. 
#For BBN ('Period_01', 'Period_02', 'Period_03', 'Period_04', 'Period_05', 'Period_06') percentage will be as follows (5%, 9%,35%,33%, 18%, 0%) respectivly
all_clean['time'] = all_clean['time'].replace(['Period_01', 'Period_02', 'Period_03', 'Period_04', 'Period_05', 'Period_06'],[2,3,6,5,4,1])
sur_clean['time'] = sur_clean['time'].replace(['Period_01', 'Period_02', 'Period_03', 'Period_04', 'Period_05', 'Period_06'],[2,3,6,5,4,1])
#change 'clothLayer' atrebiute. For AHP method the most important clothLayer is ['Dress_22', 'Dress_94', 'Dress_95', 'Dress_213', 'Dress_215', 'Dress_364', 'Dress_365', 'Dress_366']='Light' = 1 in summer and 5 in winter
#['Dress_78', 'Dress_192', 'Dress_194'],'Heavy' = 1 in summer and 5 in winter. 
#['Dress_99', 'Dress_150', 'Dress_220'],'semiHeavy' = 2 in summer and 4 in winter.
#['Dress_206', 'Dress_207',],'meduim' = 3 in both summer and winter
#                        'semiLight' = 4 in summer and 2 in winter.
#For BBN ('Heavy', 'semiHeavy', 'meduim', 'semiLight', 'Light') percentage will be as follows (1%, 5%,10%,16%, 68%) 
#respectivly in summer and reveresed in winter
all_clean['clothLayer'] = all_clean['clothLayer'].replace(['Dress_22', 'Dress_94', 'Dress_95', 'Dress_213', 'Dress_215', 
                                                           'Dress_364', 'Dress_365', 'Dress_366'],5)
all_clean['clothLayer'] = all_clean['clothLayer'].replace(['Dress_78', 'Dress_192', 'Dress_194'],1)
all_clean['clothLayer'] = all_clean['clothLayer'].replace(['Dress_99', 'Dress_150', 'Dress_220'],2)
all_clean['clothLayer'] = all_clean['clothLayer'].replace(['Dress_206', 'Dress_207',],3)

sur_clean['clothLayer'] = sur_clean['clothLayer'].replace(['Dress_22', 'Dress_94', 'Dress_95', 'Dress_213', 'Dress_215', 
                                                           'Dress_364', 'Dress_365', 'Dress_366'],5)
sur_clean['clothLayer'] = sur_clean['clothLayer'].replace(['Dress_78', 'Dress_192', 'Dress_194'],1)
sur_clean['clothLayer'] = sur_clean['clothLayer'].replace(['Dress_99', 'Dress_150', 'Dress_220'],2)
sur_clean['clothLayer'] = sur_clean['clothLayer'].replace(['Dress_206', 'Dress_207',],3)
#change 'airSpeedNow' atrebiute. For AHP method the most important airSpeedNow is Negligable=3, LittleWindy=2, Windy=1, 
#in AC conditioning building and reversed in normal vintilationed building
#For BBN ('Negligable', 'LittleWindy', 'Windy') percentage will be as follows (85%, 15%,0%) respectivly in AC 
#conditioning building and reversed in normal vintilationed building
all_clean['airSpeedNow'] = all_clean['airSpeedNow'].replace(['Negligable', 'LittleWindy', 'Windy'],[3,2,1]) #changed
sur_clean['airSpeedNow'] = sur_clean['airSpeedNow'].replace(['Negligable', 'LittleWindy', 'Windy'],[3,2,1]) #changed
#change attribute type to numaric as needed. 
all_clean = all_clean.infer_objects()
sur_clean = sur_clean.infer_objects()
#change attribute type to numaric as needed.
#all_clean['co2'] = all_clean['airSpeedNow'].astype(float)
#print (all_clean['thermalComf'][pd.to_numeric(all_clean['thermalComf'], errors='coerce').isnull()]) #find parsing error
#all_clean['thermalComf'].apply(pd.to_numeric)
print('type of each all data-set columns', all_clean.dtypes )
#print (sur_clean['thermalComf'][pd.to_numeric(sur_clean['thermalComf'], errors='coerce').isnull()]) #find parsing error
print('type of each sur_clean data-set columns', sur_clean.dtypes )
#all_clean.head() 
print('type of each meas_clean data-set columns', meas_clean.dtypes )


#8- visualization of AHP data correlative
#create df of objective VOC 
obj_voc_df = meas_clean[['lpg','nitric','voc','ch2o','alcohol','methane']].copy()
##//sns.pairplot(obj_voc_df)

obj_airquality_df = meas_clean[['co','co2','h2','o2','air_speed','Humad','Temp']].copy()
##//obj_airquality_df.infer_objects()
##// sns.pairplot(obj_airquality_df)
##//obj_airquality_df.dtypes

obj_visial_df = meas_clean[['lightLevel','lightColor']].copy()
##//sns.pairplot(obj_visial_df)

obj_thermal_df = meas_clean[['air_speed','Humad','Temp','Rtemp']].copy()
##//sns.pairplot(obj_thermal_df)

sbj_airquality_df = sur_clean[['nigaAir','ac_control','odorUsually','odor','age','bodyActivity','vent','airSpeedNow']].copy()
##//sns.pairplot(sbj_airquality_df, hue="bodyActivity", diag_kind="kde")

sbj_metab_df = sur_clean[['age','bodyActivity','weight','time']].copy()
##//sns.pairplot(sbj_metab_df, hue="bodyActivity", diag_kind="kde")

sbj_thermal_df = sur_clean[['nigaThermal','summTemp','wintTemp','thermalComf','tempNow','clothLayer']].copy()
##//sns.pairplot(sbj_thermal_df, hue="clothLayer", diag_kind="kde")

sbj_illum_df = sur_clean[['BlindOFF','lightControl','luminaireOFF','daylight']].copy()
##//sns.pairplot(sbj_illum_df, hue="daylight", diag_kind="kde")

sbj_Acous_df = sur_clean[['nigaNoise','outNoise','backgNoise','noiseGenarally','noiseNow','people_Noise','AcousComfort']].copy()
##//sns.pairplot(sbj_Acous_df, hue="AcousComfort", kind="kde", diag_kind="kde")

sbj_visial_df = sur_clean[['lightLevelFeel','nigaLightQua','colorComf','visualComf','building_image','daylight','age']].copy()
##//sns.pairplot(sbj_visial_df, hue="age", kind="kde", diag_kind="kde", markers=["o", "s", "D"], corner=True) 

bbn_humanBodyMeta_df = all_clean[['age','bodyActivity','weight','time']].copy()


#//g = sns.pairplot(bbn_humanBodyMeta_df, 
#                 hue="age", 
#                 #hue_order ='',
#                 palette = sns.color_palette("husl",3),
#                 kind="kde", 
#                 diag_kind="kde", 
#                 markers=["o", "s", "D"], 
#                 corner=True,
#                 #diag_kws = 'grid_kws', 
                 #grid_kws = 'grid_kws'
#                 ) 
                           
#g.map_lower(sns.kdeplot, levels=4, color=".2")     




#print('type of each all data-set columns', sur_clean.dtypes )
#sur_clean.head()
#plt.hist(sur_clean['thermalComf'])
#plt.plot(all_clean['co2'])
#plt.show()
#sur_clean['thermalComf'].head
#print('type of each all data-set columns', all_clean.dtypes )

bbn_thermalComf_df = all_clean[['clothLayer','air_speed','Temp','Humad','Rtemp','nigaThermal','sumTemp','wintTemp','thermalComf','tempNow']].copy() 
#g = sns.pairplot(bbn_thermalComf_df, 
#                 hue="clothLayer", 
                 #hue_order ='',
#                 palette = sns.color_palette("husl",4),
                 #kind="hist", 
#                 diag_kind="kde", 
                 #markers=["H", "s", "M","L"], 
#                 corner=True,
                 #diag_kws = 'grid_kws', 
                 #grid_kws = 'grid_kws'
#                 ) 
#g.map_lower(sns.kdeplot, levels=4, color=".2")   

bbn_illuminationLevel_df = all_clean[['daylight','luminaireOFF','lightControl']].copy()
#g = sns.pairplot(bbn_illuminationLevel_df, 
#                 hue=" daylight", 
#                 #hue_order ='',
#                 palette = sns.color_palette("husl",3),
#                 #kind="kde", 
#                 diag_kind="kde", 
#                 markers=["o", "s", "D"], 
#                 corner=True,
                 #diag_kws = 'grid_kws', 
                 #grid_kws = 'grid_kws'
#                 ) 

bbn_visualComf_df = all_clean[['age','lightLevel','lightColor','nigaLightQua','colorComf','visualComf','lightLevelFeel','building_image']].copy()
#g = sns.pairplot(bbn_visualComf_df, 
#                 hue="visualComf", 
                 #hue_order ='',
#                 palette = sns.color_palette("husl",5),
#                 kind="kde", 
#                 diag_kind="kde", 
#                 markers=["o", "s", "D"], 
#                 corner=True,
                 #diag_kws = 'grid_kws', 
                 #grid_kws = 'grid_kws'
#                 ) 

bbn_acuosticComf_df = all_clean[['age','peaople_sound','outNoise','backgNoise','people_Noise','AcousComfort','noiseGenarally','noiseNow','nigaNoise','vent']].copy()
#g = sns.pairplot(bbn_acuosticComf_df, 
#                 hue="AcousComfort", 
                 #hue_order ='',
#                 palette = sns.color_palette("husl",5),
                 #kind="kde", 
#                 diag_kind="kde", 
                 #markers=["o", "s", "D"], 
#                 corner=True,
                 #diag_kws = 'grid_kws', 
                 #grid_kws = 'grid_kws'
#                 ) 

bbn_vocCons_df = all_clean[['lpg','alcohol','nitric','ch2o', 'methane', 'voc','odor']].copy()
#g = sns.pairplot(bbn_vocCons_df, 
#                 hue="odor", 
                 #hue_order ='',
#                 palette = sns.color_palette("husl",3),
                 #kind="kde", 
#                 diag_kind="kde", 
                 #markers=["o", "s", "D"], 
#                 corner=True,
                 #diag_kws = 'grid_kws', 
                 #grid_kws = 'grid_kws'
#                 ) 

bbn_airQua_df = all_clean[['o2','co2','co','h2','air_speed','odorUsually']].copy()
#g = sns.pairplot(bbn_airQua_df, 
#                 hue="odorUsually", 
                 #hue_order ='',
#                 palette = sns.color_palette("husl",3),
                 #kind="kde", 
#                 diag_kind="kde", 
                 #markers=["o", "s", "D"], 
#                 corner=True,
                 #diag_kws = 'grid_kws', 
                 #grid_kws = 'grid_kws'
#                 ) 

bbn_airComf_df = all_clean[['ac_control','sleepy','nigaAir','vent','airSpeedNow','Ventilation and Air smell']].copy()
#g = sns.pairplot(bbn_airComf_df, 
#                 hue="nigaAir", 
                 #hue_order ='',
#                 palette = sns.color_palette("husl",3),
#                 kind="kde", 
#                 diag_kind="kde", 
#                 markers=["o", "s", "D"], 
#                 corner=True,
                 #diag_kws = 'grid_kws', 
                 #grid_kws = 'grid_kws'
#                 ) 

import numpy as nm

#10 - do AHP and MAUT fit data. write the founded equation  ahp_contin = contineues data function. 
#ahp_binary = binary data function, ahp_rank = ranked data function. 
ahp_contin = lambda z,mu,lowerRange,upperRange: (0 if ((z > upperRange) or (z<lowerRange)) else (1-(abs(z-mu)/(upperRange - lowerRange)))**0.1)
ahp_binary = lambda z: (1 if z>0 else 0)
ahp_rank = lambda z,mini,maxi: (z / (maxi - mini+1))

#11- creating wait vectors: 
#obj_voc_df[['lpg','nitric','voc','ch2o','alcohol','methane']]     ## measured VOC values
obj_voc_weight = [0.26, 0.029, 0.145, 0.146, 0.174, 0.245]

##obj_airquality_df[['co','co2','h2','o2','air_speed','Humad','Temp' ]] + obj_voc_calc   
## measured airquality values ## add obj_voc_calc to the end of obj_airquality_df dataframe
obj_airQual_weight = [0.173, 0.058, 0.157, 0.143, 0.085, 0.162, 0.168 , 0.173]

#obj_visial_df[['lightLevel','lightColor']]
obj_visual_weight = [0.91, 0.09]

#obj_thermal_df= [['air_speed','Humad','Temp','Rtemp']]
obj_thermal_weight = [ 0.182, 0.27, 0.314, 0.23]

#obj_param_calc=[obj_airQual, obj_visual, obj_acoustic, obj_thermal]  ##Second level wiehgt ## same for objective measure 
##and subjective obinion
param_wieght=[0.212, 0.258, 0.272, 0.258]

#sbj_airquality_df[['nigaAir','ac_control','odorUsually','odor','age','bodyActivity','vent','airSpeedNow']]
subj_airQual_weight= [0.12, 0.12,0.07,0.03, 0.28, 0.1, 0.14,0.14]

#sbj_metab_df[['age','bodyActivity','weight','time']]
subj_metabolism_weight= [ 0.11, 0.17, 0.45, 0.13]

#sbj_thermal_df[['nigaThermal','summTemp','wintTemp','thermalComf','tempNow','clothLayer']] ## add "subj_metabolism_calculated" as last 
#colum in the  "sbj_thermal_df"
subj_thermal_weight =[0.1, 0.19, 0.14, 0.1, 0.2, 0.04, 0.13]

#sbj_illum_df [['BlindOFF','lightControl','luminaireOFF'] 
subj_illum_weight =[0.263, 0.052, 0.685]

#sbj_Acous_df[['nigaNoise','outNoise','backgNoise','noiseGenarally','noiseNow','people_Noise','AcousComfort']] ##remove "people_noise" 
## add'age'
subj_Acous_weight =[0.1 , 0.1, 0.19, 0.1, 0.12, 0.1, 0.28]

#sbj_visial_df [['lightLevelFeel','nigaLightQua','colorComf','visualComf','building_image','daylight','age']] ##add 'daylight' 
#as the last column of the "sbj_visial_df" and remove "lightLevelFeel"
subj_visual_weight =[ 0.03, 0.11, 0.14, 0.14, 0.18, 0.14, 0.26]


#obj_airquality_df.insert(7, )
#df = df.drop(columns=['gender'])

#### 12 - do calculation

N= len(all_clean)
BPI = []
calculatedValueDF = []
subjectiveComf = []
objectiveComf = []
averagePerformance = 0
resultedValues = []

for i in range (0,N): 
    print('i = ',i)
    #12.1 Apply MAUT function for all variables
    obj_voc_calc = [ahp_contin(all_clean['lpg'][i], 3.5, 2, 5),
                    ahp_contin(all_clean['nitric'][i], 0.1, 0.05, 1),
                    ahp_contin(all_clean['voc'][i], 50, 30, 100),
                    ahp_contin(all_clean['ch2o'][i], 0.2, 0.07, 1.9),
                    ahp_contin(all_clean['alcohol'][i], 0.1, 0.017, 1),
                    ahp_contin(all_clean['methane'][i], 2, 1, 4)
                   ]
    # obj_voc_weight = [0.26, 0.029, 0.145, 0.146, 0.174, 0.245]
    obj_airquality_calc = [ahp_contin(all_clean['co'][i], 3, 2, 25), 
                           ahp_contin(all_clean['co2'][i], 800, 700, 1000), 
                           ahp_contin(all_clean['h2'][i], 2, 0.4, 4), 
                           ahp_contin(all_clean['o2'][i], 20, 19.5, 23.5), 
                           ahp_contin(all_clean['air_speed'][i], 0.15, 0.1, 0.8), 
                           ahp_contin(all_clean['Humad'][i], 50, 20, 70), 
                           ahp_contin(all_clean['Temp'][i], 22.5, 20, 27) 
                          ]
    print('obj_airquality_calc list values',obj_airquality_calc )
    print('temperature value', all_clean['Temp'][i])
    print('temperature type', type(all_clean['Temp'][i]))
    #obj_airQual_weight = [0.173, 0.058, 0.157, 0.143, 0.085, 0.162, 0.168 , 0.173] + obj_voc_calc (wight)
    obj_visual_calc = [ahp_contin(all_clean['lightLevel'][i], 350, 150, 500),   # 750, 500, 950),
                       ahp_contin(all_clean['lightColor'][i], 7200, 5000, 9500), # 4200, 3500, 5000)
                      ]
    #obj_visual_weight = [0.91, 0.09]
    obj_thermal_calc = [ahp_contin(all_clean['air_speed'][i], 0.15, 0.1, 0.8),
                        ahp_contin(all_clean['Humad'][i], 50, 20, 70),
                        ahp_contin(all_clean['Temp'][i], 22.5, 20, 27),
                        ahp_contin(all_clean['Rtemp'][i], 23, 10, 40)
                       ]
    #obj_thermal_weight = [ 0.182, 0.27, 0.314, 0.23] 
    obj_acous_calc = ahp_contin(all_clean['peaople_sound'][i], 35, 25, 45)  #48, 40, 55)
    #obj_acous_weight = 1
    subj_airQual_calc = [ahp_binary(all_clean['nigaAir'][i]),
                         ahp_binary(all_clean['ac_control'][i]),
                         ahp_binary(all_clean['odorUsually'][i]),
                         ahp_binary(all_clean['odor'][i]),
                         ahp_rank(all_clean['age'][i],1,3),
                         ahp_rank(all_clean['bodyActivity'][i], 1, 5),
                         ahp_rank(all_clean['vent'][i],1,5),
                         ahp_binary(all_clean['airSpeedNow'][i])
                        ]
    #subj_airQual_weight= [0.12, 0.12,0.07,0.03, 0.28, 0.1, 0.14,0.14]
    subj_metabolism_calc = [ahp_rank(all_clean['age'][i],1,3),
                            ahp_rank(all_clean['bodyActivity'][i], 1, 5),
                            ahp_rank(all_clean['weight'][i], 1, 6),
                            ahp_rank(all_clean['time'][i], 1, 5)
                           ]
    #subj_metabolism_weight= [ 0.11, 0.17, 0.45, 0.13]
    subj_thermal_calc = [ahp_binary(all_clean['nigaThermal'][i]),
                         ahp_rank(all_clean['sumTemp'][i], 1, 5),
                         ahp_rank(all_clean['wintTemp'][i], 1, 5),
                         ahp_binary(all_clean['thermalComf'][i]),
                         ahp_rank(all_clean['tempNow'][i], 1, 5),
                         ahp_rank(all_clean['clothLayer'][i], 1, 5)
                        ]
    ## add "subj_metabolism_calculated" as last #colum in the  "sbj_thermal_df"
    #subj_thermal_weight =[0.1, 0.19, 0.14, 0.1, 0.2, 0.04, 0.13]
    subj_illum_calc = [ahp_binary(all_clean['BlindOFF'][i]),
                       ahp_binary(all_clean['lightControl'][i]),
                       ahp_binary(all_clean['luminaireOFF'][i])
                      ]
    #subj_illum_weight =[0.263, 0.052, 0.685]
    subj_Acous_calc = [ahp_binary(all_clean['nigaNoise'][i]),
                       ahp_binary(all_clean['outNoise'][i]),
                       ahp_binary(all_clean['backgNoise'][i]),
                       ahp_rank(all_clean['noiseGenarally'][i],1,5),
                       ahp_rank(all_clean['noiseNow'][i],1,5),
                       ahp_rank(all_clean['AcousComfort'][i],1,5),
                       ahp_rank(all_clean['age'][i],1,3),
                      ]
    #subj_Acous_weight =[0.1 , 0.1, 0.19, 0.1, 0.12, 0.1, 0.28]
    subj_visual_calc = [ahp_rank(all_clean['lightLevelFeel'][i],1,5),
                        ahp_binary(all_clean['nigaLightQua'][i]),
                        ahp_rank(all_clean['colorComf'][i],1,5),
                        ahp_rank(all_clean['visualComf'][i],1,5),
                        ahp_rank(all_clean['building_image'][i],1,5),
                        ahp_binary(all_clean['daylight'][i]),
                        ahp_rank(all_clean['age'][i],1,3)
                       ]  
    #subj_visual_weight =[ 0.03, 0.11, 0.14, 0.14, 0.18, 0.14, 0.26]

    #12.2 apply AHP weight vector and calculate: 
    obj_voc = nm.multiply(obj_voc_calc,obj_voc_weight)
    obj_airquality_calc.append(sum(obj_voc))
    obj_airquality = nm.multiply(obj_airquality_calc,obj_airQual_weight)
    subj_illum = nm.multiply(subj_illum_calc, subj_illum_weight)
    obj_visual_calc[0] = obj_visual_calc[0] *sum(subj_illum)
    obj_visual = nm.multiply(obj_visual_calc, obj_visual_weight)
    print(obj_visual)
    
    print(obj_visual)
    print('summation of obj_visual= ', sum(obj_visual))
    obj_thermal = nm.multiply(obj_thermal_calc, obj_thermal_weight)
    obj_acous = obj_acous_calc
    
    
    subj_airQual = nm.multiply(subj_airQual_weight, subj_airQual_calc)
    subj_metabolism = nm.multiply(subj_metabolism_weight, subj_metabolism_calc)
    subj_thermal_calc.append(sum(subj_metabolism)) 
    subj_thermal = nm.multiply(subj_thermal_calc, subj_thermal_weight)
    subj_Acous = nm.multiply(subj_Acous_calc, subj_Acous_weight)
    subj_visual = nm.multiply(subj_visual_calc, subj_visual_weight)
    

    calculatedValueDF  = [sum(obj_airquality),  sum(obj_visual), obj_acous, sum(obj_thermal), sum(subj_airQual), 
                             sum(subj_thermal), sum(subj_Acous), sum(subj_visual)
                            ]
    print('visaul comfort= ',obj_visual)
    print('Acoustical comfort= ',obj_acous)
    
    subjectiveComf = 0.65*sum(nm.multiply(param_wieght, calculatedValueDF[4:8]))
    objectiveComf = 0.35*sum(nm.multiply(param_wieght, calculatedValueDF[0:4]))
    calculatedValueDF.append(objectiveComf)
    calculatedValueDF .append(subjectiveComf)
    BPI.append(subjectiveComf + subjectiveComf)
    calculatedValueDF.append(BPI[i])

    averagePerformance = (averagePerformance + BPI[i])/2
    calculatedValueDF.append(averagePerformance)
    resultedValues.append(calculatedValueDF)
    #input("Press Enter to continue...")

#convert list to dataframe
result_df = pd.DataFrame(resultedValues, columns =['obj_airquality', 'obj_visual', 'obj_acous', 'obj_thermal', 'subj_airQual', 
                             'subj_thermal', 'subj_Acous', 'subj_visual', 'objectiveComf','subjectiveComf','BPI','averageBPI']) 
#print list, data frame, average. 
#vesualize result 


#result_df.head(n=20)
result_df.tail(n=100)

g = sns.pairplot(result_df, 
                 #hue="nigaAir", 
                 #hue_order ='',
                 palette = sns.color_palette("husl",3),
                 #kind="kde", 
                 diag_kind="kde", 
                 markers=["o", "s", "D"], 
                 corner=True,
                 #diag_kws = 'grid_kws', 
                 #grid_kws = 'grid_kws',
                 dropna=True
                 ) 

plt.show()



