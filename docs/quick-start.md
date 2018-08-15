---
id: quick-start
title: Quickstart Guide
sidebar_label: Quickstart Guide
---

## Setting up

1.  First time users: If you want to use DeepAffects's public API, you must have a free account and API key. To create an account and receive <ACCESS_TOKEN> register at our [developer portal](https://developers.deepaffects.com/). Once registered, an API Key will be auto-generated for you. Use this API Key in place of <ACCESS_TOKEN> in the examples below.

2.  Returning users: If you already have an account, you can always retrieve <ACCESS_TOKEN> and manage your API usage on your DeepAffects [dashboard](https://developers.deepaffects.com) after logging in.

## Choose API Product

Currently, deepaffects provides 2 audio based products:

1.  **Generic Audio Analysis**: [This product](#generic-audio-analysis) contains APIs like: Denoising API, Speaker Diarization API, Paralinguistic Feature Extraction API, Emotion Extraction API. The APIs in this product are available for use to all developers. The developer has the ability to activate only specific set of APIs by switching them on in the dashboard.

2.  **Custom Audio Analysis**: [This product](#custom-audio-analysis) contains custom API's built exclusively for clients. These API's are approved for usage only for the specific clients.

## Choose your language

For your convenience, DeepAffects has provided native language bindings in Python and NodeJs! You can view code examples in the dark area to the right, and you can switch the programming language of the examples with the tabs in the top right.

Don't worry If the programming language you want to use DeepAffects with is not listed, the DeepAffects suite of emotion APIs can also be used directly through RESTful API calls, just use the shell tab on the right to check the equivalent cURL command for the API endpoint

### Installation

1.  **Python**: The python client source can be found at [github](https://github.com/SEERNET/deepaffects-python). The installation instruction can be found in the readme.
2.  **Nodejs**: The nodejs api client source can be found at [github](https://github.com/SEERNET/deepaffects-node). The installation instruction can be found in the readme.
