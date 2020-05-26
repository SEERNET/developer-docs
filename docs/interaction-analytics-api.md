---
id: interaction-analytics-api
title: Interaction Analytics API
sidebar_label: Interaction Analytics API
---

DeepAffects Interaction Analytics API extracts comprehensive interaction based metrics from your audio data

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/async/analytics/interaction`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->

<!--Shell-->

```shell
curl -X POST \
"https://proxy.api.deepaffects.com/audio/generic/api/v1/async/analytics/interaction?apikey=<API_KEY>&webhook=<WEBHOOK_URL>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US"}

# in case of using a url
{"url": "https://publicly-facing-url.flac", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US"}
```

<!--Javascript-->

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
     sampleRate: 8000,
     metrics: ['all'] },
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

url = "https://proxy.api.deepaffects.com/audio/generic/api/v1/async/analytics/interaction"

querystring = {"apikey":"<API_KEY>", "webhook":"<WEBHOOK_URL>"}

payload = {
    "encoding": "FLAC",
    "languageCode": "en-US",
    "sampleRate": 8000,
    "metrics": ["all"]
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
        "questions": [
          {
            "end": 293.02, 
            "start": 292.1, 
            "text": "Does that make sense?"
          }
        ], 
        "speaker_id": "0", 
        "value": 1
      }, 
      {
        "questions": [
          {
            "end": 420.02, 
            "start": 418.1, 
            "text": "Sorry, what platform?"
          }
        ], 
        "speaker_id": "1", 
        "value": 1
      }
    ], 
    "segments": [
      {
        "emotion": "joy", 
        "emotion_score": 0.99, 
        "end": 1, 
        "speaker_id": "0", 
        "start": 0, 
        "text": "this is fun"
      }, 
      {
        "emotion": "sadness", 
        "emotion_score": 0.92, 
        "end": 3, 
        "speaker_id": "1", 
        "start": 1, 
        "text": "not really"
      }, 
      {
        "emotion": "joy", 
        "emotion_score": 0.81, 
        "end": 4.5, 
        "speaker_id": "0", 
        "start": 3, 
        "text": "let's get this going"
      },
      ...
    ], 
    "talk_to_listen": [
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
    "total_speech_duration": 500.5
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
| content      | String | base64 encoding of the audio file.                       | Semi-Optional                     |
| url          | String | Publicly facing url                                      | Semi-Optional                     |
| separateSpeakerPerChannel | Boolean | Set to True if the input audio is multi-channel and each channel has a separate speaker | [default to False] |
| speakerIds   | List[String] | Optional set of speakers to be identified from the call | [default to []]      |
| metrics          | List[String] | List of metrics to be run. Send ['all'] to extract all analytics                                      | Acceptable values in the list: 'all', 'emotion', 'energy', 'interruptions', 'pace', 'questions_asked', 'tone', 'talk_to_listen', 'key_phrases', 'summary', 'intents'                |

Additional to the above parameters, all the parameters from the [Speaker Diarization API](./speaker-diarization-api.html) and the [Speech Recognition API](./speech-to-text-api.html) are also acknowledged.

> Exactly one of url and content should be passed. In case both values are passed, an error is thrown.

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
| response   | Object | The actual output of the interaction analytics | The Interaction Analytics object is defined below                               |

#### Interaction Analytics Object

| Parameter    | Type   | Description                     | Notes                                                                           |
| ------------ | ------ | ------------------------------- | ------------------------------------------------------------------------------- |
| num_speakers | Number | The number of speakers detected | The number of speakers will be equal to `speakerCount` parameter. In case `speakerCount` is set as `-1`, or isn't set, the number of speakers are estimated algorithmically|
| segments     | List   | List of diarized segments       | The Diarized Segment is defined below                        |
| energy     | List   | List of SpeakerId-Value Segments       | The SpeakerId-Value Segment is defined below                        |
| interruptions     | List   | List of Timed Segments       | The Timed Segment is defined below                        |
| pace     | List   | List of SpeakerId-Value Segments       |                         |
| questions_asked | List  | List of Question-Asked Segments       |             |
| tone | List    | List of SpeakerId-Value Segments       |              |
| talk_to_listen | List    | List of SpeakerId-Value Segments       |              |
| intent_timings | List | List of Intent-Timings Segment |              |
| key_phrase_timings | List | List of KeyPhrase-Timings-Timings Segment |              |
| calleq | Object    | Aggregate level metrics       | The CallEQ Object is defined below           |


#### Diarized Segment

| Parameter  | Type   | Description                                        | Notes |
| ---------- | ------ | -------------------------------------------------- | ----- |
| speaker_id | String | The speaker id for the corresponding audio segment |       |
| start      | Number | Start time of the audio segment in seconds         |       |
| end        | Number | End time of the audio segment in seconds           |       |
| text       | String | The transcription output corresponding to the segment           |       |
| emotion    | String | Emotion corresponding to the segment                | Will be computed only if specified via metrics |
| emotion_score | Number | The confidence score for the emotion | Will be computed only if emotion is computed |
| intent     | String | Intent corresponding to the segment: Current intent list: budget, authority, timing, action, need               | Will be computed only if specified via metrics |

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


#### CallEQ Object

| Parameter  | Type   | Description                                        | Notes |
| ---------- | ------ | -------------------------------------------------- | ----- |
| summary      | String | Extractive summary comprised of top few sentences from the conversation to present the gist of the call.          |       |
| key_phrases        | List[String] | Top key phrases in the conversation ranked based on their importance and affinity to a extreme sentiments.           |       |
| loudness        | List[Tuple] | start, end timings of 90% percentile "loud" segments           |       |


#### Question-Asked Segment

| Parameter  | Type   | Description                                        | Notes |
| ---------- | ------ | -------------------------------------------------- | ----- |
| speaker_id | String | The speaker id for the corresponding questions segment |       |
| value        | Number | Count of number of questions asked by the speaker           |       |
| questions        | List[Objects] | List of objects with start, end, text entries. This object describes the exact point in time where the question was asked            |       |

#### Intent-Timings Segment

| Parameter  | Type   | Description                                        | Notes |
| ---------- | ------ | -------------------------------------------------- | ----- |
| speaker_id | String | The speaker id for the corresponding questions segment |       |
| intents    | List[Objects] | List of objects with start, end, text, intent entries. This object describes the exact point in time where the intent was detected            |       |


#### KeyPhrase-Timings Segment

| Parameter  | Type   | Description                                        | Notes |
| ---------- | ------ | -------------------------------------------------- | ----- |
| start      | Number | Start time of the audio segment in seconds         |       |
| end        | Number | End time of the audio segment in seconds           |       |
| keyphrase        | String | The key phrase at the point in time          |       |
