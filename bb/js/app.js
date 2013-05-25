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


/**
 *  called by the webworksready event when the environment is ready
 */
function initApp(locstor) {
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
	StereomoodOAuth.consumerKey = locstor.getItem("stid");
	StereomoodOAuth.consumerSecret = locstor.getItem("stpwd");
	StereomoodOAuth.callbackUrl = 'http://www.steromood.com/api/oauth/authenticate';
	MeTwitOAuth.consumerKey	= locstor.getItem("meid");
	MeTwitOAuth.consumerSecret = locstor.getItem("mepwd");
    var webip = locstor.getItem("webip");
    var lcunknown = locstor.getItem("unknown");
    var lcsunclear = locstor.getItem("sun-clear");
	var lcrainy = locstor.getItem("rainy");
	var lcstormy = locstor.getItem("stormy");
    var lcsnowy = locstor.getItem("snowy");
    var lccloudy = locstor.getItem("cloudy");
    var lchailing = locstor.getItem("hailing");
	var lcheavyseas = locstor.getItem("heavyseas");
	var lccalmseas = locstor.getItem("calmseas");
	var lcfoggy = locstor.getItem("foggy");
	var lcsnowy = locstor.getItem("snowy");
	var lcsnowflurries = locstor.getItem("snowflurries");
    var lcwindy = locstor.getItem("windy");
}


/**
 *  Set click handlers for the OAuth Start button
 *  Note: window.open can only be triggered in this way, you must set a click handler for this.
 */
function setClickHandlers() {
	var link = document.getElementById('btnAccess');
	link.addEventListener('click', function(e) {

		// if the childWindow is already open, don't allow user to click the button
		if(childWindow !== null) {
			return false;
		}

		e.preventDefault();
		toast('Fetching access token...');
		setTimeout(function() {
			getAccessToken();
		}, 500);
	});
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


/**
 *  get authenticated users feed
 */
function getFeed() {
	toast('Loading feed...');
	$('#content p').remove();

	StereomoodOAuth.get('https://api.twitter.com/1.1/statuses/user_timeline.json',

	// success
	function(data) {
		var tweets = JSON.parse(data.text);

		// show the last 10 tweets from the users timeline
		for(var i = 0; i < 11; i++) {
			$('#content').append('<p>' + tweets[i].text + '</p>');
		}
	},

	// failure
	function(data) {
		alert('Error getting timeline: ' + e);
		return false;
	});
}

function checkMeteo(lat,lon) {


	var url = "https://api.metwit.com/v2/weather/?location_lat=" + lat + " &location_lng=" +lon ;

	$.ajax({
		type: 'GET',
		url: url,

		success: function() {
		   var xml = "<rss version='2.0'><channel><title>RSS Title</title></channel></rss>",
                   xmlDoc = $.parseXML( xml ),
                   $xml = $( xmlDoc ),
                   $status = $xml.find( "status" );
		},

		error: function(data) {
			alert('Error checking in!' + data.text);
		}
	});
}

function checkSongs(mood) {
     if (!(mood == '')) {
	var url = "http://www.stereomood.com/api/search.xml?type=" + mood ;

	$.ajax({
		type: 'GET',
		url: url,

		success: function() {
			toast('Checked in @ ' + venueName);
		},

		error: function(data) {
			alert('Error checking in!' + data.text);
		}
	});
     }
}

/**
 *  display a toast message to the user
 */
function toast(msg) {
//	blackberry.ui.toast.show(msg);
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
   startStereoMoodOAuth();
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

/**
 *  google maps
 */

// initialize the map
function initGoogleMaps() {
   var geocoder, map;
   geocoder = new google.maps.Geocoder();
   var myLocation = new google.maps.LatLng(myLat, myLong);
   var mapOptions = {
      zoom: 8,
      center: myLocation,
      mapTypeId: google.maps.MapTypeId.ROADMAP
      }
   map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions), timeoutSeconds = 4, usingMap = false;
                                   
   geocoder.geocode( function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
         map.setCenter(results[0].geometry.location);
         var marker = new google.maps.Marker({
            map: map, 
            position: results[0].geometry.location
         });
         } else {
            alert("The map failed because: " + status);
         }
   });
}


// create a marker / push-pin
function createGoogleMarker(place) {
  var placeLoc = place.geometry.location;
  var marker = new google.maps.Marker({
    map: googleMap,
    position: place.geometry.location
  });
}

function doSMSave() {
var lcid = document.getElement("gsmood").id;
    locstor.setItem(lcunknown,lcid);
    locstor.setItem(lcsunclear,lcid);
	locstor.setItem(lcrainy,lcid);
	locstor.setItem(lcstormy,lcid);
    locstor.setItem(lcsnowy,lcid);
    locstor.setItem(lccloudy,lcid);
    locstor.setItem(lchailing,lcid);
	locstor.setItem(lcheavyseas,lcid);
	locstor.setItem(lccalmseas,lcid);
	locstor.setItem(lcfoggy,lcid);
	locstor.setItem(lcsnowy,lcid);
	locstor.setItem(lcsnowflurries,lcid);
    locstor.setItem(lcwindy,"");
}