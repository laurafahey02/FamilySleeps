## Use this script to process the FamilySleeps Demographic Information
# It can be run from the command line as follows:
# Rscript demographic_questionaire.R2 input_file output_file

### Step 0: Read command line arguments
args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]
output_file <- args[2]

### Step 1: Read in data

quest <- read.csv(input_file, header = TRUE)
quest[quest ==""] <- "NA"
quest[is.na(quest)] <- "NA"

col_names <- readLines("column_names.txt")
# Set as column names of quest
colnames(quest) <- col_names

### Step 2: Create df of just parental data
parents <- quest[,1:6]
family_id <- quest[,32]
parents$Family_ID <- family_id
parents$Individual_ID <- "Parents"

parents$Demographic_DOB <- "NA"
parents$Demographic_age <- "NA"
parents$Demographic_sex <- "NA"
parents$Demographic_pronouns <- "NA"
parents$Demographic_school <- "NA"
parents$Demographic_class <- "NA"
parents$Demographic_sleep <- "NA"
parents$Demographic_siblings <- "NA"
parents$Demographic_pets <- "NA"
parents$Demographic_parent <- "NA"
parents$Demographic_nightlight <- "NA"
parents$Demographic_sensor <- "NA"
parents$Demographic_device <- "NA"

### Step 3: Create df of just childrends data
child1 <- quest[,7:19]
child1$Family_ID <- family_id
child1$Individual_ID <- "Child1"

child2 <- quest[,20:32]
child2$Demographic_sensor <- "NA"
child2$Individual_ID <- "Child2"

both_children <- rbind(child1, child2)

both_children$Demographic_partner_pronouns <- "NA"
both_children$Demographic_ethnicity <- "NA"
both_children$Demographic_education <- "NA"
both_children$Demographic_partner_education <- "NA"
both_children$Demographic_work <- "NA"

### Step 4: Combind parental and childrens data by rows and write to file
all <- rbind(parents, both_children)

#rearrange columns
demo_quest <- all[, c("Family_ID", "Individual_ID", "Demographic_partner_pronouns", "Demographic_ethnicity", "Demographic_education", "Demographic_partner_education", "Demographic_work", "Demographic_DOB", "Demographic_age", "Demographic_sex", "Demographic_pronouns", "Demographic_school", "Demographic_class", "Demographic_sleep", "Demographic_siblings", "Demographic_pets", "Demographic_parent", "Demographic_nightlight", "Demographic_sensor", "Demographic_device")]

write.csv(demo_quest, output_file, quote = F, row.names = F)
