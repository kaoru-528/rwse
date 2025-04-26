# When you use this program for the first time, you need to install the following packages.
# install.packages("tidyverse")
# Load libraries
library(tidyverse)

# Load source files
src_dir <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/src")
r_files <- list.files(src_dir, pattern = "\\.R$", full.names = TRUE)  # フルパスを取得
lapply(r_files, source)

# Load data
ds <- LoadData(DataPath = "/example/ExampleDS.txt")
Hard <- Wse(Data = ds, DataTransform = "none", ThresholdName = "ldt", ThresholdMode = "h", Index = 3, InitThresholdValue = 1, Var = 1)
# Perform WSE in (none, ldt, s, 3, 1)
Soft <- Wse(Data = ds, DataTransform = "none", ThresholdName = "ldt", ThresholdMode = "s", Index = 3, InitThresholdValue = 1, Var = 1)
# Create result
CreateResult(Hard = Hard, Soft = Soft, Index = 3, ResultPath = "./output/NDT_WSE/")

# Pefrom tipshWSE in (h, 1, 3)
TipshHard <- Tipsh(Data = ds, ThresholdMode = "h", Var = 1, Index = 3)
