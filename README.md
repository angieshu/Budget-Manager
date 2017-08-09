<h1 align="center">
    <br>
    Budgie
    <br>
    <br>
    <a href=""><img src="https://github.com/angieshu/Budgie/blob/master/img/budgie_intro.gif" width="300"></a>
    <br>
<h4 align="center">
    Budget Manager iOS App
    <br>
    <br>
    <a href=""><img src="https://github.com/angieshu/Budgie/blob/master/img/budgie_screenshots.png"></a>
    <br>
</h4>
</h1>

## Key Features

• You can keep track of your income and expenses

• Live preview (make changes, see changes)

• Set goals (up to 4)

• Edit goals by adding payments

• Visually compare income and expenses


## Motivation

I can't imagine my life without a phone. I do almost everything with it: pay bills, play games, communicate etc. All of these wouldn't be possible without mobile applications. So I decided to build my own app just to learn how to create a user friendly interface and make this interface interract with a user. 

## Getting Started

Budgie was built in XCode 8.0. I also used [iOS Charts API](https://github.com/danielgindi/Charts) to create charts.

## Interface overview

<h1 align="center">
<br>
<a href=""><img src="https://github.com/angieshu/Budgie/blob/master/img/interface.png"></a>
</h1>

I used UIViewController for 'Welcome' window and UITabBarController that has 4 UIViewControllers in it for the rest.

## Code overview

There are 4 classes to control windows: IncomeVC, ExpensesVC, GoalsVC, and SummaryVC. 'Welcome' window connected with Tab Bar Controller by tapping a button.

### IncomeVC and ExpensesVC

These two classes are very similar to each other. So here I'm going to describe only one of them.

Class contains 5 IBOutlets and 2 arrays: one keeps names of months, and second - has information about the income during those months. 

When application is started, it downloads user's data, displays information on a screen and creates a bar chart with information about income during past months. saveData() function is called every time when user makes cnahges.

<img width="558" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/income_view.png">

As soons as user tapped 'Add income' button, function addIncomeTapped() gets called. Here I validate input: check whether text field was empty, or negative or invalid number was entered. If everything was good, I update both total and current month incomes, save data, display an updated chart, and under the text field show a massage about amount was added. Otherwise, the function throws an error massage.

<img width="500" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/add_income.png">

In the following function I set a bar chart based on the information about income provided by user.

<img width="558" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/set_chart.png">

Finally, in updateTotalIncome() I count sum of all the incomes from current and previous moths, in updateIncomeThisMonth() - as you could guess from the name - update indormation about current month income, and currencyFormat() simply converts entered number to the currency format string.

<img width="500" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/income_finally.png">

### GoalsVC

Probably, the most complicated part of this project.

This class has 4 variables, 3 IBOutlets, 1 dictionary to keep track of goals, and 5 arrays that contain info about custom labels and buttons that get created every time when user sets a goal.

Just like in a previous class when the app is started, I download user's data (if there is no data display appropriate massage) and put goal labels on the screen.

<img width="500" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/goalsVC.png">

When the user taps a 'Set goal' button setButtonTapped() function gets called. Here I validate an input. If everuthing is fine, update a goals dictionary and display a new goal on a screen. Otherwise, an error massage is displayed.

<img width="520" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/goals_setGoal1.png">
<img width="500" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/goals_setGoal2.png">

Goal label consists of 5 elements: background, goal name and amount, 'Delete' button, 'add payment' button and 'add payment' text field. Each of them has to be created programmatically every time when user sets a new goal.

<img width="540" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/goal_make.png">
<img width="540" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/goal_make2.png">

addPayment() function changes the goal's amount and then saves data.

<img width="500" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/goals_addpayment.png">

The last function in this class I want to talk about, is called pressButton(). It gets called when the user wants to delete one of the goals. When this happens, the goal has to be removed from a dictionary, all the labels and buttons have to be removed as well, and, if there are any goals below the one that needs to be deleted, each of them has to be moved upward. Huh, I think, that is it for this class. 

<img width="520" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/goals_pressbutton.png">


### SummaryVC








