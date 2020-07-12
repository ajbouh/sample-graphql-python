from ariadne import QueryType, InterfaceType, ObjectType

from p2j.p2j import p2j, j2p
import tempfile

query = QueryType()

@query.field("jupyterToPython")
def resolve_jupyterToPython(parent, info, source):
  with tempfile.NamedTemporaryFile('w+', suffix='.py') as inf:
    inf.write(source)
    inf.flush()
    with tempfile.NamedTemporaryFile('w+', suffix='.ipynb') as outf:
      j2p(inf.name, outf.name, True)
      return outf.read()


@query.field("pythonToJupyter")
def resolve_pythonToJupyter(parent, info, source):
  with tempfile.NamedTemporaryFile('w+', suffix='.py') as inf:
    inf.write(source)
    inf.flush()
    with tempfile.NamedTemporaryFile('w+', suffix='.ipynb') as outf:
      p2j(inf.name, outf.name, True)
      return outf.read()
