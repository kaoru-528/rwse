# install packages "tidyverse"
# install.packages("tidyverse")
library(tidyverse)

# Loading data
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
print(WSE_Path)
source(WSE_Path)

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


# Calling Hal wavelet estimation based on Fisz data transformation
# idata_hft = HFT(ds1,"ut")
# Calling Hal wavelet estimation based on Anscombe data transformation
# idata_hat = HAT(ds1,"none")
# Calling the Bartlett data transformation based Hal wavelet estimation
# idata_hbt = HBT(ds1,"none")

# Calling Hal wavelet estimation without data transformation
# create file name and path
time = Sys.time() %>% format("%d-%H-%M-%S")
file_name <- paste0("NDT_",time, ".dat")
directory_path <- "./output/NDT-WSE/"
file_path <- paste0(directory_path, file_name)

file.create(file_path)
hard = round(H(ds, "ldt", "h", 16), digits = 3)
soft = round(H(ds, "ldt", "s", 16), digits = 3)
edata_h = data.frame(hard, soft)
write.table(edata_h, file_path)



#Output estimation results
# print("ds1")
# print(ds1)
# print("HFT")
# print(idata_hft)
# print("HBT")
# print(idata_hbt)
# print("HAT")
# print(idata_hat)
# print("H")
# print(edata_h)

# evaluation
# Calculate MSE
# mse = MSE(ds,edata_h[,1])
# print("MSE")
# print(mse)