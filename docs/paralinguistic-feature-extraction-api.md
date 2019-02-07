---
id: paralinguistic-feature-extraction-api
title: Paralinguistic Feature Extraction Api
sidebar_label: Paralinguistic Feature Extraction Api
---

Paralingustic feature extraction api extracts features from audio file as explained in the next section

### POST Request

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/featurize`

`POST https://proxy.api.deepaffects.com/audio/generic/api/v1/async/featurize`

There are two stages in the audio feature extraction methodology:

1.  Short-term feature extraction: It splits the input signal into short-term widnows (frames) and computes a number of features for each frame. This process leads to a sequence of short-term feature vectors for the whole signal.
2.  Mid-term feature extraction: Extracts a number of statistcs (e.g. mean and standard deviation) over each short-term feature sequence.

### Sample Code

### Shell

```shell
curl -X POST "https://proxy.api.deepaffects.com/audio/generic/api/v1/sync/featurize?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

curl -X POST "https://proxy.api.deepaffects.com/audio/generic/api/v1/async/featurize?apikey=<API_KEY>&webhook=<Your webhook url>&request_id=abcd-1234" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US"}
```

### Python

```python
import deepaffects
from deepaffects.rest import ApiException
from pprint import pprint

# Configure API key authorization: UserSecurity
deepaffects.configuration.api_key['apikey'] = '<API_KEY>'

# create an instance of the API class
api_instance = deepaffects.FeaturizeApi()
body = deepaffects.Audio.from_file('/path/to/file') # Audio | Audio object that needs to be featurized.

try:
    # featurize an audio file
    api_response = api_instance.sync_featurize_audio(body)
    pprint(api_response)
except ApiException as e:
    print("Exception when calling FeaturizeApi->sync_featurize_audio: %s\n" % e)

# async request
webhook = 'https://your/webhook/' # str | The webhook url where result from async resource is posted
request_id = 'request_id_example' # str | Unique identifier for the request (optional)

try:
    # featurize an audio file
    api_response = api_instance.async_featurize_audio(body, webhook, request_id=request_id)
    pprint(api_response)
except ApiException as e:
    print("Exception when calling FeaturizeApi->async_featurize_audio: %s\n" % e)
```

### Javascript

```javascript
var DeepAffects = require("deep-affects");
var defaultClient = DeepAffects.ApiClient.instance;

// Configure API key authorization: UserSecurity
var UserSecurity = defaultClient.authentications["UserSecurity"];
UserSecurity.apiKey = "<API_KEY>";

var apiInstance = new DeepAffects.FeaturizeApi();

var body = DeepAffects.Audio.fromFile("/path/to/file"); // {Audio} Audio object

var callback = function(error, data, response) {
  if (error) {
    console.error(error);
  } else {
    console.log("API called successfully. Returned data: " + data);
  }
};

// sync request
apiInstance.syncFeaturizeAudio(body, callback);

// async request
webhook = "http://your/webhook/";
apiInstance.asyncFeaturizeAudio(body, webhook, callback);
```

### Output

```shell
# Sync:

{"mfccs": [[0.1, 0.3, ..], [0.9, 0.2, ..], [0.1, 0.2, ..]], "zcr": [0.1, 0.2, ..], "energy": [0.3, 0.4, ..]}

# Async:

{
"request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
"api": "requested_api_name"
}

# Webhook:

{
"request_id": "unique_request_id_corresponding to async request_id",
"response": {
    "mfccs": [[0.1, 0.3, ..], [0.9, 0.2, ..], [0.1, 0.2, ..]],
    "zcr": [0.1, 0.2, ..],
    "energy": [0.3, 0.4, ..]}
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
| apikey    | String | The apikey                                                             | Required for authentication inside all requests |
| webhook    | String | The webhook url at which the responses will be sent                    | Required for async requests                     |
| request_id | Number | An optional unique id to link async response with the original request | Optional                                        |

### Output Parameters

| Name       | Type           | Description                         | Notes |
| ---------- | -------------- | ----------------------------------- | ----- |
| mfccs  | Number | mel frequency cepstral coefficients |       |
| zcr    | Number   | zero crossing rate                  |       |
| energy | Number   | energy                              |       |

### Available Short Term Features

| Feature ID         | Feature Name                                                                        | Description                                                                |
| ------------------ | ----------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| Zero Crossing Rate | The rate of sign-changes of the signal during the duration of a particular frame.   |                                                                            |
| Energy             | The sum of squares of the signal values, normalized by the respective frame length. |                                                                            |
| MFCCs              | Mel Frequency Cepstral Coefficients form a cepstral representation where the        | frequency bands are not linear but distributed according to the mel-scale. |

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
