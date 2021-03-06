---
id: voice-activity-detection-api
title: Voice Activity Detection API
sidebar_label: Voice Activity Detection API
---

Voice activity detection (VAD) is a technique used in speech processing to detect the presence (or absence) of human speech. The DeepAffects Voice activity detection API analyzes the audio input and tags specific segments where human speech is detected. We additionaly tag non-speech segments with additional metadata such as noise, music, applause or laughter for additional down stream processing.


### POST Request

### Async

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/async/vad`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->

<!--Shell-->

```shell
curl -X POST \
"https://proxy.api.deepaffects.com/audio/generic/api/v1/async/vad?apikey=<API_KEY>&webhook=<WEBHOOK_URL>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US", "minNonSpeechDuration": 1}
```
<!--Javascript-->

```javascript
var request = require("request");

var options = { method: 'POST',
  url: 'https://proxy.api.deepaffects.com/audio/generic/api/v1/async/vad',
  qs: 
   { apikey: '<API_KEY>',
     webhook: '<WEBHOOK_URL>' },
  headers: 
   { 'Content-Type': 'application/json' },
  body: 
   { languageCode: 'en-US',
     sampleRate: '8000',
     url: 'https://publicly-facing-url.wav',
     minNonSpeechDuration: 1 },
  json: true };

request(options, function (error, response, body) {
  if (error) throw new Error(error);

  console.log(body);
});

```
<!--Python-->

```python
import requests
import base64

url = "https://proxy.api.deepaffects.com/audio/generic/api/v1/async/vad"

querystring = {"apikey":"<API_KEY>", "webhook":"<WEBHOOK_URL>"}

payload = {
    "encoding": "Wave",
    "languageCode": "en-US",
    "minNonSpeechDuration": 1
}

# The api accepts data either as a url or as base64 encoded content
# passing payload as url:
payload["url"] = "https://publicly-facing-url.wav"
# alternatively, passing payload as content:
with open(audio_file_name, 'rb') as fin:
    audio_content = fin.read()
payload["content"] = base64.b64encode(audio_content).decode('utf-8')

headers = {
    'Content-Type': "application/json",
}

response = requests.post(url, json=payload, headers=headers, params=querystring)

print(response.text)
```
<!--END_DOCUSAURUS_CODE_TABS-->

### Output

<!--DOCUSAURUS_CODE_TABS-->

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
"response": {
    "segments":
        [{
            "tag": "speech",
            "start": 0,
            "end": 1
        },{
            "tag": "laughter",
            "start": 1,
            "end": 3
        }]
}
}
```
<!--END_DOCUSAURUS_CODE_TABS-->

### Body Parameters

| Parameter            | Type   | Description                                    | Notes                        |
| -------------------- | ------ | ---------------------------------------------- | ---------------------------- |
| encoding             | String | Encoding of audio file like MP3, WAV etc.      |                              |
| sampleRate           | Number | Sample rate of the audio file.                 |                              |
| languageCode         | String | Language spoken in the audio file.             | [default to &#39;en-US&#39;] |
| minNonSpeechDuration | Number | The minimum duration for a non-speech segment. | Optional, defaults to 0.     |
| content              | String | base64 encoding of the audio file.             | Semi-Optional.               |
| url                  | String | Publicly facing url.                           | Semi-Optional.               |

> NOTE: Exactly one of url and content should be passed. In case both values are passed, error is thrown.


### Query Parameters

| Parameter  | Type   | Description                                                             | Notes                                            |
| ---------- | ------ | ----------------------------------------------------------------------- | ------------------------------------------------ |
| apikey     | String | The apikey.                                                             | Required for authentication inside all requests. |
| webhook    | String | The webhook url at which the responses will be sent.                    | Required for async requests.                     |
| request_id | String | An optional unique id to link async response with the original request. | Optional.                                        |

### Output Parameters (Async)

| Parameter  | Type   | Description                      | Notes                                                               |
| ---------- | ------ | -------------------------------- | ------------------------------------------------------------------- |
| request_id | String | The request id.                  | This defaults to the originally sent id or is generated by the api. |
| api        | String | The api method which was called. |                                                                     |

### Output Parameters (Webhook)

| Parameter  | Type   | Description                  | Notes                                                               |
| ---------- | ------ | ---------------------------- | ------------------------------------------------------------------- |
| request_id | String | The request id.              | This defaults to the originally sent id or is generated by the api. |
| segments   | List   | List of identified segments. | The Voice Activity Detection Segment object is defined below .      |

#### Voice Activity Detection Segment

| Parameter | Type   | Description                                      | Notes |
| --------- | ------ | ------------------------------------------------ | ----- |
| tag       | String | Tag for the corresponding segment, eg: `speech`. |       |
| start     | Float  | Start of the audio segment.                      |       |
| end       | Float  | end of the audio segment.                        |       |

> Note: Currently supported tags: noise, speech, music, applause, laughter.