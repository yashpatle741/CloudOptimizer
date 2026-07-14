from functools import lru_cache
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    aws_region: str = "eu-north-1"
    aws_access_key_id: str = ""
    aws_secret_access_key: str = ""

    model_config = SettingsConfigDict(
        env_file=".env",
        extra="ignore"
    )

@lru_cache
def get_settings():
    return Settings()