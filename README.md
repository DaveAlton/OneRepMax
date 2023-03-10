# OneRepMax

This project is created to take in an input file (workoutData.txt) and display the exercises it contains along with the one rep max for each exercise.

Once an exercise is tapped, the user should be taken to a view that shows a chart displaying their one rep max over time.

To change the data, one can alter the workoutData.txt to include other data.

# Contents

ExercisesViewController displays the exercises from the workout data. Its view model is called ExercisesViewModel.

ExerciseDetailsViewController displays the one rep max over time. Its view model is called ExerciseDetailsViewModel

DataParser is the object that reads from the workout data and returns a formatted data structure. Only the best one rep max for each day is returned.

Calculator is the object that uses an Equation to calculate the one rep max. Equations can be swapped out, and the brzycki and epley equations are currently included. Once a calculation has been calculated, a Calculation object is returned.
