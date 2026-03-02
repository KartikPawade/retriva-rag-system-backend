from supabase import Client, create_client
from src.config.settings import appConfig

supabase: Client = create_client(
    appConfig["supabase_api_url"], appConfig["supabase_secret_key"]
)