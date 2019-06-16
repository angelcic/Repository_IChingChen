// --------------------------
// Assignment 1: Git & GitHub
// --------------------------
// 1.Please apply for a GitHub account and create a repository then upload yourhomework to the repository.After the process, please ​send your repository link to usthrough slack direct message​ and  we will check your assignments through yourrepository every week.We need you to structure your repo as below

// 2. Here are a few git and github commands we usually use in software development, please explain the meanings and use cases of them

// git status ：檢視檔案的狀態。會列出尚未被版本追蹤的檔案、已提交至暫存區的檔案、已修改尚未提交至暫存區的檔案。當想要檢視是否有檔案已經更改但尚未紀錄版本時可用此指令檢視檔案狀態。
// git add ：將檔案從工作區添加到儲存區。檔案完成一項功能或是修改後可用此指令將檔案加到暫存區。
// git commit ：提交，將檔案從暫存區儲存到版本庫中。確定暫存區的檔案是想要提交的正確版本後可用此指令將檔案提交。
// git log ：以新到舊列出版本庫的提交歷史紀錄。列出最近的commit及其相關訊息（包含提交ID）。發現現行版本發生過去沒有的問題，可藉由此指令查找log，看歷次做了什麼修改。
// git push [Repo_name][Branch_name] ：將本地端的檔案上傳到遠端的版本庫。想把本地端的分支commit上傳到遠端版本庫時可用此方法上傳。
// git remote -v ：查看當前遠端版本庫的url。 -v 表示要求輸出更詳細的版本庫訊息。可確定設定的遠端版本庫ＵＲＬ是否正確。
// git branch ：查看當前所在的分支。可確定現在操作的是哪一個分支。
// fork ：GitHub中相當於clone的功能，能複製GitHub上其他人的版本庫到自己的帳號下。在GitHub上看到有興趣的專案可用此功能將他人專案的遠端版本庫複製到自己的遠端版本庫進行修改，在不影響他人的版本庫的同時也能保有對版本庫的原作者的連結，讓看到我的版本庫的人可以知道原作者是誰。

// 3. Please describe how to establish a github repo and how to upload the local projects to github. Try to explain it as detail as possible.

//1)在GitHub右上角點選「+」號，並選擇「New repository」
//2)填寫版本庫的名稱，然後按下「Create repository」
//3)在本地用$ git remote add [Repo_Name] [Repo_URL]指令紀錄遠端版本庫的URL。參數Repo_Name是給遠端版本庫的代稱，一般預設用origin，參數Repo_URL是檔案在GitHub上版本庫的URL，"https://github.com/(自己的GitHub帳號)/(GitHub上的版本庫名稱).git"
//4)接著在本地用$ git push [Repo_Name] [Branch_Name] 指令將本地的Repository上傳到指定的github 版本庫及分支。他會將可透過Branch_Name分支上可訪問的所有commit複製到GitHub的版本庫中
//

// --------------------------
// Assignment 2: Swift Basic
// --------------------------
// 1. In swift , we usually define a variable through the syntax as below:
//var x: Int = 10
// When calculating circle’s area, we use the formula: 2 * radius * Pi to get area. Now, please define a variable Pi and assign a value to it. You can refer to the syntax above while do think about using  var or let and which data type it should be.
 
 let Pi = Double.pi //因為PI在數學中有代表的固定值，不需要改變其值，因此設為常數型態


// 2. Create two constants x and y of type Int then assign any value to them. After that, please calculate the average of x and y and store the result in a constant named average.

 let x: Int = 5
 let y: Int = 6
 let average: Double = Double(x+y) / 2

// 3.    Following with Q2, now we want to save the average in a record system, but the system doesn’t accept 65 but 65.0.
//
// ●    Please solve this problem so that we can put the average in the record system.

// 用Double()將整數換成浮點數後再指定給average

// ●    Please explain the difference between ( 10 / 3 ) and ( 10.0 / 3.0 ).

10 / 3
10.0 / 3.0
//前者為整數的除法·結果會省略掉小數點後的位數
//後者為輔點數的除法·結果會保留小數點之後的位數

// 4. Swift is a very powerful language that it can infer the data type for you ( Type inference ) while we still need to know the basics well. Please change the following codes into the one with data type.
// Ex:  var x = 10 =>  var x: Int = 10

var flag: Bool = true
var inputString: String = "Hello world."
let bitsInBite: Int = 8
let averageScore: Double = 86.8

// 5. Compound assignment operator is very useful when programming. Please create salary as 22000, and use unary plus operator adding 28000 to salary, and it will be 50000 after this process.

var salary = 22000
salary += 28000

// 6. You should notice that ‘=’ has difference meaning in programming. In real world, ‘=’ means equal while In programming, ‘=’ means assign. You simply put the right hand side data into left hand side variable or constant.
// Now please write down the Equality operator in swift.

// ==

// 7. Declare two constants that values are 10 and 3 each, then please calculate the remainder and save the result in a constant named remain.

let values1 = 10
let values2 = 3
let remain = 10 % 3

// 8. Please explain the difference between let and var.

//var 為變數，其值可以依需求更動
//let 為常數，其值在初始化後就固定了不可以改變

//9. Please write down naming conventions and rules you learned in this session.

//命名中不能有空白鍵
//用Camel case 方法命名法來區隔命名中的單字，以小寫開頭，後續單字以大寫開頭
//命名中不能以數字或特殊符號為開頭

//10. What is Type Inference in swift?

//變數常數在初始化時不用宣告他是什麼型別的變數常數，swift會自動從存入的資料判斷它是什麼型別的變數常數
//var iAmString: String = "String"
//var iAmString = "String" //不用宣告為String，swift也知道他是String型別的變數

//11. What is the problem about this piece of code?
//var phoneNumber = 0987654321，
//phoneNumber = "Hello world."

//在初始化變數phoneNumber時指定存入Int型別的資料，因此被默認為Int型別的變數
//因此之後無法再存入不同型別的資料，例如String

//----------------------
//Assignment 3: Swift Collection and Control Flow - Colletion
//----------------------

//You should know how to declare an array in swift, and also how to add, remove, insert, read object in an array. You should be familiar with the following syntax : append, insert, remove.
//
//Array is a dangerous stuff in swift. If you access the array with index which is out of range, your app will crash with fatal error. Please interact with array very carefully.

//1. Please create an empty array with String data type and save it in a variable named myFriends.

var myFriend: [String] = []

//2. According to Q1, now I have three friends, ‘Ian’, ‘Bomi’, and ‘Kevin’. Please help me to add their name in to myFriends array.

myFriend += ["Ian","Bomi","Kevin"]

//3.    Oops,I forget to add ‘Michael’ who is one of my best friend, please help me to add Michael to the end of myFriends array.

myFriend += ["Michael"]

//4.    Because I usually hang out with Kevin, please move Kevin to the beginning of the myFriends array.

//myFriend.swapAt(0, 2)
myFriend.remove(at: 2)
myFriend.insert("Kevin", at: 0)

//5.    Use for…each to print all the friend in myFriends array.

//myFriend.forEach { friend in
//    print(friend)
//}

for friend in myFriend{
    print(friend)
}

//6.    Now I want to know who is at index 5 in the myFriends array, try to find the answer for me. Please explain how did you get the answer and why the answer is it.

//因為myFriend這個陣列中目前只有4筆資料，而陣列的index是從0開始計算的，因此最多只能取出第四筆資料，也就是index 3，超過這個範圍Swift編譯器會跳出Index out of range的錯誤提示，因此無法查詢在myFriend陣列中查詢index 5
//myFriend.count = 4
//myFriend[5] // Error

//7. How to get the first element in an array?

myFriend[0]

//8. How to get the last element in an array?

myFriend[myFriend.count-1]

//9. Please create an dictionary with keys of type String, value of type Int, and save it in a variable named myCountryNumber.

var myCountryNumber: [String:Int] = [:]
//var myCountryNumber = [String:Int]()

//10. Please add three keys ‘US’, ‘GB’, ‘JP’ with values 1, 44 , 81.

myCountryNumber["US"] = 1
myCountryNumber["GB"] = 44
myCountryNumber["JP"] = 81

//11. Change the ‘GB’ value from 44 to 0.

myCountryNumber["GB"] = 0

//12. How to declare a empty dictionary?

//var (dictionary name): [(key type):(value type)] = [:]
//var (dictionary name) = [(key type):(value type)]()

//13. How to remove a key-value pair in a dictionary?

//可以直接將key對應的value改為nil
myCountryNumber["US"] = nil
//或是呼叫removeValue(forKey: (key))方法
//myCountryNumber.removeValue(forKey: "US")

//---------------------
//Assignment 3: Swift Collection and Control Flow - Control Flow
//---------------------
//1. Here is an array:
let lottoNumbers = [10, 9, 8, 7, 6, 5]

//Please use For-Loop and Range to print the last three members in the lottoNumbers array.

for num in lottoNumbers[(lottoNumbers.count-3)...(lottoNumbers.count-1)]{
    print(num)
}

//2. When use for-in loop, we make the computer do the same thing multiple times. The index is increasing by 1. What if we want to decreasing by -1 ? What if we want to increasing by 2 ? Please use swift syntax to get the result as images list below :
print("-----print 5...10 with for in------")
for num in 5...10{
    print(num)
}

print("-----print 10,8,6 with for in------")
for num in stride(from: 6, through: 10, by: 2).reversed(){
    print(num)
}

//Please find a method which can help us complete these requirements.
//
//3. Please use while loop to solve above question.

print("-----print 5...10 with while------")
var whileNum = 5
while whileNum <= 10{
    print(whileNum)
    whileNum += 1
}
print("-----print 10,8,6 with while------")
whileNum = 10
while  whileNum >= 6{
    print(whileNum)
    whileNum -= 2
}

//4.    Please use repeat-while loop to solve question 2.

print("-----print 5...10 with repeat-while------")
var repeatWhileNum = 5
repeat{
    print(repeatWhileNum)
    repeatWhileNum += 1
}while repeatWhileNum <= 10

print("-----print 10,8,6 with repeat-while------")
repeatWhileNum = 10
repeat{
    print(repeatWhileNum)
    repeatWhileNum -= 2
}while  repeatWhileNum >= 6

//5.    Here is variable isRaining to record the weather. Please write a statement that if the weather is raining, print “It’s raining, I don’t want to work today.”, otherwise print  “Although it’s sunny, I still don’t want to work today.”

var isRaining = true

if isRaining{
    print("It’s raining, I don’t want to work today.")
}else{
    print("Although it’s sunny, I still don’t want to work today.")
}

//6.    In a company, we usually use numbers to represent job levels. Let’s make a example. We have four job levels : Member, Team Leader, Manager, Director. We use 1 to present Member, 2 to Team Leader, 3 to Manager, 4 to Director.

let jobLevels = [1: "Member", 2: "Team Leader", 3:"Manager", 4:"Director"]

//Now, create a variable name jobLevel and assign a number to it. If jobLevel number is in our list, print the relative job title name; if not, just print “We don't have this job”. Please use switch statement to complete this requirement.

var jobLevel = 2
switch jobLevel {
case 1...4:
    print(jobLevels[jobLevel] ?? "jobLevel is nil")
default:
    print("We don't have this job”. Please use switch statement to complete this requirement.")
}
//------------------------------
//Assignment 4: Function in Swift
//------------------------------
//1. Please declare a function named greet with person as argument label and name as parameter name. This greet function will return a String. For example, if you call the function greet like this:
//
//greet(person: "Celeste")
//
//It will return string: “Hello, Celeste”.

func greet(person name: String) -> String{
    return "Hello, \(name)"
}
greet(person: "Celeste")

//2. Please declare a function named multiply with two argument a , b , and with no return value that when you call this function, compiler will print out the result of a * b. Be noticed that we want to give argument b with a default value 10.

func multiply(a: Int = 10, b: Int = 10){
    print(a*b)
}
multiply()

//3. What’s the difference between argument label and pararmeter label in function ?
//
// argument label 是外部參數，讓使用者呼叫方法時方便知道輸入的參數所代表的意義
// pararment label 是內部參數，使用者呼叫方法時並不會看到這個內部參數名，方便方法內使用
//
//4. What are the return type in the following statements?

//func birthday( ) -> String {
//
//}
// => return type is String

//func payment( ) -> Double {
//
//}
// => return type is Double






