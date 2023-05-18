# Loading data
dataPath = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/DS4.txt")
ds4 = read.table(dataPath)[2]
ds4 = as.numeric(ds4$V2)

# Load Hal wavelet estimation module
WSE_Path = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/WaveletShrinkageEestimation.R")
print("载入哈尔小波估计模块")
print(WSE_Path)
source(WSE_Path)

# Calculate the cumulative value of the data
cul_ds4 = toCulData(ds4)
print(cul_ds4)

# Calling Hal wavelet estimation based on Anscombe data transformation
# idata_hft = HFT(ds4,"ut","s")
# cul_idata_hft = toCulData(idata_hft)
# mseRes = MSE(cul_idata_hft,cul_ds4)
# print(round(mseRes,3))

# idata_hft = HFT(ds4,"ut","h")
# cul_idata_hft = toCulData(idata_hft)
# mseRes = MSE(cul_idata_hft,cul_ds4)
# print(round(mseRes,3))


# Calling Hal wavelet estimation based on Fisz data transformation
# idata_hft = HFT(ds4,"ut")
# Calling Hal wavelet estimation based on Anscombe data transformation
# idata_hat = HAT(ds4,"none")
# Calling the Bartlett data transformation based Hal wavelet estimation
# idata_hbt = HBT(ds4,"none")
# Calling Hal wavelet estimation without data transformation
idata_h = H(ds4,"lt")

#Output estimation results
print("ds4")
print(ds4)
# print("HFT")
# print(idata_hft)
# print("HBT")
# print(idata_hbt)
# print("HAT")
# print(idata_hat)
print("H")
print(idata_h)
