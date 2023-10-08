import UIKit

print("--------------- First Task - Library ---------------")
print()
/*
 შევქმნათ Class Book.
 Properties: bookID(უნიკალური იდენტიფიკატორი Int), String title, String author, Bool isBorrowed.
 Designated Init.
 Method რომელიც ნიშნავს წიგნს როგორც borrowed-ს.
 Method რომელიც ნიშნავს წიგნს როგორც დაბრუნებულს.
 */

class Book {
    let bookID: Int
    let title: String
    let author: String
    var isBorrowed: Bool
    
    init(bookID: Int, title: String, author: String, isBorrowed: Bool) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    
    func markAsBorrowed() {
        if !isBorrowed {
            isBorrowed = true
            print("The book \(title) is being borrowed")
        } else {
            print("The book \(title) was already borrowed")
        }
    }
    
    func markAsReturned() {
        if isBorrowed {
            isBorrowed = false
            print("The book \(title) is being returned")
        } else {
            print("The book \(title) was already returned")
        }
    }
}

/*
 შევქმნათ Class Owner
 Properties: ownerId(უნიკალური იდენტიფიკატორი Int), String name, Books Array სახელით borrowedBooks.
 Designated Init.
 Method რომელიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
 Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი.
 */

class Owner {
    let ownerID: Int
    let name: String
    var borrowedBooks: [Book]
    
    init(ownerID: Int, name: String) {
        self.ownerID = ownerID
        self.name = name
        self.borrowedBooks = []
    }
    
    func borrowBook(_ book: Book) {
        if !book.isBorrowed {
            book.markAsBorrowed()
            borrowedBooks.append(book)
            print("\(name) has borrowed book \(book.title)")
        } else {
            print("Book \(book.title) was already borrowed")
        }
    }
    
    func returnBook(_ book: Book) {
        if borrowedBooks.contains(where: { $0 === book }) {
            book.markAsReturned()
            borrowedBooks.removeAll { $0 === book }
            print("\(name) has returned book \(book.title)")
        } else {
            print("\(name) did not borrow book \(book.title)")
        }
    }
}

/*
 შევქმნათ Class Library
 Properties: Books Array, Owners Array.
 Designated Init.
 Method წიგნის დამატება, რათა ჩვენი ბიბლიოთეკა შევავსოთ წიგნებით.
 Method რომელიც ბიბლიოთეკაში ამატებს Owner-ს.
 Method რომელიც პოულობს და აბრუნებს ყველა ხელმისაწვდომ წიგნს.
 Method რომელიც პოულობს და აბრუნებს ყველა წაღებულ წიგნს.
 Method რომელიც ეძებს Owner-ს თავისი აიდით თუ ეგეთი არსებობს.
 Method რომელიც ეძებს წაღებულ წიგნებს კონკრეტული Owner-ის მიერ.
 Method რომელიც აძლევს უფლებას Owner-ს წააღებინოს წიგნი თუ ის თავისუფალია.
 */

class Library {
    var booksArray: [Book]
    var ownersArray: [Owner]
    
    init() {
        self.booksArray = []
        self.ownersArray = []
    }
    
    func addBook(_ book: Book) {
        booksArray.append(book)
    }
    
    func addOwner(_ owner: Owner) {
        ownersArray.append(owner)
    }
    
    func getAvalaibleBooks() -> [Book] {
        booksArray.filter { $0.isBorrowed == false}
    }
    
    func getBorrowedBooks() -> [Book] {
        booksArray.filter { $0.isBorrowed == true}
    }
    
    func findOwner(ownerID: Int) -> Owner? {
        ownersArray.first { $0.ownerID == ownerID }
    }
    
    func getBorrowedBooksByOwner(_ owner: Owner) -> [Book] {
        return booksArray.filter { book in
            return book.isBorrowed && owner.borrowedBooks.contains { $0 === book }
        }
    }
    
    func borrowBookFromLibrary(_ owner: Owner, _ book: Book) {
        if book.isBorrowed {
            print("\(book.title) is already borrowed.")
        } else {
            owner.borrowBook(book)
        }
    }
    
    func returnBookBack(_ owner: Owner, _ book: Book) {
        if !book.isBorrowed {
            print("\(book.title) is not borrowed.")
        } else {
            owner.returnBook(book)
        }
    }
}

/*
 გავაკეთოთ ბიბლიოთეკის სიმულაცია.
 შევქმნათ რამოდენიმე წიგნი და რამოდენიმე Owner-ი, შევქმნათ ბიბლიოთეკა.
 დავამატოთ წიგნები და Owner-ები ბიბლიოთეკაში
 წავაღებინოთ Owner-ებს წიგნები და დავაბრუნებინოთ რაღაც ნაწილი.
 დავბეჭდოთ ინფორმაცია ბიბლიოთეკიდან წაღებულ წიგნებზე, ხელმისაწვდომ წიგნებზე და გამოვიტანოთ
 წაღებული წიგნები კონკრეტულად ერთი Owner-ის მიერ.
 */

let firstBook = Book(bookID: 001,
                     title: "Hamlet",
                     author: "William Shakespeare",
                     isBorrowed: false)

let secondBook = Book(bookID: 002,
                      title: "Odyssey",
                      author: "Homer",
                      isBorrowed: true)

let thirdBook = Book(bookID: 003,
                     title: "The Trial",
                     author: "Franz Kafka",
                     isBorrowed: false)

let fourthBook = Book(bookID: 004,
                      title: "The Stranger",
                      author: "Albert Camus",
                      isBorrowed: false)


let firstOwner = Owner(ownerID: 001, name: "Jon Jones")
let secondOwner = Owner(ownerID: 002, name: "Israel Adesanya")
let thirdOwner = Owner(ownerID: 003, name: "Conor McGregor")

var myLibrary = Library()

myLibrary.booksArray.append(firstBook)
myLibrary.booksArray.append(secondBook)
myLibrary.booksArray.append(thirdBook)

myLibrary.ownersArray.append(firstOwner)
myLibrary.ownersArray.append(secondOwner)
myLibrary.ownersArray.append(thirdOwner)

myLibrary.borrowBookFromLibrary(secondOwner, firstBook)
myLibrary.borrowBookFromLibrary(firstOwner, fourthBook)
myLibrary.borrowBookFromLibrary(thirdOwner, thirdBook)

let borrowedBooks = myLibrary.getBorrowedBooks()
print()
print("Borrowed Books:")

for book in borrowedBooks {
    print(("\(book.title) by \(book.author)"))
}

myLibrary.returnBookBack(secondOwner, firstBook)

let availableBooks = myLibrary.getAvalaibleBooks()
print()
print("Available Books:")

for book in availableBooks {
    print("\(book.title) by \(book.author)")
}

print()
print("Owner is \(myLibrary.findOwner(ownerID: 009)?.name ?? "Not Found")")
// Finding Owner by ownerID

var borrowedByOwner = myLibrary.getBorrowedBooksByOwner(thirdOwner)

for book in borrowedByOwner {
    print("\(book.title) was borrowed by \(thirdOwner.name)") // Books that are borrowed by owner
}

print()
print("--------------- Second Task - E-commerce Platform ---------------")
print()

/*
 შევქმნათ Class Product,
 შევქმნათ შემდეგი properties productID (უნიკალური იდენტიფიკატორი Int), String name, Double price.
 შევქმნათ Designated Init.
 */

class Product {
    let productID: Int
    let name: String
    var price: Double
    
    init(productID: Int, name: String, price: Double) {
        self.productID = productID
        self.name = name
        self.price = price
    }
}

/*
 შევქმნათ Class Cart
 Properties: cartID(უნიკალური იდენტიფიკატორი Int), Product-ების Array სახელად items.
 შევქმნათ Designated Init.
 Method იმისათვის რომ ჩვენს კალათაში დავამატოთ პროდუქტი.
 Method იმისათვის რომ ჩვენი კალათიდან წავშალოთ პროდუქტი მისი აიდით.
 Method რომელიც დაგვითვლის ფასს ყველა იმ არსებული პროდუქტის რომელიც ჩვენს კალათაშია.
 */

class Cart {
    let cartID: Int
    var items: [Product]
    
    init(cartID: Int) {
        self.cartID = cartID
        self.items = []
    }
    
    func addItem(_ item: Product) {
        items.append(item)
    }
    
    func removeItem(_ productID: Int) {
        items.removeAll(where: { $0.productID == productID })
    }
    
    func calculateSum() -> Double {
        items.map { $0.price }.reduce(0, +)
    }
}

/*
 შევქმნათ Class User
 Properties: userID(უნიკალური იდენტიფიკატორი Int), String username, Cart cart.
 Designated Init.
 Method რომელიც კალათაში ამატებს პროდუქტს.
 Method რომელიც კალათიდან უშლის პროდუქტს.
 Method რომელიც checkout (გადახდის)  იმიტაციას გააკეთებს დაგვითვლის თანხას და გაასუფთავებს ჩვენს shopping cart-ს.
 */

class User {
    let userID: Int
    let userName: String
    let cart: Cart
    
    init(userID: Int, userName: String) {
        self.cart = Cart(cartID: userID)
        self.userID = userID
        self.userName = userName
    }
    
    func addItemToCart(_ item: Product) {
        cart.addItem(item)
    }
    
    func removeItemFromCart(_ productID: Int) {
        cart.removeItem(productID)
    }
    
    func checkOut() -> Double {
        let totalPrice = cart.calculateSum()
        print("Thank you, \(userName), for your purchase! " +
              "The total amount paid: $\(totalPrice)")
        cart.items.removeAll()
        return totalPrice
    }
}

/*
 გავაკეთოთ იმიტაცია და ვამუშაოთ ჩვენი ობიექტები ერთად.
 შევქმნათ რამოდენიმე პროდუქტი.
 შევქმნათ 2 user-ი, თავისი კალათებით,
 დავუმატოთ ამ იუზერებს კალათებში სხვადასხვა პროდუქტები,
 დავბეჭდოთ price ყველა item-ის ამ იუზერების კალათიდან.
 და ბოლოს გავაკეთოთ სიმულაცია ჩექაუთის, დავაბეჭდინოთ იუზერების გადასხდელი თანხა და გავუსუფთაოთ კალათები.
 */

let firstProduct = Product(productID: 001, name: "Coca-Cola", price: 1.6)
let secondProduct = Product(productID: 002, name: "Fanta", price: 1.5)
let thirdProduct = Product(productID: 003, name: "Pepsi", price: 1.4)
let fourthProduct = Product(productID: 004, name: "Red-Bull", price: 3.5)
let fifthProduct = Product(productID: 005, name: "Sandora", price: 4.0)


let firstUser = User(userID: 001, userName: "Jon Jones")
let secondUser = User(userID: 002, userName: "Charles Oliveira")

firstUser.addItemToCart(secondProduct)
secondUser.addItemToCart(fifthProduct)
secondUser.addItemToCart(secondProduct)
secondUser.addItemToCart(firstProduct)

let totalPriceForFirstUser = firstUser.cart.calculateSum()
print("\(firstUser.userName), the total price of " +
      "your items is $\(totalPriceForFirstUser)")

let totalPriceForSecondUser = secondUser.cart.calculateSum()
print("\(secondUser.userName), the total price of " +
      "your items is $\(totalPriceForSecondUser)")

secondUser.removeItemFromCart(005) // Removing Item from cart
let priceAfterRemoving = secondUser.cart.calculateSum()
print("\(secondUser.userName), total price in cart after " +
      "removing an item is $\(priceAfterRemoving)")

firstUser.checkOut()
secondUser.checkOut()
