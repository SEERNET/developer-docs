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
import requests
import base64

url = "https://proxy.api.deepaffects.com/text/generic/api/v1/sync/text_recognise_emotion"
querystring = {"apikey":"<API_KEY>"}
payload = {"content": "YOUR_TEXT"}
headers = {
    'Content-Type': "application/json",
}

response = requests.post(url, json=payload, headers=headers, params=querystring)
print(response.text)
```

<!--Javascript-->

```javascript
var request = require("request");

var options = { method: 'POST',
  url: 'https://proxy.api.deepaffects.com/text/generic/api/v1/sync/text_recognise_emotion',
  qs:
   { apikey: '<API_KEY>'},
  headers:
   { 'cache-control': 'no-cache',
     'Content-Type': 'application/json' },
  body:
   { content: 'YOUR_TEXT'},
  json: true };

request(options, function (error, response, body) {
  if (error) throw new Error(error);

  console.log(body);
});
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
| apikey    | String | The apikey. | Required for authentication inside all requests. |

### Output Parameters

Output is the list of emotion scores. The parameters in emotion scores are as follows:

| Parameter | Type   | Description                         | Notes |
| --------- | ------ | ----------------------------------- | ----- |
| version   | String | API Version.                        |       |
| response  | Object | Object with emotion and confidence. | Possible values: `surprise`, `joy`, `trust`, `sadness`, `fear`, `anger`, `disgust` and `neutral`. |
