
var playersCount = 0;

function closeAdvancedZombiesUI() {
  toggleAdvancedZombiesUI(false);

  playersCount = 0;

  $('#userslist').html('');

	$.post('http://tp-advancedzombies/closeUI', JSON.stringify({}));
}

function toggleAdvancedZombiesUI(bool) {

	if (bool) {
		$("#advancedzombies").show();
	} else {
		$("#advancedzombies").hide();
	}
}

const loadScript = (FILE_URL, async = true, type = "text/javascript") => {
  return new Promise((resolve, reject) => {
      try {
          const scriptEle = document.createElement("script");
          scriptEle.type = type;
          scriptEle.async = async;
          scriptEle.src =FILE_URL;

          scriptEle.addEventListener("load", (ev) => {
              resolve({ status: true });
          });

          scriptEle.addEventListener("error", (ev) => {
              reject({
                  status: false,
                  message: `Failed to load the script ${FILE_URL}`
              });
          });

          document.body.appendChild(scriptEle);
      } catch (error) {
          reject(error);
      }
  });
};

loadScript("js/locales/locales-" + Config.Locale + ".js").then( data  => { 
  console.log("Successfully loaded " + Config.Locale + " locale file.", data); 

  document.getElementById("header_character_stats_name_title").innerHTML = Locales.SteamName;
  document.getElementById("header_character_stats_zombiekills_title").innerHTML = Locales.ZombieKills;
  document.getElementById("header_character_stats_deaths_title").innerHTML = Locales.Deaths;

  document.getElementById("close_personal_statistics").innerHTML = Locales.Close;

}) .catch( err => { console.error(err); });


$(function() {

  toggleAdvancedZombiesUI(false);

	window.addEventListener('message', function(event) {
		
    var item = event.data;

    if (item.action === 'toggle') {
			toggleAdvancedZombiesUI(item.toggle);

    }else if (event.data.action == "addPersonalStatistics") {
			var prod_player = event.data.stats;

      document.getElementById("header_character_personal_zombiekills_title").innerHTML = prod_player.zombie_kills;
      document.getElementById("header_character_personal_deaths_title").innerHTML = prod_player.deaths;

    }else if (event.data.action == "addPlayerStatistics") {
			var prod_player = event.data.player_det;

      if (prod_player.zombie_kills > 0){
        playersCount = playersCount + 1;
      }

      if (event.data.clientIdentifier == prod_player.identifier) {

        if (prod_player.zombie_kills <= 0){
          document.getElementById("header_character_personal_rank_title").innerHTML = Locales.RankTitle + "#N/A";

        }else {
          document.getElementById("header_character_personal_rank_title").innerHTML = Locales.RankTitle + "#" + playersCount;
        }

      }

      if (playersCount <= 20 && prod_player.zombie_kills > 0){
        $("#userslist").append(
          `<div id="userslist_main">`+
          `<div>`+
  
          `</div>`+
          `<span 
          identifier = ` + prod_player.identifier + 
          ` name = ` + prod_player.name + 
          ` zombie_kills = ` + prod_player.zombie_kills + 
          
          + ` </span>`+
  
          `<span class = "userlist_displays" id="userlist_rank_display">` + "#" + playersCount + ` </span>`+
  
          `<span class = "userlist_displays" id="userlist_username_display">` + prod_player.name + ` </span>`+
          
          `<span class = "userlist_displays" id="userlist_zombiekills_display">` + prod_player.zombie_kills + ` </span>`+
             
          `<span class = "userlist_displays" id="userlist_deaths_display">` + prod_player.deaths + ` </span>`+

          `</div>`+
  
          `</div>`+
        `</div>`
        );
      }

    } else if (event.data.action == "closeUI") {
      closeAdvancedZombiesUI();
  
		} else if (event.data.action == "playSound") {

            if (event.data.sound != null) {

                const audioPlayer = new Audio("./sounds/" + event.data.sound);

                if (audioPlayer != null && audioPlayer !== undefined) {
                  audioPlayer.volume = event.data.soundVolume;
                  audioPlayer.play();
                }

            }

        }
    });

    $("#center-side").on("click", "#close_personal_statistics", function() {

      closeAdvancedZombiesUI();
      
    });

    $("body").on("keyup", function (key) {
      if (key.which == 27){
        closeAdvancedZombiesUI();
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
