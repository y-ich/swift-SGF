%class_name SGFParser
%token_type Token
%nonterminal_type value String
%nonterminal_type c_value_type CValueType
%nonterminal_type prop_value CValueType
%nonterminal_type prop_value_list "[CValueType]"
%nonterminal_type property "(String, [CValueType])"
%nonterminal_type property_list "[(String, [CValueType])]"
%nonterminal_type node Node
%nonterminal_type sequence Node
%nonterminal_type gametree Node
%nonterminal_type gametree_list "[Node]"
%nonterminal_type collection "[Node]"
%nonterminal_type output "[Node]"

output ::= collection(a). {
    return a
}

collection ::= gametree(a). {
    return [a]
}
collection ::= gametree(a) collection(b). {
    return [a] + b
}

gametree ::= OPEN_PARENTHESIS sequence(a) CLOSE_PARENTHESIS. {
    return a
}
gametree ::= OPEN_PARENTHESIS sequence(a) gametree_list(b) CLOSE_PARENTHESIS. {
    var node = a
    while node.children.count > 0 {
        node = node.children[0]
    }
    node.children.append(contentsOf: b)
    return a
}

gametree_list ::= gametree(a). {
    return [a]
}
gametree_list ::= gametree(a) gametree_list(b). {
    return [a] + b
}

sequence ::= node(a). {
    return a
}
sequence ::= node(a) sequence(b). {
    a.children.append(b)
    return a
}

node ::= SEMICOLUMN. {
    return Node()
}
node ::= SEMICOLUMN property_list(a). {
    let node = Node()
    for (k, v) in a {
        node.properties[k] = v
    }
    return node
}

property_list ::= property(a). {
    return [a]
}
property_list ::= property(a) property_list(b). {
    return [a] + b
}

property ::= PROP_INDENT(a) prop_value_list(b). {
    return (a.toIdentifierString()!, b)
}

prop_value_list ::= prop_value(a). {
    return [a]
}
prop_value_list ::= prop_value(a) prop_value_list(b). {
    return [a] + b
}

prop_value ::= OPEN_BRACKET CLOSE_BRACKET. {
    return .single("")
}
prop_value ::= OPEN_BRACKET c_value_type(a) CLOSE_BRACKET. {
    return a
}

c_value_type ::= VALUE(a). {
    return .single(a.toValueString()!)
}
c_value_type ::= VALUE(a) COLUMN VALUE(b). {
    return .compose(a.toValueString()!, b.toValueString()!)
}

//value_type ::= NUMBER | REAL | DOUBLE | COLOR | SIMPLE_TEXT | TEXT | POINT | MOVE | STONE
