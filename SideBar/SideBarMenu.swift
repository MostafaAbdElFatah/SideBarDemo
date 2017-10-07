

import UIKit

protocol SidarBarTableViewControllerDelegate{
    func siderBarControllDidSelectedRow(indexPath:NSIndexPath)
}

class SideBarMenu: UITableViewController {
    
    var delegate:SidarBarTableViewControllerDelegate?
    var tableData:Array<String> = []
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.siderBarControllDidSelectedRow(indexPath)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkTextColor()
            let selectedView:UIView = UIView(frame:CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            cell!.selectedBackgroundView = selectedView
        }
        cell!.textLabel?.text = self.tableData[indexPath.row]
        return cell!
    }
}
