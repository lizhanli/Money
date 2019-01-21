//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport

/*
 *什么是原型模式?
 *原型就是我们所说的事物的祖先,或者说是事物的本质,亦或说就是指本身
 *官方说法：原型模式指的是通过克隆已有的对象来创建新的对象，已有的对象即为原型
 *克隆分为：浅拷贝和深拷贝
 *浅拷贝：指引用的拷贝，指针指向同一块内存地址
 *深拷贝：内容的拷贝，指针指向不同的内存地址
 */

//swift 数组是值类型
//var array = ["1", "2", "1", "10"]
//print(array)//["1", "2", "1", "10"]
//var array1 = array
//array.append("3")
//print(array)//["1", "2", "1", "10", "3"]
//print(array1)//["1", "2", "1", "10"]

//class Person {
//    var name: String?
//    var age: Int?
//    init(name: String?, age: Int?) {
//        self.name = name
//        self.age = age
//    }
//}
//var p = Person(name: "李先生", age: 18)
//var p1 = p
//p1.name = "王大美女"
//print(p.name)//王大美女
//print(p1.name)//王大美女
//我们可以看到类是引用类型，我们的p和p1指向的是同一块内存地址，那么我们怎么才能深克隆一份p呢

//class Person: NSCopying  {
//    var name: String?
//    var age: Int?
//    var son: Son?
//    init(name: String?, age: Int?) {
//        self.name = name
//        self.age = age
//    }
//    //实现此方法
//    func copy(with zone: NSZone? = nil) -> Any {
//        let p = Person(name: self.name, age: self.age)
//        return p
//    }
//}

//class Son {
//    var height: String?
//}

//class Son: NSCopying {
//    var height: String?
//    func copy(with zone: NSZone? = nil) -> Any {
//        let s = Son()
//        return s
//    }
//}

//var p = Person(name: "李先生", age: 16)
//p.son = Son()
//p.son?.height = "170cm"
//var p1 = p.copy() as! Person
//p1.son = p.son?.copy() as! Son
//p1.name = "王大美女"
//p1.son?.height = "162cm"
//print("p1.name===\(p1.name)")//p1.name===Optional("王大美女")
//print("p.name===\(p.name)")//p.name===Optional("李先生")

//Son 没有准守NSCopying，我们发现son并未实现深拷贝
//print("p.son.height===\(p.son?.height)")//p.son.height===Optional("162cm")
//print("p1.son.height===\(p1.son?.height)")//p1.son.height===Optional("162cm")

//我们可以看出此时的p1是p深拷贝出来的, 我们的Person类需要准守NSCopying 协议，实现copy(with zone: NSZone? = nil) 方法

//当我们的Son 也准守NSCopying时，打印如下
//print("p.son.height===\(p.son?.height)")//p.son.height===Optional("170cm")
//print("p1.son.height===\(p1.son?.height)")//p1.son.height===Optional("162cm")

//其实原型模式就是要求我们充分理解深拷贝和浅拷贝的区别，及怎样实现深拷贝和浅拷贝


class Person: NSObject, NSCopying {
    
    var name: String?
    var age: Int?
    
    init(name: String?, age: Int?) {
        self.name = name
        self.age = age
    }
    func copy(with zone: NSZone? = nil) -> Any {
        return Person(name: self.name, age: self.age)
    }
}
var pArray = [Person(name: "李先生1号", age: 11), Person(name: "李先生2号", age: 12), Person(name: "李先生3号", age: 13), Person(name: "李先生4号", age: 14)]

func deepCopy(array: [AnyObject]?) ->[AnyObject]? {
    guard let array = array else {
        return nil
    }
   return array.map { (item) -> AnyObject in
        if item is NSCopying {
            return (item as AnyObject).copy() as AnyObject
        } else {
            return item
        }
    }
}
//var p1Array = pArray
//p1Array[1].name = "王女士"
//print("p1Array.name\(p1Array[1].name)")//p1Array.nameOptional("王女士")
//print("pArray.name\(pArray[1].name)")//pArray.nameOptional("王女士")


var p1Array = deepCopy(array: pArray)
(p1Array?[1] as! Person).name = "王女士"
print("p1Array.name\((p1Array?[1] as! Person).name)")//p1Array.nameOptional("王女士")
print("pArray.name\(pArray[1].name)")//pArray.nameOptional("李先生2号")
//此时就实现数组里面的Person对象的深拷贝，注意此时的Person必须是NSObject类型






















