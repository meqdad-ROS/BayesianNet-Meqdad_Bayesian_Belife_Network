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

        
variables = survey03.columns


numValues = survey03.iloc[:,[10,11,15,16,18,21,22,23]].columns  

qualiVariables = survey03.iloc[:,[4,5,6,7,8,9,12,13,14,17,19,20,24,25]].columns
print('Number of interesting numarical variables= ', len(numValues))
print('Number of interesting categorial variables= ', len(qualiVariables))
print('total number of expected pictures = ', len(numValues)*(len(qualiVariables)**2))

c = 0

for i in range(len(numValues)):
    for j in range(len(qualiVariables)-1): 
        for k in range(j+1,len(qualiVariables)):
            c = c+1 
            plt.figure(c)
            fig = sns.boxplot(x=qualiVariables[j] , y= numValues[i], hue=qualiVariables[k], data=survey03)    
        
print('the second phase is started ------------------------------------------ ')        
          

for i in range(2,len(variables)-1):
    for j in range(i+1,len(variables)): 
        c = c+1 
        plt.figure(c)
        fig = sns.countplot(x=variables[i] , hue= variables[j], data=survey03)
     


