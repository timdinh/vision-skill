#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <path-to-image> [prompt]"
  exit 1
fi

IMAGE_PATH="$1"
PROMPT="${2:-Describe this image for an AI prompt:}"

if [ ! -f "$IMAGE_PATH" ]; then
  echo "Error: File not found: $IMAGE_PATH"
  exit 1
fi

EXTENSION="${IMAGE_PATH##*.}"
EXTENSION=$(echo "$EXTENSION" | tr '[:upper:]' '[:lower:]')

case "$EXTENSION" in
  jpg|jpeg)
    MIME_TYPE="image/jpeg"
    ;;
  png)
    MIME_TYPE="image/png"
    ;;
  webp)
    MIME_TYPE="image/webp"
    ;;
  gif)
    MIME_TYPE="image/gif"
    ;;
  *)
    echo "Unsupported image format: $EXTENSION"
    exit 1
    ;;
esac

# For cross-platform compatibility, we use stdin for base64 and ensure no wrapping and no newlines.
BASE64_IMAGE=$(base64 < "$IMAGE_PATH" | tr -d '\n')

# Create a temporary file for the JSON payload to avoid ARG_MAX issues
JSON_PAYLOAD=$(mktemp)
cat <<EOF > "$JSON_PAYLOAD"
{
  "model": "kimi-k2.6",
  "messages": [
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "$PROMPT"
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "data:$MIME_TYPE;base64,$BASE64_IMAGE"
          }
        }
      ]
    }
  ]
}
EOF

curl https://api.moonshot.ai/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${MOONSHOT_API_KEY}" \
  -d @"$JSON_PAYLOAD" | jq -r '.choices[0].message.content'

rm "$JSON_PAYLOAD"
