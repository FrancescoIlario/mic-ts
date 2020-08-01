# mic-ts

Simple example of audio recording with Vue.JS, TypeScript and MediaRecorder

Allow the page to use the microphone and talk.
The record stops after 9 seconds and the download of the file 'test.webm' will be available after a short time. 

## Run the sample

### Docker

You can pull the image from Docker Hub and run with the following command

```console
$ docker run --name mic-ts -p 8080:80 filario/mic-ts:v1.0.0 
```

Alternatively you can build it and run without downloading the 

```console
$ docker build -t mic-ts . 
$ docker run --name mic-ts -p 8080:80 mic-ts
```

### NPM

Use npm to run the application

```console
$ npm run serve
```
