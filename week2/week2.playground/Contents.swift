//------------------------------------
//Object-Oriented Swift
//------------------------------------

//1.Declare a class ​Animal​ with property ​gender​ and method ​eat()​. The data type of gender should be enum Gender as below and when you call eat() method, it will print "I eat everything!"

enum Gender {
    case male
    case female
    case undefined
}

class Animal {
    let gender: Gender
    
    init(gender: Gender) {
        self.gender = gender
    }
    
    func eat() {
        print("I eat everything!")
    }
    
}
//2.Declare three classes: ​Elephant​, ​Tiger​, ​Horse​ that inheriting from Animal and override the eat method to print what they usually eat.

class Elephant: Animal {
    override func eat() {
        print("I eat grass")
    }
}

class Tiger: Animal {
    override func eat() {
        print("I eat meat")
    }
}

class Horse: Animal {
    override func eat() {
        print("I eat grass")
    }
}

//3.Declare a class ​Zoo​ with a property ​weeklyHot​ which means the most popular one in the zoo this week. The codes below can’t work correctly, please find what data type should A be and solve the problem. Be ​noticed that ​tiger​, ​elephant​, ​horse​ are instances of class Tiger, Elephant and Horse.
//class​ Zoo {
//    var​ weeklyHot: ​A
//    init​(weeklyHot: ​A​) { }
//
//}
//let​ zoo = ​Zoo​(weeklyHot: ​Tiger​())
//zoo​.weeklyHot = ​tiger
//zoo​.weeklyHot = ​elephant
//zoo​.weeklyHot = ​horse

class Zoo{
    var weeklyHot: Animal
    init(weeklyHot: Animal){
        self.weeklyHot = weeklyHot
    }
}

let tiger = Tiger(gender: .female)
let elephant = Elephant(gender: .male)
let horse = Horse(gender: .female)
let zoo = Zoo(weeklyHot: Tiger(gender: .undefined))
zoo.weeklyHot = tiger
zoo.weeklyHot = elephant
zoo.weeklyHot = horse


//4.What have you learned in ​Object-Oriented Swift​ session ?

// 知道了 struct 和 class 的建構方式和 property, method, initializer 等特性以及 class 的繼承

//5.What’s the difference between ​Struct​ and ​Class​ ?

// 1) class 可以被繼承、 struct 不行
// 2) struct 自動生成能初始化所有屬性的建構子 (member wise initializer) ， class 要自己寫
// 3) struct 是 value type ，當將他的實例或屬性被指派給一個變數或常數、傳遞給方法使用時，事實上是將資料拷貝之後再把拷貝的資料指派出去，指派後兩者是獨立的實體，做任何修改都不會互相影響。
//    class 是 reference type ，當將他的實例或屬性被指派給一個變數或常數、傳遞給方法使用時，則是把實體本身傳遞出去，修改其內容相當於修改其實體本身。

//6.What’s the difference between ​instance method​ and ​type method​ ?

// instance method： 必須先有實例才能用實例去呼叫方法
// ​type method： 可以直接用型別去呼叫方法

//7.What does ​Initilizer​ do in class and struct ?

// 初始化 class 或 struct 的屬性值

//8.What does ​self​ mean in an instance method and a type method ?

// 在 instance method 中， self 等同於該實例本身。
// 在 type method 中， self 指向這個型別本身，而不是型別的某個實例。

//9.What’s the difference between ​reference type​ and ​value type​ ?

// value type: 將他的實例或屬性被指派給一個變數或常數、傳遞給方法使用時，事實上是將資料拷貝之後再把拷貝的資料指派出去，對拷貝的資料做任何修改並不會引影響原本實體內的資料。
// reference type: 將他的實例或屬性被指派給一個變數或常數、傳遞給方法使用時，實際上傳送的是實例儲存的位置，修改其內容相當於修改其實體本身。

//------------------------------------
//Enumerations and Optionals in Swift
//------------------------------------

//1.There are several gasoline types, 92, 95, 98, and diesel that we can use enum to model them.

//●Please create enum named ​Gasoline​ to model gasoline.

//●Every kind of gasoline has its price. Please create a method named ​getPrice in Gasoline enum that will return different price depending on different gasoline.

//●Please establish ​raw values​ for ​Gasoline​. The data type of raw value should be String. For example, ​Gasoline.oil92.rawValue​ should be “92”.

enum Gasoline: String {
    case oil92 = "92"
    case oil95 = "95"
    case oil98 = "98"
    case diesel = "diesel"
    
    func getPrice(of type: Gasoline) -> Int {
        switch type {
        case .oil92: return 10
        case .oil95: return 10
        case .oil98: return 10
        case .diesel: return 10
        }
        
    }
}

//●Please explain what is enum ​associate value​ and how it works

//列舉中的每個 case 成員值，可以儲存一個或以上其他型別的相關值(associated value)，每個成員的相關值可以不一樣。
//使用方法為在成員值後面加上小括號()，並將 ​associate value​ 的指定型別放在小括號內(像使用 tuple 一樣)。
//在程式中將該列舉成員值指派給變數或常數時，這些相關值才會被設置。例如：

enum Somebody {
    case name(String)
    case age(Int)
    case favoriteFood(String, String)
}

let somebody = Somebody.favoriteFood("pizza", "cola")

//取出夾帶在 enum 裡的值要先判斷變數屬於哪個 case ，再透過 (let name) 取出
switch somebody {
case .favoriteFood(let food1, let food2):
    print("food1 = \(food1), food2 = \(food2)")
default:
    break
}

//2.Optional is a very special data type in Swift. Take ​​var​ a: ​Int​? = ​10​​​ for example, the value of ​a​ will be ​nil​ or ​Int​. You should learn how to deal with optional data type.

//●People would like to have pets, but not everyone could have one. Declare a class ​Pet​ with ​name​ property and a class ​People​ with ​pet​ property which will store a Pet instance or nil​. Please try to figure out what data type is suitable for these properties in Pet and People.

//●Please create a People instance and use ​guard let​ to unwrap the ​pet property.

//●Please create another People instance and use ​if let​ to unwrap the ​pet property.

class Pet {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class People {
    var pet: Pet?
    init(pet: Pet?) {
        self.pet = pet
    }
    func useGuardLetGetPet() {
        guard let pet = pet else {
            print("no pet!")
            return
        }
        print("pet name is \(pet.name)")
    }
    
    func useIfLetGetPet() {
        if let pet = pet {
            print("pet name is \(pet.name)")
        } else {
            print("no pet!")
        }
    }
}

let people1 = People(pet: nil)
people1.useGuardLetGetPet()

let people2 = People(pet: Pet(name: "Happy"))
people2.useIfLetGetPet()


// ----------------
//Protocol in Swift
// ----------------
//1.Declare a struct ​Person​ with a ​name​ property type String and a protocol name PoliceMan​. There is only one method ​arrestCriminals​ with no argument and return void in the protocol.
//2.Make struct ​Person​ conformto ​PoliceMan​ protocol.
//3.Declare a protocol ​ToolMan​ with a method ​fixComputer​ that no argument and return void.
//4.Add a property ​toolMan​ to the struct Person with data type ​ToolMan​.
//5.Declare a struct named ​Engineer​ that conforming to the ​ToolMan​ protocol.
//6.Create a Person instance with the name Steven and also create the relative data you need to declare this instance.
struct Person: PoliceMan {
    let name: String
    let toolMann: ToolMan
    func arrestCriminals() {
        print("arrest criminals")
    }
}

protocol PoliceMan {
    func arrestCriminals()
}

protocol ToolMan {
    func fixComputer()
}

struct Engineer: ToolMan {
    func fixComputer() {
        print("fix computer")
    }
}

let Steven = Person(name: "Steven", toolMann: Engineer())

// -----------------------
//Error Handling in Swift
// -----------------------

//Read the code above first and paste it in the playground file, there is an error inside the code.Please solve the error ​by adding additional code​ in the file. Do not remove or modifythe code above. Call ​guess(number:)​ and pass 20 as the argument after you fix the problem.

enum GuessNumberGameError: Error {
    case wrongNumber
}

class GuessNumerGame {
    var targetNumber = 10
    
    func guess(number: Int) throws {
        guard number == targetNumber else {
            throw GuessNumberGameError.wrongNumber
        }
        print("Guess the right number: \(targetNumber)")
    }
}

let guess = GuessNumerGame()
do {
    try guess.guess(number: 20)
} catch GuessNumberGameError.wrongNumber{
    print("Guess the wrong number!")
}
