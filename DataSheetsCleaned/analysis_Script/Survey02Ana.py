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



c = 0       
variables = survey02.columns


numValues = survey02.iloc[:,[18,19,21,25,26,29,34]].columns  

qualiVariables = survey02.iloc[:,[4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,22,23,24,27,28,30,31,32,33,35,36,37]].columns
print('Number of interesting numarical variables= ', len(numValues))
print('Number of interesting categorial variables= ', len(qualiVariables))
print('total number of expected pictures = ', len(numValues)*(len(qualiVariables)**2))


for i in numValues:
    for j in range(len(qualiVariables)-1): 
        for k in range(j+1,len(qualiVariables)):
            c = c+1 
            plt.figure(c)
            fig = sns.boxplot(x=qualiVariables[j] , y= i, hue=qualiVariables[k], data=survey02)    
        
print('the second phase is started ------------------------------------------ ')     

for i in range(2,len(variables)-1):
    for j in range(i+1,len(variables)): 
        c = c+1 
        plt.figure(c)
        fig = sns.countplot(x=variables[i] , hue= variables[j], data=survey02)
     


