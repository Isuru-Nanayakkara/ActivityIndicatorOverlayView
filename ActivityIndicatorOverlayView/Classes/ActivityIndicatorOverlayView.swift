import UIKit

/// A simple overlay view
open class ActivityIndicatorOverlayView {
    // MARK: - Properities
    // MARK: Class Properties
    public static let shared = ActivityIndicatorOverlayView()
    
    // MARK: Instance Properties
    /// The view that covers the entire screen
    public var overlayView = UIView()
    /// The bounding box view for the activity indicator (`activityIndicator`)
    public var activityIndicatorBackgroundView = UIView()
    /// The activity indicator
    public var activityIndicator = UIActivityIndicatorView()
    
    /// The background color for `overlayView`
    public var overlayViewColor = UIColor.white.withAlphaComponent(0.3)
    /// The background color for the bounding box view of the activity indicator (`activityIndicatorBackgroundView`)
    public var activityIndicatorBackgroundColor = UIColor(red: 27.0/255.0, green: 27.0/255.0, blue: 27.0/255.0, alpha: 0.7)
    /// The color of the activity indicator
    public var activityIndicatorColor: UIColor = .white
    /// The size of the bounding box of the activity indicator (`containerView`)
    public var size: CGSize {
        // Sanity check the value
        didSet {
            if size.height < 0 {
                size.height = 0
            }
            
            if size.width < 0 {
                size.width = 0
            }
        }
    }
    
    /// The style of `activityIndicator`
    public var activityIndicatorStyle: UIActivityIndicatorView.Style = .large
    
    private var activeConstraints = [NSLayoutConstraint]()
    
    // MARK: - Initializer
    public init() {
        size = CGSize(width: 80, height: 80)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorBackgroundView.clipsToBounds = true
        activityIndicatorBackgroundView.layer.cornerRadius = 10
        activityIndicatorBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Display
    
    /// Adds the overlay view to the top most view
    open func show() {
        guard let topView = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController?.view else {
            return
        }
        
        overlayView.backgroundColor = overlayViewColor
        activityIndicatorBackgroundView.backgroundColor = activityIndicatorBackgroundColor
        activityIndicator.color = activityIndicatorColor
        activityIndicator.style = activityIndicatorStyle
        
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.addSubview(overlayView)
        activityIndicatorBackgroundView.addSubview(activityIndicator)
        overlayView.addSubview(activityIndicatorBackgroundView)
        
        activeConstraints = [
            overlayView.heightAnchor.constraint(equalTo: topView.heightAnchor),
            overlayView.widthAnchor.constraint(equalTo: topView.widthAnchor),
            overlayView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            overlayView.topAnchor.constraint(equalTo: topView.topAnchor),

            activityIndicatorBackgroundView.heightAnchor.constraint(equalToConstant: size.height),
            activityIndicatorBackgroundView.widthAnchor.constraint(equalToConstant: size.width),
            activityIndicatorBackgroundView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            activityIndicatorBackgroundView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),

            activityIndicator.heightAnchor.constraint(equalToConstant: size.height),
            activityIndicator.widthAnchor.constraint(equalToConstant: size.width),
            activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorBackgroundView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorBackgroundView.centerXAnchor)
        ]
        
        for constraint in activeConstraints {
            constraint.isActive = true
        }
        
        activityIndicator.startAnimating()
    }
    
    /// Hides the overlay view from their superview
    open func hide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.overlayView.removeFromSuperview()
            for constraint in self.activeConstraints {
                constraint.isActive = false
            }
            self.activeConstraints.removeAll()
        }
    }
}
