$(function() {
	
	window.addEventListener('message', function(event) {
		
		if (event.data.action == "playSound") {

            if (event.data.sound != null) {

                const audioPlayer = new Audio("./sounds/" + event.data.sound);

                if (audioPlayer != null && audioPlayer !== undefined) {
                  audioPlayer.volume = event.data.soundVolume;
                  audioPlayer.play();
                }

            }

        }
    });

    $('audio').addEventListener('error', function failed(e) {
        // audio playback failed - show a message saying why
        // to get the source of the audio element use $(this).src
        switch (e.target.error.code) {
          case e.target.error.MEDIA_ERR_ABORTED:
            alert('You aborted the video playback.');
            break;
          case e.target.error.MEDIA_ERR_NETWORK:
            alert('A network error caused the audio download to fail.');
            break;
          case e.target.error.MEDIA_ERR_DECODE:
            alert('The audio playback was aborted due to a corruption problem or because the video used features your browser did not support.');
            break;
          case e.target.error.MEDIA_ERR_SRC_NOT_SUPPORTED:
            alert('The video audio not be loaded, either because the server or network failed or because the format is not supported.');
            break;
          default:
            alert('An unknown error occurred.');
            break;
        }
    }, true);

});
