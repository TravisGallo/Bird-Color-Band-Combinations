# R script to created a spreadsheet of color band combinations always including one aluminum band
# There are a lot of examples of this online
# This is just my adaptation
# Updated 12-18-2017 by Travis Gallo

library("gtools") 


# character vector of avaliable colors
# make sure to have "AL" for aluminum band
bands <- c("AL", "BL", "BK", "R", "W", "Y", "G")

# create combinations
n_bands <- 4 #number of bands that can go on a bird (two on each leg in our case)
combos <- permutations(length(bands), n_bands, bands, repeats.allowed=TRUE)

# keep only combos that include aluminum band
combos_w_AL <- combos[rowSums(combos=="AL") == 1,]
nrow(combos_w_AL) # how many combos have you made?
colnames(combos_w_AL) <- c("Upper.Left",  "Lower.Left", "Upper.Right",	"Lower.Right")
write.csv(combos_w_AL, "original_color_band_combos.csv")

# OPTIONAL
# maybe you dont want a full list of combos to take to the field
# randomly draw a subset of combos (here 200)
# I did a random draw thinking of mixing up my colors so I dont run out of, lets say black, really quick
bands_subset <- as.data.frame(combos_w_AL[sample(nrow(combos_w_AL), 200, replace=FALSE),])
write.csv(bands_subset, "subset_color_band_combos.csv")

######################
### FOLLOWING YEAR ###
######################
# remove used combos from larger possible combo list 
# logic supplied by David Winsemius at Heritage Laboratories - pulled this from online
# create list of unique band combos used
# load .csv of the combinations that were used exactly as they were before
used_bands <- read.csv("yourfilepath/yourfilename.csv", header=TRUE)
head(used_bands) # column names should match with below
head(combos_w_AL) # column names should match with above

# goes through and removes used combos from the larger list of combinations
unused_combos <- combos_w_AL[apply(combos_w_AL, 1, function(x) max(apply(used_bands, 1, function(y) all.equal(x, y, check.attributes=FALSE)))) !="TRUE", ]
nrow(unused_combos) # how many combos left (should be the original amount - the used combos)

#OPTIONAL - again you can take a random subset
bands_subset2 <- as.data.frame(unused_combos[sample(nrow(unused_combos), 200, replace=FALSE),])




