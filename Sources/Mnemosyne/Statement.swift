import SQLite3
import Foundation


public struct Statement {

    public func finalize() {
        sqlite3_finalize(pointer)
    }

    public func bind(_ double: Double, at index: Int32) -> ReturnCode {
        ReturnCode(sqlite3_bind_double(pointer, index, double))
    }

    public func bind(_ int: Int32, at index: Int32) -> ReturnCode {
        ReturnCode(sqlite3_bind_int(pointer, index, int))
    }

    public func bind(_ int: Int64, at index: Int32) -> ReturnCode {
        ReturnCode(sqlite3_bind_int64(pointer, index, int))
    }

    public func bind(_ string: String, at index: Int32) -> ReturnCode {
        // https://www.sqlite.org/c3ref/c_static.html
        return ReturnCode(sqlite3_bind_text(pointer, index, string, -1, SQLITE_TRANSIENT))
    }

    public func bindNull(at index: Int32) -> ReturnCode {
        ReturnCode(sqlite3_bind_null(pointer, index))
    }

    public func bind(_ double: Double?, at index: Int32) -> ReturnCode {
        switch double {
        case .some(let double):
            return bind(double, at: index)
        case .none:
            return bindNull(at: index)
        }
    }

    public func bind(_ int: Int32?, at index: Int32) -> ReturnCode {
        switch int {
        case .some(let int):
            return bind(int, at: index)
        case .none:
            return bindNull(at: index)
        }
    }

    public func bind(_ int: Int64?, at index: Int32) -> ReturnCode {
        switch int {
        case .some(let int):
            return bind(int, at: index)
        case .none:
            return bindNull(at: index)
        }
    }

    public func bind(_ string: String?, at index: Int32) -> ReturnCode {
        switch string {
        case .some(let string):
            return bind(string, at: index)
        case .none:
            return bindNull(at: index)
        }
    }

    public var bindParameterCount: Int32 {
        sqlite3_bind_parameter_count(pointer)
    }

    public func bindParameterIndex(with name: String) -> Int32 {
        sqlite3_bind_parameter_index(pointer, name)
    }

    public func bindParameterName(at index: Int32) -> String? {
        guard let cString = sqlite3_bind_parameter_name(pointer, index) else { return nil }
        let string = String(cString: cString)
        return string
    }

    public func clearBindings() -> ReturnCode {
        ReturnCode(sqlite3_clear_bindings(pointer))
    }

    public func columnDouble(at index: Int32) -> Double {
        sqlite3_column_double(pointer, index)
    }

    public func columnInt(at index: Int32) -> Int32 {
        sqlite3_column_int(pointer, index)
    }

    public func columnInt64(at index: Int32) -> Int64 {
        sqlite3_column_int64(pointer, index)
    }

    public func columnText(at index: Int32) -> String {
        String(cString: sqlite3_column_text(pointer, index))
    }

    public func columnBytes(at index: Int32) -> Int32 {
        sqlite3_column_bytes(pointer, index)
    }

    public enum ColumnType {
        case integer
        case float
        case text
        case blob
        case null

        init?(_ int32: Int32) {
            switch int32 {
            case SQLITE_INTEGER:
                self = .integer
            case SQLITE_FLOAT:
                self = .float
            case SQLITE_TEXT, SQLITE3_TEXT:
                self = .text
            case SQLITE_BLOB:
                self = .blob
            case SQLITE_NULL:
                self = .null
            default:
                return nil
            }
        }
    }

    public func columnType(at index: Int32) -> ColumnType {
        ColumnType(sqlite3_column_type(pointer, index))!
    }

    public func columnName(at index: Int32) -> String? {
        guard let cString = sqlite3_column_name(pointer, index) else { return nil }
        let string = String(cString: cString, encoding: .utf8)
        return string
    }

    public func columnDatabaseName(at index: Int32) -> String? {
        guard let cString = sqlite3_column_database_name(pointer, index) else { return nil }
        let string = String(cString: cString, encoding: .utf8)
        return string
    }

    public func columnTableName(at index: Int32) -> String? {
        guard let cString = sqlite3_column_table_name(pointer, index) else { return nil }
        let string = String(cString: cString, encoding: .utf8)
        return string
    }

    public func columnOriginName(at index: Int32) -> String? {
        guard let cString = sqlite3_column_origin_name(pointer, index) else { return nil }
        let string = String(cString: cString, encoding: .utf8)
        return string
    }

    public var dataCount: Int32 {
        sqlite3_data_count(pointer)
    }

    public var sql: String {
        String(cString: sqlite3_sql(pointer))
    }

    public var expandedSql: String {
        String(cString: sqlite3_expanded_sql(pointer))
    }

    @available(iOS 15.0, *)
    @available(macOS 12.0, *)
    public var normalizedSql: String {
        String(cString: sqlite3_normalized_sql(pointer))
    }

    public func reset() -> ReturnCode {
        ReturnCode(sqlite3_reset(pointer))
    }

    public func step() -> ReturnCode {
        ReturnCode(sqlite3_step(pointer))
    }

    public var stmtBusy: Bool {
        sqlite3_stmt_busy(pointer) != 0
    }


    // MARK: - internal

    internal init(pointer: OpaquePointer? = nil) {
        self.pointer = pointer
    }


    // MARK: - private

    private var pointer: OpaquePointer?

}


let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)

let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
