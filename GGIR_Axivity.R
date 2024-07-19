### GGIR Rscript ###

# This can be run from terminal using
#Rscript GGIR.R outputdir outputfile
# For example, if output dir is /home/lfahey/FamilySleeps/axivity/results and output file name you want is ggir_variables.csv, run as:
#Rscript GGIR.R /home/lfahey/FamilySleeps/axivity/results ggir_variables.csv

#### Step 1. Load libraries ####
library(GGIR)
library(ActCR)

#### Step 2. Specify directory with input data, the directory where you want to store the GGIR output and the output file name with just the variables of interest ####
args <- commandArgs(trailingOnly = TRUE)

outputdir <- args[1]
outputfile <- args[2]

datadir <- "/home/lfahey/FamilySleeps/axivity/raw_data"

#### Step 2. Specify directory with input data and the directory where you want to store the GGIR output ####

GGIR(datadir = datadir,
     outputdir = outputdir, cosinor = TRUE, visualreport=FALSE)
# incluce start and end dates

#### Step 3. Process output files ####

# GGIR automatically writes the result files to the output directory, we now what to read these back in to extract only the variables of interest, and combine them all into one file.
# I am reading back in the person level summary files, which are derived from the variables in the day/night level summaries

part2_results <- read.csv("/home/lfahey/FamilySleeps/axivity/results/output_raw_data/results/part2_summary.csv", header=T)
part4_results <- read.csv("/home/lfahey/FamilySleeps/axivity/results/output_raw_data/results/part4_summary_sleep_cleaned.csv", header=T)
part5_results <- read.csv("/home/lfahey/FamilySleeps/axivity/results/output_raw_data/results/part5_personsummary_MM_L40M100V400_T5A5.csv", header=T)

# Filter to only columns of interest
# grep("daysleeper", names(part4_results), value = TRUE) # to find exact column names

part2_var <- part2_results[, c("ID", "IS_interdailystability", "cosinorIS", "IV_intradailyvariability", "cosinorIV", "cosinor_acrophase", "cosinor_amp")]
part4_var <- part4_results[, c("ID", "sleeponset_AD_T5A5_mn", "sleeponset_AD_T5A5_sd", "sleeponset_WD_T5A5_mn", "sleeponset_WD_T5A5_sd", "sleeponset_WE_T5A5_mn", "sleeponset_WE_T5A5_sd", "wakeup_AD_T5A5_mn", "wakeup_AD_T5A5_sd", "wakeup_WD_T5A5_mn", "wakeup_WD_T5A5_sd", "wakeup_WE_T5A5_mn", "wakeup_WE_T5A5_sd", "SleepDurationInSpt_AD_T5A5_mn", "duration_sib_wakinghours_AD_T5A5_mn", "number_sib_wakinghours_AD_T5A5_mn", "n_WEnights_daysleeper", "n_WDnights_daysleeper", "WASO_AD_T5A5_mn", "SleepRegularityIndex_AD_T5A5_mn")]
part5_var <- part5_results[, c("ID", "M5TIME_num_pla", "M5VALUE_pla", "L5TIME_num_pla", "L5VALUE_pla")]
# combine three dataframes
all_var <- cbind(part2_var, part4_var, part5_var)

# write to csv file
write.csv(all_var, outputfile, row.names = FALSE)
