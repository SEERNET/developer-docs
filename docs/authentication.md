---
id: authentication
title: Authentication
sidebar_label: Authentication
---

DeepAffects uses API keys to allow access to the API. You can register a new DeepAffects API key at our [developer portal](https://developers.deepaffects.com).
DeepAffects expects for the API key to be included in all API requests to the server along with the base url.

<!--DOCUSAURUS_CODE_TABS-->

<!--Shell-->

```shell
# With shell, you can just pass the correct header with each request
curl "api_endpoint_here?apikey=<API_KEY>"
```

<!--Python-->

```python
import deepaffects

# Configure API key authorization: UserSecurity
deepaffects.configuration.api_key['apikey'] = '<API_KEY>'
```

<!--Javascript-->

```javascript
var DeepAffects = require("deep-affects");
// Configure API key authorization: UserSecurity
var UserSecurity = defaultClient.authentications["UserSecurity"];
UserSecurity.apiKey = "<API_KEY>";
```
<!--END_DOCUSAURUS_CODE_TABS-->

> Make sure to replace `<API_KEY>` with `API Key` obtained from [developer portal](https://developers.deepaffects.com).
