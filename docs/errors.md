---
id: errors
title: Errors
sidebar_label: Errors
---

Our API returns standard HTTP success or error status codes. For errors, we will also include extra information about what went wrong encoded in the response as JSON. The various HTTP status codes we might return are listed below.

## HTTP Status codes

| Status Code | Title                 | Description                                 |
| ----------- | --------------------- | ------------------------------------------- |
| 200         | OK                    | The request was successful.                 |
| 202         | OK                    | The async request was successfully accepted |
| 400         | Bad request           | Bad request                                 |
| 401         | Unauthorized          | <API_KEY> is invalid.                       |
| 402         | Over quota            | Over plan quota on this endpoint.           |
| 404         | Not found             | The resource does not exist.                |
| 50X         | Internal Server Error | An error occurred with our API.             |

## Example error response.

```json
{
  "fault": {
    "faultstring": "Invalid ApiKey",
    "detail": {
      "errorcode": "oauth.v2.InvalidApiKey"
    }
  }
}
```

## Error types

All errors are returned in the form of JSON with a type and optional message.

| Type           | Description                                             |
| -------------- | ------------------------------------------------------- |
| params_invalid | Your parameters were not valid.                         |
| unknown_route  | URL was not valid.                                      |
| queued         | Lookup queued. Try this request again in a few minutes. |
| rate_limit     | The request has been rate limited.                      |
| api_error      | Internal API error.                                     |
