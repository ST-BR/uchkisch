import Cocoa
import FlutterMacOS

class BlurryContainerViewController: NSViewController {
  let flutterViewController = FlutterViewController()

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  override func loadView() {
    let blurView = NSVisualEffectView()
    blurView.autoresizingMask = [.width, .height]
    blurView.blendingMode = .behindWindow
    blurView.state = .active
    if #available(macOS 10.14, *) {
        blurView.material = .sidebar
    }
    self.view = blurView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.addChild(flutterViewController)
    flutterViewController.view.frame = self.view.bounds
    flutterViewController.view.autoresizingMask = [.width, .height]
    self.view.addSubview(flutterViewController.view)
  }
}

class MainFlutterWindow: NSPanel {
  override func awakeFromNib() {
    let viewController = BlurryContainerViewController()
    let windowFrame = self.frame
    self.contentViewController = viewController
    self.setFrame(windowFrame, display: true)
    self.level = .floating;
    self.styleMask = [self.styleMask,  .fullSizeContentView, .unifiedTitleAndToolbar];
    self.collectionBehavior = [self.collectionBehavior, .canJoinAllSpaces]
    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true
    self.isMovableByWindowBackground = true
    self.isReleasedWhenClosed = false
    self.standardWindowButton(.closeButton)?.isHidden = true
    self.standardWindowButton(.miniaturizeButton)?.isHidden = true
    self.standardWindowButton(.zoomButton)?.isHidden = true
//    self.hidesOnDeactivate = true
    self.isFloatingPanel = true
      
      var channel = FlutterMethodChannel(name: "ru.stbr.uchkisch", binaryMessenger: viewController.flutterViewController.engine.binaryMessenger);
      channel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          if (call.method == "show") {
              self.makeKeyAndOrderFront(self)
              self.orderFrontRegardless()
              NSLog("SHOWW")
          }
          if (call.method == "hide") {
              NSApp.hide(nil)
              NSLog("HIDEE")
          }
      })

  RegisterGeneratedPlugins(registry: viewController.flutterViewController)

    super.awakeFromNib()
  }
    
  override var canBecomeKey: Bool {
    return true
  }

  override var canBecomeMain: Bool {
    return true
  }
}
