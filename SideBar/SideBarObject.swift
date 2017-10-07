

import UIKit

@objc protocol SideBarDelegate{
    func SideBarDidSelectedButtonAtIndex(index:Int)
    optional func SideBarWillClose()
    optional func SideBarWillOpen()
}

class SideBarObject: NSObject , SidarBarTableViewControllerDelegate {
    
    let barWidth:CGFloat = 250.0
    let sideBarTableViewTopInsert:CGFloat = 64.0
    let sideBarContainerView:UIView = UIView()
    let sideBarTableViewController:SideBarMenu = SideBarMenu()
    var originView:UIView!
    
    var animator:UIDynamicAnimator!
    var delegate:SideBarDelegate?
    var isSideBarOpen:Bool = false
    
    override init() {
        super.init()
    }
    
    init(sourceView:UIView , menuItem:Array<String>) {
        super.init()
        self.originView = sourceView
        sideBarTableViewController.tableData = menuItem
        
        self.setupSideBar()
        
        self.animator = UIDynamicAnimator(referenceView: self.originView)
        let ShowGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        ShowGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        originView.addGestureRecognizer(ShowGestureRecognizer)
        let hideGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        originView.addGestureRecognizer(hideGestureRecognizer)
        
        
    }
    
    func handleSwipe(recognizer:UISwipeGestureRecognizer){
        if recognizer.direction == UISwipeGestureRecognizerDirection.Left {
            self.showSideBar(false)
            delegate?.SideBarWillClose?()
        }else if recognizer.direction == UISwipeGestureRecognizerDirection.Right {
            self.showSideBar(true)
            delegate?.SideBarWillOpen?()
        }
    }
    
    func showSideBar(shoudOpen:Bool){
        
        animator.removeAllBehaviors()
        isSideBarOpen = shoudOpen
        let gravityX:CGFloat  = (shoudOpen) ? 0.5 : -0.5
        let magnitude:CGFloat = (shoudOpen) ? 28  : -28
        let boundaryX:CGFloat  = (shoudOpen) ? barWidth  : -barWidth - 1
        let gravityBehavior:UIGravityBehavior =  UIGravityBehavior(items: [sideBarContainerView])
        gravityBehavior.gravityDirection = CGVectorMake(gravityX, 0)
        animator.addBehavior(gravityBehavior)
        
        let CollisionBehavior:UICollisionBehavior = UICollisionBehavior(items: [sideBarContainerView])
        CollisionBehavior.addBoundaryWithIdentifier("sideBarboundary", fromPoint: CGPointMake(boundaryX, 20), toPoint: CGPointMake(boundaryX, originView.frame.size.height))
        animator.addBehavior(CollisionBehavior)
        let pushBehavior:UIPushBehavior = UIPushBehavior(items: [sideBarContainerView], mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.magnitude = magnitude
        animator.addBehavior(pushBehavior)
        let sideBarBehavior:UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sideBarContainerView])
        sideBarBehavior.elasticity = 0.3
        animator.addBehavior(sideBarBehavior)
        
    }
    
    func setupSideBar(){
        
        self.sideBarContainerView.frame = CGRectMake(-barWidth - 1, originView.frame.origin.y, barWidth, originView.frame.size.height)
        sideBarContainerView.backgroundColor = UIColor.clearColor()
        sideBarContainerView.clipsToBounds = false
        originView.addSubview(sideBarContainerView)
        let blurView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        blurView.frame = sideBarContainerView.bounds
        sideBarContainerView.addSubview(blurView)
        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.frame = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds = false
        sideBarTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        sideBarTableViewController.tableView.backgroundColor = UIColor.clearColor()
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.contentInset = UIEdgeInsetsMake(sideBarTableViewTopInsert, 0, 0, 0)
        sideBarTableViewController.tableView.reloadData()
        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
        
    }
    
    
    
    func siderBarControllDidSelectedRow(indexPath: NSIndexPath) {
        delegate?.SideBarDidSelectedButtonAtIndex(indexPath.row)
    }
    
    
}
