import pytest
import json

from ariadne import graphql_sync

def test_simple(schema):
  with open(__file__) as f:
    pysource = f.read()
  success, result = graphql_sync(
    schema,
    {
      "query": """{
  pythonToJupyter(source:"""+json.dumps(pysource)+""")
}""",
    })
  assert success
  assert "errors" not in result
  print(result['data'])
