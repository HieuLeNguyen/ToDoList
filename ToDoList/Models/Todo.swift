import UIKit

enum TodoTypes {
    case new
    case inprogress
    case completed
}

struct TodoItem {
    var title: String
    var description: String
    var duration: TimeInterval?
    var image: UIImage?
    var isSelected: Bool = false
    var type: TodoTypes
}

extension TimeInterval {
    func formattedDuration() -> String {
        let hours = Int(self) / 3600
        let minutes = (Int(self) % 3600) / 60
        
        if hours > 0 {
            return String(format: "%dh %dm", hours, minutes)
        } else {
            return String(format: "%dm", minutes)
        }
    }
}


