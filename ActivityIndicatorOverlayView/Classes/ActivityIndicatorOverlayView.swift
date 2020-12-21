import UIKit

/// A simple progress view
open class ActivityIndicatorOverlayView {
    // MARK: - Properities
    // MARK: Class Properties
    public static let shared = ActivityIndicatorOverlayView()
    
    // MARK: Instance Properties
    /// The background view
    public var containerView = UIView()
    /// The bounding box for the activity indicator (`activityIndicator`)
    public var progressView = UIView()
    /// The activity indicator
    public var activityIndicator = UIActivityIndicatorView()

    /// The background color for `containerView`
    public var backgroundColor = UIColor.white.withAlphaComponent(0.3)
    /// The background color for the bounding box of the activity indicator (`progressView`)
    public var forgroundColor = UIColor(red: 27.0/255.0, green: 27.0/255.0, blue: 27.0/255.0, alpha: 0.7)
    /// The color of the activity indicator
    public var color: UIColor = .white
    /// The size of the bounding box of the activity indicator (`progressView`)
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
        containerView.translatesAutoresizingMaskIntoConstraints = false
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        progressView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Display
    
    /// Adds the progress views to the top most view
    open func showProgressView() {
        guard let topView = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController?.view else {
            return
        }
        
        containerView.backgroundColor = backgroundColor
        progressView.backgroundColor = forgroundColor
        activityIndicator.color = color
        activityIndicator.style = activityStyle
        
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.addSubview(containerView)
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        
        activeConstraints = [
            containerView.heightAnchor.constraint(equalTo: topView.heightAnchor),
            containerView.widthAnchor.constraint(equalTo: topView.widthAnchor),
            containerView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topView.topAnchor),

            progressView.heightAnchor.constraint(equalToConstant: size.height),
            progressView.widthAnchor.constraint(equalToConstant: size.width),
            progressView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            progressView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            activityIndicator.heightAnchor.constraint(equalToConstant: size.height),
            activityIndicator.widthAnchor.constraint(equalToConstant: size.width),
            activityIndicator.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: progressView.centerXAnchor)
        ]
        
        for constraint in activeConstraints {
            constraint.isActive = true
        }
        
        activityIndicator.startAnimating()
    }
    
    /// Hides the progress views from their superview
    open func hideProgressView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.containerView.removeFromSuperview()
            for constraint in self.activeConstraints {
                constraint.isActive = false
            }
            self.activeConstraints.removeAll()
        }
    }
}
