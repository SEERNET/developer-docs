---
id: text-summary-api
title: Conversational Summarization API
sidebar_label: Conversational Summarization API
---

The Conversation Summarization API allows you to summarize the meaning of an audio transcript (speaker tagged), extracting its most relevant part of the conversation. The API provides two types of summaries:

Abstractive - Text summarization aims to understand the meaning behind a text and communicate it in newly generated sentences.

Extractive - Extracting the most relevant sentences. Its suited for the sales call, customer support call, virtual meetings, podcasts & more.

You can also pass id of the speaker as the part of request to get the speaker aware summaries(both extractive and abstractive).

### POST Request

### Async

`POST https://proxy.api.deepaffects.com/text/generic/api/v1/async/summary`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->

<!--Shell-->


```shell
curl -X POST \
"https://proxy.api.deepaffects.com/text/generic/api/v1/async/summary?apikey=<API_KEY>&webhook=<WEBHOOK_URL>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"summaryType": "abstractive", "summaryData": [{"speakerId":"spk", "text":"text blob for speaker"}]}
```
<!--Javascript-->

```javascript
var request = require("request");

var options = { method: 'POST',
  url: 'https://proxy.api.deepaffects.com/text/generic/api/v1/async/summary',
  qs: 
   { apikey: '<API_KEY>',
     webhook: '<WEBHOOK_URL>' },
  headers: 
   { 'Content-Type': 'application/json' },
  body: 
   {summaryType: "abstractive", summaryData: [{speakerId:"spk", text:"text blob for speaker"}]},
  json: true };

request(options, function (error, response, body) {
  if (error) throw new Error(error);

  console.log(body);
});
```
<!--Python-->

```python
import requests
import base64

url = "https://proxy.api.deepaffects.com/text/generic/api/v1/async/summary"

querystring = {"apikey":"<API_KEY>", "webhook":"<WEBHOOK_URL>"}

{"summaryType": "abstractive", "summaryData": [{"speakerId":"spk", "text":"text blob for speaker"}]}

headers = {
    'Content-Type': "application/json",
}

response = requests.post(url, json=payload, headers=headers, params=querystring)

print(response.text)
```
<!--END_DOCUSAURUS_CODE_TABS-->

### Async Output

<!--DOCUSAURUS_CODE_TABS-->
<!--Async-->

```json
{
"request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
"api": "requested_api_name"
}
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Webhook Output

<!--DOCUSAURUS_CODE_TABS-->
<!--extractive-->
```json
{
    "request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
    "response": {
        "summaries": [
          {
            "speaker_id": "spk",
            "value": "extractive summary corresponding to speaker spk"
          }
        ]
    }
}
```
<!--speaker_wise_abstractive-->
```json
{
    "request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
    "response": {
        "summaries": [
          {
            "speaker_id": "spk",
            "value": "abstractive summary corresponding to speaker spk"
          }
        ]
    }
}
```

<!--abstractive-->
```json
{
    "request_id": "8bdd983a-c6bd-4159-982d-6a2471406d62",
    "response": {
        "summaries": {
          "long": "long abstractive summary of the data",
          "short": "short abstractive summary of the data"
        }
    }
}
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Body Parameters

| Parameter   | Type               | Description                                                                | Notes                   |
| ----------- | ------------------ | -------------------------------------------------------------------------- | ----------------------- |
| summaryType | String             | Permitted values: `extractive`, `speaker_wise_abstractive`, `abstractive`. | Default is `extractive` |
| summaryData | List[Summary-Data] | List of speakerId, text object.                                            |                         |


### Summary-Data
| Parameter | Type   | Description                   | Notes |
| --------- | ------ | ----------------------------- | ----- |
| speakerId | String | Speaker id for the text blob. |       |
| text      | String | Text blob for summary.        |       |

### Query Parameters

| Parameter  | Type   | Description                                                             | Notes                                            |
| ---------- | ------ | ----------------------------------------------------------------------- | ------------------------------------------------ |
| apikey     | String | The apikey.                                                             | Required for authentication inside all requests. |
| webhook    | String | The webhook url at which the responses will be sent.                    | Required for async requests.                     |
| request_id | String | An optional unique id to link async response with the original request. | Optional.                                        |

### Output Parameters (Async)

| Parameter  | Type   | Description                      | Notes                                                               |
| ---------- | ------ | -------------------------------- | ------------------------------------------------------------------- |
| request_id | String | The request id.                  | This defaults to the originally sent id or is generated by the api. |
| api        | String | The api method which was called. |                                                                     |

### Output Parameters (Webhook)

| Parameter  | Type   | Description                                                            | Notes                                                                |
| ---------- | ------ | ---------------------------------------------------------------------- | -------------------------------------------------------------------- |
| request_id | String | The request id.                                                        | This defaults to the originally sent id or is generated by the api.  |
| response   | Object | `summaries` key containing list of object of `spkeaer_id` and `value`. | In case of `abstractive`, `long` and `short` summaries are provided. |

