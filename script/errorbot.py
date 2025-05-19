import os
import requests

# Get environment variables
BOT_TOKEN = os.getenv('TELEGRAM_BOT_TOKEN')
CHAT_ID = os.getenv('TELEGRAM_CHAT_ID')
TOPIC_ID = os.getenv('TELEGRAM_TOPIC_ID')
BUILD_TYPE = os.getenv('BUILD_TYPE', 'Unknown')
KERNEL_CL = os.getenv('KERNEL_CL', 'Unknown')
FILE_PATH = os.getenv('ANYKERNEL3_FILE')
COMMIT_URL = os.getenv('COMMIT_URL', '#')
RUN_URL = os.getenv('RUN_URL', '#')
KSU_URL = os.getenv('KSU_URL', '#')

def send_file_with_caption(chat_id, file_path, caption, topic_id=None):
    """Send a file with a caption to a Telegram chat or a specific topic."""
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendDocument"
    
    data = {
        "chat_id": chat_id,
        "caption": caption,
        "parse_mode": "HTML",
    }
    
    if topic_id:
        data["message_thread_id"] = topic_id

    try:
        with open(file_path, "rb") as file:
            files = {"document": file}
            response = requests.post(url, data=data, files=files)

        # Only print status
        if response.status_code == 200:
            print("✅ File successfully sent to Telegram.")
        else:
            print(f"❌ Failed to send file. Status: {response.status_code}")
            print("Response snippet:", response.text[:200])  # Limit output
    except Exception as e:
        print(f"❌ Error sending file: {e}")

def main():
    # Ensure required variables are set
    if not BOT_TOKEN or not CHAT_ID or not FILE_PATH:
        print("❌ Missing required environment variables.")
        return

    # HTML caption
    caption = (
        "<b>✹ Build Type</b>\n"
        f"<i>-> {BUILD_TYPE}</i>\n"
        "<b>✹ Kernel</b>\n"
        f"<i>-> <a href='{KERNEL_CL}'>CL</a></i>\n"
        "<b>✹ Manager</b>\n"
        f"<i>-> <a href='{KSU_URL}'>Release</a></i>\n"
        "<b>✹ Commit</b>\n"
        f"<i>-> <a href='{COMMIT_URL}'>View</a></i>\n"
        "<b>✹ Workflow</b>\n"
        f"<i>-> <a href='{RUN_URL}'>Run</a></i>\n"
    )

    send_file_with_caption(CHAT_ID, FILE_PATH, caption, TOPIC_ID)

if __name__ == "__main__":
    main()