---
id: speaker-enrollment-api
title: Speaker Enrollment API
sidebar_label: Speaker Enrollment API
---

<h3> Speaker Enrollment API for Identification (REST Api)</h3>

Speaker enrollment api enrolls user for [Speaker Identification Api](./speaker-identification-api.html) and [Realtime Speaker Identification Api](./realtime-speaker-identification-api.html).

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/diarization/enroll`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->
```shell
curl -X POST \
"https://proxy.api.deepaffects.com/audio/generic/api/v2/sync/diarization/enroll?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US", "speakerId": "user1" }
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Output

<!--DOCUSAURUS_CODE_TABS-->
<!--Success-->
```json
{
  "message": "Success"
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
>  * Enroll a user with one to three audio samples of 10-12 seconds each, no more than 30 seconds, and ideally with at least 6 seconds, where there's continuous speech, no silence, and preferably no background noise.
>  * Ideally, only enroll multiple audio samples when they show the diversity in the person's speech, and do not use multiple samples from same audio recording.
>  * All audio samples in a speakerId should be of the same sample rate, although you may create multiple speakerIds per person, each with different sample rates.
>  * You may add the additional audio samples to a speakerId over an extended time period.


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

| Parameter | Type   | Description                              | Notes                                                                                                                                                                 |
| --------- | ------ | ---------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| message   | String | Status of enrollment Success or Failure | Success: Current enrollment is successful. Failure: The enrollment failed |

### Speaker Enrollment Delete API for Identification (REST Api)

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

### Get Enrolled Speakers Api

This API lists all the enrolled speakers enrolled for a developer along with enrollment status

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


```json
# The above command returns output:
{
  "developer_id": "testuser",
  "enrolled_speaker_ids": [
    {
      "speaker_id": "speaker_1",
      "enrollment_complete" "True"
    }
  ]
}
```

### Query Parameters

| Parameter | Type   | Description | Notes                                           |
| --------- | ------ | ----------- | ----------------------------------------------- |
| apikey   | String | The apikey  | Required for authentication inside all requests |

### About

DeepAffects is a speech analysis platform for Developers. We offer a number of speech analysis apis like, Speech Enhancement, Multi-Speaker Diarization, Emotion Recognition, Voice-prints, Conversation Metrics etc. For more information, checkout our [developer portal](https://developers.deepaffects.com)
