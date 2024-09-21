#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 19 23:59:38 2022

@author: meqdad
"""


import pandas as pd 
import seaborn as sns
import matplotlib.pyplot as plt
import pandas_profiling as pp

objectiveData = pd.read_csv("AllObjectiveMeasureData00.csv",low_memory=False)
subjectiveData = pd.read_csv("Allsurveysaltogether.csv",low_memory=False)
roomAnalysis = pd.read_csv("RoomWiseData.csv",low_memory=False)

survey01 = pd.read_csv("Surveies01.csv",low_memory=False)
survey02 = pd.read_csv("Surveies02.csv",low_memory=False)
survey03 = pd.read_csv("Surveies03.csv",low_memory=False)

#survey01.head
survey11 = pp.ProfileReport(survey01)
survey11.to_file(output_file="<survey01_Report>.html")
#survey03.tail
#survey01.groupby('How you would to descripe the air speed in this room at this moment', level=0).sum().plot(kind='bar')

survey13 = pp.ProfileReport(survey03)
survey13.to_file(output_file="<survey03_Report>.html")


#survey02.describe()
survey12 = pp.ProfileReport(survey02)
survey12.to_file(output_file="<survey02_Report>.html")


roomData = pp.ProfileReport(roomAnalysis)
roomData.to_file(output_file="<RoomWiseData_Report>.html")


AllSurveys = pp.ProfileReport(objectiveData)
AllSurveys.to_file(output_file="<AllSurveys_Report>.html")


measured = pp.ProfileReport(subjectiveData)
measured.to_file(output_file="<AllSubjectiveData_Report>.html")



