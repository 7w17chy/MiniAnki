import Foundation

class Deck {
    var vocabulary: [String:String] = [:]
    
    var next: (l: String, r: String) {
        return (
          l: vocabulary.keys.randomElement()!,
          r: vocabulary.values.randomElement()!
        )
    }

    init?(path: String) {
        let data: Data
        do {
            data = try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            print("unable to open file containing deck data")
            return nil
        }

        // FIXME cleanup required, there must be a nicer, more readable way to achieve this!
        /* The data format is as follows:
         *    vocab,translation;vocab2,translation2;vocabN,translationN
         * So we first split it into Vocab-Translation pairs (fst map) and further split those
         * into sublists (scnd map), decompose the sublist and add it to a dictionary:
         *    [vocab:translation]
         */
        let parsed: [String:String] =
          String(data: data, encoding: String.Encoding.utf8)!
          .split(separator: ";").map { String($0) }
          .map { $0.split(separator: ",") }
          .map { sublist in sublist.map { String($0) } } // [[String]]
          .reduce(into: [:]) { accumulator, sublist in
              // decompose sublist
              let vocab: String = sublist[0]
              let transl: String = sublist[1]
              accumulator[vocab] = transl
          }
        self.vocabulary = parsed
    }
}
