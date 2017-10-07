
import UIKit

class ViewController: UIViewController , SideBarDelegate {
    
    @IBOutlet weak var imageViewBg: UIImageView!
    var SideBar:SideBarObject = SideBarObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SideBar = SideBarObject(sourceView: self.view, menuItem: ["image 1","image 2","image 3","image 4","image 5"])
        SideBar.delegate = self
        
    }
    func SideBarDidSelectedButtonAtIndex(index: Int) {

        switch index {
        case 0: imageViewBg.image = UIImage(named: "img14")
        case 1: imageViewBg.image = UIImage(named: "img15")
        case 2: imageViewBg.image = UIImage(named: "img16")
        case 3: imageViewBg.image = UIImage(named: "img17")
        case 4: imageViewBg.image = UIImage(named: "img18")
        default:
            imageViewBg.image = UIImage(named: "img13")
        }
        
    }
    
    

}

