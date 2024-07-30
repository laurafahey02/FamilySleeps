### Processing of Coded Children's Chronotype Questionnaire from OnlineSurveys ###

# Step 1: Read in data and assign column names

# Read in raw questionnaire data as a dataframe called quest 
quest <- read.csv("clwhkm6pz004314obf0rq5lzg-analytics-coded-30-07-2024.csv", header=T)

# Read in file with column names that match the order of columns in the raw childrens chronotype quesitonaire from online surveys
col_names <- readLines("column_names.txt")
# Set as column names of quest
colnames(quest) <- col_names


# Step 2: Divide quest dataframe into 3 - child1, child2 and studyID

child1 <- quest[,1:43]
child2 <- quest[,44:86]
Family_ID <- quest[,87]

# Assign Family and Individual IDs to child1 and 2 
# For individual IDs, this will just be set to child 1 or child2, which will be replaced by reseach assistant, Aoife Brennan.
Individual_ID <- rep("child1", 3)
child1_IDs <- cbind(familyID, Individual_ID, child1)
Individual_ID <- rep("child2", 3)
child2_IDs <- cbind(familyID, Individual_ID, child2)

# Step 4: Recombine child1 and child2 into one dataframe
# Bind child1 and child2 dataframes by rows
Both_children <- rbind(child1_IDs, child2_IDs)

# Step 5: Write to .csv file
write.csv(Both_children, "ChildrensChronotypeQuestionaire.csv", quote = F, row.names = F)
