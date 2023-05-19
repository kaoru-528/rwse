# MSE(Mean Squared Error)
MSE = function(oriData, estList)
{
  if(length(oriData)!= length(estList))
  {
    return(FALSE)
  }
  index = 1
  total = 0
  while(index <= length(oriData))
  {
    total = total + (oriData[[index]] - estList[[index]])**2
    index = index + 1
  }
  total = sqrt(total)
  return(total / length(oriData))
}