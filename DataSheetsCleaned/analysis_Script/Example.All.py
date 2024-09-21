# -*- coding: utf-8 -*-
"""
Created on Mon Aug 29 14:41:08 2022

@author: hmeqdad
"""

import pandas as pd 
import seaborn as sns
import matplotlib.pyplot as plt
#import pandas_profiling as pp

objectiveData = pd.read_csv("AllObjectiveMeasureData00.csv",low_memory=False)
subjectiveData = pd.read_csv("Allsurveysaltogether.csv",low_memory=False)
roomAnalysis = pd.read_csv("RoomWiseData.csv",low_memory=False)

survey01 = pd.read_csv("Surveies01.csv",low_memory=False)
survey02 = pd.read_csv("Surveies02.csv",low_memory=False)
survey03 = pd.read_csv("Surveies03.csv",low_memory=False)

  
#Analysis of survey number 01 
#Data frames are survey01,  survey02, survey03,  
#Other data frames are subjectiveData and roomAnalysis

# df = survey01

# numaric11 = df.iloc[:,[24,25,27]]

# #sns.pairplot(numaric11, hue='How you describe the current temperature in this room?' )
# plt.figure(1)
# fig1 = sns.countplot(x='Does the temperature in this part of the building have a negative effect on your work performance? ',hue='Do you feel comfortable under the current temperature? ',data=survey01)

# plt.figure(2)
# fig2 = sns.countplot(x='How would you describe the summer indoor air temperature (your most time feeling)?',hue='How would you describe the winter indoor air temperature (your most time feeling)?',data=survey01)

# plt.figure(3)
# fig3 = sns.countplot(x='How you describe the current temperature in this room?',hue='How would you describe the summer indoor air temperature (your most time feeling)?',data=survey01)

# plt.figure(4)
# fig4 = sns.countplot(x='How you describe the current temperature in this room?',hue='How would you describe the winter indoor air temperature (your most time feeling)?',data=survey01)

variables = survey02.columns

c = 0
# for i in variables:
#     for j in variables: 
#         c = c+1 
#         plt.figure(c)
#         fig = sns.countplot(x=i , hue= j, data=survey01)
        
variables = survey02.columns
#numValues = survey01.iloc[:,[18,19,20,21,24,25,27,31,32,33,34,37,41]].columns  
numValues = survey02.iloc[:,[24,25,27,31,32,37,41]].columns  
#qualiVariables = survey01.iloc[:,[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,22,23,26,28,29,30,35,36,38,39,40,42,43]].columns
qualiVariables = survey02.iloc[:,[4,5,6,7,8,9,10,16,23,26,28,29,30,35,36,38,39,40,42,43]].columns
print('Number of interesting numarical variables= ', len(numValues))
print('Number of interesting categorial variables= ', len(qualiVariables))
print('total number of expected pictures = ', len(numValues)*(len(qualiVariables)**2))


for i in numValues:
    for j in range(len(qualiVariables)-1): 
        for k in range(j+1,len(qualiVariables)):
            c = c+1 
            plt.figure(c)
            fig = sns.boxplot(x=qualiVariables[j] , y= i, hue=qualiVariables[k], data=survey01)    
        

#sns.barplot(data =survey03, x='Distraction from outside noise? ', y='Comfort Under current noise Level', hue='Describe noise at this moment ')

#sns.boxplot(data =survey03,x='Cloth Type',y='Com   fortable under the current temperature.')

#sns.boxplot(data =survey03,x='Activity ',y='Comfortable under the current temperature.')

#numaric01 = survey03.iloc[:,[19,22,23,24]]
#sns.pairplot(numaric,hue='Describe the current light level ')

#sns.countplot(x='Does the distraction from noise in this part of building have a negative effect on your work performance "most time feeling"?', hue = 'Your Activity ',data=survey02)

#sns.countplot(x='Does the distraction from noise in this part of building have a negative effect on your work performance "most time feeling"?', hue = 'Occupation ',data=survey02)

#sns.countplot(x='Does the distraction from noise in this part of building have a negative effect on your work performance "most time feeling"?', hue = 'Height',data=survey02)
#sns.countplot(x='Does the distraction from noise in this part of building have a negative effect on your work performance "most time feeling"?',data=survey02)


