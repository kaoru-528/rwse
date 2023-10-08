ThresholdForGroups = function(Ds,mode,ThresholdName)
{
	groupLength = length(Ds)
	lists = list()
	i = 1
	while(i <= groupLength)
	{
		list_s = ThresholdForGroup(Ds[[i]],mode,ThresholdName)
		lists = append(lists, list(list_s))
		i = i + 1
	}
	return(lists)
}

#Apply the soft or hard thresholding method of ThresholdName to a set of wavelet coefficients
ThresholdForGroup = function(GroupWaveletCoefficients,mode,ThresholdName)
{
    dataLength = length(GroupWaveletCoefficients[[1]])
    t = 1000
    if(ThresholdName == 'ut')
    {
        t = getUniversalThreshold(dataLength)
    }
    if(ThresholdName == 'lht')
    {
        #t = getMyThreshold(GroupWaveletCoefficients[[1]],mode)
    }

	lists = list()
    lists = append(lists,list(GroupWaveletCoefficients[[1]]))
    i = 2
    groupLength = length(GroupWaveletCoefficients)

    if(ThresholdName == 'ldt' || ThresholdName == 'lut')
    {
        C = getScalingCoefficientsFromGroup(GroupWaveletCoefficients[[1]])
    }
    if(ThresholdName == 'lht')
    {
        #print(t)
        #pass
    }
    while(i <= groupLength)
    {
        if(ThresholdName == 'ldt')
        {
            #print("step 1.5")
            tempList = ldtThreshold(GroupWaveletCoefficients[[i]],mode,i,dataLength,C)
            #print("step 2")
        }
        else
        {

            if(ThresholdName == 'lut')
            {
                ut_dataLength = length(C[[i]])
                t = getUniversalThreshold(ut_dataLength)
            }

            if(ThresholdName == 'lht')
            {
                #print(GroupWaveletCoefficients[i])
                #pass
            }
            tempList = ThresholdForOneLevel(GroupWaveletCoefficients[[i]],mode,t)
            if(ThresholdName == 'lht')
            {
                #print(list)
                #pass
            }
        }

        lists = append(lists,list(tempList))
        i = i + 1
    }

    return(lists)
}

# ---------------------------------
# Get ut, lut threshold
# ut:Universal Threshold
# lut:Level-universal-Threshold
# lut is applied to the length of j-th
# level empirical wavelet coefficients.
# ---------------------------------
getUniversalThreshold = function(groupLength)
{
	a = log(groupLength)
	b = 2*a
	c = b**0.5
	return(c)
}
# ---------------------------------
# Get ldt threshold
# ldt:Level-dependent-Threshold
# ---------------------------------
getLevelDependentThreshold = function(J,now_level,mean)
{
	a = 2 ** (-1 * 0.5 * (J - now_level + 2))
	log2j = log(2 ** now_level)
	b = 2 * log2j
	c = (4 * log2j) ** 2
	d = 8 * mean * log2j * (2 ** (J - now_level))
	t = a * (b + ((c + d) ** 0.5))
	return(t)
}

# Thresholding the wavelet coefficients of a layer at a threshold value of t
ThresholdForOneLevel = function(WaveletCoefficients,mode,t)
{
	coefficientsLength = length(WaveletCoefficients)
	tempList = c()
	i = 1
	while(i <= coefficientsLength)
	{
		a = Threshold(WaveletCoefficients[i],t,mode)
		tempList = append(tempList,a)
		i = i + 1
	}
	return(tempList)
}

#Calculating ldt and thresholding the data
ldtThreshold = function(data,mode,loop_level,dataLength,C)
{
	#Highest Resolution
	J = getHighestResolutionLevel(dataLength)
	#Current Resolution
	#j = J - loop_level + 1
	#Thresholding the data one by one
	i = 1
	tempList = c()
	#print(loop_level)
	#print(data)
	while (i <= length(data))
	{
		#Get ldt threshold
		# mean = 2.145161
		mean = C[[loop_level]][i]
		#print(mean)
		t = getLevelDependentThreshold(J,loop_level,mean)
		denoise_data = Threshold(data[[i]],t,mode)
		tempList = append(tempList,denoise_data)
		i = i + 1
	}
	#print(list)
	return(tempList)
}

#Thresholding of the value coe according to the threshold r
Threshold = function(coe,r,mode)
{
	if(mode == 'h'){
		if(abs(coe) <= r){
	    return(0)
		}
		else{
	    return(coe)
		}
	}
	else{
		if(abs(coe) <= r){
	    return(0)
		}
		else{
			if(coe > 0){
	        	return(coe - r)
	    	}
	    	else{
	        	return(coe + r)
	    	}
		}
	}
}