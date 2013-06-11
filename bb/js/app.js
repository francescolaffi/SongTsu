/*
 * Copyright 2012 Research In Motion Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

 var stitems = [];
 var pcitems = [];
 var current = 0;
 var len;
 var pccurrent = 0;
 var currentMood ="";
 
/**
 *  called by the webworksready event when the environment is ready
 */
function initApp() {
        startGeolocation();
	authCode = null;
	childWindow = null;

	// setup our credentials, and callback URL to monitor
	AuthOptions = {
		consumerKey: '',
		consumerSecret: '',
		callbackUrl: ''
	};
	
    StereomoodOAuth = OAuth(AuthOptions);
    MeTwitOAuth = OAuth(AuthOptions);
    StereomoodOAuth.consumerKey = "338ba2b6cfc5406eff0255f399e74d69051a0bdb2"
    localStorage.setItem("stid","");
    StereomoodOAuth.consumerSecret = "4cbaf0d53abfd235814612e5657214fd";
    localStorage.setItem("stpwd","");
    StereomoodOAuth.callbackUrl = 'http://www.steromood.com/api/oauth/authenticate';
    MeTwitOAuth.consumerKey	= localStorage.getItem("meid");
    MeTwitOAuth.consumerSecret = localStorage.getItem("mepwd");
    var webip = localStorage.getItem("webip");
    var lcunknown = localStorage.getItem("unknown");
    var lcsunclear = localStorage.getItem("sun-clear");
    var lcrainy = localStorage.getItem("rainy");
    var lcstormy = localStorage.getItem("stormy");
    var lcsnowy = localStorage.getItem("snowy");
    var lccloudy = localStorage.getItem("cloudy");
    var lchailing = localStorage.getItem("hailing");
    var lcheavyseas = localStorage.getItem("heavyseas");
    var lccalmseas = localStorage.getItem("calmseas");
    var lcfoggy = localStorage.getItem("foggy");
    var lcsnowy = localStorage.getItem("snowy");
    var lcsnowflurries = localStorage.getItem("snowflurries");
    var lcwindy = localStorage.getItem("windy");
}

/**
 *  Start the OAuth process by opening a childWindow, and directing the user to authorize the app
 */
function startStereoMoodOAuth() {
	toast('Contacting Stereomood...');
	StereomoodOAuth.get('http://www.stereomood.com/api/oauth/request_token', function(data) {
		window.requestParams = data.text;
		getStereoMoodAccessToken();
		return true;
	}, function(data) {
		alert('Error : No Authorization');
		return false;
	});
}

/**
 *  Start the OAuth process by opening a childWindow, and directing the user to authorize the app
 */
function startMeTwitOAuth() {
	// open the authorzation url
	
	var url = 'http://metwit.com/oauth/authorize/?client_id=' + MeTwitOAuth.consumerKey + '&response_type=code&redirect_uri=&scope='+MeTwitOAuth.callbackUrl;
    childWindow = window.open(url, '_blank');

    // evaluate the url every second, when Foursquare redirects to our callback url, the following if statements gets fired
	window.int = self.setInterval(function(){
    	var currentURL = childWindow.window.location.href;
    	var callbackURL = MeTwitOAuth.redirectUri;
		var inCallback = currentURL.indexOf(callbackURL);

		// location has changed to our callback url, parse the oauth code
		if (inCallback == 0) {

			// stop the interval from checking for url changes	
			window.clearInterval(int)

			// parse the oauth code
			var code = childWindow.window.location.href;
				code = code.split('access_token=');
				code = code[1];
			window.accessToken = code;

			// close the childWindow
			childWindow.close();
			setTimeout(function(){ 
				bb.pushScreen('connected.html', 'connected');
			}, 1000);
		}
	},1000);
}

/**
 *  exchange request token for access token & get authorization from user
 */
function getStereoMoodAccessToken() {
	var url = 'http://www.stereomood.com/api/oauth/access_token' + requestParams;
	childWindow = window.open(url, '_blank');

	// evaluate the url every second, when facebook redirects to our callback url, the following if statements gets fired
	window.int = self.setInterval(function() {
		var currentURL = childWindow.window.location.href;

		var callbackURL = AuthOptions.callbackUrl;
		var inCallback = currentURL.indexOf(callbackURL);

		// location has changed to our callback url, parse the oauth code
		if(inCallback == 0) {

			// stop the interval from checking for url changes	
			window.clearInterval(int)

			// parse the oauth codes
			var oauthToken = checkForQueryStrings('oauth_token') || null;
			var oauthVerifier = checkForQueryStrings('oauth_verifier') || null;

			// close the childWindow
			childWindow.close();

			setTimeout(function() {
				getOAuthToken(oauthToken, oauthVerifier);
			}, 1000);
		}
	}, 1000);
}



/**
 *  exchange the access token for oauth tokens
 */
function getOAuthToken(oauthToken, oauthVerifier) {
	toast('Getting OAuth Tokens');
	StereomoodOAuth.get('https://api.twitter.com/oauth/access_token?oauth_verifier=' + oauthVerifier + '&' + requestParams,

	// success - we have finally have access tokens!
	function(data) {
		window.accessParams = {};
		var qvars_tmp = data.text.split('&');
		for(var i = 0; i < qvars_tmp.length; i++) {
			var y = qvars_tmp[i].split('=');
			accessParams[y[0]] = decodeURIComponent(y[1]);
		}

		// tell jsOAuth that we have access tokens - it'll use these for future requests to the service
		// note:  you'll want to safely store these tokens - if you were to close the app at this point
		//        the tokens would be lost, and you'd need to re-authorize with the service.
		//
		//        ** if you do save the tokens and load them from memory later, don't foget to set them
		//        in jsOAuth again like we're doing on the line below! **
		StereomoodOAuth.setAccessToken([accessParams.oauth_token, accessParams.oauth_token_secret]);
		bb.pushScreen('connected.html', 'connected');
	},

	// failure
	function(data) {
		// you can put any error handling you may want to do in here, if the request for access tokens fails
	});
}


function checkMeteo(lat,lon) {


	var url = "https://api.metwit.com/v2/weather/?location_lat=" + lat + "&location_lng=" +lon ;

	$.ajax({
		type: 'GET',
		url: url,
        dataType: "xml",
		success: function(xml) {
                   var status = $(xml).find( "status" );
				   if (status =="clear") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/clear.png" }
				   else if (status =="rainy") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/rainy.png" }
				   else if (status =="stormy") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/stormy.png" }
				   else if (status =="snowy") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/snowy.png" }
				   else if (status =="partly cloudy") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/partly-cloudy.png" }
				   else if (status =="cloudy") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/cloudy.png" }
				   else if (status =="hailing") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/hailing.png" }
				   else if (status =="heavy seas") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/heavy-seas.png" }
				   else if (status =="calm seas") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/calm-seas.png" }
				   else if (status =="foggy") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/foggy.png" }
				   else if (status =="snow flurries") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/snow-flurries.png" }
				   else if (status =="windy") {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/windy.png" }
				   else {document.getElementbyId("meteo").getElementsByTagName('img')[0].src = "img/metwit/clear.png" }
		},
		error: function(data) {
		   $("img").src = "img/metwit/windy.png";
//			alert('Error checking in!' + data.text);
		}
	});
}

function checkSongs(mood) {
     if (!(mood == '')) {
	    var url = "http://www.stereomood.com/api/search.json?api_key=338ba2b6cfc5406eff0255f399e74d69051a0bdb2&type=mood&q=" + mood ;
	    $.ajax({
		   type: 'GET',
		   url: url,
		   dataType: 'json',
		   success: function(data) {
//		      objdata = JSON.parse(data);
			  for (var i = 0 ; i < data.songs.length; i++ ){
				stitems.push(data.songs[i].audio_url);
				stitems.push(data.songs[i].title);
				stitems.push(data.songs[i].image_url);
				stitems.push(data.songs[i].album);
				stitems.push(data.songs[i].artist);				
			  }
			  len = data.songs.length;
            PlayMusic();
		    },

		error: function(data) {
//			alert('Error checking in!' + data.text);
		}
	});
     }
}

function PlayMusic() {
	audio = document.getElementsByTagName('audio')[0];
	title = document.getElementById('stitle');
	songname = document.getElementById('songname');
	simage = document.getElementById('simg');
    songname.innerHTML = stitems[1];
	simage.src = stitems[2];
	title.innerHTML = stitems[3];
    run(stitems[0], audio);
    audio.addEventListener('ended',function(e){
        current= current+5;
        if(current == (len*5)){
            current = 0;
            link = stitems[0];
            songname.innerHTML = stitems[1];
	        simage.src = stitems[2];
	        title.innerHTML = stitems[3];			
        }else{
            link = stitems[current];   
            songname.innerHTML = stitems[current+1];
	        simage.src = stitems[current+2];
	        title.innerHTML = stitems[current+3];					
        }
        run(link,audio);
		CheckMood();
    });
}
function run(link, player){
        player.src = link;
        player.play();
}

function CheckMood () {
if (currentMood == "") {
      checkSongs('Relax');
	  currentMood = "Relax";
	  }
/*
$.ajax({
		type: 'GET',
		url: 'http://monitorzc.iriscouch.com/so_index/_design/index/gsmoods.html',
		   success: function(data) {
		      var risp = JSON.parse(data);
			  checkSongs(risp[1]);
		      },

		error: function(data) {
			alert('Error StereoMood!' + data.text);
		}
}); */
}

function checkSongs(mood) {
     if (!(mood == '')) {
	    var url = "http://www.stereomood.com/api/search.json?api_key=338ba2b6cfc5406eff0255f399e74d69051a0bdb2&type=mood&q=" + mood ;
	    $.ajax({
		   type: 'GET',
		   url: url,
		   dataType: 'json',
		   success: function(data) {
//		      objdata = JSON.parse(data);
			  for (var i = 0 ; i < data.songs.length; i++ ){
				stitems.push(data.songs[i].audio_url);
				stitems.push(data.songs[i].title);
				stitems.push(data.songs[i].image_url);
				stitems.push(data.songs[i].album);
				stitems.push(data.songs[i].artist);				
			  }
			  len = data.songs.length;
            PlayMusic();
		    },

		error: function(data) {
//			alert('Error checking in!' + data.text);
		}
	});
     }
}


/** 
 *  helper function which checks for certain query strings when the app loads (for use in the OAuth callback)
 */
function checkForQueryStrings(id) {
	var string = "[\\?&]" + id + "=([^&#]*)";
	var regex = new RegExp(string);
	var results = regex.exec(childWindow.location.href);
	if(results === null) {
		return;
	} else {
		return results[1];
	}
}

function CheckMeTwit(id,pwd) {
   MeTwitOAuth.consumerKey = id;
   MeTwitOAuth.consumerSecret = pwd;   
   startMeTwitOAuth();
}

function CheckStereoMood(id,pwd) {
   StereomoodOAuth.consumerKey = id;
   StereomoodOAuth.consumerSecret = pwd;
 //  startStereoMoodOAuth();
}


/**
 *  geolocation
 */

// we use HTML5 Geolocation to pin-point where the user is
function startGeolocation() {
  var options;
  navigator.geolocation.getCurrentPosition(geoSuccess, geoFail, options);
}

// geolocation success callback
function geoSuccess(position) {
  var gpsPosition = position;
  var coordinates = gpsPosition.coords;
  myLat = coordinates.latitude;
  myLong = coordinates.longitude;
 }

// geolocation failure callback
function geoFail() {
  alert('Error getting your position. Using defaults instead');

  // set default position upon failure
  myLat = 43.465187;
  myLong = -80.522372;
}

function doSMSave() {
var lcid = document.getElement("gsmood").id;
    localStorage.setItem(lcunknown,lcid);
    localStorage.setItem(lcsunclear,lcid);
	localStorage.setItem(lcrainy,lcid);
	localStorage.setItem(lcstormy,lcid);
    localStorage.setItem(lcsnowy,lcid);
    localStorage.setItem(lccloudy,lcid);
    localStorage.setItem(lchailing,lcid);
	localStorage.setItem(lcheavyseas,lcid);
	localStorage.setItem(lccalmseas,lcid);
	localStorage.setItem(lcfoggy,lcid);
	localStorage.setItem(lcsnowy,lcid);
	localStorage.setItem(lcsnowflurries,lcid);
    localStorage.setItem(lcwindy,"");
}

function checkPic() {
     
	    var url = "http://www.panoramio.com/map/get_panoramas.php?set=public&from=0&to=20";
	    $.ajax({
		   type: 'GET',
		   url: url,
		   dataType: 'json',
		   success: function(data) {
//		      objdata = JSON.parse(data);
			  for (var i = 0 ; i < 20; i++ ){
				pcitems.push(data.photos[i].photo_file_url);
			  }
			  len = 20;
            changePic();
		    },

		error: function(data) {
			alert('Error checking in!' + data.text);
		}
	});
}

function changePic() {
    simage = document.getElementById('ppic');
    if(pccurrent == 20){
       pccurrent = 0;
	   simage.src = pcitems[0];
        }else{
		pccurrent++;
	   simage.src = pcitems[pccurrent];
    };
}

// initialize accelerometer
function initSensors() {

	// start listening to the accelerometer sensor with a delay feedback of 1000 ** microseconds **
	blackberry.sensors.setOptions("deviceaccelerometer", {
		delay: 10000,
		background: true,
		batching: false,
		queue: false,
		reducedReporting: false
	});

	// start the event listener for the sensors callback
	blackberry.event.addEventListener("deviceaccelerometer", accelCallback);
}

function doParamSave(){
   localStorage.setItem("stid", document.querySelector('#stid').value );
   localStorage.setItem("stpwd", document.querySelector('#stpwd').value);
   localStorage.setItem("meid", document.querySelector('#meid').value);
   localStorage.setItem("mepwd", document.querySelector('#mepwd').value);
   localStorage.setItem("webip", document.querySelector('#webip').value);
}	


// accelerometer callback
function accelCallback(data) {
	x = data.x;

	if(x <= -13) {
		// if sound is playing, do not play another one
		if(hitPlaying == 1) {
			return false;
		
		// no sounds currently playing, play a sound
		} else {
			playHit();
			hitPlaying = 1;
			setTimeout(function() {
				hitPlaying = 0;
			}, 200);
		}
	}
}