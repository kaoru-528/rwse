# Load wavelet conversion module
WaveletTransform_Path = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/WaveletTransform.R")
print("Load wavelet conversion module")
print(WaveletTransform_Path)
source(WaveletTransform_Path)
# Load data conversion module
DT_Path = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/DataTransform.R")
print("Load data conversion module")
print(DT_Path)
source(DT_Path)
# Load Threshold Module
Threshold_Path = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/Threshold.R")
print("Load Threshold Module")
print(Threshold_Path)
source(Threshold_Path)
# Load Evaluation Module
Evaluation_Path = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/EvaluationIndex.R")
print("Load Evaluation Module")
print(Evaluation_Path)
source(Evaluation_Path)

# Hal wavelet estimation without data transformation
H = function(data,thresholdName,thresholdMode, index)
{
  groupLength = 2^index
  dataLength = length(data)
  

  if(groupLength >= getGroupLength(dataLength)){
    groupLength = getGroupLength(dataLength)
  }
  
  # Cut the original data into a number of sub-data of length 2^J
  groups = getGroups(data,groupLength)
  
  # Calculate c
  #print("Start calculating scale factor")
  Cs = getScalingCoefficientsFromGroups(groups)
  # df = as.data.frame(t(sapply(Cs, unlist)))
  # write.csv(round(df,digits = 3), "./output/NDT_WSE/ScallingCoefficients.csv", row.names = FALSE)
  # print("Cs[[1]]")
  # print(Cs[[1]])
  
  #Calculate d
  #print("Start calculating wavelet coefficients")
  Ds = getWaveletCoefficientsFromGroups(Cs)
  # dw = as.data.frame(t(sapply(Ds, unlist)))
  # write.csv(round(dw, digits = 3), "./output/NDT_WSE/WaveletCoefficients.csv", row.names = FALSE)
  # print("Ds[[1]]")
  # print(Ds[[1]])
  
  # Noise reduction of wavelet coefficients using thresholdMode noise reduction rule, thresholdName threshold
  #print("Start calculating the noise reduction wavelet coefficients")
  Denoise_Ds = ThresholdForGroups(Ds,thresholdMode,thresholdName)
  
  # No noise reduction (for testing)
  if(thresholdName == "none")
  {
    Denoise_Ds = Ds
  }
  # dn = as.data.frame(t(sapply(Denoise_Ds, unlist)))
  # write.csv(round(dn,digits = 3), "./output/NDT_WSE/Dnoise_Ds.csv", row.names = FALSE)
  
  # Perform inverse wavelet conversion
  #print("Start restoring data")
  i_groups = inverseHaarWaveletTransformForGroups(Cs,Denoise_Ds)
  #print("i_groups[[1]]")
  #print(i_groups[[1]])
  
  # Perform moving average
  #print("Perform moving average")
  idata = movingAverage(i_groups,dataLength)

  idata = list(idata=idata, Cs=Cs,Ds=Ds, Denoise_Ds=Denoise_Ds)
  
  # Return Results
  return(idata)
}

# Anscombe Transformation of Hal Wavelet Estimation
HAT = function(data,thresholdName,thresholdMode,var=1, index)
{
  groupLength = 2^index
  # Get data length
  dataLength = length(data)
  #print("dataLength")
  #print(dataLength)
  
  # Get subdata length
  if(groupLength >= getGroupLength(dataLength)){
    # Get subdata length
    groupLength = getGroupLength(dataLength)
    #print("groupLength")
    #print(groupLength)
  }
  
  # Cut the original data into a number of sub-data of length 2^J
  groups = getGroups(data,groupLength)
  #print("groups[[1]]")
  #print(groups[[1]])
  
  #Transform sub-data to Gaussian data by Anscombe
  a_groups = AnscombeTransformFromGroups(groups,var)
  #print("Anscombe : groups[[1]]")
  #print(groups[[1]])
  
  # Calculate c
  #print("Start calculating scale factor")
  Cs = getScalingCoefficientsFromGroups(a_groups)
  #print("Cs[[1]]")
  #print(Cs[[1]])
  
  #Calculate d
  #print("Start calculating wavelet coefficients")
  Ds = getWaveletCoefficientsFromGroups(Cs)
  #print("Ds[[1]]")
  #print(Ds[[1]])
  
  # Noise reduction of wavelet coefficients using thresholdMode noise reduction rule, thresholdName threshold
  #print("Start calculating the noise reduction wavelet coefficients")
  Denoise_Ds = ThresholdForGroups(Ds,thresholdMode,thresholdName)
  
  # No noise reduction (for testing)
  if(thresholdName == "none")
  {
    Denoise_Ds = Ds
  }
  
  # Perform inverse wavelet conversion
  #print("Start restoring data")
  i_groups = inverseHaarWaveletTransformForGroups(Cs,Denoise_Ds)
  #print("i_groups[[1]]")
  #print(i_groups[[1]])
  
  # Perform moving average
  #print("Perform moving average")
  a_idata = movingAverage(i_groups,dataLength)
  
  # Perform inverse Anscombe data conversion
  idata = inverseAnscombeTransformFromGroup(a_idata,var);
  
  idata = list(idata=idata, Cs=Cs,Ds=Ds, Denoise_Ds=Denoise_Ds)
  # Return Results
  return(idata)
}

# Anscombe Transformation 2 of Hal Wavelet Estimation
HA2T = function(data,thresholdName,thresholdMode,var=1,index)
{
  groupLength = 2^index
  # Get data length
  dataLength = length(data)
  #print("dataLength")
  #print(dataLength)
  
  # Get subdata length
  if(groupLength >= getGroupLength(dataLength)){
    groupLength = getGroupLength(dataLength)
    #print("groupLength")
    #print(groupLength)
  }
  
  # Cut the original data into a number of sub-data of length 2^J
  groups = getGroups(data,groupLength)
  #print("groups[[1]]")
  #print(groups[[1]])
  
  #Transform sub-data to Gaussian data by Anscombe
  a_groups = AnscombeTransformFromGroups(groups,var)
  #print("Anscombe : groups[[1]]")
  #print(groups[[1]])
  
  # Calculate c
  #print("Start calculating scale factor")
  Cs = getScalingCoefficientsFromGroups(a_groups)
  #print("Cs[[1]]")
  #print(Cs[[1]])
  
  #Calculate d
  #print("Start calculating wavelet coefficients")
  Ds = getWaveletCoefficientsFromGroups(Cs)
  #print("Ds[[1]]")
  #print(Ds[[1]])
  
  # Noise reduction of wavelet coefficients using thresholdMode noise reduction rule, thresholdName threshold
  #print("Start calculating the noise reduction wavelet coefficients")
  Denoise_Ds = ThresholdForGroups(Ds,thresholdMode,thresholdName)
  
  # No noise reduction (for testing)
  if(thresholdName == "none")
  {
          Denoise_Ds = Ds
  }
  
  # Perform inverse wavelet conversion
  #print("Start restoring data")
  i_groups = inverseHaarWaveletTransformForGroups(Cs,Denoise_Ds)
  #print("i_groups[[1]]")
  #print(i_groups[[1]])
  
  # Perform moving average
  #print("Perform moving average")
  a_idata = movingAverage(i_groups,dataLength)
  
  # Perform inverse Anscombe 2 data conversion
  idata = inverseAnscombeTransform2FromGroup(a_idata,var);
  
  idata = list(idata=idata, Cs=Cs,Ds=Ds, Denoise_Ds=Denoise_Ds)
  # Return Results
  return(idata)
}

# Anscombe Transformation 3 of Hal Wavelet Estimation
HA3T = function(data,thresholdName,thresholdMode,var=1, index)
{
  groupLength = 2^index
  # Get data length
  dataLength = length(data)
  #print("dataLength")
  #print(dataLength)
  
  # Get subdata length
  if(groupLength >= getGroupLength(dataLength)){
    groupLength = getGroupLength(dataLength)
    #print("groupLength")
    #print(groupLength)
  }
  
  # Cut the original data into a number of sub-data of length 2^J
  groups = getGroups(data,groupLength)
  #print("groups[[1]]")
  #print(groups[[1]])
  
  #Transform sub-data to Gaussian data by Anscombe
  a_groups = AnscombeTransformFromGroups(groups,var)
  #print("Anscombe : groups[[1]]")
  #print(groups[[1]])
  
  # Calculate c
  #print("Start calculating scale factor")
  Cs = getScalingCoefficientsFromGroups(a_groups)
  #print("Cs[[1]]")
  #print(Cs[[1]])
  
  #Calculate d
  #print("Start calculating wavelet coefficients")
  Ds = getWaveletCoefficientsFromGroups(Cs)
  #print("Ds[[1]]")
  #print(Ds[[1]])
  
  # Noise reduction of wavelet coefficients using thresholdMode noise reduction rule, thresholdName threshold
  #print("Start calculating the noise reduction wavelet coefficients")
  Denoise_Ds = ThresholdForGroups(Ds,thresholdMode,thresholdName)
  
  # No noise reduction (for testing)
  if(thresholdName == "none")
  {
          Denoise_Ds = Ds
  }
  
  # Perform inverse wavelet conversion
  #print("Start restoring data")
  i_groups = inverseHaarWaveletTransformForGroups(Cs,Denoise_Ds)
  #print("i_groups[[1]]")
  #print(i_groups[[1]])
  
  # Perform moving average
  #print("Perform moving average")
  a_idata = movingAverage(i_groups,dataLength)
  
  # Perform inverse Anscombe 3 data conversion
  idata = inverseAnscombeTransform3FromGroup(a_idata,var);
  
  idata = list(idata=idata, Cs=Cs,Ds=Ds, Denoise_Ds=Denoise_Ds)
  # Return Results
  return(idata)
}

# Bartlett Transformation of Hal Wavelet Estimation
HBT = function(data,thresholdName,thresholdMode,var=1, index)
{
groupLength = 2^index
  # Get data length
  dataLength = length(data)
  #print("dataLength")
  #print(dataLength)
  
  # Get subdata length
  if(groupLength >= getGroupLength(dataLength)){
    groupLength = getGroupLength(dataLength)
    #print("groupLength")
    #print(groupLength)
  }

# Cut the original data into a number of sub-data of length 2^J
groups = getGroups(data,groupLength)
#print("groups[[1]]")
#print(groups[[1]])

#Convert sub-data into Gaussian data by Bartlett transformation
b_groups = BartlettTransformFromGroups(groups,var)
#print("Bartlett : groups[[1]]")
#print(groups[[1]])

# Calculate c
#print("Start calculating scale factor")
Cs = getScalingCoefficientsFromGroups(b_groups)
#print("Cs[[1]]")
#print(Cs[[1]])

#Calculate d
#print("Start calculating wavelet coefficients")
Ds = getWaveletCoefficientsFromGroups(Cs)
#print("Ds[[1]]")
#print(Ds[[1]])

# Noise reduction of wavelet coefficients using thresholdMode noise reduction rule, thresholdName threshold
#print("Start calculating the noise reduction wavelet coefficients")
Denoise_Ds = ThresholdForGroups(Ds,thresholdMode,thresholdName)

# No noise reduction (for testing)
if(thresholdName == "none")
{
Denoise_Ds = Ds
}

# Perform inverse wavelet conversion
#print("Start restoring data")
i_groups = inverseHaarWaveletTransformForGroups(Cs,Denoise_Ds)
#print("i_groups[[1]]")
#print(i_groups[[1]])

# Perform moving average
#print("Perform moving average")
b_idata = movingAverage(i_groups,dataLength)

# Perform inverse Bartlett data conversion
idata = inverseBartlettTransformFromGroup(b_idata,var);

idata = list(idata=idata, Cs=Cs,Ds=Ds, Denoise_Ds=Denoise_Ds)

# Return Results
return(idata)
}
# Freeman Transformation of Hal Wavelet Estimation
HB2T = function(data, thresholdName, thresholdMode, var=1, index)
{
  groupLength = 2^index
  # Get data length
  dataLength = length(data)
  #print("dataLength")
  #print(dataLength)
  
  # Get subdata length
  if(groupLength >= getGroupLength(dataLength)){
    groupLength = getGroupLength(dataLength)
    #print("groupLength")
    #print(groupLength)
  }
  
  # Cut the original data into a number of sub-data of length 2^J
  groups = getGroups(data,groupLength)
  #print("groups[[1]]")
  #print(groups[[1]])
  
  #Convert sub-data into Gaussian data by Bartlett transformation 2
  b2_groups = BartlettTransform2FromGroups(groups,var)
  #print("Bartlett2 : groups[[1]]")
  #print(groups[[1]])
  
  # Calculate c
  #print("Start calculating scale factor")
  Cs = getScalingCoefficientsFromGroups(b2_groups)
  #print("Cs[[1]]")
  #print(Cs[[1]])
  
  #Calculate d
  #print("Start calculating wavelet coefficients")
  Ds = getWaveletCoefficientsFromGroups(Cs)
  #print("Ds[[1]]")
  #print(Ds[[1]])
  
  # Noise reduction of wavelet coefficients using thresholdMode noise reduction rule, thresholdName threshold
  #print("Start calculating the noise reduction wavelet coefficients")
  Denoise_Ds = ThresholdForGroups(Ds,thresholdMode,thresholdName)
  
  # No noise reduction (for testing)
  if(thresholdName == "none")
  {
          Denoise_Ds = Ds
  }
  
  # Perform inverse wavelet conversion
  #print("Start restoring data")
  i_groups = inverseHaarWaveletTransformForGroups(Cs,Denoise_Ds)
  #print("i_groups[[1]]")
  #print(i_groups[[1]])
  
  # Perform moving average
  #print("Perform moving average")
  b2_idata = movingAverage(i_groups,dataLength)
  
  # Perform inverse Bartlett 2 data conversion
  idata = inverseBartlettTransform2FromGroup(b2_idata,var);
  
  idata = list(idata=idata, Cs=Cs,Ds=Ds, Denoise_Ds=Denoise_Ds)
  # Return Results
  return(idata)
}

# Fisz Transformation of Hal Wavelet Estimation
HFitT = function(data,thresholdName,thresholdMode, var=1 , index)
{
  groupLength = 2^index
  # Get data length
  dataLength = length(data)
  #print("dataLength")
  #print(dataLength)
  
  # Get subdata length
  if(groupLength >= getGroupLength(dataLength)){
    groupLength = getGroupLength(dataLength)
    #print("groupLength")
    #print(groupLength)
  }
  # Cut the original data into a number of sub-data of length 2^J
  groups = getGroups(data,groupLength)
  #print("groups[[1]]")
  #print(groups[[1]])
  
  # Transform the sub-data into Gaussian data by Fisz transformation
  Cs1  = getScalingCoefficientsFromGroups(groups)
  Ds1  = getWaveletCoefficientsFromGroups(Cs1)
  Fs1  = FiszTransformFromGroups(Cs1,Ds1,var)
  f_groups = inverseHaarWaveletTransformForGroups(Cs1,Fs1)
  #print(f_groups)
  
  # Calculate c
  #print("Start calculating scale factor")
  Cs2  = getScalingCoefficientsFromGroups(f_groups)
  #Calculate d
  #print("Start calculating wavelet coefficients")
  Ds2  = getWaveletCoefficientsFromGroups(Cs2)
  
  # Noise reduction of wavelet coefficients using thresholdMode noise reduction rule, thresholdName threshold
  #print("Start calculating the noise reduction wavelet coefficients")
  Denoise_Ds2 = ThresholdForGroups(Ds2,thresholdMode,thresholdName)
  # No noise reduction (for testing)
  if(thresholdName == "none")
  {
    Denoise_Ds2 = Ds2
  }
    
  # Perform inverse Fisz data conversion
  f_igroups = inverseHaarWaveletTransformForGroups(Cs2,Denoise_Ds2)
  Cs3  = getScalingCoefficientsFromGroups(f_igroups)
  Fs2  = getWaveletCoefficientsFromGroups(Cs3)
  CDs  = inverseFiszTransformFromGroups(Cs3,Fs2,var)
  Cs4 = CDs[[1]]
  Ds3 = CDs[[2]]
  
  # Perform inverse wavelet conversion
  #print("Start restoring data")
  igroups = inverseHaarWaveletTransformForGroups(Cs4,Ds3)
  
  # Perform moving average
  #print("Perform moving average")
  idata= movingAverage(igroups,dataLength)

  idata = list(idata=idata, Cs=Cs4,Ds=Ds3, Denoise_Ds=Denoise_Ds2)
  # Return Results
  return(idata)
}


# Freeman Transformation of Hal Wavelet Estimation
HFreT = function(data,thresholdName="ut",thresholdMode="s",var=1, index)
{
  groupLength = 2^index
  # Get data length
  dataLength = length(data)
  #print("dataLength")
  #print(dataLength)
  
  # Get subdata length
  if(groupLength >= getGroupLength(dataLength)){
    groupLength = getGroupLength(dataLength)
    #print("groupLength")
    #print(groupLength)
  }
  
  # Cut the original data into a number of sub-data of length 2^J
  groups = getGroups(data,groupLength)
  #print("groups[[1]]")
  #print(groups[[1]])
  
  #Convert sub-data into Gaussian data by Freeman transformation
  f_groups = FreemanTransformFromGroups(groups,var)
  #print("Freeman : groups[[1]]")
  #print(groups[[1]])
  
  # Calculate c
  #print("Start calculating scale factor")
  Cs = getScalingCoefficientsFromGroups(f_groups)
  #print("Cs[[1]]")
  #print(Cs[[1]])
  
  #Calculate d
  #print("Start calculating wavelet coefficients")
  Ds = getWaveletCoefficientsFromGroups(Cs)
  #print("Ds[[1]]")
  #print(Ds[[1]])
  
  # Noise reduction of wavelet coefficients using thresholdMode noise reduction rule, thresholdName threshold
  #print("Start calculating the noise reduction wavelet coefficients")
  Denoise_Ds = ThresholdForGroups(Ds,thresholdMode,thresholdName)
  
  # No noise reduction (for testing)
  if(thresholdName == "none")
  {
          Denoise_Ds = Ds
  }
  
  # Perform inverse wavelet conversion
  #print("Start restoring data")
  i_groups = inverseHaarWaveletTransformForGroups(Cs,Denoise_Ds)
  #print("i_groups[[1]]")
  #print(i_groups[[1]])
  
  # Perform moving average
  #print("Perform moving average")
  f_idata = movingAverage(i_groups,dataLength)
  
  # Perform inverse Freeman data conversion
  idata = inverseFreemanTransformFromGroup(f_idata,var);
  
  idata = list(idata=idata, Cs=Cs,Ds=Ds, Denoise_Ds=Denoise_Ds)
  # Return Results
  return(idata)
}

# 累積関数
toCulData = function(data)
{
  culData = c()
  oldValue = 0
  index = 1
  while(index <= length(data))
  {
    nowValue = data[[index]] + oldValue
    culData = append(culData,nowValue)
    oldValue = nowValue
    index = index + 1
  }
  return(culData)
}