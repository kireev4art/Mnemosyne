import SQLite3


/// Return code by SQLite3 C-API
///
/// [docs](https://www.sqlite.org/rescode.html)
public enum ReturnCode: Equatable {
    case unknown(Int32)

    // primary
    case abort
    case auth
    case busy
    case cantopen
    case constraint
    case corrupt
    case done
    case empty

    case error
    case format
    case full
    case `internal`
    case interrupt
    case ioerr
    case locked
    case mismatch

    case misuse
    case nolfs
    case nomem
    case notadb
    case notfound
    case notice
    case ok
    case perm

    case `protocol`
    case range
    case readonly
    case row
    case schema
    case toobig
    case warning

    // extended
    case abortRollback
    case authUser
    case busyRecovery
    case busySnapshot
    case busyTimeout
    case cantopenConvpath
    case cantopenDirtywal
    case cantopenFullpath
    case cantopenIsdir
    case cantopenNotempdir
    case cantopenSymlink
    case constraintCheck
    case constraintComithook
    case constraintDatatype
    case constraintForeignkey
    case constraintFunction
    case constraintNotnull
    case constraintPinned
    case constraintPrimarykey
    case constraintRowid
    case constraintTrigger
    case constraintUnique
    case constraintVtab
    case corruptIndex
    case corrputSequence

    case corruptVtab
    case errorMissingCollseq
    case errorRetry
    case errorSnapshot
    case ioerrAccess
    case ioerrAuth
    case ioerrBeginAtomic
    case ioerrBlocked
    case ioerrCheckreservedlock
    case ioerrClose
    case ioerrCommitAtomic
    case ioerrConvpath
    case ioerrCurruptfs
    case ioerrData
    case ioerrDelete
    case ioerrDeleteNoent
    case ioerrDirClose
    case ioerrDirFsync
    case ioerrFstat
    case ioerrFsync
    case ioerrGettemppath
    case ioerrLock
    case ioerrMmap
    case ioerrNomem
    case ioerrRdlock

    case ioerrRead
    case ioerrRollbackAtomic
    case ioerrSeek
    case ioerrShmlock
    case ioerrShmmap
    case ioerrShmopen
    case ioerrShmsize
    case ioerrShortRead
    case ioerrTruncate
    case ioerrUnlock
    case ioerrVnode
    case ioerrWrite
    case lockedSharedcache
    case lockedVtab
    case noticeRecoverRollback
    case noticeRecoverWal
    case okLoadPermanently
    case readonlyCantinit
    case readonlyCantlock
    case readonlyDbmoved
    case readonlyDirectory
    case readonlyRecovery
    case readonlyRollback
    case warningAutoindex

    init(_ code: Int32) {
        switch code {
        case SQLITE_ABORT:
            self = .abort
        case SQLITE_AUTH:
            self = .auth
        case SQLITE_BUSY:
            self = .busy
        case SQLITE_CANTOPEN:
            self = .cantopen
        case SQLITE_CONSTRAINT:
            self = .constraint
        case SQLITE_CORRUPT:
            self = .corrupt
        case SQLITE_DONE:
            self = .done
        case SQLITE_EMPTY:
            self = .empty
        case SQLITE_ERROR:
            self = .error
        case SQLITE_FORMAT:
            self = .format
        case SQLITE_FULL:
            self = .full
        case SQLITE_INTERNAL:
            self = .internal
        case SQLITE_INTERRUPT:
            self = .interrupt
        case SQLITE_IOERR:
            self = .ioerr
        case SQLITE_LOCKED:
            self = .locked
        case SQLITE_MISMATCH:
            self = .mismatch
        case SQLITE_MISUSE:
            self = .misuse
        case SQLITE_NOLFS:
            self = .nolfs
        case SQLITE_NOMEM:
            self = .nomem
        case SQLITE_NOTADB:
            self = .notadb
        case SQLITE_NOTFOUND:
            self = .notfound
        case SQLITE_NOTICE:
            self = .notice
        case SQLITE_OK:
            self = .ok
        case SQLITE_PERM:
            self = .perm
        case SQLITE_PROTOCOL:
            self = .protocol
        case SQLITE_RANGE:
            self = .range
        case SQLITE_READONLY:
            self = .readonly
        case SQLITE_ROW:
            self = .row
        case SQLITE_SCHEMA:
            self = .schema
        case SQLITE_TOOBIG:
            self = .toobig
        case SQLITE_WARNING:
            self = .warning

        // https://www.sqlite.org/rescode.html#extended_result_code_list
        case 516:
            self = .abortRollback
        case 279:
            self = .authUser
        case 261:
            self = .busyRecovery
        case 517:
            self = .busySnapshot
        case 773:
            self = .busyTimeout
        case 1038:
            self = .cantopenConvpath
        case 1294:
            self = .cantopenDirtywal
        case 782:
            self = .cantopenFullpath
        case 526:
            self = .cantopenIsdir
        case 270:
            self = .cantopenNotempdir
        case 1550:
            self = .cantopenSymlink
        case 275:
            self = .constraintCheck
        case 531:
            self = .constraintComithook
        case 3091:
            self = .constraintDatatype
        case 787:
            self = .constraintForeignkey
        case 1043:
            self = .constraintFunction
        case 1299:
            self = .constraintNotnull
        case 2835:
            self = .constraintPinned
        case 1555:
            self = .constraintPrimarykey
        case 2579:
            self = .constraintRowid
        case 1811:
            self = .constraintTrigger
        case 2067:
            self = .constraintUnique
        case 2323:
            self = .constraintVtab
        case 779:
            self = .corruptIndex
        case 523:
            self = .corrputSequence

        case 267:
            self = .corruptVtab
        case 257:
            self = .errorMissingCollseq
        case 513:
            self = .errorRetry
        case 769:
            self = .errorSnapshot
        case 3338:
            self = .ioerrAccess
        case 7178:
            self = .ioerrAuth
        case 7434:
            self = .ioerrBeginAtomic
        case 2826:
            self = .ioerrBlocked
        case 3594:
            self = .ioerrCheckreservedlock
        case 4106:
            self = .ioerrClose
        case 7690:
            self = .ioerrCommitAtomic
        case 6666:
            self = .ioerrConvpath
        case 8458:
            self = .ioerrCurruptfs
        case 8202:
            self = .ioerrData
        case 2570:
            self = .ioerrDelete
        case 5898:
            self = .ioerrDeleteNoent
        case 4362:
            self = .ioerrDirClose
        case 1290:
            self = .ioerrDirFsync
        case 1802:
            self = .ioerrFstat
        case 1034:
            self = .ioerrFsync
        case 6410:
            self = .ioerrGettemppath
        case 3850:
            self = .ioerrLock
        case 6154:
            self = .ioerrMmap
        case 3082:
            self = .ioerrNomem
        case 2314:
            self = .ioerrRdlock

        case 266:
            self = .ioerrRead
        case 7946:
            self = .ioerrRollbackAtomic
        case 5642:
            self = .ioerrSeek
        case 5130:
            self = .ioerrShmlock
        case 5386:
            self = .ioerrShmmap
        case 4618:
            self = .ioerrShmopen
        case 4874:
            self = .ioerrShmsize
        case 522:
            self = .ioerrShortRead
        case 1546:
            self = .ioerrTruncate
        case 2058:
            self = .ioerrUnlock
        case 6922:
            self = .ioerrVnode
        case 778:
            self = .ioerrWrite
        case 262:
            self = .abort
        case 518:
            self = .lockedVtab
        case 539:
            self = .noticeRecoverRollback
        case 283:
            self = .noticeRecoverWal
        case 256:
            self = .okLoadPermanently
        case 1288:
            self = .readonlyCantinit
        case 520:
            self = .readonlyCantlock
        case 1032:
            self = .readonlyDbmoved
        case 1544:
            self = .readonlyDirectory
        case 264:
            self = .readonlyRecovery
        case 776:
            self = .readonlyRollback
        case 284:
            self = .warningAutoindex

        default:
            self = .unknown(code)
        }
    }
}
