---
id: speaker-enrollment-api
title: Speaker Enrollment API
sidebar_label: Speaker Enrollment API
---

<h3> Speaker Enrollment API for Text Independent Speaker Identification (REST Api)</h3>

Speaker Enrollment process is *text independent*. This implies that there are no restrictions on what the speaker says in the audio and hence no specific passphrases are required during the process. Speaker Enrollment API enrolls user for [TI Speaker Identification Api](./speaker-identification-api.html),  [Realtime Speaker Identification Api](./realtime-speaker-identification-api.html),
[Speaker Diarization Api](./speaker-diarization-api.html)


### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/diarization/enroll`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->
```shell
curl -X POST \
"https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/diarization/enroll?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US", "speakerId": "speaker1" }
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Output

<!--DOCUSAURUS_CODE_TABS-->
<!--Success-->
```json
{
  "enroll_quality": "average", 
  "enrollment_complete": true, 
  "message": "Success", 
  "speaker_id": "speaker1", 
  "total_enroll_duration": 30.0, 
  "total_speech_duration": 20.0
}
```
<!--Failure-->

```json
{
  "fault": {
    "detail": {
      "error_code": "com.deepaffects.BadRequest"
    }, 
    "fault_string": "Error in enroll: Insufficent speech content in audio"
  }
}
```
<!--END_DOCUSAURUS_CODE_TABS-->


> **NOTES:** 
>  * Enroll a user with three to five audio samples of 12-24 seconds each, no more than 30 seconds, and with at least 10 seconds, where there's continuous speech, no silence, and preferably no background noise.
>  * Ideally, only enroll multiple audio samples when they show the diversity in the person's speech, and do not use multiple samples from same audio recording.
>  * Enrollments with less than 6 seconds of speech will be rejected.
>  * You may add the additional audio samples to a speakerId over an extended time period.
>  * If total speech duration of an enrollment is less than 12 seconds, the enrollment will be treated as incomplete and enrollment_complete will be set to false.
>  * Enrollments with status enrollment_complete=true will be considered for identification, otherwise it would return error message.


### Body Parameters

| Parameter    | Type   | Description                               | Notes                        |
| ------------ | ------ | ----------------------------------------- | ---------------------------- |
| encoding     | String | Encoding of audio file like MP3, WAV etc. |                              |
| sampleRate   | Number | Sample rate of the audio file.            |                              |
| languageCode | String | Language spoken in the audio file.        | [default to &#39;en-US&#39;] |
| content      | String | base64 encoding of the audio file.        |                              |
| speakerId    | String | speaker id to be registered               | acceptable format: `[a-zA-Z0-9_]+` |

### Query Parameters

| Parameter | Type   | Description | Notes                                           |
| --------- | ------ | ----------- | ----------------------------------------------- |
| apikey   | String | The apikey  | Required for authentication inside all requests |

### Output Parameters (Sync)

| Parameter             | Type   | Description                             | Notes                              |
| --------------------- | ------ | --------------------------------------- | ---------------------------------- |
| message               | String | Status of enrollment Success            | Success:  enrollment is successfull|
| speaker_id            | String | Registered speaker id                   |                                    |
| enroll_quality        | String | Quality of the enrollment               | values: poor, average, good, high  |
| enrollment_complete   | Bool   | Status of the enrollment                | true if total speech exceeds 12sec |
| total_speech_duration | Number | Total Speech Duration of the enrollment |                                    |
| total_enroll_duration | Number | Total Duration of the enrollment        |                                    |

### Speaker Enrollment Delete API (REST Api)

This API deletes speaker enrollment for the user

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/diarization/delete`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->

```shell
curl -X POST \
"https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/diarization/delete?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"speakerId": "user1"}
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Output
```json
# The above command returns output:
{
  "message": "Success"
}
```

### Body Parameters

| Parameter | Type   | Description                 | Notes |
| --------- | ------ | --------------------------- | ----- |
| speakerId | String | speaker id to be registered |       |

### Query Parameters

| Parameter | Type   | Description | Notes                                           |
| --------- | ------ | ----------- | ----------------------------------------------- |
| apikey   | String | The apikey  | Required for authentication inside all requests |

### Output Parameters (Sync)

| Parameter | Type   | Description    | Notes              |
| --------- | ------ | -------------- | ------------------ |
| message   | String | Request status | Success or Failure |


### Get Speaker Enrollment Status Api

This API fetches the status of speaker enrollment for a developer

### GET Request

`GET https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/diarization/enroll`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->

```shell
curl -X GET \
"https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/diarization/enroll?apikey=<API_KEY>&speakerId=<SPEAKER_ID>"
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Output

```json
# The above command returns output:
{
  "speaker_id": "speaker_1",
  "enrollment_complete":true,
  "total_speech_duration": 20.0,
  "total_enroll_duration": 30.0,
  "enroll_quality": "average"
}
```

### Query Parameters

| Parameter | Type   | Description                             | Notes                                           |
| --------- | ------ | --------------------------------------- | ----------------------------------------------- |
| apikey    | String | The apikey                              | Required for authentication inside all requests |
| speakerId | String | speaker id whose details to be fetched  |                                                 |


### Get All Enrolled Speakers Api

This API lists all the completely enrolled speakers for a developer along with other data

### GET Request

`GET https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/diarization/get_enrolled_speakers`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->

```shell
curl -X GET \
"https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/diarization/get_enrolled_speakers?apikey=<API_KEY>"
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Output

```json
# The above command returns output:
{
  "developer_id": "testuser",
  "enrolled_speaker_ids": [
    {
      "speaker_id": "speaker_1",
      "enrollment_complete":true,
      "total_speech_duration": 20.0,
      "total_enroll_duration": 30.0,
      "enroll_quality": "average"
    }
  ]
}
```

### Query Parameters

| Parameter      | Type   | Description | Notes                                                                       |
| -------------- | ------ | ----------- | --------------------------------------------------------------------------- |
| apikey         | String | The apikey  | Required for authentication inside all requests                             |
| getAllSpeakers | Bool   | true/false  | Set to true for fetching incomplete enrolled speakers too. Default to false |
