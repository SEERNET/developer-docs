---
id: chapter-detection-api
title: Chapter Detection API
sidebar_label: Chapter Detection API
---

Chapter Detection API automatically extracts chapters from a video. For each chapter, Optical Character Recognition (OCR) is performed to extract the text in the video frame. If the frame is of a slidedeck, title is also extracted. Thus generating a 'Table of Contents' metadata for the video. 

> Note: This API is still in alpha release.

### POST Request

`POST https://proxy.api.deepaffects.com/video/generic/api/alpha/async/videochapters`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->
```shell

# async request
curl -X POST \
"https://proxy.api.deepaffects.com/video/generic/api/alpha/async/videochapters?apikey=<API_KEY>>&webhook=<Your webhook url>" -H 'content-type: application/json' -d @data.json

# contents of data.json with content
{"content": "bytesEncodedVideoString", "sampleRate": 8000, "encoding": "MPEG-4", "languageCode": "en-US"}

# contents of data.json with url
{"url": "https://publicly-facing-url.mp4", "sampleRate": 8000, "encoding": "MPEG-4", "languageCode": "en-US"}

```

<!--Python-->
```python
import requests
import base64

url = "https://proxy.api.deepaffects.com/video/generic/api/alpha/async/videochapters"

querystring = {"apikey":"<API_KEY>", "webhook":"<WEBHOOK_URL>"}

payload = {
    "encoding": "MPEG-4",
    "languageCode": "en-US",
    "sampleRate": 48000
}

# The api accepts data either as a url or as base64 encoded content
# passing payload as url:
payload["url"] = "https://publicly-facing-url.mp4"
# alternatively, passing payload as content:
with open(video_file_name, 'rb') as fin:
    video_content = fin.read()
payload["content"] = base64.b64encode(video_content).decode('utf-8')

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
  url: 'https://proxy.api.deepaffects.com/video/generic/api/alpha/async/videochapters',
  qs: 
   { apikey: '<API_KEY>',
     webhook: '<WEBHOOK_URL>'},
  headers: 
   {  'Content-Type': 'application/json' },
  body: 
   { encoding: 'MPEG-4',
     languageCode: 'en-US',
     url: 'https://publicly-facing-url.mp4',
     sampleRate: 48000 },
  json: true };

request(options, function (error, response, body) {
  if (error) throw new Error(error);

  console.log(body);
});
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Output
<!--DOCUSAURUS_CODE_TABS-->
<!--Async-->

```json
{
"request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
"api": "/video/generic/api/alpha/async/videochapters"
}
```
<!--Webhook-->
```json
{
  "request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62", 
  "response": {
    "chapters": [
      {
        "end": 1, 
        "raw_text": "raw% text", 
        "start": 0, 
        "text": "cleaned text", 
        "title": "TITLE"
      }
    ]
  }
}
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Body Parameters

| Parameter    | Type   | Description                               | Notes                        |
| ------------ | ------ | ----------------------------------------- | ---------------------------- |
| encoding     | String | Encoding of video file like MP4, MKV etc. |                              |
| sampleRate   | Number | Sample rate of the video file.            |                              |
| languageCode | String | Language spoken in the video file.        | [default to &#39;en-US&#39;] |
| content      | String | base64 encoding of the video file.                       | Optional                     |
| url          | String | Publicly facing url                                      | Optional                     |

> Exactly one of url and content should be passed. In case both values are passed, error is thrown


### Query Parameters

| Parameter  | Type   | Description                                                            | Notes                                           |
| ---------- | ------ | ---------------------------------------------------------------------- | ----------------------------------------------- |
| apikey    | String | The apikey                                                             | Required for authentication inside all requests |
| webhook    | String | The webhook url at which the responses will be sent                    | Required for async requests                     |
| request_id | String | An optional unique id to link async response with the original request | Optional                                        |

### Output Parameters (Async)

| Parameter  | Type   | Description                     | Notes                                                              |
| ---------- | ------ | ------------------------------- | ------------------------------------------------------------------ |
| request_id | String | The request id                  | This defaults to the originally sent id or is generated by the api |
| api        | String | The api method which was called |                                                                    |

### Output Parameters (Webhook)

| Parameter  | Type   | Description                          | Notes                                                              |
| ---------- | ------ | ------------------------------------ | ------------------------------------------------------------------ |
| request_id | String | The request id                       | This defaults to the originally sent id or is generated by the api |
| response   | Object | The actual output of the chapter detection | The Chapter object is defined below                               |

### Chapter Object

| Parameter    | Type   | Description                     | Notes                                                                           |
| ------------ | ------ | ------------------------------- | ------------------------------------------------------------------------------- |
| start | Number | The start time of the chapter |  |
| end   | Number | The start time of the chapter |  |
| title     | String   | The title extracted from the OCR output       | Set if a slide is detected in the frame                                            |
| raw_text     | String   | The entire raw text extracted by the OCR engine      | |
| text     | String   | Cleaned up version of the raw text extracted by the OCR engine      | |
