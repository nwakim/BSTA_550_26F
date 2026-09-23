library(dplyr)

# Set the first day of class: "Term begins" date in OHSU academic calendar
first_day = as.Date("9/28/26", "%m/%d/%y")
# Set last day of the class: "Term ends" date in OHSU academic calendar
last_day = as.Date("12/11/26", "%m/%d/%y")

# Create the calendar dates sequence
cal_dates = seq(from = first_day, to = last_day, by = "day")
year = "2026"

## Week 1 dates
w1d1 = cal_dates[1]
w1d2 = cal_dates[3]
hw0 = cal_dates[4]

## Week 2 dates
w2d1 = cal_dates[8]
w2d2 = cal_dates[10]
hw1 = cal_dates[14]
cp0 = cal_dates[14]

## Week 3 dates
w3d1 = cal_dates[15]
w3d2 = cal_dates[17]
cp1 = cal_dates[21]
hw1sol = cal_dates[21]

## Week 4 dates 
w4d1 = cal_dates[22]
w4d2 = cal_dates[24]
hw2 = cal_dates[28]
hw2sol = cal_dates[28]
q1_open = cal_dates[24]
q1_close = cal_dates[28]

## Week 5 dates
w5d1 = cal_dates[29]
w5d2 = cal_dates[31]
hw3 = cal_dates[35]
hw3sol = cal_dates[35]

## Week 6 dates
w6d1 = cal_dates[36]
w6d2 = cal_dates[38]
hw4 = cal_dates[42]
hw4sol = cal_dates[42]
q2_open = cal_dates[38]
q2_close = cal_dates[42]

## Week 7 dates
w7d1 = cal_dates[43]
w7d2 = cal_dates[45]
cp2 = cal_dates[49]

## Week 8 dates
w8d1 = cal_dates[50]
w8d2 = cal_dates[52]
hw5 = cal_dates[56]

## Week 9 dates
w9d1 = cal_dates[57]
w9d2 = cal_dates[59]
cp3 = cal_dates[63]

## Week 10 dates
w10d1 = cal_dates[64]
w10d2 = cal_dates[66]
hw6 = cal_dates[70]
hw7sol = cal_dates[69]
q3_open = cal_dates[66]
q3_close = cal_dates[70]

## Week 11 dates
w11d1 = cal_dates[71]
w11d2 = cal_dates[73]
hw7 = cal_dates[74]
proj = cal_dates[75]

## Old HW 8/9 dates: no longer used for homework, kept so schedule_01.qmd still renders
hw8 = cal_dates[70]
hw9 = cal_dates[74]