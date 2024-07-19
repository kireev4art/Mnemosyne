import SQLite3


public struct Connection {

    public static func open(filename: String) -> (code: ReturnCode, connection: Connection) {
        var pointer: OpaquePointer?
        let int32 = sqlite3_open(filename, &pointer)
        let code = ReturnCode(int32)
        let connection = Connection(pointer: pointer)
        return (code, connection)
    }

    public struct OpenFlags: OptionSet {

        public static let readOnly = OpenFlags(rawValue: SQLITE_OPEN_READONLY)

        public static let readWrite = OpenFlags(rawValue: SQLITE_OPEN_READWRITE)

        public static let create = OpenFlags(rawValue: SQLITE_OPEN_CREATE)

        public static let uri = OpenFlags(rawValue: SQLITE_OPEN_URI)

        public static let memory = OpenFlags(rawValue: SQLITE_OPEN_MEMORY)

        public static let noMutex = OpenFlags(rawValue: SQLITE_OPEN_NOMUTEX)

        public static let fullMutex = OpenFlags(rawValue: SQLITE_OPEN_FULLMUTEX)

        public static let sharedCache = OpenFlags(rawValue: SQLITE_OPEN_SHAREDCACHE)

        public static let privateCache = OpenFlags(rawValue: SQLITE_OPEN_PRIVATECACHE)

        public static let exrescode = OpenFlags(rawValue: SQLITE_OPEN_EXRESCODE)

        public static let noFollow = OpenFlags(rawValue: SQLITE_OPEN_NOFOLLOW)


        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }


        public let rawValue: Int32

    }

    public static func open2(filename: String, flags: OpenFlags = [.readWrite, .create], vfs: String? = nil) -> (code: ReturnCode, connection: Connection) {
        var pointer: OpaquePointer?
        let int32 = sqlite3_open_v2(filename, &pointer, flags.rawValue, vfs)
        let code = ReturnCode(int32)
        let connection = Connection(pointer: pointer)
        return (code, connection)
    }

    public func close() -> ReturnCode {
        let int32 = sqlite3_close(pointer)
        return ReturnCode(int32)
    }

    public func close2() -> ReturnCode {
        let int32 = sqlite3_close_v2(pointer)
        return ReturnCode(int32)
    }

    public var changes: Int32 {
        sqlite3_changes(pointer)
    }

    @available(macOS 12.3, *)
    public var changes64: Int64 {
        sqlite3_changes64(pointer)
    }

    public func dbCacheFlush() -> ReturnCode {
        ReturnCode(sqlite3_db_cacheflush(pointer))
    }

    public func getAutocommit() -> Bool {
        if sqlite3_get_autocommit(pointer) == 0 {
            return false
        } else {
            return true
        }
    }

    public func interrupt() {
        sqlite3_interrupt(pointer)
    }

    @available(macOS 14.2, *)
    public var isInterrupted: Bool {
        let int32 = sqlite3_is_interrupted(pointer)
        switch int32 {
        case 0:
            return false
        case 1:
            return true
        default:
            #if DEBUG
            fatalError("Unexpected return value: \(int32)")
            #else
            return true
            #endif
        }
    }

    public var lastInsertRowid: Int64 {
        sqlite3_last_insert_rowid(pointer)
    }

    func prepare2(sql: String) -> (code: ReturnCode, statement: Statement) {
        var statementPointer: OpaquePointer?
        let int32 = sqlite3_prepare_v2(pointer, sql, -1, &statementPointer, nil)
        let returnCode = ReturnCode(int32)
        let statement = Statement(pointer: statementPointer)
        return (returnCode, statement)
    }

    public func setLastInsertRowid(_ value: Int64) {
        sqlite3_set_last_insert_rowid(pointer, value)
    }

    public var systemErrno: Int32 {
        sqlite3_system_errno(pointer)
    }

    public var totalChanges: Int32 {
        sqlite3_total_changes(pointer)
    }

    @available(macOS 12.3, *)
    public var totalChanges64: Int64 {
        sqlite3_total_changes64(pointer)
    }


    // MARK: - internal

    internal init(pointer: OpaquePointer? = nil) {
        self.pointer = pointer
    }


    // MARK: - private

    private var pointer: OpaquePointer?

}
