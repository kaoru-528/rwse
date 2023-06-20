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

create_file = function(i, directory_path, time)
{
    file_name_edata = paste0(time,"_edata_J=",i  ,".csv")
    file_name_coe = paste0(time,"_coe_J=",i  ,".csv")
    edata = paste0(directory_path, file_name_edata)
    coe = paste0(directory_path, file_name_coe)
    file_path = list(edata = edata, coe = coe)
    return(file_path)
}

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
time = Sys.time() %>% format("%H-%M-%S")
directory_path = "./output/NDT_WSE/"
for(i in 2:log(getGroupLength(length(ds)), base = 2)){
    hard = H(ds, "ldt", "h", i)
    soft = H(ds, "ldt", "s", i)
    edata = list(hard = round(hard$idata, digits = 3), soft = round(soft$idata, digits = 3))
    hard_coe= rbind("Cs",as.data.frame(t(sapply(hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(hard$Denoise_Ds, unlist))))
    soft_coe= rbind("Cs",as.data.frame(t(sapply(soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(soft$Denoise_Ds, unlist))))
    coe = rbind("hard",hard_coe,"soft",soft_coe)
    file_path = create_file(i, directory_path, time)
    write.csv(edata, file_path$edata, row.names = FALSE)
    write.csv(coe, file_path$coe, row.names = FALSE)
}

# HAT_A1
# Calling Hal wavelet estimation without data transformation
time = Sys.time() %>% format("%H-%M-%S")
directory_path = "./output/DT_Ans_WSE/A1/"
for(i in 2:log(getGroupLength(length(ds)), base = 2)){
    ut_hard = HAT(ds, "ut", "h", 1,i)
    ut_soft = HAT(ds, "ut", "s", 1,i)
    ut_edata = list(ut_hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
    ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
    ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
    ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
    file_path = create_file(i, directory_path, time)
    write.csv(ut_edata, file_path$edata, row.names = FALSE)
    write.csv(ut_coe, file_path$coe, row.names = FALSE)
}

# HAT_A2
# Calling Hal wavelet estimation without data transformation
time = Sys.time() %>% format("%H-%M-%S")
directory_path = "./output/DT_Ans_WSE/A2/"
for(i in 2:log(getGroupLength(length(ds)), base = 2)){
    ut_hard = HA2T(ds, "ut", "h", 1,i)
    ut_soft = HA2T(ds, "ut", "s", 1,i)
    ut_edata = list(ut_hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
    ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
    ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
    ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
    file_path = create_file(i, directory_path, time)
    write.csv(ut_edata, file_path$edata, row.names = FALSE)
    write.csv(ut_coe, file_path$coe, row.names = FALSE)
}

# HAT_A3
# Calling Hal wavelet estimation without data transformation
time = Sys.time() %>% format("%H-%M-%S")
directory_path = "./output/DT_Ans_WSE/A3/"
for(i in 2:log(getGroupLength(length(ds)), base = 2)){
    ut_hard = HA3T(ds, "ut", "h", 1, i)
    ut_soft = HA3T(ds, "ut", "s", 1, i)
    ut_edata = list(ut_hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
    ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
    ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
    ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
    file_path = create_file(i, directory_path, time)
    write.csv(ut_edata, file_path$edata, row.names = FALSE)
    write.csv(ut_coe, file_path$coe, row.names = FALSE)
}

# HBT_B1
# Calling Hal wavelet estimation without data transformation
time = Sys.time() %>% format("%H-%M-%S")
directory_path = "./output/DT_Bar_WSE/B1/"
for(i in 2:log(getGroupLength(length(ds)), base = 2)){
    ut_hard = HBT(ds, "ut", "h", 1, i)
    ut_soft = HBT(ds, "ut", "s", 1, i)
    ut_edata = list(ut_hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
    ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
    ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
    ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
    file_path = create_file(i, directory_path, time)
    write.csv(ut_edata, file_path$edata, row.names = FALSE)
    write.csv(ut_coe, file_path$coe, row.names = FALSE)
}


# HBT_B2
# Calling Hal wavelet estimation without data transformation
time = Sys.time() %>% format("%H-%M-%S")
directory_path = "./output/DT_Bar_WSE/B2/"
for(i in 2:log(getGroupLength(length(ds)), base = 2)){
    ut_hard = HB2T(ds, "ut", "h", 1, i)
    ut_soft = HB2T(ds, "ut", "s", 1, i)
    ut_edata = list(ut_hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
    ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
    ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
    ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
    file_path = create_file(i, directory_path, time)
    write.csv(ut_edata, file_path$edata, row.names = FALSE)
    write.csv(ut_coe, file_path$coe, row.names = FALSE)
}

# HFitT
# Calling Hal wavelet estimation without data transformation
time = Sys.time() %>% format("%H-%M-%S")
directory_path = "./output/DT_Fit_WSE/"
for(i in 2:log(getGroupLength(length(ds)), base = 2)){
    ut_hard = HFitT(ds, "ut", "h", 1, i)
    ut_soft = HFitT(ds, "ut", "s", 1, i)
    ut_edata = list(ut_hard = round(ut_hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
    ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
    ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
    ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
    file_path = create_file(i, directory_path, time)
    write.csv(ut_edata, file_path$edata, row.names = FALSE)
    write.csv(ut_coe, file_path$coe, row.names = FALSE)
}

# HFreT
# Calling Hal wavelet estimation without data transformation
time = Sys.time() %>% format("%H-%M-%S")
directory_path = "./output/DT_Fre_WSE/"
for(i in 2:log(getGroupLength(length(ds)), base = 2)){
    ut_hard = HFreT(ds, "ut", "h", 1, i)
    ut_soft = HFreT(ds, "ut", "s", 1, i)
    ut_edata = list(ut_hard = round(ut_hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
    ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
    ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
    ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
    file_path = create_file(i, directory_path, time)
    write.csv(ut_edata, file_path$edata, row.names = FALSE)
    write.csv(ut_coe, file_path$coe, row.names = FALSE)
}



# evaluation
# Calculate MSE
# mse = MSE(ds,edata_h[,1])
# print("MSE")
# print(mse)