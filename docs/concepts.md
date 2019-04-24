---
id: concepts
title: Concepts
sidebar_label: Concepts
---

## Rate Limiting

You can make 5 requests per minute to each API. The requests are capped at 100 requests per day. If you think you’ll need a higher rate limit, drop us a line at support@seernet.io and we can take it forward from there.

Once you go over the rate limit you will receive a `rate_limit` error response.

## Webhooks

Certain requests, such as extracting emotion from a large audio, may have an asynchronous response (since there’s some complex background processing involved). For these requests you give us a webhook URL you want to be called when the request has finished processing.

To link up your requests to webhooks you can pass a `webhook` parameter when making these calls, containing a custom defined webhook identifier. We’ll pass this identifier back to you with the webhook request.

If you return anything other than a HTTP 200 status to the webhook POST then we’ll try to deliver the response to the webhook for up to 5 times with an exponential backoff. If we don't receive a 200 response from your server, we stop delivering the response.

For testing you can create a temporary webhook using https://webhook.site/ 

To know more about webhooks visit https://simonfredsted.com/1583

## Sync v/s Async v/s Realtime

As mentioned above, processing larger audio files take a while and hence we've created async apis specifically for them.

The sync apis are limited to audio files less than 2 minutes. For files with duration larger than those, use the async variant of the API.

For realtime processing we've created realtime api's based on grpc which accepts the data in smaller chunks and provides the response in realtime.

## Audio Encoding

DeepAffects supports various audio types for ease of integration. As a rule of thumb, we support all the audiotypes which are inherently supported by [ffmpeg](https://trac.ffmpeg.org/wiki/audio%20types)

A subset of the supported formats is specified as follows:

1. WAV
2. MP3
3. PCM (signed/unsigned) (8/16/32/64 bit) (big/little endian)
4. AAC
5. Mulaw
6. MP4
7. M4A
8. MOV
9. WMV (Windows Media Video)

> A more exhaustive list can be fetched via `ffmpeg -formats`.

### Best practices for handling audio data

1. It is recommended to pass audio without performing any cosmetic/structural changes to the original file. Changes such as encoding/re-encoding/upsampling/downsampling/automatic gain control (AGC) cause a downstream impact on the accuracy of the results.

2. Store the audio data in a lossless format wherever possible. Lossy audio may have a negative impact on the accuracy of the API.

3. In case of multiple channels, DeepAffects downmixes it to a single channel during transcoding.
