# Sign Language Model API

A Flask-based REST API that serves a deep learning model for sign language recognition from video, deployable on Railway/Hugging Face.

## Overview

The API accepts a short video clip, samples a fixed number of frames from it, and feeds them through a CNN + LSTM model to predict the sign language gesture being performed.

## How It Works

1. A video file is uploaded to the `/predict` endpoint
2. Frames are extracted, resized, and normalized into a fixed-length sequence
3. A CNN extracts spatial features from each frame
4. An LSTM processes the sequence of features to capture motion over time
5. The model outputs the predicted sign label as JSON

## Model Architecture

- **CNN backbone:** two convolutional blocks (Conv2D → ReLU → MaxPool) followed by adaptive average pooling, extracting spatial features from each frame
- **LSTM head:** processes the sequence of per-frame CNN features to capture temporal (motion) patterns across the video
- **Classifier:** a fully connected layer mapping the final LSTM hidden state to sign language classes

## API

**POST** `/predict`

- **Body:** multipart form-data with a `video` file field
- **Response:**
```json
{
  "translation": "predicted_sign_label"
}
```

## Technologies

- Python
- PyTorch (model definition and inference)
- OpenCV (video frame extraction and preprocessing)
- Flask + Flask-CORS (REST API)
- Docker (containerized deployment)

## Deployment

The project includes a `Dockerfile` and `Procfile` for deployment on platforms such as Railway or Hugging Face Spaces. The server reads the port from the `PORT` environment variable, making it compatible with most cloud hosting providers.

## Running Locally

```bash
pip install -r requirements.txt
python app.py
```

The API will be available at `http://localhost:5000/predict`.
