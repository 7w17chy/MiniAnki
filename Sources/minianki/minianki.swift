import SwiftCrossUI

@main
struct CounterApp: App {
    let identifier = "de.thulis.MiniAnki"
    let windowProperties = WindowProperties(title: "MiniAnki")
    
    let vocabState = VocabularyState(deckPath: "/home/thulis/devel/minianki/test.txt")
    let score = ScoreState()
    
    var body: some ViewContent {
        VStack {
            HStack {
                Text("\(vocabState.currentLeft)")
                Text(" ?= ")
                Text("\(vocabState.currentRight)")
            }
            HStack {
                Button("Yes") {
                    if vocabState.checkCorrectAnswer() {
                        score.correctAnswerGiven()
                    } else {
                        score.wrongAnswerGiven()
                    }
                    vocabState.advance()
                }
                Button("No") {
                    if vocabState.checkWrongAnswer() {
                        score.correctAnswerGiven() 
                    } else {
                        score.wrongAnswerGiven()
                    }
                    vocabState.advance()
                }
            }
            HStack {
                Text("Correct answers: \(score.correctAnswers)")
                Text("Wrong answers: \(score.wrongAnswers)")
            }
        }
    }
}
