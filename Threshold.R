ThresholdForGroups = function(Ds,mode,ThresholdName,dt,groups ,tt)
{
	groupLength = length(Ds)
	lists = list()
	i = 1
	while(i <= groupLength)
	{
		list_s = ThresholdForGroup(Ds[[i]],mode,ThresholdName,dt,groups, tt, i)
		lists = append(lists, list(list_s))
		i = i + 1
	}
	return(lists)
}

#Apply the soft or hard thresholding method of ThresholdName to a set of wavelet coefficients
ThresholdForGroup = function(GroupWaveletCoefficients,mode,ThresholdName,dt,groups, tt,j)
{
	if(ThresholdName == 'ut'|| ThresholdName == 'ldt' || ThresholdName == 'lut'|| ThresholdName == 'none'){
		dataLength = length(GroupWaveletCoefficients[[1]])
		t = 1000
		j = 1
		if(ThresholdName == 'ut')
		{
			t = getUniversalThreshold(dataLength)
		}
		else if (ThresholdName == 'none') {
		   t = tt
		   print(t)
		}
		lists = list()
		lists = append(lists,list(GroupWaveletCoefficients[[1]]))
		i = 2
		groupLength = length(GroupWaveletCoefficients)

		if(ThresholdName == 'ldt' || ThresholdName == 'lut')
		{
			C = getScalingCoefficientsFromGroup(GroupWaveletCoefficients[[1]])
		}

		while(i <= groupLength)
		{
			if(ThresholdName == 'ldt')
			{
				tempList = ldtThreshold(GroupWaveletCoefficients[[i]],mode,i,dataLength,C)
			}
			else
			{
				if(ThresholdName == 'lut')
				{
					ut_dataLength = length(C[[i]])
					t = getUniversalThreshold(ut_dataLength)
				}
				tempList = ThresholdForOneLevel(GroupWaveletCoefficients[[i]],mode,t)
			}
			lists = append(lists,list(tempList))
			i = i + 1
		}
	}
	else{
			t = lhtThreshold(groups[[j]], dt, ThresholdName, mode)
			j = j + 1
			lists = list()
			lists = append(lists,list(GroupWaveletCoefficients[[1]]))
			i = 2
			groupLength = length(GroupWaveletCoefficients)
			while(i <= groupLength)
			{
				tempList = ThresholdForOneLevel(GroupWaveletCoefficients[[i]],mode,t)
				lists = append(lists,list(tempList))
				i = i + 1
			}
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
	a = 2 ** (0.5 * (J - now_level + 2))
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

lhtThreshold <- function(original_groups, transform_method, threshold_rule, mode) {
print("lhtThreshold")
subgroup_len = length(original_groups)
minimum <- optimize(f = loss_function, interval = c(-50,50), original_group = original_groups, dt = transform_method, thresholdName = threshold_rule, thresholdMode = mode, tol = 0.01)$minimum
# minimum = optim(par = 1, fn = loss_function, original_group = original_groups, dt = transform_method, thresholdName = threshold_rule, thresholdMode = mode, method = "Brent",lower = -2,upper = 2)$par
# minimumが負の値になる場合は0にする
print("minimum")
print(minimum)
if (minimum < 0) {
minimum <- 0
}
threshold_value <- ((1 - log(2) / log(subgroup_len)) ^ (-0.5)) * minimum
print("threshold_value")
print(threshold_value)
return(threshold_value)
}

loss_function <- function(t, original_group, dt, thresholdName, thresholdMode) {
  # 偶数番目と奇数番目に分ける
  odd_group <- original_group[seq(1, length(original_group), by = 2)]
  even_group <- original_group[seq(2, length(original_group), by = 2)]

  odd_index = log(length(odd_group), base = 2)
  even_index = log(length(even_group), base = 2)

  # 偶数番目と奇数番目についてWSEを行う
  print(odd_group)
 thresholded_odd_group <- wse(odd_group, dt, "none", thresholdMode, 1, odd_index, t)
 thresholded_even_group <- wse(even_group, dt, "none", thresholdMode, 1, even_index, t)

	odd_ave_list = list()
	even_ave_list = list()

	# odd_ave_list <- numeric(length(thresholded_odd_group$idata))
	# even_ave_list <- numeric(length(thresholded_even_group$idata))

	for (i in 1:length(thresholded_odd_group$idata)) {
	if (i != length(thresholded_odd_group$idata)) {
		odd_ave <- (thresholded_odd_group$idata[i] + thresholded_odd_group$idata[i + 1]) * 0.5
	} else {
		odd_ave <- (thresholded_odd_group$idata[i] + thresholded_odd_group$idata[1]) * 0.5
	}
	odd_ave_list= c(odd_ave_list, odd_ave)
	}

	for (i in 1:length(thresholded_even_group$idata)) {
	if (i != length(thresholded_even_group$idata)) {
		even_ave <- (thresholded_even_group$idata[i] + thresholded_even_group$idata[i + 1]) * 0.5
	} else {
		even_ave <- (thresholded_even_group$idata[i] + thresholded_even_group$idata[1]) * 0.5
	}
	even_ave_list= c(even_ave_list, even_ave)
	}
  squared_error <- 0
  for (i in 1:length(thresholded_odd_group$idata)) {
    odd_squared_error <- (odd_ave_list[[i]][1] - original_group[2 * i - 1]) ^ 2
    even_squared_error <- (even_ave_list[[i]][1] - original_group[2 * i]) ^ 2
    squared_error <- squared_error + odd_squared_error + even_squared_error
	print("squared_error")
	print(squared_error)
  }
  return(squared_error)
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