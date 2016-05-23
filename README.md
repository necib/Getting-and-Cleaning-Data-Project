# Getting-and-Cleaning-Data-Project

Repo for the submission of the course project for Cleaning Data course.

## Overview

The purpose of this project is to demonstrate how to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The source data for this project can be found [here.] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

##Making Modifications to This Script

Once you have obtained and unzipped the source files, you will need to make one modification to the R file before you can process the data. you have to set the path of the working directory to relect the location of the source files in your own directory.

## Project Summary

The script run_analysis.R will execute the following tasks:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
* From the data set in the previous step, it creates a second, independent tidy data set with the average of each variable for each activity and each subject.

You can find additional information about the variables, data and transformations in the CodeBook.MD file.
