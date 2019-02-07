---
id: interaction-analytics-api
title: Interaction Analytics Api
sidebar_label: Interaction Analytics Api
---

DeepAffects Interaction Analytics API extracts comprehensive interaction based metrics from your audio data

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/async/analytics/interaction`

### Sample Code

### Shell

```shell
curl -X POST "https://proxy.api.deepaffects.com/audio/generic/api/v1/async/analytics/interaction?apikey=<API_KEY>&webhook=<WEBHOOK_URL>&request_id=<REQUEST_ID>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US"}

# in case of using a url
{"url": "https://publicly-facing-url.flac", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US"
```

### Javascript

```javascript
var request = require("request");

var options = { method: 'POST',
  url: 'https://proxy.api.deepaffects.com/audio/generic/api/v1/async/analytics/interaction',
  qs: 
   { apikey: '<API_KEY>',
     webhook: '<WEBHOOK_URL>' },
  headers: 
   { 'cache-control': 'no-cache',
     'Content-Type': 'application/json' },
  body: 
   { url: 'https://publicly-facing-url.flac',
     encoding: 'FLAC',
     languageCode: 'en-US',
     sampleRate: 8000 },
  json: true };

request(options, function (error, response, body) {
  if (error) throw new Error(error);

  console.log(body);
});
```

### Python

```python
import requests
import base64

url = "https://proxy.api.deepaffects.com/audio/generic/api/v1/async/analytics/interaction"

querystring = {"apikey":"<API_KEY>", "webhook":"<WEBHOOK_URL>", "request_id":"<OPTIONAL_REQUEST_ID>"}

payload = {
    "encoding": "FLAC",
    "languageCode": "en-US",
    "sampleRate": 8000
}

# The api accepts data either as a url or as base64 encoded content
# passing payload as url:
payload["url"] = "https://publicly-facing-url.flac"
# alternatively, passing payload as content:
with open(audio_file_name, 'rb') as fin:
    audio_content = fin.read()
payload["content"] = base64.b64encode(audio_content).decode('utf-8')

headers = {
    'Content-Type': "application/json",
}

response = requests.post(url, data=payload, headers=headers, params=querystring)

print(response.text)
```

### Output

```shell
# Async:

{
"request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
"api": "requested_api_name"
}

# Webhook:

{
"request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
"response":
    {
    "energy": [
        {
        "speaker_id": "0", 
        "value": 8
        },
        {
        "speaker_id": "1", 
        "value": 2
        }
    ], 
    "interruptions": [
        {
        "end": 3.1, 
        "start": 2.9
        }
    ], 
    "num_speakers": 2, 
    "pace": [
        {
        "speaker_id": "0", 
        "value": "slow"
        },
        {
        "speaker_id": "1", 
        "value": "fast"
        }
    ], 
    "questions_asked": [
        {
        "speaker_id": "0", 
        "value": 31
        },
        {
        "speaker_id": "1", 
        "value": 11
        }
    ], 
    "segments": [
        {
        "end": 1, 
        "speaker_id": "0", 
        "start": 0, 
        "text": "this is fun"
        },
        {
        "end": 3, 
        "speaker_id": "1", 
        "start": 1, 
        "text": "not really"
        }, 
        {
        "end": 4.5, 
        "speaker_id": "0", 
        "start": 3, 
        "text": "let's get this going"
        }
    ], 
    "talk_to_listen_ratio": [
        {
        "speaker_id": "0", 
        "value": "55:45"
        },
        {
        "speaker_id": "1", 
        "value": "45:55"
        }
    ], 
    "tone": [
        {
        "speaker_id": "0", 
        "value": "excited"
        },
        {
        "speaker_id": "1", 
        "value": "sad"
        }
    ], 
    "total_speech_duration": 4.5
    }
}
```

### Body Parameters

| Parameter    | Type   | Description                                              | Notes                        |
| ------------ | ------ | -------------------------------------------------------- | ---------------------------- |
| encoding     | String | Encoding of audio file like MP3, WAV etc.                |                              |
| sampleRate   | Number | Sample rate of the audio file.                           |                              |
| languageCode | String | Language spoken in the audio file.                       | [default to &#39;en-US&#39;] |
| content      | String | base64 encoding of the audio file.                       | Optional                     |
| url          | String | Publicly facing url                                      | Optional                     |

> Exactly one of url and content should be passed. In case both values are passed, error is thrown

### Query Parameters

| Parameter  | Type   | Description                                                            | Notes                                           |
| ---------- | ------ | ---------------------------------------------------------------------- | ----------------------------------------------- |
| apikey    | String | The apikey                                                             | Required for authentication inside all requests |
| webhook    | String | The webhook url at which the responses will be sent                    | Required for async requests                     |
| request_id | Number | An optional unique id to link async response with the original request | Optional                                        |

### Output Parameters (Async)

| Parameter  | Type   | Description                     | Notes                                                              |
| ---------- | ------ | ------------------------------- | ------------------------------------------------------------------ |
| request_id | String | The request id                  | This defaults to the originally sent id or is generated by the api |
| api        | String | The api method which was called |                                                                    |

### Output Parameters (Webhook)

| Parameter  | Type   | Description                          | Notes                                                              |
| ---------- | ------ | ------------------------------------ | ------------------------------------------------------------------ |
| request_id | String | The request id                       | This defaults to the originally sent id or is generated by the api |
| response   | Object | The actual output of the interaction analytics | The Interaction Analytics object is defined below                               |

#### Interaction Analytics Object

| Parameter    | Type   | Description                     | Notes                                                                           |
| ------------ | ------ | ------------------------------- | ------------------------------------------------------------------------------- |
| num_speakers | Number | The number of speakers detected | The number of speaker will be detected only when the request set speakers to -1 |
| segments     | List   | List of diarized segments       | The Diarized Segment is defined below                        |
| energy     | List   | List of SpeakerId-Value Segments       | The SpeakerId-Value Segment is defined below                        |
| interruptions     | List   | List of Timed Segments       | The Timed Segment is defined below                        |
| pace     | List   | List of SpeakerId-Value Segments       |                         |
| questions_asked | List  | List of SpeakerId-Value Segments       |             |
| tone | List    | List of SpeakerId-Value Segments       |              |
| talk_to_listen_ratio | List    | List of SpeakerId-Value Segments       |              |


#### Diarized Segment

| Parameter  | Type   | Description                                        | Notes |
| ---------- | ------ | -------------------------------------------------- | ----- |
| speaker_id | String | The speaker id for the corresponding audio segment |       |
| start      | Number | Start time of the audio segment in seconds         |       |
| end        | Number | End time of the audio segment in seconds           |       |
| text        | String | The transcription output corresponding to the segment           |       |

#### SpeakerId-Value Segment

| Parameter  | Type   | Description                                        | Notes |
| ---------- | ------ | -------------------------------------------------- | ----- |
| speaker_id | String | The speaker id for the corresponding audio segment |       |
| value      |  Basic|   The value of the parent's key for this speaker        |       |


#### Timed Segment

| Parameter  | Type   | Description                                        | Notes |
| ---------- | ------ | -------------------------------------------------- | ----- |
| start      | Number | Start time of the audio segment in seconds         |       |
| end        | Number | End time of the audio segment in seconds           |       |

