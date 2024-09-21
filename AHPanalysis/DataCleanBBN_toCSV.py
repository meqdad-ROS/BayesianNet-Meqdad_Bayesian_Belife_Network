import pandas as pd 
import json

# implementing PHP and MAUT methods. 
# 1- importing data
sur = pd.read_csv("/home/meqdad/Dropbox/ROS/Arch_Plans_Paper/DataSheetsCleaned/All surveys altogether-Cleaned.csv")
meas = pd.read_csv("/home/meqdad/Dropbox/ROS/Arch_Plans_Paper/DataSheetsCleaned/AllObjectiveMeasureData00.csv")
all = pd.read_csv("/home/meqdad/Dropbox/ROS/Arch_Plans_Paper/DataSheetsCleaned/AllData-Cleaned-long.csv")
mini = pd.read_csv("/home/meqdad/Dropbox/ROS/Arch_Plans_Paper/DataSheetsCleaned/ALLData-Cleaned-minimized.csv")


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



mini.rename(
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

miniCl = mini[['lightLevel', 'lightColor',
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
#all_clean = miniCl.replace(['yes','Yes', 'Yes ','yes '],1)   ###to be replaced if needed in a future analysis
all_clean = allCl.replace(['yes','Yes', 'Yes ','yes '],1)
all_clean = all_clean.replace(['no','No', 'No ','no ', 'NO'],0)
all_clean = all_clean.replace(['may be','May be', 'Maybe','maybe'],0)
sur_clean = surCl.replace(['yes','Yes', 'Yes ','yes '],1)
sur_clean = sur_clean.replace(['no','No', 'No ','no ', 'NO'],0)
sur_clean = sur_clean.replace(['may be','May be', 'Maybe','maybe'],0)

#change 'age' atrebiute. For AHP method the most important age is student age01=1, Age02 = 2, Age03 =3, (60%, 20%,20%) for BBN
all_clean['age'] = all_clean['age'].replace(['Age01','Age02', 'Age03'],[1,2,3])
sur_clean['age'] = sur_clean['age'].replace(['Age01','Age02', 'Age03'],[1,2,3])
#change 'weight' atrebiute. #For BBN percentage will be as follows (23%, 25%,20%,17%, 10%, 5%) respectivly
all_clean['weight'] = all_clean['weight'].replace(['Wieg01', 'Wieg02', 'Wieg03', 'Wieg04', 'Wieg05', 'Wieg06'],[1,2,3,4,5,6])
sur_clean['weight'] = sur_clean['weight'].replace(['Wieg01', 'Wieg02', 'Wieg03', 'Wieg04', 'Wieg05', 'Wieg06'],[1,2,3,4,5,6])
#For BBN ('Walking', 'Running', 'Working', 'Stall', 'ClimbingStairs', 'Sleeping') percentage will be as follows (50%, 10%,25%,10%, 5%, 0%) respectivly
all_clean['bodyActivity'] = all_clean['bodyActivity'].replace(['Walking', 'Running', 'Working', 'Stall', 'ClimbingStairs', 'Sleeping'],[1,2,3,4,5,6])
sur_clean['bodyActivity'] = sur_clean['bodyActivity'].replace(['Walking', 'Running', 'Working', 'Stall', 'ClimbingStairs', 'Sleeping'],[1,2,3,4,5,6])
#For BBN ('Period_01', 'Period_02', 'Period_03', 'Period_04', 'Period_05', 'Period_06') percentage will be as follows (5%, 9%,35%,33%, 18%, 0%) respectivly
all_clean['time'] = all_clean['time'].replace(['Period_01', 'Period_02', 'Period_03', 'Period_04', 'Period_05', 'Period_06'],[1,2,3,4,5,6])
sur_clean['time'] = sur_clean['time'].replace(['Period_01', 'Period_02', 'Period_03', 'Period_04', 'Period_05', 'Period_06'],[1,2,3,4,5,6])
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
all_clean['airSpeedNow'] = all_clean['airSpeedNow'].replace(['Negligable', 'LittleWindy', 'Windy'],[1,2,3]) #changed
sur_clean['airSpeedNow'] = sur_clean['airSpeedNow'].replace(['Negligable', 'LittleWindy', 'Windy'],[1,2,3]) #changed
#change attribute type to numaric as needed. 
all_clean = all_clean.infer_objects()
sur_clean = sur_clean.infer_objects() 
#mini_clean = all_clean.coby()  ###to be replaced if needed in a future analysis

#change attribute type to numaric as needed.
#all_clean['co2'] = all_clean['airSpeedNow'].astype(float)
#print (all_clean['thermalComf'][pd.to_numeric(all_clean['thermalComf'], errors='coerce').isnull()]) #find parsing error
#all_clean['thermalComf'].apply(pd.to_numeric)
#print('type of each all data-set columns', all_clean.dtypes )
#print (sur_clean['thermalComf'][pd.to_numeric(sur_clean['thermalComf'], errors='coerce').isnull()]) #find parsing error
#print('type of each sur_clean data-set columns', sur_clean.dtypes )
#all_clean.head() 
#print('type of each meas_clean data-set columns', meas_clean.dtypes )

# 8- now convert all dataframe to csv for further evaluation 
all_clean.to_csv("all_clean")
sur_clean.to("survey_cleaned")
meas_clean.to_csv("measered_cleaned")
# 8- now convert all dataframe to dictionary. 
# dataDic = all_clean.to_dict('list')
# ###to be replaced if needed in a future analysis
# #dataDic = meas_clean.to_dict(orient='dict') ###to use it to replace previouse sentence if needed in a future analysis
# #dataDic = sur_clean.to_dict(orient='dict') ###to use it to replace previouse sentence if needed in a future analysis
# #dataDic = mini_clean.to_dict(orient='dict') ###to use it to replace previouse sentence if needed in a future analysis

# dataDic.update({"N": len(dataDic['lightLevelFeel'])})
# print(dataDic)

# # 9: - import Jason, read it and convert it to dectionary then merge it to dataDic above
# with open('/home/meqdad/Dropbox/ROS/Arch_Plans_Paper/DataSheetsCleaned/supplim_data.json', 'r') as f:
#   dataContent = f.read()
# #print(dataContent)    
# data = json.loads(dataContent)
# #subdata = json.load('/home/meqdad/Dropbox/ROS/Arch_Plans_Paper/DataSheetsCleaned/supplim_data.json')
# data.update(dataDic)
# print(data) 
# #10 write a Jason file with data. 
# with open('data.json', 'w', encoding='utf-8') as f:
#     json.dump(data, f, ensure_ascii=False, indent=4)


