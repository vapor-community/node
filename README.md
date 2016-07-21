<h1 align="center">Node</h1>

> a point at which lines or pathways intersect or branch; a central or connecting point.

The purpose of this package is to be an intermediary data layer that can allow transformation between unrelated formats. In this way any node convertible object can be converted to any other node convertible object and vice versa.

![](/Resources/ConvertiblePNG.png)

An example of this type of pattern below shows how we might create a `Model` from `JSON`, and then later serializing that `Model` to a `DatabaseFormat`. By using this pattern, we can seamlessly interchange `JSON` or `DatabaseFormat` as we see fit.

![](/Resources/ConcreteExamplePNG.png)

### 📋 Examples

Json to Int

```Swift
let id = try Int(with: json)
```

XML to Model

```Swift
let post = try Post(with: xml)
```

User from Json

```Swift
let user = try User(with: request, in: session)
```

Multi

```Swift
let user = try User(with: json)
let xml = try XML(with: user)
let response = try HTTPClient.get("http://legacyapi.why-xml", body: xml.serialize())
let profile = try Profile(with: response.json)
return try JSON(with: profile)
```

### ⛓ NodeConvertible

This type is used to define how a type is represented as `Node` and vice versa.

```Swift
public protocol NodeRepresentable {
    func makeNode() throws -> Node
}

public protocol NodeInitializable {
    init(with node: Node, in context: Context) throws
}

public protocol NodeConvertible: NodeInitializable, NodeRepresentable {}
```

Any type that conforms to this protocol can be converted into any other compatible type that also conforms.

> Note: `Context` above is an empty protocol that can be used for complex mapping. It is safe to ignore this if you're not using it internally

## 💧 Community

We pride ourselves on providing a diverse and welcoming community. Join your fellow Vapor developers in [our slack](slack.qutheory.io) and take part in the conversation.

## 🔧 Compatibility

Node has been tested on OS X 10.11, Ubuntu 14.04, and Ubuntu 15.10.
