---
id: job-status-api
title: Job Status API
sidebar_label: Job Status API
---

Job Status API returns information about the status of the job and its corresponding output.

### GET Request

`GET https://proxy.api.deepaffects.com/transaction/generic/api/v1/async/status`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->

<!--Shell-->

```shell
curl -X GET \
  'https://proxy.api.deepaffects.com/transaction/generic/api/v1/async/status?apikey=<API_KEY>&request_id=<REQUEST_ID>'
```

<!--Javascript-->
```javascript
var request = require("request");

var options = { method: 'GET',
  url: 'https://proxy.api.deepaffects.com/transaction/generic/api/v1/async/status',
  qs: 
   { apikey: '<API_KEY>',
     request_id: '<REQUEST_ID>' }};

request(options, function (error, response, body) {
  if (error) throw new Error(error);

  console.log(body);
});
```

<!--Python-->
```python
import requests

url = "https://proxy.api.deepaffects.com/transaction/generic/api/v1/async/status"

querystring = {"apikey":"<API_KEY>","request_id":"<REQUEST_ID>"}

payload = ""
headers = {
    'cache-control': "no-cache"
    }

response = requests.get(url, data=payload, headers=headers, params=querystring)

print(response.text)
```
<!--END_DOCUSAURUS_CODE_TABS-->

### Output

```shell
{
  "response": {
    "request_id": "<REQUEST_ID>", 
    "response": {
      "confidence": 0.97, 
      "num_speakers": 2, 
      "transcript": "Hi! Hello, this is Susan.", 
      "words": [
        {
          "confidence": 0.97, 
          "end": 1, 
          "speaker_id": "1", 
          "start": 0, 
          "word": "Hi"
        }, 
        {
          "confidence": 0.97, 
          "end": 2, 
          "speaker_id": "2", 
          "start": 1.2, 
          "word": "Hello"
        }, 
        {
          "confidence": 0.97, 
          "end": 2.6, 
          "speaker_id": "2", 
          "start": 2, 
          "word": "this"
        }, 
        {
          "confidence": 0.97, 
          "end": 3, 
          "speaker_id": "2", 
          "start": 2.6, 
          "word": "is"
        }, 
        {
          "confidence": 0.97, 
          "end": 4, 
          "speaker_id": "2", 
          "start": 3, 
          "word": "Susan"
        }
      ]
    }
  }, 
  "status": "Completed"
}
```
### Query Parameters

| Parameter  | Type   | Description                                                            | Notes                                           |
| ---------- | ------ | ---------------------------------------------------------------------- | ----------------------------------------------- |
| apikey    | String | The apikey                                                             | Required for authentication inside all requests |
| request_id | String | The request_id corresponding to the request | Required                                        |

> Note: Polling is NOT recommended in a production server. Rather, use webhooks to asynchronously recieve notifications once the job completes. If you have any further questions, contact us at support@seernet.io


### Output Parameters
| Parameter  | Type   | Description                                                            | Notes                                           |
| ---------- | ------ | ---------------------------------------------------------------------- | ----------------------------------------------- |
| status    | String | The status of the job: `Completed`, `Failed`, `Running`                                                             |  |
| response | Object | The response corresponding to the transaction id |  The Response Object defined below                                       |


### Response Object

| Parameter  | Type   | Description                                                            | Notes                                           |
| ---------- | ------ | ---------------------------------------------------------------------- | ----------------------------------------------- |
| request_id | String | The request_id corresponding to the request |                            
| response | Object | The response object as defined in the required API type | |
