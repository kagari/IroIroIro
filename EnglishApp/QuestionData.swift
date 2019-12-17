import Foundation

// お題や使用した英単語を保持するクラス
class QuestionData {
    let questions: [String]
    var question: String?
    var usedTextList: [String]
    var alphabet: Character?
    
    init() {
        
        self.questions = ["Cat", "Dog", "Phone", "Person", "Apple", "Egg", "Fish", "Fire", "Gum", "Clock", "Orange", "Onion", "Milk", "Melon", "Salt" , "Tea", "Water"]
        self.question = questions.randomElement()
        self.usedTextList = []
    }
    
    // MARK: - setter, getter
    func addUsedText(usedText: String?) {
        guard let usedText = usedText else {
            print("usedText is nil...")
            return
        }
        self.usedTextList.append(usedText)
    }
    
    func getUsedTextList() -> [String] {
        return self.usedTextList
    }
    
    func getQuestion() -> String? {
        return self.question
    }
}
