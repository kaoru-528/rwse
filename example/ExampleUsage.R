# When you use this program for the first time, you need to install the following packages.
# install.packages("tidyverse")

# Load libraries
library(tidyverse)
# Load Hal wavelet estimation module
WSE_Path = paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/src/WaveletShrinkageEstimation.R")
source(WSE_Path)

# Load data
ds = loadData(dataPath = "/example/ExampleDS.txt")

# Perform WSE in (none, ldt, h, 3, 1)
hard = wse(data = ds, dt = "none", thresholdName = "ldt", thresholdMode = "h", index = 3, initThresholdvalue = 1)
# Perform WSE in (none, ldt, s, 3, 1)
soft = wse(data = ds, dt = "none", thresholdName = "ldt", thresholdMode = "s", index = 3, initThresholdvalue = 1)
# Create result
createResult(hard = hard, soft = soft, index = 3, resultPath = "./output/NDT_WSE/")

# Pefrom tipshWSE in (h, 1, 3)
tipshHard = tipsh(data = ds, thresholdMode = "h", var = 1, index = 3)