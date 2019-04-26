---
id: speaker-diarization-api
title: Speaker Diarization API
sidebar_label: Speaker Diarization API
---

Speaker diarization api tries to figure out "Who Speaks When".
Splits audio clip into segments corresponding to a unique speaker

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v2/async/diarize`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->

```shell
curl -X POST "https://proxy.api.deepaffects.com/audio/generic/api/v2/async/diarize?apikey=<API_KEY>&webhook=<WEBHOOK_URL>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US", "audioType": "callcenter"}
```
<!--Javascript-->

```javascript
var DeepAffects = require("deep-affects");
var defaultClient = DeepAffects.ApiClient.instance;

// Configure API key authorization: UserSecurity
var UserSecurity = defaultClient.authentications["UserSecurity"];
UserSecurity.apiKey = "<API_KEY>";

var apiInstance = new DeepAffects.DiarizeApiV2();

var body = DeepAffects.DiarizeAudio.fromFile("/path/to/file"); // DiarizeAudio | Audio object that needs to be diarized.

var callback = function(error, data, response) {
  if (error) {
    console.error(error);
  } else {
    console.log("API called successfully. Returned data: " + data);
  }
};

webhook = "https://your/webhook/";
// async request
apiInstance.asyncDiarizeAudio(body, webhook, callback);
```
<!--Python-->

```python
import requests
import base64

url = "https://proxy.api.deepaffects.com/audio/generic/api/v2/async/diarize"

querystring = {"apikey":"<API_KEY>", "webhook":"<WEBHOOK_URL>"}

payload = {
    "encoding": "Wave",
    "languageCode": "en-US",
    "speakers": -1,
    "doVad": True
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
  "num_speakers": 2,
  "segments":[
        {
            "speaker_id": "speaker1",
            "start": 0,
            "end": 1
        }
    ]
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
| speakerCount     | Number | Number of speakers in the file (-1 for unknown speakers) | [default to -1]              |
| audioType    | String | Type of the audio based on number of speakers            | [default to callcenter]      |
| speakerIds   | List[String] | Optional set of speakers to be identified from the call | [default to []]      |
| doVad        | Bool   | Apply voice activity detection                           | [default to False]           |
| content      | String | base64 encoding of the audio file.                       | Optional                     |
| url          | String | Publicly facing url                                      | Optional                     |
| source          | String | The source for the audio file: webex, zoom, gotomeeting, phone                                      | Optional                     |

audioType: can have the following values: 
  1) callcenter 
  2) meeting
  3) earningscalls
  4) interview
  5) media-broadcast

> We recommend using callcenter when there are upto 6 speakers expected to be identified and meeting when more than 6 speakers are expected.

> Exactly one of url and content should be passed. In case both values are passed, error is thrown


> doVad: Default=False. This parameters is required if you want silence & noise segments removed from the diarization output. 

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
| response   | Object | The actual output of the diarization | The Diarized object is defined below                               |

#### Diarized Object

| Parameter    | Type   | Description                     | Notes                                                                           |
| ------------ | ------ | ------------------------------- | ------------------------------------------------------------------------------- |
| num_speakers | Number | The number of speakers detected | The number of speaker will be detected only when the request set speakers to -1 |
| segments     | List   | List of diarized segments       | The Diarized Segment is defined below                                           |

#### Diarized Segment

| Parameter  | Type   | Description                                        | Notes |
| ---------- | ------ | -------------------------------------------------- | ----- |
| speaker_id | String | The speaker id for the corresponding audio segment |       |
| start      | Number | Start time of the audio segment in seconds         |       |
| end        | Number | End time of the audio segment in seconds           |       |
