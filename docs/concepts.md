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

## Sync v/s Async v/s Realtime

As mentioned above, processing larger audio files take a while and hence we've created async apis specifically for them.

The sync apis are limited to audio files less than 2 minutes. For files with duration larger than those, use the async variant of the API.

For realtime processing we've created realtime api's based on grpc which accepts the data in smaller chunks and provides the response in realtime.
