### Processing of Coded Questionnaire Data from OnlineSurveys ###

# Step 1: Read in data

# Raw questionnaire data
quest <- read.csv("//wsl.localhost/Ubuntu/home/lfahey/FamilySleeps/questionaires/raw_data/clwhkm6pz004314obf0rq5lzg-analytics-coded-19-07-2024.csv", header=T)
# ID - study ID dictionary (obtained from Aoife Brennan)
IDs <- read.table("//wsl.localhost/Ubuntu/home/lfahey/FamilySleeps/questionaires/raw_data/ids.txt", header=T, sep="\t")

# Change name of 87th column to be more accurate and match IDs column name
names(quest)[87] <- "studyID"

# Step 2: Divide quest dataframe into 3 - child1, child2 and studyID

child1 <- quest[,1:43]
child2 <- quest[,44:86]
studyID <- quest[,87]

# Make child 1 and 2 have the same column names (since they're the same questions repeated for each child)
colnames(child2) <- colnames(child1)

# Step 4: Recombine

# Bind child1 and child2 dataframes by rows
both_children <- rbind(child1, child2)

# Add studyID as the first column
questionaires_children <- cbind(studyID, both_children)

# Add ID based on matching studyID
questionaires_ID <- merge(IDs, questionaires_children, by = "studyID")

# Step 5: Write to .csv file
write.csv(questionaires_ID, "//wsl.localhost/Ubuntu/home/lfahey/FamilySleeps/questionaires/questionaires_ID.txt", quote = F, row.names = F)
