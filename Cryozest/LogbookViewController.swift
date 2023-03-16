import UIKit

class LogbookViewController: UITableViewController {

    var sessions = [Session]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
            navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! SessionTableViewCell
        let session = sessions[indexPath.row]

        cell.configureCell(session: session)

        return cell
    }

    struct Session {
        var date: String
        var duration: TimeInterval
        var temperature: Int
        var humidity: Int
    }

}

