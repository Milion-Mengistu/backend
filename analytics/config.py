from typing import Literal

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    app_name: str = "Fuel-Aware Backend"
    app_env: str = "development"
    app_host: str = "0.0.0.0"
    app_port: int = 8000
    supabase_db_url: str
    telemetry_table: str = "telemetry_normalized"
    openai_api_key: str | None = None
    openai_model: str = "gpt-5.5"
    ai_runtime: Literal["python", "node"] = "python"

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore",
    )


settings = Settings()
