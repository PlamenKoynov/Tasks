function initialize() {
	var myLatlng = new google.maps.LatLng(42.7253401,25.4833039);
	var mapOptions = {
		zoom: 7,
	    center: myLatlng
  	}
	var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	parser(map);
}

function parser(map) {
	var request = new XMLHttpRequest();
	request.open("GET", "offices.json", false);
	request.send(null);
	var my_JSON_object = JSON.parse(request.responseText);
	var size = my_JSON_object.result.offices.length;			
	getAddress(my_JSON_object, size, map);
	//setInterval(parser, 18000000);
}

function getAddress(JObj, size, map)
{
	//console.log(size);
	var i = 0;
	var int = setInterval(function(){
		var city = JObj.result.offices[i].city;
		var address = JObj.result.offices[i].address;	
		var info = JObj.result.offices[i].worktime;
		console.log(city + ' ' + address );
		GeoCode(city, address, map);
		i++;
		if(i == size - 1) {
			clearInterval(int);
			}
	}, 700);	
}

function GeoCode(city, address, map)
{
	var markersInfo = new Array();
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode( { 'address': address + city + 'Bulgaria'}, function(results,status) {
		if (status === google.maps.GeocoderStatus.OK) {
			var latitude = results[0].geometry.location.lat();
			var longitude = results[0].geometry.location.lng();
			myLatlng = new google.maps.LatLng(latitude, longitude);		
			var marker = new google.maps.Marker({
				position: myLatlng,
				map: map
				});			
		}
	});
}
google.maps.event.addDomListener(window, 'load', initialize);
