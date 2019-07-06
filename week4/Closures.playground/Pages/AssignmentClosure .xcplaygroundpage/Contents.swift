//Please implement a closure which input type is Int, out put type is Bool. The functionality of this closure is to verify if the input is odd or not, If it’s odd, please return true, otherwise return false.

let num = [1,2,3,4,5,6,7]
num.map{(num: Int) -> Bool in
    if num % 2 == 0 {
        return false
    } else {
        return true
    }
}

