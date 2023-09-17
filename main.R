# install packages "tidyverse"
# install.packages("tidyverse")
library(tidyverse)

# Load data set
dataPath = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/DS/DS1.txt")
ds = read.table(dataPath)[2]
ds = as.numeric(ds$V2)

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
    file_name_variable = paste0(time,"_var_J=",i  ,".RData")
    edata = paste0(directory_path, file_name_edata)
    coe = paste0(directory_path, file_name_coe)
    variable = paste0(directory_path, file_name_variable)
    file_path = list(edata = edata, coe = coe, variable = variable)
    return(file_path)
}


# # ===============================================================
# # H
# # Calling Hal wavelet estimation without data transformation
# # ===============================================================
# time = Sys.time() %>% format("%H-%M-%S")
# directory_path = "./output/NDT_WSE/"
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     hard = H(ds, "ldt", "h", 3)
#     soft = H(ds, "ldt", "s", 3)
#     edata = list(hard = round(hard$idata, digits = 3), soft = round(soft$idata, digits = 3))
#     hard_coe= rbind("Cs",as.data.frame(t(sapply(hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(hard$Denoise_Ds, unlist))))
#     soft_coe= rbind("Cs",as.data.frame(t(sapply(soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(soft$Denoise_Ds, unlist))))
#     coe = rbind("hard",hard_coe,"soft",soft_coe)
#     file_path = create_file(i, directory_path, time)
#     write.csv(edata, file_path$edata, row.names = FALSE)
#     write.csv(coe, file_path$coe, row.names = FALSE)
#     save(hard, soft, file = file_path$variable)
# }

# ===============================================================
# HAT_A1
# Calling Hal wavelet estimation with Anscombe
# ===============================================================
time = Sys.time() %>% format("%H-%M-%S")
directory_path = "./output/DT_Ans_WSE/A1/"
for(i in 2:log(getGroupLength(length(ds)), base = 2)){
    ut_hard = HAT(ds, "ut", "h", 1,i)
    ut_soft = HAT(ds, "ut", "s", 1,i)
    ut_edata = list(ut_hard = round(ut_hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
    ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
    ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
    ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
    file_path = create_file(i, directory_path, time)
    write.csv(ut_edata, file_path$edata, row.names = FALSE)
    write.csv(ut_coe, file_path$coe, row.names = FALSE)
    save(ut_hard, ut_soft, file = file_path$variable)
}

# # HAT_A2
# time = Sys.time() %>% format("%H-%M-%S")
# directory_path = "./output/DT_Ans_WSE/A2/"
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     ut_hard = HA2T(ds, "ut", "h", 1,i)
#     ut_soft = HA2T(ds, "ut", "s", 1,i)
#     ut_edata = list(ut_hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
#     ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
#     ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
#     ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
#     file_path = create_file(i, directory_path, time)
#     write.csv(ut_edata, file_path$edata, row.names = FALSE)
#     write.csv(ut_coe, file_path$coe, row.names = FALSE)
#     save(ut_hard, ut_soft, file = file_path$variable)
# }

# # HAT_A3
# # Calling Hal wavelet estimation without data transformation
# time = Sys.time() %>% format("%H-%M-%S")
# directory_path = "./output/DT_Ans_WSE/A3/"
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     ut_hard = HA3T(ds, "ut", "h", 1, i)
#     ut_soft = HA3T(ds, "ut", "s", 1, i)
#     ut_edata = list(ut_hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
#     ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
#     ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
#     ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
#     file_path = create_file(i, directory_path, time)
#     write.csv(ut_edata, file_path$edata, row.names = FALSE)
#     write.csv(ut_coe, file_path$coe, row.names = FALSE)
#     save(ut_hard, ut_soft, file = file_path$variable)
# }

# # ===============================================================
# # HBT_B1
# # Calling Hal wavelet estimation with Bartlett
# # ===============================================================
# time = Sys.time() %>% format("%H-%M-%S")
# directory_path = "./output/DT_Bar_WSE/B1/"
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     ut_hard = HBT(ds, "ut", "h", 1, i)
#     ut_soft = HBT(ds, "ut", "s", 1, i)
#     ut_edata = list(ut_hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
#     ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
#     ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
#     ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
#     file_path = create_file(i, directory_path, time)
#     write.csv(ut_edata, file_path$edata, row.names = FALSE)
#     write.csv(ut_coe, file_path$coe, row.names = FALSE)
#     save(ut_hard, ut_soft, file = file_path$variable)
# }


# # HBT_B2
# # Calling Hal wavelet estimation without data transformation
# time = Sys.time() %>% format("%H-%M-%S")
# directory_path = "./output/DT_Bar_WSE/B2/"
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     ut_hard = HB2T(ds, "ut", "h", 1, i)
#     ut_soft = HB2T(ds, "ut", "s", 1, i)
#     ut_edata = list(ut_hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
#     ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
#     ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
#     ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
#     file_path = create_file(i, directory_path, time)
#     write.csv(ut_edata, file_path$edata, row.names = FALSE)
#     write.csv(ut_coe, file_path$coe, row.names = FALSE)
#     save(ut_hard, ut_soft, file = file_path$variable)
# }

# # ===============================================================
# # HFitT
# # Calling Hal wavelet estimation with Fisz
# # ===============================================================
# time = Sys.time() %>% format("%H-%M-%S")
# directory_path = "./output/DT_Fit_WSE/"
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     ut_hard = HFitT(ds, "ut", "h", 1, i)
#     ut_soft = HFitT(ds, "ut", "s", 1, i)
#     ut_edata = list(ut_hard = round(ut_hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
#     ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
#     ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
#     ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
#     file_path = create_file(i, directory_path, time)
#     write.csv(ut_edata, file_path$edata, row.names = FALSE)
#     write.csv(ut_coe, file_path$coe, row.names = FALSE)
#     save(ut_hard, ut_soft, file = file_path$variable)
# }

# # ===============================================================
# # HFreT
# # Calling Hal wavelet estimation with Freeman
# # ===============================================================
# time = Sys.time() %>% format("%H-%M-%S")
# directory_path = "./output/DT_Fre_WSE/"
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     ut_hard = HFreT(ds, "ut", "h", 1, i)
#     ut_soft = HFreT(ds, "ut", "s", 1, i)
#     ut_edata = list(ut_hard = round(ut_hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
#     ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
#     ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
#     ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
#     file_path = create_file(i, directory_path, time)
#     write.csv(ut_edata, file_path$edata, row.names = FALSE)
#     write.csv(ut_coe, file_path$coe, row.names = FALSE)
#     save(ut_hard, ut_soft, file = file_path$variable)
# }



# Calculate the cumulative value of the data
# cul_ds1 = toCulData(ds1)
# print(cul_ds1)

# evaluation
# Calculate MSE
# mse = MSE(ds,edata_h[,1])
# print("MSE")
# print(mse)