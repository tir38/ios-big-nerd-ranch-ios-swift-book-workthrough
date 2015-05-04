
import UIKit

class QuizViewController: UIViewController {


    @IBOutlet weak var questionLabel: UILabel! // implicitly unwrap
    @IBOutlet weak var answerLabel: UILabel!
    
    private let questions = [
        "What is your name?",
        "What is your quest?",
        "What is the air-speed velocity of an unladen swallow?"
    ]
    
    private let answers = [
        "It is Arthur, King of the Britons.",
        "To seek the Holy Grail.",
        "What do you mean?  An African or European swallow?"
    ]
    
    private var currentQuestionIndex: Int = 0
    
    @IBAction func questionButtonPressed(sender: UIButton) {
        currentQuestionIndex++
        currentQuestionIndex = (currentQuestionIndex % questions.count)
        println(currentQuestionIndex)
        
        let question = questions[currentQuestionIndex]
        questionLabel.text = question
    
        answerLabel.text = "???"
    }
    
    @IBAction func answerButtonPressed(sender: UIButton) {
        answerLabel.text = answers[currentQuestionIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = questions[0]
    }
}
