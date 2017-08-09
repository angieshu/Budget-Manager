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

<img width="558" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/income_view.png">

When application is started, it downloads user's data, displays information on a screen and creates a bar chart with information about income during past months. saveData() function is called every time when user makes cnahges.

<img width="558" alt="add_income" src="https://github.com/angieshu/Budgie/blob/master/img/add_income.png">"

As soons as user tapped 'Add income' button, function addIncomeTapped() gets called. Here I validate input: check whether text field was empty, or negative or invalid number was entered. If everything was good, I update both total and current month incomes, save data, display an updated chart, and under the text field show a massage about amount was added. Otherwise, the function throws an error massage.







