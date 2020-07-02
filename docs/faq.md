---
id: faqs
title: Frequently Asked Questions
sidebar_label: Frequently Asked Questions
---

## Why am I not able to signup/login to the Developer Portal?

Deepaffects APIs are only available for corporate or academic users. Create your account with those email ids only. Please write to support@seernet.io for further queries/support.


## What are the pricing plans?

We provide free audio processing for 200 minutes of data across our APIs. For more usage please visit https://www.deepaffects.com/pricing.


## Why my async request takes much time to get a 202 response?

You are probably passing audio stream as `content` in the body request which takes more time to submit the request due to network latency. Even though `content` is supported, we recommend you to use a public facing url and pass it as `url` parameter for faster request submission.


## What value should I pass for `audioType` in async requests?

Use `callcenter` if audio stream has 2-3 speakers. For 4-6 speakers use `meeting`. Use `earnings_calls` if you are analyzing earnings call recordings.


## What audio formats are supported?

DeepAffects supports various audio types for ease of integration. As a rule of thumb, we support all the audiotypes which are inherently supported by [ffmpeg](https://trac.ffmpeg.org/wiki/audio%20types). A more exhaustive list can be fetched via command `ffmpeg -formats`.
