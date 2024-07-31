## Use this script to process the FamilySleeps Morningness-Eveningness Questionnaire (MEQ) and the Pittsburgh Sleep Quality Index
# It can be run from the command line as follows:
# Rscript individual_questionaire.R input_file output_file

### Step 0: Read command line arguments
args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]
output_file <- args[2]

### Step 1: Read in data and assign column names

# Read in raw questionnaire data as a dataframe called quest
quest <- read.csv(input_file, header = TRUE)

# Replace missing values with the string NA
quest[quest ==""] <- "NA"
quest[is.na(quest)] <- "NA"

# Read in file with column names that match the order of columns in the raw children's chronotype questionnaire from online surveys
# This file is already in all questionaire directories
col_names <- readLines("column_names.txt")
# Set as column names of quest
colnames(quest) <- col_names

### Step 2: Reorder so that individual ID is the first column
Individual_ID <- quest[,ncol(quest)]
questions <- quest[,1:ncol(quest) - 1]
questionaire <- cbind(Individual_ID, questions)

# Step 3: Write to .csv file
write.csv(questionaire, output_file, quote = F, row.names = F)
