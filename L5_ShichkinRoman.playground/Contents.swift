//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также методы действий.
//
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//
//6. Вывести сами объекты в консоль.

import Foundation

enum Action {
    case startEngine
    case stopEngine
    case openWindows
    case closeWindows
    case putInTheTrunk(volume: Decimal)
    case unloadFromTheTrunk(volume: Decimal)
    case roof
    case somethingForTrunk
}


protocol Car: class {
    var brandCar: String { get }
    var yearOfIssue: Int { get }
    var trunkVolume: Decimal { get }
    var engineStarted: Bool { get set }
    var windowsAreOpen: Bool { get set }
    var filledTrunkVolume: Decimal { get set }
    
    func engine() -> Void
    func window() -> Void
    func putInTheTrunk(volume: Decimal) -> Void
    func unloadFromTheTrunk(volume: Decimal) -> Void
}

extension Car {
    func engine() -> Void {
        if engineStarted == true {
            engineStarted = false
            print("Двигатель остановлен")
        } else {
            engineStarted = true
            print("Двигатель запущен")
        }
    }
    
    func window() -> Void {
        if windowsAreOpen == true {
            windowsAreOpen = false
            print("Окна закрыты")
        } else {
            windowsAreOpen = true
            print("Окна открыты")
        }
    }
    
    func putInTheTrunk(volume: Decimal) -> Void {
        if volume <= (trunkVolume - filledTrunkVolume) {
            filledTrunkVolume += volume
            print("В багажнк загружен объём \(volume). Общая загруженность: \(filledTrunkVolume) из \(trunkVolume)")
        } else {
            print("В багажник объём \(volume) не вместится. Доступный свободный объём: \(trunkVolume - filledTrunkVolume)")
        }
    }
    
    func unloadFromTheTrunk(volume: Decimal) -> Void {
        if volume > filledTrunkVolume {
            print("Из багажника нельзя выгрузить объём \(volume)! Доступно: \(filledTrunkVolume) из \(trunkVolume)")
        } else {
            filledTrunkVolume -= volume
            print("Объём \(volume) выгружен из багажника. Осталось: \(filledTrunkVolume) из \(trunkVolume)")
        }
    }
}

class SportCar: Car {
    var brandCar: String
    var yearOfIssue: Int
    var trunkVolume: Decimal
    var engineStarted: Bool
    var windowsAreOpen: Bool
    var filledTrunkVolume: Decimal
    let isCabriolet: Bool
    var roofIsOpen: Bool
    let from0To100: Decimal

    //инициализатор для кабриолета
    init(brandCar: String, yearOfIssue: Int, trunkVolume: Decimal, engineStarted: Bool, windowsAreOpen: Bool, filledTrunkVolume: Decimal, roofIsOpen: Bool, from0To100: Decimal) {
        self.isCabriolet = true
        self.roofIsOpen = roofIsOpen
        self.from0To100 = from0To100
        self.brandCar = brandCar
        self.yearOfIssue = yearOfIssue
        self.trunkVolume = trunkVolume
        self.engineStarted = engineStarted
        self.windowsAreOpen = windowsAreOpen
        if filledTrunkVolume >= self.trunkVolume {
            self.filledTrunkVolume = trunkVolume
        } else {
            self.filledTrunkVolume = filledTrunkVolume
        }
    }
    
    //инициализатр для некабриолета
    init(brandCar: String, yearOfIssue: Int, trunkVolume: Decimal, engineStarted: Bool, windowsAreOpen: Bool, filledTrunkVolume: Decimal, from0To100: Decimal) {
        self.isCabriolet = false
        self.roofIsOpen = false
        self.from0To100 = from0To100
        self.brandCar = brandCar
        self.yearOfIssue = yearOfIssue
        self.trunkVolume = trunkVolume
        self.engineStarted = engineStarted
        self.windowsAreOpen = windowsAreOpen
        if filledTrunkVolume >= self.trunkVolume {
            self.filledTrunkVolume = trunkVolume
        } else {
            self.filledTrunkVolume = filledTrunkVolume
        }
    }
    
    func roof() -> Void {
        if isCabriolet == true {
            if roofIsOpen == true {
                roofIsOpen = false
                print("Крыша закрывается")
            } else {
                roofIsOpen = true
                print("Крыша открывается")
            }
        } else {
            print("Автомобиль не кабриолет. Открыть/закрыть крышу нельзя.")
        }
    }
    
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return """
            =======================================
            Марка авто: \(self.brandCar)
            Год выпуска: \(self.yearOfIssue)
            Загрузка багажника: \(self.filledTrunkVolume) из \(self.trunkVolume)
            Каблиолет: \(self.isCabriolet ? ("Да\nПоложение крыши: \(self.roofIsOpen ? "Открыта" : "Закрыта")") : "Нет")
            Состояние двигателя: \(self.engineStarted ? "Запущен" : "Остановлен")
            Положение окон: \(self.windowsAreOpen ? "Открыты" : "Закрыты")
            Разгон от 0 до 100 км/ч (сек): \(self.from0To100)
            =======================================
            """
    }
}

var ferrari = SportCar.init(
    brandCar: "Ferrari",
    yearOfIssue: 2018,
    trunkVolume: 50,
    engineStarted: true,
    windowsAreOpen: false,
    filledTrunkVolume: 10,
    roofIsOpen: true,
    from0To100: 4.5
)

print(ferrari)
ferrari.roof()
ferrari.putInTheTrunk(volume: 100)
ferrari.putInTheTrunk(volume: 20)
ferrari.unloadFromTheTrunk(volume: 10)
ferrari.engine()
ferrari.window()
print(ferrari)

var nissan = SportCar.init(
    brandCar: "Nissan",
    yearOfIssue: 2000,
    trunkVolume: 150,
    engineStarted: false,
    windowsAreOpen: false,
    filledTrunkVolume: 170000,
    from0To100: 10
)

print(nissan)
nissan.roof()

//-----------------TrunkCar-----------------

class TrunkCar: Car {
    var brandCar: String
    var yearOfIssue: Int
    var trunkVolume: Decimal
    var engineStarted: Bool
    var windowsAreOpen: Bool
    var filledTrunkVolume: Decimal
    var truckBody: Bool
    
    init(brandCar: String, yearOfIssue: Int, trunkVolume: Decimal, engineStarted: Bool, windowsAreOpen: Bool, filledTrunkVolume: Decimal, truckBody: Bool) {
        self.truckBody = truckBody
        self.brandCar = brandCar
        self.yearOfIssue = yearOfIssue
        self.trunkVolume = trunkVolume
        self.engineStarted = engineStarted
        self.windowsAreOpen = windowsAreOpen
        if filledTrunkVolume >= self.trunkVolume {
            self.filledTrunkVolume = trunkVolume
        } else {
            self.filledTrunkVolume = filledTrunkVolume
        }
    }
    
    func trunkBodyMove() -> Void {
        if truckBody == true {
            truckBody = false
            print("Кузов опущен")
        } else {
            truckBody = true
            print("Кузов поднят")
        }
    }
    
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
            =======================================
            Марка авто: \(self.brandCar)
            Год выпуска: \(self.yearOfIssue)
            Загрузка багажника: \(self.filledTrunkVolume) из \(self.trunkVolume)
            Положение кузова грузовика: \(self.truckBody ? "Поднят" : "Опущен")
            Состояние двигателя: \(self.engineStarted ? "Запущен" : "Остановлен")
            Положение окон: \(self.windowsAreOpen ? "Открыты" : "Закрыты")
            =======================================
            """
    }
}

var truck = TrunkCar.init(
        brandCar: "Volvo",
        yearOfIssue: 2020,
        trunkVolume: 20000,
        engineStarted: false,
        windowsAreOpen: true,
        filledTrunkVolume: 1000,
        truckBody: true
)

print(truck)
truck.engine()
truck.unloadFromTheTrunk(volume: 15000)
truck.putInTheTrunk(volume: 17000)
truck.putInTheTrunk(volume: 150000)
truck.unloadFromTheTrunk(volume: 3500.5)
truck.window()
truck.trunkBodyMove()
print(truck)
