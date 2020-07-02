---
id: text-emotion-recognition-api
title: Text Emotion Recognition API
sidebar_label: Text Emotion Recognition API
---

Text Emotion API extracts emotions from the paragraph of text.

### POST Request

`POST https://proxy.api.deepaffects.com/text/generic/api/latest/sync/text_recognise_emotion`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->

<!--Shell-->

```shell
curl -X POST \
"https://proxy.api.deepaffects.com/text/generic/api/latest/sync/text_recognise_emotion?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json


# contents of data.json
{
  "content": "YOUR_TEXT"
}
```
<!--Python-->

```python
from __future__ import print_statement
import deepaffects
from deepaffects.rest import ApiException
from pprint import pprint

# Configure API key authorization: UserSecurity
deepaffects.configuration.api_key['apikey'] = '<API_KEY>'

# create an instance of the API class
api_instance = deepaffects.EmotionApi()
var body = {
  "content": "YOUR_TEXT" # Text that needs to be featurized
}

try:
    # Find emotion in text
    api_response = api_instance.sync_text_recognise_emotion(body)
    pprint(api_response)
except ApiException as e:
    print("Exception when calling EmotionApi->sync_recognise_emotion: %s\n" % e)
```

<!--Javascript-->

```javascript
var DeepAffects = require("deep-affects");
var defaultClient = DeepAffects.ApiClient.instance;

// Configure API key authorization: UserSecurity
var UserSecurity = defaultClient.authentications["UserSecurity"];
UserSecurity.apiKey = "YOUR API KEY";

var apiInstance = new DeepAffects.EmotionApi();

var body = {
  content: "YOUR_TEXT"
};

var callback = function(error, data, response) {
  if (error) {
    console.error(error);
  } else {
    console.log("API called successfully. Returned data: " + data);
  }
};
// sync request
apiInstance.syncRecogniseTextEmotion(body, callback);
```

<!--END_DOCUSAURUS_CODE_TABS-->


### Output

```shell
# Sync:

{
"version": "1.0.5",
"response": {
  "neutral": 0.7
  }
}
```


### Body Parameters

| Parameter | Type   | Description | Notes |
| --------- | ------ | ----------- | ----- |
| content   | String | Text.       |       |

### Query Parameters

| Parameter | Type   | Description | Notes                                            |
| --------- | ------ | ----------- | ------------------------------------------------ |
| apikey    | String | The apikey  | Required for authentication inside all requests. |

### Output Parameters

Output is the list of emotion scores. The parameters in emotion scores are as follows:

| Parameter | Type   | Description                         | Notes |
| --------- | ------ | ----------------------------------- | ----- |
| version   | String | API Version.                        |       |
| response  | Object | Object with emotion and confidence. | Possible values: `surprise`, `joy`, `trust`, `sadness`, `fear`, `anger`, `disgust` and `neutral`. |
