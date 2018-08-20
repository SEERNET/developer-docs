---
id: speaker-identification-api
title: Speaker Identification Api
sidebar_label: Speaker Identification Api
---

Speaker identification api tries to figure out "Who Speaks When" for already enrolled speakers.
Splits audio clip into segments corresponding to a unique speaker and returns start and end of the segment

> Enroll user using [Speaker Enrollment Api](./speaker-enrollment-api) before using identification api.

### POST Request

### Async

V1 - `POST https://proxy.api.deepaffects.com/audio/generic/api/v1/async/diarization/identify`
<br />
V2 - `POST https://proxy.api.deepaffects.com/audio/generic/api/v2/async/diarization/identify`
<br />
V3 - `POST https://proxy.api.deepaffects.com/audio/generic/api/v3/async/diarization/identify`
<br />

### Sync

V1 - `POST https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/diarization/identify`
<br />
V2 - `POST https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/diarization/identify`

### Choose Api Version

Each api version is optimized to provide optimal latency and accuracy for different usecases. Api version should be selected depending upon the trade-off betweeen accuracy and latency suitable for the required usecase.

| Api Version | Latency | Accuracy |
| ----------- | ------- | -------- |
| V1 Async    | Low     | Good     |
| V2 Async    | More    | Better   |
| V3 Async    | High    | Best     |
| V1 Sync     | Low     | Good     |
| V2 Sync     | High    | Best     |

### Sample Code

### Shell

```shell
curl -X POST "https://proxy.api.deepaffects.com/audio/generic/api/v3/async/diarization/identify?apikey=<API_KEY>&webhook=<WEBHOOK_URL>&request_id=<REQUEST_ID>" -H 'content-type: application/json' -d @data.json

curl -X POST "https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/diarization/identify?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US", speakerIds: ["user1"]}
```

### Output

```shell
# Sync:

{
    "segments":
        [{
            "speaker_id": "speaker1",
            "start": 0,
            "end": 1
        }]
}


# Async:

{
"request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
"api": "requested_api_name"
}

# Webhook:

{
"request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
"response": {
    "segments":
        [{
            "speaker_id": "speaker1",
            "start": 0,
            "end": 1
        }]
}
}
```

### Body Parameters

| Parameter    | Type         | Description                               | Notes                        |
| ------------ | ------------ | ----------------------------------------- | ---------------------------- |
| encoding     | String       | Encoding of audio file like MP3, WAV etc. |                              |
| sampleRate   | Number       | Sample rate of the audio file.            |                              |
| languageCode | String       | Language spoken in the audio file.        | [default to &#39;en-US&#39;] |
| content      | String       | base64 encoding of the audio file.        |                              |
| speakerIds   | List[String] | List of enrolled speakers to identify     |                              |

### Query Parameters

| Parameter  | Type   | Description                                                            | Notes                                           |
| ---------- | ------ | ---------------------------------------------------------------------- | ----------------------------------------------- |
| api_key    | String | The apikey                                                             | Required for authentication inside all requests |
| webhook    | String | The webhook url at which the responses will be sent                    | Required for async requests                     |
| request_id | Number | An optional unique id to link async response with the original request | Optional                                        |

### Output Parameters (Async)

| Parameter  | Type   | Description                     | Notes                                                              |
| ---------- | ------ | ------------------------------- | ------------------------------------------------------------------ |
| request_id | String | The request id                  | This defaults to the originally sent id or is generated by the api |
| api        | String | The api method which was called |                                                                    |

### Output Parameters (Webhook)

| Parameter  | Type   | Description                 | Notes                                                              |
| ---------- | ------ | --------------------------- | ------------------------------------------------------------------ |
| request_id | String | The request id              | This defaults to the originally sent id or is generated by the api |
| segments   | List   | List of identified segments | The Speaker Identification Segment object is defined below         |

#### Speaker Identification Segment

| Parameter  | Type   | Description                           | Notes |
| ---------- | ------ | ------------------------------------- | ----- |
| speaker_id | String | speaker id of the identified speaker. |       |
| start      | Float  | Start of the audio segment.           |       |
| end        | Float  | end of the audio segment.             |       |