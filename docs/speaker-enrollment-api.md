---
id: speaker-enrollment-api
title: Speaker Enrollment/Deletion Api
sidebar_label: Speaker Enrollment/Deletion Api
---

<h3> Speaker Enrollment API for Identification (REST Api)</h3>

Speaker enrollment api enrolls user for [Speaker Identification Api](./speaker-identification-api.html) and [Realtime Speaker Identification Api](./realtime-speaker-identification-api.html).

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/diarization/enroll`

### Sample Code

```shell
curl -X POST "https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/diarization/enroll?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US", "speakerId": "user1" }
```

### Output

```shell
# Sync:

{
  "message": "Success"
}
```

> For every successfull enrollment the response will containe message as "Success".  
>  Repeat the enrollment with different audios untill the status message changes to
> "Complete". Then proceed with speaker identification

 <br />
> Enroll a user atleast thrice with 3 different audio, each about 10-12 seconds.
> The more diverse the enrollment audio files, the better the accuracy for identification.

### Body Parameters

| Parameter    | Type   | Description                               | Notes                        |
| ------------ | ------ | ----------------------------------------- | ---------------------------- |
| encoding     | String | Encoding of audio file like MP3, WAV etc. |                              |
| sampleRate   | Number | Sample rate of the audio file.            |                              |
| languageCode | String | Language spoken in the audio file.        | [default to &#39;en-US&#39;] |
| content      | String | base64 encoding of the audio file.        |                              |
| speakerId    | String | speaker id tobe registered                |                              |

### Query Parameters

| Parameter | Type   | Description | Notes                                           |
| --------- | ------ | ----------- | ----------------------------------------------- |
| api_key   | String | The apikey  | Required for authentication inside all requests |

### Output Parameters (Sync)

| Parameter | Type   | Description                              | Notes                                                                                                                                                                 |
| --------- | ------ | ---------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| message   | String | Status of enrollment Success or Complete | Success: Current enrollment is successfull, Complete: Enrollment is completed, Repeat the enrollments with different audio samples until Complete message is received |

### Speaker Enrollment Delete API for Identification (REST Api)

This API deletes speaker enrollment for the user

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/diarization/delete`

### Sample Code

### Shell

```shell
curl -X POST "https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/diarization/delete?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"speakerId": "user1"}
```

```shell
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
| api_key   | String | The apikey  | Required for authentication inside all requests |

### Output Parameters (Sync)

| Parameter | Type   | Description    | Notes              |
| --------- | ------ | -------------- | ------------------ |
| message   | String | Request status | Success or Failure |
