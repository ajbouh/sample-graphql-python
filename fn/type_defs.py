from ariadne import gql

type_defs = gql('''
type Query {
  pythonToJupyter(
    source: String!,
  ): String!

  jupyterToPython(
    source: String!,
  ): String!
}
''')
