# When you use this program for the first time, you need to install the following packages.
# install.packages("tidyverse")
# Load libraries
library(tidyverse)
# Load Hal wavelet estimation module
WSE_Path = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/src/WaveletShrinkageEestimation.R")
source(WSE_Path)

# Load data
ds = loadData(dataPath = "/DS/DS6.txt")
# hard = wse(data = ds, dt = "none", thresholdName = "ldt", thresholdMode = "h", index = 3, initThresholdvalue = 1)
# soft = wse(data = ds, dt = "none", thresholdName = "ldt", thresholdMode = "s", index = 3, initThresholdvalue = 1)
# createResult(hard = hard, soft = soft, index = 3, resultPath = "./output/NDT_WSE/")

hard = tipsh(data = ds, thresholdName = "ldt", thresholdMode = "h", index = 3)