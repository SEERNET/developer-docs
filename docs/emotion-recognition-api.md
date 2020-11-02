---
id: emotion-recognition-api
title: Emotion Recognition API
sidebar_label: Emotion Recognition API
---

Emotion recognition api extract emotions from the audio file.

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/recognise_emotion`

`POST https://proxy.api.deepaffects.com/audio/generic/api/v2/async/recognise_emotion`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->

<!--Shell-->


```shell
curl -X POST \
"https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/recognise_emotion?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

curl -X POST \
"https://proxy.api.deepaffects.com/audio/generic/api/v2/async/recognise_emotion?apikey=<API_KEY>&webhook=<Your webhook url>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US"}

# in case of using a url, (urls supported only for async)
{"url": "https://publicly-facing-url.flac", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US"}
```

<!--Python-->

```python
import requests
import base64

async_url = "https://proxy.api.deepaffects.com/audio/generic/api/v2/async/recognise_emotion" # async api url
sync_url = "https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/recognise_emotion" # sync api url

querystring = {"apikey":"<API_KEY>", "webhook":"<WEBHOOK_URL>"}

payload = {
    "encoding": "Wave",
    "languageCode": "en-US"
}

# The api accepts data either as a url or as base64 encoded content
# (urls supported only for async)
# passing payload as url:
payload["url"] = "https://publicly-facing-url.wav"
# alternatively, passing payload as content:
with open(audio_file_name, 'rb') as fin:
    audio_content = fin.read()
payload["content"] = base64.b64encode(audio_content).decode('utf-8')

headers = {
    'Content-Type': "application/json",
}

# Async Request
response = requests.post(async_url, json=payload, headers=headers, params=querystring)

# alternatively use sync request for payload upto 1 minute
response = requests.post(sync_url, json=payload, headers=headers, params=querystring)

print(response.text)
```

<!--Javascript-->

```javascript
var request = require("request");

// you can also use sync url for the sync request
var options = { method: 'POST',
  url: 'https://proxy.api.deepaffects.com/audio/generic/api/v2/async/recognise_emotion',
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
     sampleRate: 8000,
     metrics: ['all'] },
  json: true };

request(options, function (error, response, body) {
  if (error) throw new Error(error);

  console.log(body);
});
```
<!--END_DOCUSAURUS_CODE_TABS-->

### Output

<!--DOCUSAURUS_CODE_TABS-->
<!--Sync-->

```json
[
    {
        "emotion": "joy",
        "start": 0.0,
        "end": 3.0
    },{
        "emotion": "neutral",
        "start": 3.0,
        "end": 6.0
    }
]
```

<!--Async-->
```json
{
"request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
"api": "requested_api_name"
}
```

<!--Webhook-->
```json
{
"request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
"response": [
        {
            "emotion": "joy",
            "start": 0.0,
            "end": 3.0
        },{
            "emotion": "neutral",
            "start": 3.0,
            "end": 6.0
        }
    ]
}
```
<!--END_DOCUSAURUS_CODE_TABS-->

### Body Parameters

| Parameter    | Type   | Description                               | Notes                        |
| ------------ | ------ | ----------------------------------------- | ---------------------------- |
| encoding     | String | Encoding of audio file like MP3, WAV etc. |                              |
| sampleRate   | Number | Sample rate of the audio file.            |                              |
| languageCode | String | Language spoken in the audio file.        | [default to &#39;en-US&#39;] |
| content      | String | base64 encoding of the audio file.        | Semi-Optional.               |
| url          | String | Publicly facing url.                      | Semi-Optional. Supported for async only.              |

> Exactly one of url and content should be passed. In case both values are passed, error is thrown.


### Query Parameters

| Parameter  | Type   | Description                                                            | Notes                                           |
| ---------- | ------ | ---------------------------------------------------------------------- | ----------------------------------------------- |
| apikey    | String | The apikey                                                             | Required for authentication inside all requests |
| webhook    | String | The webhook url at which the responses will be sent                    | Required for async requests                     |
| request_id | String | An optional unique id to link async response with the original request | Optional                                        |

### Output Parameters

Output is the list of emotion scores. The parameters in emotion scores are as follows:

| Parameter | Type   | Description                                     | Notes |
| --------- | ------ | ----------------------------------------------- | ----- |
| emotion   | String | Type of emotion. | Possible emotion values: `anger`, `excited`, `frustration`, `happy`, `sad` and `neutral` |
      |
| start     | Float  | Start of the audio segment.                     |       |
| end       | Float  | end of the audio segment.                       |       |

### Output Parameters (Async)

| Parameter  | Type   | Description                     | Notes                                                              |
| ---------- | ------ | ------------------------------- | ------------------------------------------------------------------ |
| request_id | String | The request id                  | This defaults to the originally sent id or is generated by the api |
| api        | String | The api method which was called |                                                                    |

### Output Parameters (Webhook)

| Parameter  | Type   | Description                                | Notes                                                              |
| ---------- | ------ | ------------------------------------------ | ------------------------------------------------------------------ |
| request_id | String | The request id                             | This defaults to the originally sent id or is generated by the api |
| response   | Object | Response object same as sync api response. |                                                                    |
