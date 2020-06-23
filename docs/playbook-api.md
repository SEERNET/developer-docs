---
id: text-playbook-api
title: Playbook API
sidebar_label: Playbook API
---

APIs to add, fetch and delete Playbook


### Playbook Add Request

`POST https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->
```shell
curl -X POST \
"https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook?apikey=<API_KEY>" -H 'content-type: application/json' -d @data.json

# contents of data.json
{"playbook": "PLAYBOOK_NAME", "groups":["LIST", "OF", "GROUP_NAMES"]}
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

| Parameter  | Type         | Description                       | Notes    |
| ---------- | ------------ | --------------------------------- | -------- |
| playbook   | String       | Name of the playbook              | Required |
| groups     | List[String] | List of group names to be applied | Required |

### Query Parameters

| Parameter | Type   | Description | Notes                                           |
| --------- | ------ | ----------- | ----------------------------------------------- |
| apikey    | String | The apikey  | Required for authentication inside all requests |

### Output Parameters

| Parameter | Type   | Description         | Notes              |
| --------- | ------ | ------------------- | ------------------ |
| message   | String | Status Message      | Success or Failure |


### Playbook Delete Request

`DELETE https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->
```shell
curl -X DELETE \
"https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook?apikey=<API_KEY>&playbook=<PLAYBOOK_NAME>"
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

| Parameter | Type   | Description    | Notes                                           |
| --------- | ------ | -------------- | ----------------------------------------------- |
| apikey    | String | The apikey     | Required for authentication inside all requests |
| playbook  | String | Playbook name  | Required                                        |

### Output Parameters

| Parameter | Type   | Description         | Notes              |
| --------- | ------ | ------------------- | ------------------ |
| message   | String | Status Message      | Success or Failure |


### Playbook Get Request

Fetches all the playbooks associated with the developer id

`GET https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook`

### Sample Code

<!--DOCUSAURUS_CODE_TABS-->
<!--Shell-->
```shell
curl -X GET \
"https://proxy.api.deepaffects.com/text/generic/api/latest/sync/playbook?apikey=<API_KEY>"
```

<!--END_DOCUSAURUS_CODE_TABS-->

### Output

<!--DOCUSAURUS_CODE_TABS-->
<!--Success-->
```json
[
  {"name": "PLAYBOOK_NAME", "groups": ["LIST", "OF", "ENABLED", "GROUPS"]}
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

| Parameter | Type   | Description | Notes                                           |
| --------- | ------ | ----------- | ----------------------------------------------- |
| apikey    | String | The apikey  | Required for authentication inside all requests |

### Output Parameters
Response is the list of Playbook-Response Segment

#### Playbook-Response Segment
| Parameter | Type         | Description                        | Notes |
| --------- | ------------ | ---------------------------------- | ----- |
| name      | String       | Name of the playbook               |       |
| groups    | List[String] | List of the groups in the playbook |       |

