from ariadne.asgi import GraphQL
from fn.schema import schema

app = GraphQL(schema, debug=True)
