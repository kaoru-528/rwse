# Loading data
dataPath = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/DS/DS1.txt")
# dsに変更
ds1 = read.table(dataPath)[2]
ds1 = as.numeric(ds1$V2)

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
hard = round(H(ds1, "ldt", "h"), digits = 3)
soft = round(H(ds1, "ldt", "s"),digits = 3)
edata_h <- data.frame(hard, soft)
write.table(edata_h, "./output/h.dat")

# Calling MSE
mse = MSE(ds1,idata_h)

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


print("MSE")
print(mse)