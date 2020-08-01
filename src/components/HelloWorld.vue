<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <p>
      Allow the page to use the microphone and talk. 
      <br/>
      The record stops after 9 seconds and the download of the file 'test.webm' will be available after a short time.
    </p>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from "vue-property-decorator";

declare const MediaRecorder: any;

@Component
export default class HelloWorld extends Vue {
  @Prop() private msg!: string;
  private recordedChunks = new Array<any>();

  mounted(): void {
    navigator.mediaDevices.getUserMedia({ audio: true }).then(stream => {
      const options = { mimeType: "video/webm" };
      const mediaRecorder = new MediaRecorder(stream, options);

      mediaRecorder.ondataavailable = this.handleDataAvailable;

      mediaRecorder.start();

      // demo: to download after 9sec
      setTimeout(() => {
        console.log("stopping");
        mediaRecorder.stop();
      }, 9000);
    });
  }

  private handleDataAvailable(event: any): void {
    console.log("data-available");
    if (!event?.data || event?.data.size <= 0) {
      return;
    }
    this.recordedChunks.push(event.data);
    console.log(this.recordedChunks);
    this.download();
  }
  private download(): void {
    const blob = new Blob(this.recordedChunks, {
      type: "video/webm"
    });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    document.body.appendChild(a);
    a.style.display = "none";
    a.href = url;
    a.download = "test.webm";
    a.click();
    window.URL.revokeObjectURL(url);
  }
}
</script>
