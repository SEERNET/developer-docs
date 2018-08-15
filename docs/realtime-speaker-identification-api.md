---
id: realtime-speaker-identification-api
title: Realtime Speaker Identification Api
sidebar_label: Realtime Speaker Identification Api
---

Identify speakers from the audio file in realtime

### Grpc Call

`client.IdentifySpeaker( chunk_generator(), TIMEOUT_SECONDS, metadata=metadata)`

### Sample Code

### Python

```python
from deepaffects.realtime.util import chunk_generator_from_file, chunk_generator_from_url, get_deepaffects_client

TIMEOUT_SECONDS = 2000
apikey = "YOUR_API_KEY"
# Set file_path as local file path or audio stream or youtube url
file_path = "FILE_PATH"

# Set is_youtube_url True while streaming from youtube url
is_youtube_url = False
languageCode = "en-Us"
sampleRate = "16000"
encoding = "wav"
speakerIds = "list of speakerIds to be identified seperated by ','"

# DeepAffects realtime Api client
client = get_deepaffects_client()

metadata = [
    ('apikey', apikey),
    ('speakerids', speakerIds),
    ('encoding', encoding),
    ('samplerate', sampleRate),
    ('languagecode', languageCode)
]

"""Generator Function

chunk_generator_from_file is the Sample implementation for generator funcion which reads audio from a file and splits it into
base64 encoded audio segment of more than 3 sec
and yields SegmentChunk object using segment_chunk
"""

# from deepaffects.realtime.types import segment_chunk
# segment_chunk(Args)

"""segment_chunk.

Args:
    encoding : Audio Encoding,
    languageCode: language code ,
    sampleRate: sample rate of audio ,
    content: base64 encoded audio,
    segmentOffset: offset of the segment in complete audio stream
"""

# Call client api function with generator and metadata

responses = client.IdentifySpeaker(
    # Use chunk_generator_from_file generator to stream from local file
    chunk_generator_from_file(file_path),
    # Use chunk_generator_from_url generator to stream from remote url or youtube with is_youtube_url set to true
    # chunk_generator_from_url(file_path, is_youtube_url=is_youtube_url),
     TIMEOUT_SECONDS, metadata=metadata)


# responses is the iterator for all the response values
for response in responses:
    print("Received message",response)

"""Response.
    response = {
        speakerId: speakerId identified in the segment,
        start: start of the segment,
        end: end of the segment
    }
"""
```

### Metadata Parameters

Metadata params are set once for an api call :

| Parameter    | Type   | Description                                      | Notes                                           |
| ------------ | ------ | ------------------------------------------------ | ----------------------------------------------- |
| apikey       | String | Apikey obtained from developer portsl            | Required for authentication inside all requests |
| encoding     | String | Encoding of audio file like MP3, WAV etc.        |
| sampleRate   | Number | Sample rate of the audio file.                   |
| languageCode | String | Language spoken in the audio file.               | [default to &#39;en-US&#39;]                    |
| speakerIds   | String | list of speakerIds to identify seperated by ','. |                                                 |

### Segment Parameters

| Parameter | Type   | Description                             | Notes    |
| --------- | ------ | --------------------------------------- | -------- |
| content   | String | base64 encoding of the audio segment.   |
| offset    | Number | Segment offset from start of the audio. |
| duration  | Number | Duration of chunk                       | optional |

### Output Response Stream

Output is the iterator streaming response objects with fowllowing parameters:

| Parameter  | Type   | Description                           | Notes |
| ---------- | ------ | ------------------------------------- | ----- |
| speaker_id | String | speaker_id of the identified speaker. |
| start      | Float  | Start of the audio segment.           |
| end        | Float  | end of the audio segment.             |
