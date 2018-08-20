---
id: audio-denoising-api
title: Audio Denoising Api
sidebar_label: Audio Denoising Api
---

Audio denoising api removes noise from your audio signals and returns the denoised audio clip

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/denoise`

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/async/denoise`

### Sample Code

### Javascript

```javascript
var DeepAffects = require("deep-affects");
var defaultClient = DeepAffects.ApiClient.instance;

// Configure API key authorization: UserSecurity
var UserSecurity = defaultClient.authentications["UserSecurity"];
UserSecurity.apiKey = "<API_KEY>";

var apiInstance = new DeepAffects.DenoiseApi();

var body = DeepAffects.Audio.fromFile("/path/to/file"); // {Audio} Audio object

var callback = function(error, data, response) {
  if (error) {
    console.error(error);
  } else {
    console.log("API called successfully. Returned data: " + data);
  }
};

// sync request
apiInstance.syncDenoiseAudio(body, callback);

webhook = "http://your/webhook/";
// async request
apiInstance.asyncDenoiseAudio(body, webhook, callback);
```

### Shell

```shell
# sync request
curl -X POST "https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/denoise?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

# async request
curl -X POST "https://proxy.api.deepaffects.com/audio/generic/api/v1/async/denoise?apikey=<API_KEY>>&webhook=<Your webhook url>&request_id=abcd-1234" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US"}
```

### Python

```python
import deepaffects
from deepaffects.rest import ApiException
from pprint import pprint

deepaffects.configuration.api_key['apikey'] = '<API_KEY>'
api_instance = deepaffects.DenoiseApi()

body = deepaffects.Audio.from_file(file_name="/path/to/file")

out_file_name = "/path/to/denoised_out_file.wav"

try:
    # Denoise an audio file
    api_response = api_instance.sync_denoise_audio(body)
    api_response.to_file(out_file_name)
except ApiException as e:
    print("Exception when calling DenoiseApi->sync_denoise_audio: %s\n" % e)

# async api
webhook = 'https://your/webhook/' # str | The webhook url where result from async resource is posted
request_id = 'request_id_example' # str | Unique identifier for the request (optional)

try:
    # Denoise an audio file
    api_response = api_instance.async_denoise_audio(body, webhook, request_id=request_id)
    pprint(api_response)
except ApiException as e:
    print("Exception when calling DenoiseApi->async_denoise_audio: %s\n" % e)
```

### Output

```shell
# Sync:

{
"content": "bytesEncodedDenoisedAudioString",
"sampleRate": 8000,
"encoding": "FLAC",
"languageCode": "en-US"
}

# Async:

{
"request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
"api": "requested_api_name"
}

# Webhook:

{
"request_id": "unique_request_id_corresponding to async request_id",
"content": "bytesEncodedDenoisedAudioString",
"sampleRate": 8000,
"encoding": "FLAC",
"languageCode": "en-US"
}
```

### Body Parameters

| Parameter    | Type   | Description                               | Notes                        |
| ------------ | ------ | ----------------------------------------- | ---------------------------- |
| encoding     | String | Encoding of audio file like MP3, WAV etc. |                              |
| sampleRate   | Number | Sample rate of the audio file.            |                              |
| languageCode | String | Language spoken in the audio file.        | [default to &#39;en-US&#39;] |
| content      | String | base64 encoding of the audio file.        |                              |

### Query Parameters

| Parameter  | Type   | Description                                                            | Notes                                           |
| ---------- | ------ | ---------------------------------------------------------------------- | ----------------------------------------------- |
| api_key    | String | The apikey                                                             | Required for authentication inside all requests |
| webhook    | String | The webhook url at which the responses will be sent                    | Required for async requests                     |
| request_id | Number | An optional unique id to link async response with the original request | Optional                                        |

### Output Parameters (Sync)

| Parameter    | Type   | Description                               | Notes                        |
| ------------ | ------ | ----------------------------------------- | ---------------------------- |
| encoding     | String | Encoding of audio file like MP3, WAV etc. |                              |
| sampleRate   | Number | Sample rate of the audio file.            |                              |
| languageCode | String | Language spoken in the audio file.        | [default to &#39;en-US&#39;] |
| content      | String | base64 encoding of the audio file.        |                              |

### Output Parameters (Async)

| Parameter  | Type   | Description                     | Notes                                                              |
| ---------- | ------ | ------------------------------- | ------------------------------------------------------------------ |
| request_id | String | The request id                  | This defaults to the originally sent id or is generated by the api |
| api        | String | The api method which was called |                                                                    |

### Output Parameters (Webhook)

| Parameter    | Type   | Description                               | Notes                                                              |
| ------------ | ------ | ----------------------------------------- | ------------------------------------------------------------------ |
| request_id   | String | The request id                            | This defaults to the originally sent id or is generated by the api |
| encoding     | String | Encoding of audio file like MP3, WAV etc. |                                                                    |
| sampleRate   | Number | Sample rate of the audio file.            |                                                                    |
| languageCode | String | Language spoken in the audio file.        | [default to &#39;en-US&#39;]                                       |
| content      | String | base64 encoding of the audio file.        |                                                                    |
