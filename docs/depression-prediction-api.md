---
id: depression-prediction-api
title: Depression Prediction API
sidebar_label: Depression Prediction API
---

Depression prediction api predicts whether the audio clip contains a depressed person

### POST Request

`POST https://proxy.api.deepaffects.com/audio/custom/ellipsis/api/v1/sync/is_depressed`

`POST https://proxy.api.deepaffects.com/audio/custom/ellipsis/api/v1/async/is_depressed`

<aside class="notice">
  Note: For optimum detection, the interview length should be a minimum of 25 seconds.
</aside>

<aside class="warning">
  Note: The sync requests are capped at 1 minute audio length. Use async api for longer audio clips.
</aside>

### Sample Code

### Shell

```shell
curl -X POST "https://proxy.api.deepaffects.com/audio/custom/ellipsis/api/v1/sync/is_depressed?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

curl -X POST "https://proxy.api.deepaffects.com/audio/custom/ellipsis/api/v1/async/is_depressed?apikey=<API_KEY>&webhook=<Your webhook url>&request_id=abcd-1234" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"content": "bytesEncodedAudioString", "sampleRate": 8000, "encoding": "FLAC", "languageCode": "en-US"}
```

### Javascript

```javascript
var DeepAffects = require("deep-affects");
var defaultClient = DeepAffects.ApiClient.instance;

// Configure API key authorization: UserSecurity
var UserSecurity = defaultClient.authentications["UserSecurity"];
UserSecurity.apiKey = "<API_KEY>";

var apiInstance = new DeepAffects.EllipsisApi();

var body = DeepAffects.Audio.fromFile("/path/to/file"); // {Audio} Audio object

var callback = function(error, data, response) {
  if (error) {
    console.error(error);
  } else {
    console.log("API called successfully. Returned data: " + data);
  }
};

// sync request
apiInstance.syncIsDepressed(body, callback);

// async request

apiInstance.asyncIsDepressed(body, callback);
```

### Python

```python
from __future__ import print_statement
import time
import deepaffects
from deepaffects.rest import ApiException
from pprint import pprint

# Configure API key authorization: UserSecurity
deepaffects.configuration.api_key = '<API_KEY>'

# create an instance of the API class
api_instance = deepaffects.EllipsisApi()
body = deepaffects.Audio.from_file("/path/to/file") # Audio | Audio object that needs to be featurized.

# sync request
api_response = api_instance.sync_is_depressed(body)
pprint(api_response)

# async request
webhook = 'https://your/webhook/' # str | The webhook url where result from async resource is posted
request_id = 'request_id_example' # str | Unique identifier for the request (optional)

api_response = api_instance.async_is_depressed(body, webhook, request_id=request_id)
pprint(api_response)
```

```shell
# The above sync request returns output:

True

# The above async request returns output:
{
  "request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
  "api": "/api/v1/async/is_depressed"
}

# The response on the webhook url:
{
  "request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
  "depressed": True
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
| request_id | String | An optional unique id to link async response with the original request | Optional                                        |

### Output Parameters (Sync)

| Parameter | Type    | Description                                          | Notes |
| --------- | ------- | ---------------------------------------------------- | ----- |
| depressed | Boolean | Whether the clip contains a person who is depressed. |       |

### Output Parameters (Async)

| Parameter  | Type   | Description                     | Notes                                                              |
| ---------- | ------ | ------------------------------- | ------------------------------------------------------------------ |
| request_id | String | The request id                  | This defaults to the originally sent id or is generated by the api |
| api        | String | The api method which was called |                                                                    |

### Output Parameters (Webhook)

| Parameter  | Type    | Description                                          | Notes                                                       |
| ---------- | ------- | ---------------------------------------------------- | ----------------------------------------------------------- |
| request_id | String  | The request id                                       | This the indentifier to link back with the original request |
| depressed  | Boolean | Whether the clip contains a person who is depressed. |                                                             |
