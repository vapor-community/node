<h1 align="center">Node</h1>

> a point at which lines or pathways intersect or branch; a central or connecting point.


The purpose of this package is to be an intermediary data layer that can allow transformation between unrelated formats.



### NodeConvertible

This type is used to define how a type is represented as `Node` and vice versa.

```Swift
public protocol NodeConvertible {
    init(with node: Node, in context: Context) throws
    func toNode() throws -> Node
}
```

Any type that conforms to this protocol can be converted into any other type that also conforms.

### Examples

Json to Int

```Swift
let id = Int(with: json)
```

XML to Model

```Swift
let post = Post(with: xml)
```

User from Json

```Swift
let user = User(with: request, in: session)
```
