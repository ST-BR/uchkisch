import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)
    self.level = .floating;
      self.styleMask = [self.styleMask,  .fullSizeContentView, .unifiedTitleAndToolbar];
    // self.isFloatingPanel = true;
      // self.hidesOnDeactivate = true;
      self.collectionBehavior = [self.collectionBehavior, .canJoinAllSpaces]
    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true
    self.isMovableByWindowBackground = true
    self.isReleasedWhenClosed = false
    self.standardWindowButton(.closeButton)?.isHidden = true
    self.standardWindowButton(.miniaturizeButton)?.isHidden = true
    self.standardWindowButton(.zoomButton)?.isHidden = true

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
