import os.path
import logging
logging.getLogger("cmdstanpy").setLevel(logging.DEBUG)
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import arviz as az
import scipy.stats as stats
import csv

import cmdstanpy as stan


# try:
#     if not os.path.exists(stan.cmdstan_path()):
#         stan.install_cmdstan(overwrite=True)
#     print(stan.cmdstan_path())
# except:
#     pass




def zero_inflated(xvalue, alfa):
    if xvalue == 0:
        return 1 - alfa
    else:
        return alfa


stan_file = 'comfort02.stan'
logging.getLogger("cmdstanpy").setLevel(logging.DEBUG)
model = stan.CmdStanModel(stan_file=stan_file)



# print(model)
# print("_____________________________________1__________________________________________")
# print('modle information is ', model.exe_info())
# print("______________________________________1.1_________________________________________")

# DataCleanBBN
# params = ['bComfort', 'bComfort_std', 'ventSystem', 'ventSystem_std', 'thermal_isolation', 'thermal_isolation_std', 'acSystem', 
#                             'acSystem_std', 'airQualityComf', 'airQualityComf_std', 'AcousComfort', 'AcousComfort_std', 'visualComf', 
#                             'visualComf_std', 'thermalComf', 'thermalComf_std']

# params = ['bComfort_mu', 'bComfort_std', 'ventSystem_mu', 'ventSystem_std', 'thermal_isolation_mu', 'thermal_isolation_std', 'acSystem_mu', 
#                             'acSystem_std', 'airQualityComf_mu', 'airQualityComf_std', 'AcousComfort_mu', 'AcousComfort_std', 'visualComf_mu', 
#                             'visualComf_std', 'thermalComf_mu', 'thermalComf_std']

# params0 = ['bComfort_mu', 'ventSystem_mu', 'thermal_isolation_mu', 'acSystem_mu',
        # #    'airQualityComf_mu', 'AcousComfort_mu', 'visualComf_mu',
        #    'thermalComf_mu']

# params1 = ['bComfort_std', 'ventSystem_std', 'thermal_isolation_std',
#            'acSystem_std', 'airQualityComf_std', 'AcousComfort_std',
        #    'visualComf_std', 'thermalComf_std']

params2 = ['bComfort', 'ventSystem', 'thermal_isolation', 'acSystem', 'airQualityComf', 'AcousComfort', 'visualComf',
           'thermalComf']

data_file = 'data.json'
# data_file = 'GeneratedData1.json'
print('data = ', data_file)
print("_____________________________________1.2__________________________________________")
fit = model.sample(data=data_file, show_console=True)  # inits={parametername:[initial value]}
# access model variable by name

print("---------------------------Done sampling ---------------------------------------")
fit.save_csvfiles(dir='fitOutput.csv')
outSummary = fit.summary()
outSummary.to_csv('output/fit_summary.csv')
# print("______________________________________2_________________________________________")
MLE = model.optimize(data=data_file)
MLE.save_csvfiles(dir='fitOutput.csv')
# print(fit.stan_variable('acSystem'))
# print("______________________________________2.1_________________________________________")
mle_Output_Data = MLE.optimized_params_pd  # one of the most important data in the program  #################### (1)
output_data = fit.draws_pd()
# print('mle_Output_Data= ', mle_Output_Data) 
# print("______________________________________3___________________________________________")
# axes01 = az.plot_posterior(fit, var_names=params, combine_dims={"draw"}, figsize =(50,50), textsize = 10) #filter_vars="like",
# fig01 = axes01.ravel()[0].figure
# fig01.savefig('output/fit_posterior_plot.pdf')
# plt.savefig("posterior_plot.pdf")
# plt.savefig("posterior_plot.png")

axes01 = az.plot_posterior(fit, var_names=params2, combine_dims={"draw"}, figsize=(50, 50),
                           textsize=10)  # filter_vars="like",
fig01 = axes01.ravel()[0].figure
fig01.savefig('output/fit_posterior_mean_plot.pdf')
plt.savefig("posterior_ mean_plot.pdf")
plt.savefig("posterior_mean_plot.png")

# axes011 = az.plot_posterior(fit, var_names=params1, combine_dims={"draw"}, figsize=(50, 50),
#                             textsize=10)  # filter_vars="like",
# fig011 = axes011.ravel()[0].figure
# fig011.savefig('output/fit_posterior_std_plot.pdf')
# plt.savefig("posterior_std_plot.pdf")
# plt.savefig("posterior_std_plot.png")

# print(fit.stan_variable('bComfort_mu'))
# print(fit.stan_variable('vocCons'))
# print("______________________________________3_________________________________________")

for i in range(1, len(params2)):
    # for j in range(0,len(params2)-1):
    # axes02 = az.plot_pair(fit, var_names=[params2[i-1],params2[i]], marginals=True, combine_dims={"draw"}, figsize =(50,50), textsize = 10) # filter_vars="like",
    # fig02= axes02.ravel()[0].figure
    # fig02.savefig('output/fit_pair_plot_0'+ str(i-1)+'.pdf')
    # axes02 = az.plot_pair(fit, var_names=[params0[i - 1], params0[i]], marginals=True, combine_dims={"draw"},
    #                       figsize=(50, 50), textsize=10)  # filter_vars="like",
    # fig02 = axes02.ravel()[0].figure
    # fig02.savefig('output/fit_pair_mean_plot_0' + str(i - 1) + '.pdf')

    axes022 = az.plot_pair(fit, var_names=[params2[i - 1], params2[i]], marginals=True, combine_dims={"draw"},
                           figsize=(50, 50), textsize=10)  # filter_vars="like",
    fig022 = axes022.ravel()[0].figure
    fig022.savefig('output/fit_pair_std_plot_0' + str(i - 1) + '.pdf')

# plt.savefig("pair_plot.pdf")
# plt.savefig("pair_plot.png")
# print(fit.draws_pd('acSystem')[:3])
# print(fit.draws_xr('acSystem'))
print("______________________________________4_________________________________________")
# axes030 = az.plot_trace(fit, var_names=params2, divergences=None, compact=True, combined=True,
#                         figsize=(24, 16))  # kind= {“trace”, “rank_bars”, “rank_vlines”},filter_vars="like",
# fig030 = axes030.ravel()[0].figure
# fig030.savefig('output/fit_plot.pdf')
# plt.savefig("trace_plot.pdf")
# plt.savefig("trace_plot.png")

axes03 = az.plot_trace(fit, var_names=params2, divergences=None, compact=True, combined=True,
                       figsize=(24, 16))  # kind= {“trace”, “rank_bars”, “rank_vlines”},filter_vars="like",
fig03 = axes03.ravel()[0].figure
fig03.savefig('output/fit_trace_mean_plot.pdf')
plt.savefig("trace_mean_plot.pdf")
plt.savefig("trace_mean_plot.png")

# axes033 = az.plot_trace(fit, var_names=params1, divergences=None, compact=True, combined=True,
#                         figsize=(24, 16))  # kind= {“trace”, “rank_bars”, “rank_vlines”},filter_vars="like",
# fig033 = axes033.ravel()[0].figure
# fig033.savefig('output/fit_plot.pdf')
# plt.savefig("trace_std_plot.pdf")
# plt.savefig("trace_std_plot.png")
# az.plot_trace(fit,var_names=params, divergences="top", kind= 'rank_bars', compact=True, figsize =(24,16)) #filter_vars="like",
# az.plot_trace(fit,var_names=params, divergences="top", kind= 'rank_vlines', compact=True, figsize =(24,16)) #  filter_vars="like",
# access all model variables
# for k, v in fit.stan_variables().items():
#     print(f'{k}\t{v.shape}')
# print("______________________________________5_________________________________________")
# # access the sampler method variables
# for k, v in fit.method_variables().items():
#     print(f'{k}\t{v.shape}')
# print("______________________________________6_________________________________________")
# # access all Stan CSV file columns
# print(f'numpy.ndarray of draws: {fit.draws().shape}')
# # print("MLE putput column name: ", MLE.column_names)
# print("______________________________________7_________________________________________")
output_data = fit.draws_pd()
idata_from_cmdstanpy = az.from_cmdstanpy(fit)
print("______________________________________8_________________________________________")
data_draw = fit.draws
# print('Data_OOutput = ', data_draw)
# print(fit.metric_type)
# print("______________________________________9_________________________________________")
# # print(fit.metric)
# print("______________________________________10_________________________________________")
# # print(fit.step_size)
# print()
# print("______________________________________11_________________________________________")
# print()
# # print(fit.metadata.cmdstan_config['model'])
# print("______________________________________12_________________________________________")
# print()
# # print(fit.metadata.cmdstan_config['seed'])
# print("______________________________________13_________________________________________")
# print()
# print(fit.metadata)
# print("______________________________________14_________________________________________")
# print()
# # print(fit.metadata.method_vars_cols.keys())


fit.summary()
print("______________________________________14.00_________________________________________")
print()

print(fit.diagnose())
print("______________________________________15_________________________________________")
# print(data_draw)
outputParameters = fit.stan_variables()
print(outputParameters)
print("______________________________________15.01_________________________________________")
# print(output_data)
print("______________________________________15.02_________________________________________")
MLEoutputParameters = MLE.optimized_params_dict
# print("MLE prameters dic: ", mle_Output_Data )
print("______________________________________15.03_________________________________________")
outputParameters_mu = {}
for key in outputParameters:
    outputParameters_mu[key + '_mu'] = np.mean(outputParameters[key])
# print('Outputmeans = ', outputParameters_mu)
with open('outputParameters_means.csv', 'w') as f:  # You will need 'wb' mode in Python 2.x
    w = csv.DictWriter(f, outputParameters_mu.keys())
    w.writeheader()
    w.writerow(outputParameters_mu)
print("______________________________________15.04_________________________________________")
##########plt.show()
print("______________________________________END_________________________________________")
print(" Ending ________________ Every thing is OK")

##start predicting the resulted probability and the other factors: ______________________________________________________

# importing all data from csv files:

df = pd.read_csv('RowData/all_clean.csv')

dfFullLength = df.shape[0]  # number of data entry in the data frame
metabolism = []
voc_consentarion = []
airquailty_calc = []
illumnaation_levl = []
thermal_comfort = []
visual_comfort = []
Acoustic_Comfort = []
Acoustic_isolation = []
Ventilation_Quality = []
Building_Comfort = []
Air_quality_Comfort = []
HVACsys_condition = []
thermal_isolation = []

tc_probability = []
vc_probability = []
acc_probability = []
aic_probability = []
bcPercentage = []
hvacPercentage = []
tiPercentage = []
ventSysPercentage = []
aiPercentage = []

for i in range(0, dfFullLength):
    metabolism.append(outputParameters_mu['met_a1_mu'] * outputParameters['ageTheta'][0][df['age'].iloc[i] - 1] +
                      outputParameters_mu['met_a2_mu'] * outputParameters['weightTheta'][0][
                          df['weight'].iloc[i] - 1] +  # weightTransformed
                      outputParameters_mu['met_a3_mu'] * outputParameters['timeTheta'][0][
                          df['time'].iloc[i] - 1] +  # timeTransformed
                      outputParameters_mu['met_a4_mu'] * outputParameters['bodyActivityTheta'][0][
                          df['bodyActivity'].iloc[i] - 1] +
                      outputParameters_mu['met_const_mu'])

    thermal_comfort.append(outputParameters_mu['therm_a1_mu'] * metabolism[i] +
                           outputParameters_mu['therm_a2_mu'] * df['air_speed'].iloc[i] +
                           outputParameters_mu['therm_a3_mu'] * df['Temp'].iloc[i] +
                           outputParameters_mu['therm_a4_mu'] * df['Rtemp'].iloc[i] +
                           outputParameters_mu['therm_a5_mu'] * df['Humad'].iloc[i] +
                           outputParameters_mu['therm_a6_mu'] * df['wintTemp'].iloc[i] +
                           outputParameters_mu['therm_a7_mu'] * df['sumTemp'].iloc[i] +
                           outputParameters_mu['therm_a8_mu'] * df['tempNow'].iloc[i] +
                           outputParameters_mu['therm_a9_mu'] * zero_inflated(df['nigaThermal'].iloc[i],
                                                                              outputParameters_mu[
                                                                                  'nigaTheraml_Alfa_mu']) +
                           outputParameters_mu['therm_a10_mu'] * outputParameters['clothLayerTheta'][0][
                               df['clothLayer'].iloc[i] - 1] +
                           outputParameters_mu['therm_const_mu'])

    illumnaation_levl.append(outputParameters_mu['light_a1_mu'] * df['lightLevel'].iloc[i] +
                             outputParameters_mu['light_a2_mu'] * zero_inflated(df['luminaireOFF'].iloc[i],
                                                                                outputParameters_mu[
                                                                                    'luminaireOFFAlfa_mu']) +
                             outputParameters_mu['light_a3_mu'] * zero_inflated(df['lightControl'].iloc[i],
                                                                                outputParameters_mu[
                                                                                    'lightControlAlfa_mu']) +
                             outputParameters_mu['light_a4_mu'] * zero_inflated(df['BlindOFF'].iloc[i],
                                                                                outputParameters_mu[
                                                                                    'BlindOFFAlfa_mu']) *
                             zero_inflated(df['daylight'].iloc[i], outputParameters_mu['daylightAlfa_mu']) +
                             outputParameters_mu['light_cons_mu'])

    visual_comfort.append(outputParameters_mu['visual_a1_mu'] * illumnaation_levl[i] +
                          outputParameters_mu['visual_a2_mu'] * df['lightColor'].iloc[i] +
                          outputParameters_mu['visual_a3_mu'] * zero_inflated(df['nigaLightQua'].iloc[i],
                                                                              outputParameters_mu['nigaLightAlfa_mu']) +
                          outputParameters_mu['visual_a4_mu'] * df['colorComf'].iloc[i] +
                          outputParameters_mu['visual_a5_mu'] * df['lightLevelFeel'].iloc[i] +
                          outputParameters_mu['visual_a6_mu'] * df['building_image'].iloc[i] +
                          outputParameters_mu['visual_a7_mu'] * outputParameters['ageTheta'][0][df['age'].iloc[i] - 1] +
                          outputParameters_mu['visual_cons_mu'])

    Acoustic_isolation.append(outputParameters_mu['acou_isolation_mu_mu'] * zero_inflated(df['outNoise'].iloc[i],
                                                                                          outputParameters_mu[
                                                                                              'outNoiseAlfa_mu']) +
                              outputParameters_mu['acou_isol_cons_mu'])

    # -------------------------------------------------------------------------------------------------------------------
    Acoustic_Comfort.append(outputParameters_mu['acous_a1_mu'] * zero_inflated(df['backgNoise'].iloc[i],
                                                                               outputParameters_mu[
                                                                                   'backgNoise_Alfa_mu']) +
                            outputParameters_mu['acous_a2_mu'] * zero_inflated(df['nigaNoise'].iloc[i],
                                                                               outputParameters_mu[
                                                                                   'nigaNoise_Alfa_mu']) +
                            outputParameters_mu['acous_a3_mu'] * Acoustic_isolation[i] +
                            outputParameters_mu['acous_a4_mu'] * df['noiseNow'].iloc[i] +
                            outputParameters_mu['acous_a5_mu'] * df['noiseGenarally'].iloc[i] +
                            outputParameters_mu['acous_a6_mu'] * df['peaople_sound'].iloc[i] +
                            outputParameters_mu['acous_a7_mu'] * outputParameters['ageTheta'][0][
                                df['age'].iloc[i] - 1] +
                            outputParameters_mu['acous_cons_mu'])

    voc_consentarion.append(
        (df['lpg'].iloc[i] + df['alcohol'].iloc[i] + df['nitric'].iloc[i] + df['ch2o'].iloc[i] + df['methane'].iloc[i] +
         df['voc'].iloc[i]) * zero_inflated(df['odor'].iloc[i], outputParameters_mu['odorAlfa_mu']))

    airquailty_calc.append((voc_consentarion[i] + df['co2'].iloc[i] + df['o2'].iloc[i] +
                            df['co'].iloc[i] + df['h2'].iloc[i]) + outputParameters_mu['speed_factor_mu'] *
                           df['air_speed'].iloc[i])  #

    Air_quality_Comfort.append(outputParameters_mu['a4_mu'] +
                               outputParameters_mu['a1_mu'] * airquailty_calc[i] +
                               outputParameters_mu['a2_mu'] * df['airSpeedNow'].iloc[i] +
                               outputParameters_mu['a3_mu'] * df['vent'].iloc[i] +
                               outputParameters_mu['a13_mu'] * outputParameters['bodyActivityTheta'][0][
                                   df['bodyActivity'].iloc[i] - 1] +
                               outputParameters_mu['a14_mu'] * zero_inflated(df['odorUsually'].iloc[i],
                                                                             outputParameters_mu['odorUsuAlfa_mu']) +
                               outputParameters_mu['a15_mu'] * zero_inflated(df['sleepy'].iloc[i],
                                                                             outputParameters_mu['sleepyAlfa_mu']) +
                               outputParameters_mu['a16_mu'] * zero_inflated(df['nigaAir'].iloc[i],
                                                                             outputParameters_mu['nigaAirAlfa_mu']) +
                               outputParameters_mu['a17_mu'] * zero_inflated(df['ac_control'].iloc[i],
                                                                             outputParameters_mu['acControlAlfa_mu']))

    Building_Comfort.append(outputParameters_mu['bui_a1_mu'] * Air_quality_Comfort[i] +
                            outputParameters_mu['bui_a2_mu'] * Acoustic_Comfort[i] +
                            outputParameters_mu['bui_a2_mu'] * visual_comfort[i] +
                            outputParameters_mu['bui_a3_mu'] * thermal_comfort[i] +
                            outputParameters_mu['bui_const_mu'])

    HVACsys_condition.append(outputParameters_mu['aSys_a1_mu'] * airquailty_calc[i] +
                             outputParameters_mu['aSys_a2_mu'] * df['air_speed'].iloc[i] +
                             outputParameters_mu['aSys_a3_mu'] * Building_Comfort[i] +
                             outputParameters_mu['aSys_cons_mu'])
    # print(HVACsys_condition[i])

    thermal_isolation.append(outputParameters_mu['b1_mu'] * HVACsys_condition[i] +
                             outputParameters_mu['b2_mu'] * df['Rtemp'].iloc[i] + outputParameters_mu['b3_mu'])

    Ventilation_Quality.append(outputParameters_mu['c_mu'] +
                               zero_inflated(df['backgNoise'].iloc[i], outputParameters_mu['backgNoise_Alfa_mu']) +
                               outputParameters_mu['c1_mu'] * Air_quality_Comfort[i] +
                               outputParameters_mu['c2_mu'] * df['air_speed'].iloc[i])

    tc_probability.append(stats.norm.cdf(thermal_comfort[i], loc=outputParameters_mu['thermalComf_mu_mu'],
                                         scale=outputParameters_mu['thermalComf_std_mu']))
    vc_probability.append(stats.norm.cdf(visual_comfort[i], loc=outputParameters_mu['visualComf_mu_mu'],
                                         scale=outputParameters_mu['visualComf_std_mu']))
    acc_probability.append(stats.norm.cdf(Acoustic_Comfort[i], loc=outputParameters_mu['AcousComfort_mu'],
                                          scale=outputParameters_mu['AcousComfort_std_mu']))
    aic_probability.append(stats.norm.cdf(Air_quality_Comfort[i], loc=outputParameters_mu['airQualityComf_mu_mu'],
                                          scale=outputParameters_mu['airQualityComf_std_mu']))

    bcPercentage.append(stats.norm.cdf(Building_Comfort[i], loc=outputParameters_mu['bComfort_mu_mu'],
                                       scale=outputParameters_mu['bComfort_std_mu']))
    hvacPercentage.append(stats.norm.cdf(HVACsys_condition[i], loc=outputParameters_mu['acSystem_mu'],
                                         scale=outputParameters_mu['acSystem_std_mu']))
    tiPercentage.append(stats.norm.cdf(thermal_isolation[i], loc=outputParameters_mu['thermal_isolation_mu'],
                                       scale=outputParameters_mu['thermal_isolation_std_mu']))
    ventSysPercentage.append(stats.norm.cdf(Ventilation_Quality[i], loc=outputParameters_mu['ventSystem_mu'],
                                            scale=outputParameters_mu['ventSystem_std_mu']))
    aiPercentage.append(stats.norm.cdf(Acoustic_isolation[i], loc=outputParameters_mu['acou_isolation_mu'],
                                       scale=outputParameters_mu['acou_isolation_std_mu']))

predectionData = pd.DataFrame(
    np.array([thermal_comfort, tc_probability, visual_comfort, vc_probability, Acoustic_Comfort,
              acc_probability, Air_quality_Comfort, aic_probability, Building_Comfort,
              bcPercentage, HVACsys_condition, hvacPercentage, thermal_isolation, tiPercentage,
              Ventilation_Quality, ventSysPercentage, Acoustic_isolation, aiPercentage]).T.tolist(),
    columns=['thermal_comfort', 'tc_probability', 'visual_comfort', 'vc_probability',
             'Acoustic_Comfort', 'acc_probability', 'Air_quality_Comfort', 'aic_probability', 'Building_Comfort',
             'bcPercentage', 'HVACsys_condition', 'hvacPercentage', 'thermal_isolation', 'tiPercentage',
             'Ventilation_Quality', 'ventSysPercentage', 'Acoustic_isolation', 'aiPercentage'])
caluulationdata = pd.DataFrame(np.array([airquailty_calc, metabolism, voc_consentarion]).T.tolist(),
                               columns=['airquailty_calc', 'metabolism', 'voc_consentarion'])
caluulationdata.to_csv('latent_calculation_data.csv')
predectionData.to_csv('Output_prediction_data.csv')

# fig04 = sns.pairplot(predectionData[['thermal_comfort', 'visual_comfort', 'Acoustic_Comfort', 'Air_quality_Comfort', 'Building_Comfort', 
#                                      'HVACsys_condition', 'thermal_isolation', 'Ventilation_Quality', 'Acoustic_isolation']])
# fig05 = sns.pairplot(predectionData[['tc_probability', 'vc_probability', 'acc_probability', 'aic_probability', 
#                                      'bcPercentage','hvacPercentage','tiPercentage', 'ventSysPercentage', 'aiPercentage']])

# fig04.savefig('output/prediction_pair_plot.pdf')
# fig05.savefig('output/prediction_Probability_pair_plot.pdf')
print('------------------------All figures are ploted and saved --------------------------------------------')
print('------------------------Process Ends --------------------------------------------')

# add those variables
# real <lower=-1, upper=1> acoisola_alfa;
#     real <lower=-1, upper=1> acoisola_const;
#     real <lower=-1, upper=1> acous_isolation_cons;


# https://www.linkedin.com/in/meqdad-hasan/
