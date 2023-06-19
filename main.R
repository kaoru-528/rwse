# install packages "tidyverse"
# install.packages("tidyverse")
library(tidyverse)

# Loading datainstall.packages("writexl")
dataPath = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/DS/DS1.txt")
# dsに変更
ds = read.table(dataPath)[2]
ds = as.numeric(ds$V2)

# dataPath = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/DS2.txt")
# ds2 = read.table(dataPath)[2]
# ds2 = as.numeric(ds2$V2)

# dataPath = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/DS3.txt")
# ds3 = read.table(dataPath)[2]
# ds3 = as.numeric(ds3$V2)

# dataPath = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/DS4.txt")
# ds4 = read.table(dataPath)[2]
# ds4 = as.numeric(ds4$V2)

# Load Hal wavelet estimation module
WSE_Path = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/WaveletShrinkageEestimation.R")
print("Load Hal wavelet estimation module")
# print(WSE_Path)
source(WSE_Path)

WT_Path = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/WaveletTransform.R")
print("Load Hal wavelet Transformation module")
# print(WT_Path)
source(WT_Path)

# Calculate the cumulative value of the data
# cul_ds1 = toCulData(ds1)
# print(cul_ds1)

# Calling Hal wavelet estimation based on Anscombe data transformation
# idata_hft = HFT(ds1,"ut","s")
# cul_idata_hft = toCulData(idata_hft)
# mseRes = MSE(cul_idata_hft,cul_ds1)
# print(round(mseRes,3))

# idata_hft = HFT(ds1,"ut","h")
# cul_idata_hft = toCulData(idata_hft)
# mseRes = MSE(cul_idata_hft,cul_ds1)
# print(round(mseRes,3))

#Output estimation results
# H
# Calling Hal wavelet estimation without data transformation
# time = Sys.time() %>% format("%H-%M-%S")
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     hard = H(ds, "ldt", "h", i)
#     soft = H(ds, "ldt", "s", i)
#     hard_coe= rbind("Cs",as.data.frame(t(sapply(hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(hard$Denoise_Ds, unlist))))
#     soft_coe= rbind("Cs",as.data.frame(t(sapply(soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(soft$Denoise_Ds, unlist))))
#     coe = rbind("hard",hard_coe,"soft",soft_coe)
#     file_name_edata = paste0(time,"_edata_J=",i  ,".csv")
#     file_name_coe = paste0(time,"_coeJ=",i  ,".csv")
#     directory_path = "./output/NDT_WSE/"
#     file_path_edata = paste0(directory_path, file_name_edata)
#     file_path_coe = paste0(directory_path, file_name_coe)
#     edata_h_s = list(hard = round(hard$idata, digits = 3), soft = round(soft$idata, digits = 3))
#     write.csv(edata_h_s, file_path_edata, row.names = FALSE)
#     write.csv(coe, file_path_coe, row.names = FALSE)
# }

# HAT
# Calling Hal wavelet estimation without data transformation
time = Sys.time() %>% format("%H-%M-%S")



# evaluation
# Calculate MSE
# mse = MSE(ds,edata_h[,1])
# print("MSE")
# print(mse)