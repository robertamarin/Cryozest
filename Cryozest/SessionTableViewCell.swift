import UIKit

class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionLabel: UILabel!

    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
        }

        func configureCell(session: LogbookViewController.Session) {
            let durationMinutes = Int(session.duration) / 60
            let durationSeconds = Int(session.duration) % 60
            sessionLabel.text = "Date: \(session.date), Duration: \(String(format: "%02d:%02d", durationMinutes, durationSeconds)), Temperature: \(session.temperature)°C, Humidity: \(session.humidity)%"
        }
    }
