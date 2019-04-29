---
id: speech-to-text-api
title: Speech-to-Text API
sidebar_label: Automatic Speech Recognition API
---

Automatic Speech Recognition API provides high-quality speech-to-text conversion powered by machine learning. The api also supports speaker diarization and smart punctuation to further enhance the utility of the transcribed output.

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/async/asr`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->

<!--Shell-->

```shell
curl -X POST \
"https://proxy.api.deepaffects.com/audio/generic/api/v1/async/asr?apikey=<API_KEY>&webhook=<WEBHOOK_URL>" -H 'content-type: application/json' -d @data.json

# contents of data.json with content
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US", "audioType": "callcenter", "enableSpeakerDiarization": true}

# contents of data.json with url
{"url": "https://publicly-facing-url.flac", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US", "audioType": "callcenter", "enableSpeakerDiarization": true}
```

<!--Javascript-->

```javascript
var request = require("request");

var options = { method: 'POST',
  url: 'https://proxy.api.deepaffects.com/audio/generic/api/v1/async/asr',
  qs: 
   { apikey: '<API_KEY>',
     webhook: '<WEBHOOK_URL>'},
  headers: 
   {  'Content-Type': 'application/json' },
  body: 
   { encoding: 'FLAC',
     languageCode: 'en-US',
     url: 'https://publicly-facing-url.flac',
     sampleRate: 8000,
     enableSpeakerDiarization: true,
     enablePunctuation: true,
     audioType: "callcenter" },
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

url = "https://proxy.api.deepaffects.com/audio/generic/api/v1/async/asr"

querystring = {"apikey":"<API_KEY>", "webhook":"<WEBHOOK_URL>"}

payload = {
    "encoding": "FLAC",
    "languageCode": "en-US",
    "sampleRate": 8000
    "audioType": "callcenter",
    "enableSpeakerDiarization": true,
    "enablePunctuation": true
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
  "num_speakers": 2,
  "confidence": 0.97,
  "words":[
        {
            "speaker_id": "1",
            "start": 0,
            "end": 1,
            "word": "Hi",
            "confidence": 0.97
        },
        {
            "speaker_id": "2",
            "start": 1.2,
            "end": 2,
            "word": "Hello",
            "confidence": 0.97
        },
        {
            "speaker_id": "2",
            "start": 2,
            "end": 2.6,
            "word": "this",
            "confidence": 0.97
        },
        {
            "speaker_id": "2",
            "start": 2.6,
            "end": 3,
            "word": "is",
            "confidence": 0.97
        },
        {
            "speaker_id": "2",
            "start": 3,
            "end": 4,
            "word": "Susan",
            "confidence": 0.97
        }
    ],
    "transcript": "Hi! Hello, this is Susan."
  }
}
```
<!--END_DOCUSAURUS_CODE_TABS-->

### Body Parameters

| Parameter    | Type   | Description                                              | Notes                        |
| ------------ | ------ | -------------------------------------------------------- | ---------------------------- |
| encoding     | String | Encoding of audio file like MP3, WAV etc.                |                              |
| sampleRate   | Number | Sample rate of the audio file.                           |                              |
| languageCode | String | Language spoken in the audio file.                       | [default to &#39;en-US&#39;] |
| audioType    | String | Type of the audio based on number of speakers            | [default to callcenter]      |
| content      | String | base64 encoding of the audio file.                       | Optional                     |
| url          | String | Publicly facing url                                      | Optional                     |
| source          | String | The source for the audio file: webex, zoom, gotomeeting, phone                                      | Optional                     |
| enableSpeakerDiarization  | Boolean | Tags each word corresponding to the speaker                                   | [default to false]                     |
| enablePunctuation  | Boolean | Enables DeepAffects [Smart Punctuation API](text-punctuation-api.md)        | [default to true]                     |

audioType: can have the following values: 
  1) callcenter 
  2) meeting
  3) earningscalls
  4) interview
  5) media-broadcast

> We recommend using callcenter when there are upto 6 speakers expected to be identified and meeting when more than 6 speakers are expected.

> Exactly one of url and content should be passed. In case both values are passed, error is thrown

> source: Adding source information enables an enhanced model which is built specifically for those audio sources. 

### Query Parameters

| Parameter  | Type   | Description                                                            | Notes                                           |
| ---------- | ------ | ---------------------------------------------------------------------- | ----------------------------------------------- |
| apikey    | String | The apikey                                                             | Required for authentication inside all requests |
| webhook    | String | The webhook url at which the responses will be sent                    | Required for async requests                     |
| request_id | String | An optional unique id to link async response with the original request | Optional                                        |

### Output Parameters (Async)

| Parameter  | Type   | Description                     | Notes                                                              |
| ---------- | ------ | ------------------------------- | ------------------------------------------------------------------ |
| request_id | String | The request id                  | This defaults to the originally sent id or is generated by the api |
| api        | String | The api method which was called |                                                                    |

### Output Parameters (Webhook)

| Parameter  | Type   | Description                          | Notes                                                              |
| ---------- | ------ | ------------------------------------ | ------------------------------------------------------------------ |
| request_id | String | The request id                       | This defaults to the originally sent id or is generated by the api |
| response   | Object | The actual output of the transcription | The Transcribed object is defined below                               |

#### Transcribed Object

| Parameter    | Type   | Description                     | Notes                                                                           |
| ------------ | ------ | ------------------------------- | ------------------------------------------------------------------------------- |
| num_speakers | Number | The number of speakers detected | Field is set only when `enableSpeakerDiarization` is `true` |
| words     | List   | List of word segments       | The Word Segment is defined below                                           |
| transcript     | String   | The entire transcript with/without punctuations according to the input       |                                            |
| confidence | Number | Overall transcription confidence | |


#### Word Segment

| Parameter  | Type   | Description                                        | Notes |
| ---------- | ------ | -------------------------------------------------- | ----- |
| speaker_id | String | The speaker id for the corresponding audio segment |   Field is set only when `enableSpeakerDiarization` is `true`    |
| start      | Number | Start time of the audio segment in seconds         |       |
| end        | Number | End time of the audio segment in seconds           |       |
| word        | String | The word corresponding to the audio segment         |       |
| confidence        | Number | Confidence score for the word           |       |
