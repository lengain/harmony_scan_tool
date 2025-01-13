import Cocoa
import FlutterMacOS
import app_selector

class MainFlutterWindow: NSWindow, NSDraggingDestination {
    override func awakeFromNib() {
        let flutterViewController = MNFlutterMainViewController()
        flutterViewController.backgroundColor = NSColor.white
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)

        RegisterGeneratedPlugins(registry: flutterViewController)
        AppSelectorPlugin.register(with: flutterViewController.registrar(forPlugin: "AppSelectorPlugin"), delegate: MNPluginManager.shared())

        // 开启嗅探拖拽文件类型
        registerForDraggedTypes([.fileURL])
        
        // 获取 FlutterBinaryMessenger，通常可以通过 FlutterViewController 获取
        let messenger = flutterViewController.engine.binaryMessenger
        // 创建 FlutterMethodChannel
        let channel = FlutterMethodChannel(name: "com.lengain.htool", binaryMessenger: messenger)
        MNDartManager.shared().flutterMethodChannel = channel
        super.awakeFromNib()
        
        // 检查是否已授予完全磁盘访问权限
//        if #available(macOS 10.15, *) {
//            let hasFullDiskAccess = FileManager.default.hasFullDiskAccess()
//            if !hasFullDiskAccess {
//                // 请求完全磁盘访问权限
//                let openPanel = NSOpenPanel()
//                openPanel.canChooseFiles = false
//                openPanel.canChooseDirectories = false
//                openPanel.allowsMultipleSelection = false
//                openPanel.message = "Please grant full disk access to this app."
//                openPanel.prompt = "Grant Access"
//                openPanel.begin { (response) in
//                    if response == .OK {
//                        // 权限已授予
//                    } else {
//                        // 权限被拒绝
//                    }
//                }
//            }
//        }
    }
    

    

    // MARK: - 文件拖拽路径引用
    func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return .copy
    }

    func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return .copy
    }

    func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return MNDartManager.shared().pageType == .scan
    }

    func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pasteboard = sender.draggingPasteboard
        if let fileURLs = pasteboard.readObjects(forClasses: [NSURL.self], options: nil) as? [NSURL] {
            for fileURL in fileURLs {
                // 对文件路径进行处理
                let filePath = fileURL.path
                MNDartManager.shared().flutterMethodChannel?.invokeMethod("performDragPath", arguments: filePath)
                print("Dragged file path: \(String(describing: filePath))")
            }
            return true
        }
        return false
    }

    func concludeDragOperation(_ sender: NSDraggingInfo?) {
        // 拖动操作完成
    }
}
