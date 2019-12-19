import Foundation

// Static class to handle logging of events.
final public class Logger {
    private static let LOGGER_PLIST_KEY = "Logger.LogLevel"
    
    // Configuration
    private static var currentLogLevel: LogLevel? // TODO: This should probably be set based on a setting somehow rather than just configured here.
    private static var isInitialized: Bool {
        get {
            return currentLogLevel != nil
        }
    }
    
    // Initialization methods.
    // Base initialization method.
    public static func initialize() {
        guard !isInitialized else { return }
        // Try to determine the log level from the Info.plist
        currentLogLevel = plistLogLevel()
    }
    
    public static func intitialize(level: LogLevel) {
        guard !isInitialized else { return }
        currentLogLevel = level
    }
    
    // Public logging methods
    
    // Log something at the info level.
    public static func i(tag: String, message: String) {
        printLog(logLevel: .Info, tag: tag, message: message)
    }
    
    // Log something at the debug level
    public static func d(tag: String, message: String) {
        printLog(logLevel: .Debug, tag: tag, message: message)
    }
    
    // Log something at the warning level.
    public static func w(tag: String, message: String) {
        printLog(logLevel: .Warning, tag: tag, message: message)
    }
    
    // Log something at the error level.
    public static func e(tag: String, message: String) {
        printLog(logLevel: .Error, tag: tag, message: message)
    }
    
    // Allow someone to temporarily change the log level if needed.
    public static func changeLogLevel(level: LogLevel) {
        guard isInitialized else { return }
        currentLogLevel = level
    }
    
    // Private convenience methods.
    private static func printLog(logLevel: LogLevel, tag: String, message: String) {
        guard shouldLog(logLevel: logLevel) else { return }
        print("[\(LogLevel.toString(ll: logLevel))][\(tag)] - \(message)")
    }
    
    private static func shouldLog(logLevel: LogLevel) -> Bool {
        guard isInitialized else { return false }
        switch logLevel {
        case .Info:
            return currentLogLevel == .Info
        case .Debug:
            return currentLogLevel == .Info || currentLogLevel == .Debug
        case .Warning:
            return currentLogLevel != .Error
        case .Error:
            return true
        }
    }
    
    // Determines the log level from the plist. If no log level is present then return the default of debug.
    private static func plistLogLevel() -> LogLevel {
        let key = Bundle.main.object(forInfoDictionaryKey: LOGGER_PLIST_KEY) as? String
        guard isValidKey(key: key) else { return .Debug }
        switch key!.lowercased() {
        case "info":
            return .Info
        case "debug":
            return .Debug
        case "warning":
            return .Warning
        case "error":
            return .Error
        default:
            return .Debug
        }
    }
    
    private static func isValidKey(key: String?) -> Bool {
        guard let selectedKey = key else { return false }
        let validKeys = ["info", "debug", "error", "warning"]
        return validKeys.contains(selectedKey.lowercased())
    }
}
