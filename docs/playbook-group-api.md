---
id: text-playbook-group-api
title: Playbook Group API
sidebar_label: Playbook Group API
---

APIs to add, fetch and delete Playbook Groups.


### Playbook Group Add Request

`POST https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook/group`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->
```shell
curl -X POST \
"https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook/group?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"group": "GROUP_NAME", "group_type": "GROUP_TYPE", "hints": ["LIST", "OF", "HINTS"], "questions": ["LIST", "OF", "QUESTIONS"], "comply": true, "stopwords": ["LIST", "OF", "STOPWORDS"]}
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
    "fault_string": "Invalid payload. Refer API docs."
  }
}
```
<!--END_DOCUSAURUS_CODE_TABS-->


### Body Parameters

| Parameter  | Type         | Description                          | Notes                                              |
| ---------- | ------------ | ------------------------------------ | -------------------------------------------------- |
| group      | String       | Name of the group.                   | Required.                                          |
| group_type | String       | Type of the group.                   | Required. Permitted values: `intent` or `keyword`. |
| hints      | List[String] | Hints for group.                     | Required.                                          |
| questions  | List[String] | Questions for group.                 | Required if `group_type` is `intent`.              |
| stopwords  | List[String] | Stopwords for group.                 |                                                    |
| comply     | Bool         | flag to enable or disable the group. | Default is false.                                  |

### Query Parameters

| Parameter | Type   | Description | Notes                                            |
| --------- | ------ | ----------- | ------------------------------------------------ |
| apikey    | String | The apikey. | Required for authentication inside all requests. |

### Output Parameters

| Parameter | Type   | Description     | Notes               |
| --------- | ------ | --------------- | ------------------- |
| message   | String | Status Message. | Success or Failure. |


### Playbook Group Delete Request

`DELETE https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook/group`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->
```shell
curl -X DELETE \
"https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook/group?apikey=<API_KEY>&group=<GROUP_NAME>"
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
  "message": "Failure"
}
```
<!--END_DOCUSAURUS_CODE_TABS-->

### Query Parameters

| Parameter | Type   | Description | Notes                                            |
| --------- | ------ | ----------- | ------------------------------------------------ |
| apikey    | String | The apikey. | Required for authentication inside all requests. |
| group     | String | Group name. | Required.                                        |

### Output Parameters

| Parameter | Type   | Description     | Notes               |
| --------- | ------ | --------------- | ------------------- |
| message   | String | Status Message. | Success or Failure. |


### Playbook Group Get Request

Fetches all the groups associated with the developer id

`GET https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook/group`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->
```shell
curl -X GET \
"https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook/group?apikey=<API_KEY>"
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Output

<!--DOCUSAURUS_CODE_TABS-->
<!--Success-->
```json
[
  {"stopwords": [], "comply": false, "hints": ["test2"], "name": "test2", "group_type": "keyword"}
]
```
<!--Failure-->

```json
{
  "fault": {
    "detail": {
      "error_code": "com.deepaffects.BadRequest"
    }, 
    "fault_string": "Invalid request. Refer API docs."
  }
}
```
<!--END_DOCUSAURUS_CODE_TABS-->

### Query Parameters

| Parameter | Type   | Description | Notes                                            |
| --------- | ------ | ----------- | ------------------------------------------------ |
| apikey    | String | The apikey. | Required for authentication inside all requests. |

### Output Parameters
Response is the list of Group-Response Segment

#### Group-Response Segment
| Parameter  | Type         | Description          | Notes |
| ---------- | ------------ | -------------------- | ----- |
| name       | String       | Name of the group.   |       |
| group_type | String       | Type of the group.   |       |
| stopwords  | List[String] | List of stopwords.   |       |
| comply     | Bool         | Enabled or disabled. |       |
| hints      | List[String] | List of hints .      |       |
