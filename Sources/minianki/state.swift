import SwiftCrossUI

class VocabularyState: AppState {
    let deck: Deck
    @Observed var currentLeft: String = ""
    @Observed var currentRight: String = ""

    func advance() {
        let (l, r) = self.deck.next
        self.currentLeft = l
        self.currentRight = r
    }

    // returns true if the given vocab equals it's correct translation
    func checkCorrectAnswer() -> Bool {
        let correctAnswer = deck.vocabulary[self.currentLeft]
        return correctAnswer == self.currentRight
    }

    // returns true if the given vocab doesn't equal it's correct translation
    func checkWrongAnswer() -> Bool {
        return !self.checkCorrectAnswer()
    }

    init(deckPath: String) {
        self.deck = Deck(path: deckPath)!
        advance()
    }
}

class ScoreState: AppState {
    @Observed var correctAnswers: Int = 0
    @Observed var wrongAnswers: Int = 0

    func correctAnswerGiven() {
        self.correctAnswers += 1
    }

    func wrongAnswerGiven() {
        self.wrongAnswers += 1
    }
}
