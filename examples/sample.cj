// Cangjie grammar test file — exercises every rule of cangjie.tmLanguage.json.
// open with "Developer: Inspect Editor Tokens and Scopes" in VS Code to verify scopes.

/**
 * @brief Demo module for the Cangjie TextMate grammar.
 * @author WuJunkai2004
 * @date 2026-11-25
 */
// TODO: extend coverage; FIXME before release; NOTE and BUG markers.

package cangjie.grammar.demo

import std.math.*
import std.collection.ArrayList

@Deprecated
macro package info

// ---- keywords, identifiers, operators ----
func compute(a: Int64, b!: Int64 = 1): Int64 {
    let base = 0x1F_FF + 0o777_1 + 0b1010_0011u64
    var acc: Float64 = 1.5e-3f64
    acc *= 0x1.8p3
    const LIMIT = 10
    if (acc > LIMIT && a != b || a <= 0) {
        return -1
    }
    match (a) {
        case 0 => acc = .5
        case _ => acc += 2.0
    }
    for (i in 0..LIMIT) {
        acc += i as Float64
    }
    while (acc < 100.0) {
        acc += 2
        break
    }
    var arr = [1, 2, 3]
    arr.append(...arr)
    var x = a <- 5          // legacy: `a <- 5` operator family
    x >>= 2; x <<= 1; x &= 0xF; x ^= 0x2; x |= 0x1
    x++; x--; x++; x = x % 3
    var t = x != 0 ? 1 : 0
    var shift = 1 << 4 >> 2
    var logical = true && false || !true
    var refeq = `class` === this      // backtick identifier
    try {
        spawn {
            println("spawned ${`type`}: ${acc.toString()}")
        }
    } catch (e: Exception) {
        eprintln("error: ${e}")
    } finally {
        print("done\n\t${0x10}")
    }
    return acc
}

// ---- types and builtins ----
func misc(): Unit {
    var opt: Option<Int64> = Some(42)
    var none: Option<Int64> = None
    let i: IntNative = 1
    let u: UInt16 = 2
    let f: Float16 = 3.0
    let s: String = "text"
    let r: Rune = r'汉'
    let b: UInt8 = b'A'          // 字符字节字面量: UInt8 = 65
    let be: UInt8 = b'\n'        // 转义: UInt8 = 10
    let bu: UInt8 = b'\u{41}'    // \u 转义(最多两位): UInt8 = 65
    let ok: Bool = true
    let arr: Array<Int64> = Array<Int64>()
    let varr: VArray<Int64, 4> = VArray<Int64, 4>()
    let obj: Object = Object()
    let sb = StringBuilder()
    let it: Iterator<Int64> = ArrayList<Int64>().iterator()
    let cmp: Comparable<Int64> = Comparable<Int64>()
    let eq: Equatable<Int64> = Equatable<Int64>()
    let h: Hashable = Hashable()
    let res: Resource = Resource()
    let thr = Thread()
    let ex: IllegalArgumentException = IllegalArgumentException()
    var big: Int64 = 9_223_372_036_854_775_807i64
    var hex = 0xABCDEF
    var oct = 0o755
    var bin = 0b1111_0000
    var sci = 1e10
    var hf = 0x1.fp-2
    print("int=${big} float=${sci} rune=${r}")
}

// ---- strings ----
func strings(): Unit {
    var a = "double"
    var b = 'single'
    var c = "escaped \" \\ \n \u{4E2D}"
    var d = """
    multi "line" # not comment
    ${a} ${1 + 2} ${ifNone(opt, 0)}
    """
    var e = '''
    raw-ish 'multi' line
    '''
    var f = #"raw string with "quotes" and \backslash"#
    var g = ##"deeper raw with "quoted" text"##
    var h = #'single raw'#
    var bad = "unterminated
}

// ---- declarations ----
class Foo<T> <: Any {
    var count: Int64 = 0
    func bump(): Int64 {
        this.count += 1
        return this.count
    }
    init() {}
}

interface Shape {
    func area(): Float64
}

struct Point {
    var x: Float64 = 0.0
    var y: Float64 = 0.0
}

enum Color {
    Red | Green | Blue
}

extend Int64 {
    func isZero(): Bool {
        return this == 0
    }
}

type Alias = Int64

@Foo
annotation Mark

main() {
    let f = Foo<Int64>()
    f.bump()
}

// ---- invalid character literals (for scope checking) ----
func invalids(): Unit {
    var e1: UInt8 = b'AB'        // 多字符
    var e2: UInt8 = b''          // 空
    var e3: UInt8 = b'\u{100}'   // \u 超过两位
    var e4: UInt8 = b'汉'        // 非 ASCII
    var e5: UInt8 = b"double"    // 双引号形式不存在
    var e6: Rune = r'ab'
}
