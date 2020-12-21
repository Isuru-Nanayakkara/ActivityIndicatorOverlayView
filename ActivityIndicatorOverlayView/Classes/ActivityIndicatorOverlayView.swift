import UIKit

/// A simple overlay view
open class ActivityIndicatorOverlayView {
    // MARK: - Properities
    // MARK: Class Properties
    public static let shared = ActivityIndicatorOverlayView()
    
    // MARK: Instance Properties
    /// The background view
    public var backgroundView = UIView()
    /// The bounding box for the activity indicator (`activityIndicator`)
    public var containerView = UIView()
    /// The activity indicator
    public var activityIndicator = UIActivityIndicatorView()

    /// The background color for `backgroundView`
    public var backgroundColor = UIColor.white.withAlphaComponent(0.3)
    /// The background color for the bounding box of the activity indicator (`containerView`)
    public var forgroundColor = UIColor(red: 27.0/255.0, green: 27.0/255.0, blue: 27.0/255.0, alpha: 0.7)
    /// The color of the activity indicator
    public var color: UIColor = .white
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
    public var activityStyle: UIActivityIndicatorView.Style = .large
    
    private var activeConstraints = [NSLayoutConstraint]()
    
    // MARK: - Initializer
    public init() {
        size = CGSize(width: 80, height: 80)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Display
    
    /// Adds the overlay view to the top most view
    open func show() {
        guard let topView = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController?.view else {
            return
        }
        
        backgroundView.backgroundColor = backgroundColor
        containerView.backgroundColor = forgroundColor
        activityIndicator.color = color
        activityIndicator.style = activityStyle
        
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.addSubview(backgroundView)
        containerView.addSubview(activityIndicator)
        backgroundView.addSubview(containerView)
        
        activeConstraints = [
            backgroundView.heightAnchor.constraint(equalTo: topView.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: topView.widthAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topView.topAnchor),

            containerView.heightAnchor.constraint(equalToConstant: size.height),
            containerView.widthAnchor.constraint(equalToConstant: size.width),
            containerView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),

            activityIndicator.heightAnchor.constraint(equalToConstant: size.height),
            activityIndicator.widthAnchor.constraint(equalToConstant: size.width),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
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
            self.backgroundView.removeFromSuperview()
            for constraint in self.activeConstraints {
                constraint.isActive = false
            }
            self.activeConstraints.removeAll()
        }
    }
}
