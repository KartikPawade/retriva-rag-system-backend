from dotenv import load_dotenv
from supabase import Client, create_client
import supabase
import os


load_dotenv()

supabase_url = os.getenv("SUPABASE_URL")
supabase_key = os.getenv("SUPABASE_KEY")

if not supabase_url or not supabase_key:
    raise ValueError("SUPABASE_URL or SUPABASE_KEY is not set")

supabase : Client = create_client(supabase_url, supabase_key)
