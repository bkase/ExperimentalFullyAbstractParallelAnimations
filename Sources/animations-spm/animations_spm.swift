// Datatype Generic(ish) Parallel-ly Composing Animations
// (because it seemed cool)

import Abstract
import Operadics

typealias RelativeTime = Double

struct TupleS<S1: Semigroup, S2: Semigroup>: Semigroup {
    let tuple: (S1, S2)
    init(_ s1: S1, _ s2: S2) {
        self.tuple = (s1, s2)
    }
    init(_ tuple: (S1, S2)) {
        self.tuple = tuple
    }
    
    static func <> (left: TupleS, right: TupleS) -> TupleS {
        return TupleS(
            left.tuple.0 <> right.tuple.0,
            left.tuple.1 <> right.tuple.1
        )
    }
}

struct TupleCM<CM1: CommutativeMonoid, CM2: CommutativeMonoid>: CommutativeMonoid, Equatable where CM1: Equatable, CM2: Equatable {
    static func ==(lhs: TupleCM<CM1, CM2>, rhs: TupleCM<CM1, CM2>) -> Bool {
        return lhs.tuple.0 == rhs.tuple.0 && lhs.tuple.1 == rhs.tuple.1
    }
    
    let tuple: (CM1, CM2)
    init(_ s1: CM1, _ s2: CM2) {
        self.tuple = (s1, s2)
    }
    init(_ tuple: (CM1, CM2)) {
        self.tuple = tuple
    }
    
    static var empty: TupleCM {
        return TupleCM(CM1.empty, CM2.empty)
    }
    
    static func <> (left: TupleCM, right: TupleCM) -> TupleCM {
        return TupleCM(
            left.tuple.0 <> right.tuple.0,
            left.tuple.1 <> right.tuple.1
        )
    }
}
extension TupleCM where CM1 == Add<Int>, CM2 == Add<Double> {
    func average() -> Double {
        return tuple.1.unwrap / Double(tuple.0.unwrap)
    }
}

typealias Count = Add<Int>
typealias Sum = Add<Double>
typealias ParDuration = Max<Int>
typealias ParAnimationResult = TupleCM<Count, Sum>
typealias ParAnimationAction = FunctionCM<RelativeTime, ParAnimationResult>
typealias ParAnimation = TupleS<ParDuration, ParAnimationAction>
// semigroup operation is Parallel compose

func foo() {
    let a: ParAnimation = TupleS(Max(1), ParAnimationAction { t in
        return TupleCM(Count(1), Sum(t))
    })
    
    let b = a <> a <> a
    dump(b.tuple.1.call(0.75).average())
}

