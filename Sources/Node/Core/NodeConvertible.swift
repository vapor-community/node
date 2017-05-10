
/// The underlying protocol used for all conversions.
/// This is the base of all conversions, where both sides of data are NodeConvertible.
/// Any NodeConvertible can be turned into any other NodeConvertible type
///
/// Json => Node => Object => Node => XML => ...
public protocol NodeConvertible: NodeInitializable, NodeRepresentable {}
