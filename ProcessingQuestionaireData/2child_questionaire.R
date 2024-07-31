## Use this script to process the FamilySleeps Children's Chronotype Questionnaire and the Sleep Disturbances Scale for Children
# It can be run from the command line as follows:
# Rscript 2child_questionaire.R coded_questionaire_input_file child1_start child1_end child2_start child2_end processed_outputfile_name

# Step 0: Read command line arguments
args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]
child1_start <- as.numeric(args[2])
child1_end <- as.numeric(args[3])
child2_start <- as.numeric(args[4])
child2_end <- as.numeric(args[5])
output_file <- args[6]

# Step 1: Read in data and assign column names
# Read in raw questionnaire data as a dataframe called quest
quest <- read.csv(input_file, header = TRUE)

# Read in file with column names that match the order of columns in the raw children's chronotype questionnaire from online surveys
col_names <- readLines("column_names.txt")
# Set as column names of quest
colnames(quest) <- col_names

# Step 2: Divide quest dataframe into 3 - child1, child2 and Family_ID
child1 <- quest[, child1_start:child1_end]
child2 <- quest[, child2_start:child2_end]
Family_ID <- quest[, ncol(quest)] # Assuming Family_ID is always the last column

# Step 3: Assign Family and Individual IDs to child1 and child2
# For individual IDs, this will just be set to child1 or child2, which will be replaced by research assistant, Aoife Brennan.
Individual_ID <- rep("child1", nrow(child1))
child1_IDs <- cbind(Family_ID, Individual_ID, child1)

Individual_ID <- rep("child2", nrow(child2))
child2_IDs <- cbind(Family_ID, Individual_ID, child2)

# Step 4: Recombine child1 and child2 into one dataframe
# Bind child1 and child2 dataframes by rows
Both_children <- rbind(child1_IDs, child2_IDs)

# Step 5: Write to .csv file
write.csv(Both_children, output_file, quote = FALSE, row.names = FALSE)
