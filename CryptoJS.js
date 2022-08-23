function URLenc(filename){
	let urlpath = window.location.href.split('?')[0]+filename;
	let urlpath_enc = encodeURIComponent(urlpath);
	let urlpath_base64 = window.btoa(urlpath_enc);
	let safelinku_api = "2a995948f68b47401407332e100dae9e6dc2f3f2";
	let monetize = "https://semawur.com/full?api=" + safelinku_api + "&url=" + urlpath_base64 + "&type=2";
	window.open(monetize, "_self");
}