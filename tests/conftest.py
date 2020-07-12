import pytest

from fn.schema import schema as _schema

@pytest.fixture
def schema():
  return _schema
