# Node Manifesto

Node is a data encapsulation enum that facilities transformations from one type to another in Swift. 

## Reasoning

If you are working in an environment that requires converting between data types, especially where those conversions may required intermediate types, Node will be invaluable. Working on the web, for instance, commonly requires conversions from formats like JSON or XML to database formats like MySQL or Mongo. Instead of creating explicit conversions for each permutation of your supported types, you just conform each data type to Node once. Any type that conforms to Node's protocols can be converted to any other type that also conforms. Visually, this looks like:

### Without Node

```
XML --> MySQL
Form --> MySQL
MySQL --> JSON
XML --> Mongo
Form --> Mongo
Mongo --> JSON
```

Six conformances conversions required for six conversion use cases.

### With Node

```
    ---              ---
XML    |            |    XML
JSON   |            |   JSON
Form    > - Node - <    Form
MySQL  |            |  MySQL
Mongo  |            |  Mongo
    ---              ---
```

Five conversions required for 25 conversion use cases.

## Usage

In this simple example, you can see one conformance to `NodeConvertible` for the class `Log` provides compatibility with the MySQL database and JSON REST API.

```swift
final class Log: Model {
    let message: String

    // MARK: NodeConvertible

    init(node: Node, in context: Context) throws {
        message = try node.get("message")
    }

    func makeNode(in context: Context) throws {
        var node = Node()
        try node.set("message", message)
        return node
    }
}

let log = try Log.find(1)
let json = try log.makeJSON()
```

### Advanced

In cases where the serialization or parsing for a given conformance varies, Node is still a powerful tool.

In the following example, the User conforms manually to the `RowConvertible` and `JSONConvertible` types. 
However, since both `Row` and `JSON` are `NodeConvertible` types, Node conveniences of `.get` and `.set` are available.

```swift
final class User: Model {
    let name: Name
    let age: Int
    let organizationId: Node

    var organization: Parent<User, Organization> {
        return parent(id: organizationId)
    }

    init(row: Row) throws {
        name = try row.get() // uses whole node to init Name
        age = try row.get("age")
        organizationId = try row.get(Organization.foreignIdKey)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(name) // merges Name row into current row
        try row.set("age", age)
        try row.set(Organization.foreignIdKey, organizationId)
        return row
    }
}

// MARK: JSON

extension User: JSONConvertible {
    init(json: JSON) throws {
        name = try json.get("name") // uses Node at key `"name"` to init Name with json init
        age = try json.get("age")
        organizationId = try json.get("organization.id")
    }

    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name) // calls `makeJSON` on name and sets to key `"name"`
        try json.set("age", age)
        try json.set("organization", organization) // automatically calls `.get()`
        return json
    }
}
```
