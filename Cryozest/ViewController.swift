import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var humidityTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!

    var timer: Timer?
    var timerDuration: TimeInterval = 0
    var timerStartDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startStopButtonPressed(_ sender: UIButton) {
        if timer == nil {
            // Start the timer
            timerStartDate = Date()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.timerDuration += 1
                let minutes = Int(self.timerDuration) / 60
                let seconds = Int(self.timerDuration) % 60
                self.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
            }
            sender.setTitle("Stop", for: .normal)
        } else {
            // Stop the timer
            timer?.invalidate()
            timer = nil
            timerStartDate = nil
            sender.setTitle("Start", for: .normal)
        }
    }

    @IBAction func logSessionButtonPressed(_ sender: UIButton) {
        guard let temperatureString = temperatureTextField.text,
              let temperature = Double(temperatureString),
              let humidityString = humidityTextField.text,
              let humidity = Double(humidityString)
        else {
            showAlert(title: "Invalid Input", message: "Please enter valid numerical values for temperature and humidity.")
            return
        }

        if temperature < -89.2 || temperature > 58 {
            showAlert(title: "Invalid Input", message: "Please enter a temperature value within Earth's limits.")
            return
        }

        if humidity < 0 || humidity > 100 {
            showAlert(title: "Invalid Input", message: "Please enter a humidity value within Earth's limits.")
            return
        }

        // Create a session object with the input data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let session = LogbookViewController.Session(date: dateFormatter.string(from: Date()), duration: timerDuration, temperature: Int(temperature), humidity: Int(humidity))

        // Perform the segue to show the LogbookViewController
        performSegue(withIdentifier: "showLogbook", sender: session)
    }

    @IBAction func viewLogbookButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showLogbook", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLogbook",
           let logbookVC = segue.destination as? LogbookViewController {
            if let session = sender as? LogbookViewController.Session {
                logbookVC.sessions.append(session)
                logbookVC.tableView.reloadData()
            }
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

