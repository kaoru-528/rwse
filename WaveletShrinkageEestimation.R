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
wse = function(data, dt, thresholdName, thresholdMode, var, index, tt)
{
  groupLength = 2^index
  # Get data length
  dataLength = length(data)
  if(groupLength >= getGroupLength(dataLength)){
    # Get subdata length
    groupLength = getGroupLength(dataLength)
  }

  # Cut the original data into a number of sub-data of length 2^J
  groups = getGroups(data,groupLength)


  if(dt == "Fi"){
    # Transform the sub-data into Gaussian data by Fisz transformation
    Cs1  = getScalingCoefficientsFromGroups(groups)
    Ds1  = getWaveletCoefficientsFromGroups(Cs1)
    Fi1  = FiszTransformFromGroups(Cs1,Ds1,var)
    f_groups = inverseHaarWaveletTransformForGroups(Cs1,Fi1)

    f_groups = lapply(f_groups, function(x) x/groupLength**0.5)
    
    # Calculate c
    #print("Start calculating scale factor")
    Cs2  = getScalingCoefficientsFromGroups(f_groups)
    #Calculate d
    #print("Start calculating wavelet coefficients")
    Ds2  = getWaveletCoefficientsFromGroups(Cs2)
    
    # Noise reduction of wavelet coefficients using thresholdMode noise reduction rule, thresholdName threshold
    #print("Start calculating the noise reduction wavelet coefficients")
    Denoise_Ds2 = ThresholdForGroups(Ds2,thresholdMode,thresholdName)
      
    # Perform inverse Fisz data conversion
    f_igroups = inverseHaarWaveletTransformForGroups(Cs2,Denoise_Ds2)
    Cs3  = getScalingCoefficientsFromGroups(f_igroups)
    Fs2  = getWaveletCoefficientsFromGroups(Cs3)
    CDs  = inverseFiszTransformFromGroups(Cs3,Fs2,var)
    Cs4 = CDs[[1]]
    Ds3 = CDs[[2]]
    
    # Perform inverse wavelet conversion
    #print("Start restoring data")
    thresholded_groups = inverseHaarWaveletTransformForGroups(Cs4,Ds3)
    thresholded_groups = lapply(thresholded_groups, function(x) x*groupLength**0.5)
    
    # Perform moving average
    #print("Perform moving average")
    thresholded_data= movingAverage(thresholded_groups,dataLength)

    thresholded_data = list(idata=thresholded_data, Cs=Cs4,Ds=Ds3, Denoise_Ds=Denoise_Ds2)
  }
  else{
    if(dt == "A1" || dt == "A2"|| dt == "A3"){
      #Transform sub-data to Gaussian data by Anscombe
      groups = AnscombeTransformFromGroups(groups,var)
    }
    else if(dt == "B1"){
      #Transform sub-data to Gaussian data by Bartlet
      groups = BartlettTransformFromGroups(groups,var)
    }
    else if(dt == "B2"){
      #Transform sub-data to Gaussian data by Bartlet
      groups = BartlettTransform2FromGroups(groups,var)
    }
    else if (dt == "Fr") {
       groups = FreemanTransformFromGroups(groups,var)
    }
    else{
      groups = groups
    }

    groups = lapply(groups, function(x) x/(groupLength**0.5))

    # Calculate c
    Cs = getScalingCoefficientsFromGroups(groups)
    
    #Calculate d
    Ds = getWaveletCoefficientsFromGroups(Cs)
  

    # Noise reduction of wavelet coefficients using thresholdMode noise reduction rule, thresholdName threshold
    #print("Start calculating the noise reduction wavelet coefficients")

    Denoise_Ds = ThresholdForGroups(Ds,thresholdMode,thresholdName, dt, groups, tt)
    
    # Perform inverse wavelet conversion
    thresholded_groups = inverseHaarWaveletTransformForGroups(Cs,Denoise_Ds)
    thresholded_groups = lapply(thresholded_groups, function(x) x*groupLength**0.5)

    # Perform moving average
    thresholded_data = movingAverage(thresholded_groups,dataLength)


    if(dt == "A1"){
    # Perform inverse Anscombe data conversion
    thresholded_data = inverseAnscombeTransformFromGroup(thresholded_data,var);
    }
    else if(dt == "A2"){
      # Perform inverse Anscombe data conversion
      thresholded_data = inverseAnscombeTransform2FromGroup(thresholded_data,var);
    }
    else if(dt == "A3"){
      # Perform inverse Anscombe data conversion
      thresholded_data = inverseAnscombeTransform3FromGroup(thresholded_data,var);
    }
    else if(dt == "B1"){
      # Perform inverse Anscombe data conversion
      thresholded_data = inverseBartlettTransformFromGroup(thresholded_data,var);
    }
    else if(dt == "B2"){
      # Perform inverse Anscombe data conversion
      thresholded_data = inverseBartlettTransform2FromGroup(thresholded_data,var);
    }
    else if (dt == "Fr") {
      thresholded_data = inverseFreemanTransformFromGroup(thresholded_data,var)
    }
    else{
      thresholded_data = thresholded_data
    }
    
    thresholded_data = list(idata=thresholded_data, Cs=Cs,Ds=Ds, Denoise_Ds=Denoise_Ds)
  }

  # Return Results
  return(thresholded_data)
}


# cumulative function
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

# creating file format
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