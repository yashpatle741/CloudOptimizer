from functools import lru_cache
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    aws_region: str = "eu-north-1"

    class Config:
        env_file = ".env"


@lru_cache
def get_settings():
    return Settings()
