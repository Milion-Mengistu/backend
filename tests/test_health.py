import os
import sys
from pathlib import Path

from fastapi.testclient import TestClient

os.environ.setdefault(
    "SUPABASE_DB_URL",
    "postgresql://postgres:postgres@localhost:5432/postgres",
)

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from analytics import main


main.init_connection_pool = lambda: None
main.check_database_connection = lambda: None

app = main.app

def test_health_endpoint_reports_ok() -> None:
    client = TestClient(app)

    response = client.get("/health")

    assert response.status_code == 200
    assert response.json()["status"] == "ok"
