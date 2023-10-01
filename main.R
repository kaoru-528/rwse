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

# # ===============================================================
# # H
# # Calling Hal wavelet estimation without data transformation
# # ===============================================================
# time = Sys.time() %>% format("%H-%M-%S")
# directory_path = "./output/NDT_WSE/"
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     hard = wse(ds, "noen", "ldt", "h", 1, i)
#     soft = wse(ds, "noen", "ldt", "s", 1, i)
#     edata = list(hard = round(hard$idata, digits = 3), soft = round(soft$idata, digits = 3))
#     hard_coe= rbind("Cs",as.data.frame(t(sapply(hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(hard$Denoise_Ds, unlist))))
#     soft_coe= rbind("Cs",as.data.frame(t(sapply(soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(soft$Denoise_Ds, unlist))))
#     coe = rbind("hard",hard_coe,"soft",soft_coe)
#     file_path = create_file(i, directory_path, time)
#     write.csv(edata, file_path$edata, row.names = FALSE)
#     write.csv(coe, file_path$coe, row.names = FALSE)
#     save(hard, soft, file = file_path$variable)
# }

# # ===============================================================
# # HAT_A1
# # Calling Hal wavelet estimation with Anscombe
# # ===============================================================
# time = Sys.time() %>% format("%H-%M-%S")
# directory_path = "./output/DT_Ans_WSE/A1/"
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     ut_hard = wse(ds, "A1", "ut", "h", 1, i)
#     ut_soft = wse(ds, "A1", "ut", "s", 1, i)
#     ut_edata = list(hard = round(ut_hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
#     ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
#     ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
#     ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
#     file_path = create_file(i, directory_path, time)
#     write.csv(ut_edata, file_path$edata, row.names = FALSE)
#     write.csv(ut_coe, file_path$coe, row.names = FALSE)
#     save(ut_hard, ut_soft, file = file_path$variable)
# }

# # HAT_A2
# time = Sys.time() %>% format("%H-%M-%S")
# directory_path = "./output/DT_Ans_WSE/A2/"
# for(i in 2:log(getGroupLength(length(ds)), base = 2)){
#     ut_hard = wse(ds, "A2", "ut", "h", 1,i)
#     ut_soft = wse(ds, "A2", "ut", "s", 1,i)
#     ut_edata = list(hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
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
#     ut_hard = wse(ds, "A2", "ut", "h", 1, i)
#     ut_soft = wse(ds, "A2", "ut", "s", 1, i)
#     ut_edata = list(hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
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
#     ut_hard = wse(ds, "B1", "ut", "h", 1, i)
#     ut_soft = wse(ds, "B1", "ut", "s", 1, i)
#     ut_edata = list(hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
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
#     ut_hard = wse(ds, "B2", "ut", "h", 1, i)
#     ut_soft = wse(ds, "B2", "ut", "s", 1, i)
#     ut_edata = list(hard = round(hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
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
#     ut_hard = wse(ds, "Fi", "ut", "h", 1, i)
#     ut_soft = wse(ds, "Fi", "ut", "s", 1, i)
#     ut_edata = list(hard = round(ut_hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
#     ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
#     ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
#     ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
#     file_path = create_file(i, directory_path, time)
#     write.csv(ut_edata, file_path$edata, row.names = FALSE)
#     write.csv(ut_coe, file_path$coe, row.names = FALSE)
#     save(ut_hard, ut_soft, file = file_path$variable)
# }

# ===============================================================
# HFreT
# Calling Hal wavelet estimation with Freeman
# ===============================================================
time = Sys.time() %>% format("%H-%M-%S")
directory_path = "./output/DT_Fre_WSE/"
for(i in 2:log(getGroupLength(length(ds)), base = 2)){
    ut_hard = wse(ds, "Fr", "ut", "h", 1, i)
    ut_soft = wse(ds, "Fr", "ut", "s", 1, i)
    ut_edata = list(hard = round(ut_hard$idata, digits = 3), soft = round(ut_soft$idata, digits = 3))
    ut_hard_coe= rbind("Cs",as.data.frame(t(sapply(ut_hard$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_hard$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_hard$Denoise_Ds, unlist))))
    ut_soft_coe= rbind("Cs",as.data.frame(t(sapply(ut_soft$Cs, unlist))),"Ds",as.data.frame(t(sapply(ut_soft$Ds, unlist))),"Denoise_Ds",as.data.frame(t(sapply(ut_soft$Denoise_Ds, unlist))))
    ut_coe = rbind("hard",ut_hard_coe,"soft",ut_soft_coe)
    file_path = create_file(i, directory_path, time)
    write.csv(ut_edata, file_path$edata, row.names = FALSE)
    write.csv(ut_coe, file_path$coe, row.names = FALSE)
    save(ut_hard, ut_soft, file = file_path$variable)
}