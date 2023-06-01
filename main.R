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


# Calling Hal wavelet estimation based on Fisz data transformation
# idata_hft = HFT(ds1,"ut")
# Calling Hal wavelet estimation based on Anscombe data transformation
# idata_hat = HAT(ds1,"none")
# Calling the Bartlett data transformation based Hal wavelet estimation
# idata_hbt = HBT(ds1,"none")

# Calling Hal wavelet estimation without data transformation
# create file name and path
time = Sys.time() %>% format("%d-%H-%M-%S")
file_name = paste0(time, ".dat")
directory_path = "./output/NDT_WSE/"
file_path = paste0(directory_path, file_name)

file.create(file_path)

for(i in 3:log(getGroupLength(length(ds)), base = 2)){
    
    hard = round(H(ds, "ldt", "h", i), digits = 3)
    soft = round(H(ds, "ldt", "s", i), digits = 3)
    if(i == 3){
        J = sprintf("J = %d", i)
        new_data <- c(J,J)
        edata_h = data.frame(hard, soft)
        edata_h <- rbind(new_data,edata_h)
    }
    else{
        J = sprintf("J = %d", i)
        new_data <- c(J,J)
        edata_h_s = data.frame(hard, soft)
        edata_h_s <- rbind(new_data,edata_h_s)
        edata_h = data.frame(edata_h, edata_h_s)
    }
    write.table(edata_h, file_path)
}



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