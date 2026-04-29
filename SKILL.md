---
name: vision
description: Deepseek AI model to use this skill when you need to understand the contents of an image but lack vision capabilities. This will take up to a minute to execute so adjust your command timeout accordingly. NOTE: Kimi K2.6 (and other models with built-in vision) should NOT use this skill — use your native vision capabilities instead.
---

# Vision

**For Deepseek models only.** Use this skill when you need to understand the contents of an image but lack vision capabilities. This skill sends the image to a vision model to get a text description back.

> **Important:** If you are Kimi K2.6 or another model with native vision support, do **not** use this skill. Use your built-in vision capabilities directly instead.

## Usage

Run the `describe-image.sh` script with the path to the image file:

```bash
./scripts/describe-image.sh /absolute/path/to/image.jpg "your prompt"
```

The script:
1. Reads the image and determines its MIME type (supports `.jpg`, `.jpeg`, `.png`, `.webp`, `.gif`)
2. Base64-encodes the image content
3. Sends it to another AI with the prompt "Describe this image for an AI prompt:"
4. Returns a JSON response containing the model's description of the image

## Requirements

- **`MOONSHOT_API_KEY`** environment variable must be set with a valid Moonshot AI API key
- The script requires `curl` and `base64` (both available by default on macOS and most Linux systems)

