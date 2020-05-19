function writeCategoryStats() {
	var category_stats_string = '<div class="category_stats">\n';

	for (i=0; i < categoryStats.length; i++) {
		var number_string = '';
		if (categoryStats[i][1] == 1) {
			number_string = '1 entry';
		} else {
			number_string = categoryStats[i][1] + ' entries';
		}

		category_stats_string += '<div class="category_stat">';
		category_stats_string += ('<a href=\"' + categoryStats[i][2] + '\">' + categoryStats[i][0] + '</a>');
		category_stats_string += (': ' + number_string + '</div>');
	}

	var totalStatsString = '';
	if (totalStatsCount == 1) {
		totalStatsString = '1 entry';
	} else {
		totalStatsString = (totalStatsCount + ' entries');
	}

	category_stats_string += ('<br /><div class=\"category_stat\">Total: ' + totalStatsString + '</div></div>');
	document.write(category_stats_string);
}

function writeStyleSheetLinks() {
 if ('Emotional Supernova' == 'Technological Supernova') {

    document.write('<link rel="stylesheet" type="text/css" href="http://simx.me/stylesheets/red-right-nav.css" title="Red Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/red-left-nav.css" title="Red Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/blue-right-nav.css" title="Blue Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/blue-left-nav.css" title="Blue Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/green-right-nav.css" title="Green Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/green-left-nav.css" title="Green Left Nav" />\n');
    setActiveStyleSheet('Red Left Nav');
  } else if ('Emotional Supernova' == 'Linkable Supernova') {
    document.write('<link rel="stylesheet" type="text/css" href="http://simx.me/stylesheets/green-right-nav.css" title="Green Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/green-left-nav.css" title="Green Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/red-right-nav.css" title="Red Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/red-left-nav.css" title="Red Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/blue-right-nav.css" title="Blue Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/blue-left-nav.css" title="Blue Left Nav" />\n');
  } else {
    document.write('<link rel="stylesheet" type="text/css" href="http://simx.me/stylesheets/blue-right-nav.css" title="Blue Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/blue-left-nav.css" title="Blue Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/red-right-nav.css" title="Red Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/red-left-nav.css" title="Red Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/green-right-nav.css" title="Green Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/green-left-nav.css" title="Green Left Nav" />\n');
  }
  document.write('<link rel="alternate stylesheet" type="text/css" href="http://simx.me/stylesheets/halloween-right-nav.css" title="Halloween" />\n');
}

function activateStylesheetFromCookie() {
  var cookie;
  var curdate = new Date();
  var month = curdate.getMonth();
  var date = curdate.getDate();
  if ((month == 9) && (date == 31)) {
setActiveStyleSheet('Halloween');
} else {
  if (('Emotional Supernova' == 'Supernova Emotivo') || ('Emotional Supernova' == 'Emotional Supernova')) {
    cookie = readCookie('Stylish Emotions');
  } else if ('Emotional Supernova' == 'Technological Supernova') {
    cookie = readCookie('Stylish Technology');
  } else if ('Emotional Supernova' == 'Linkable Supernova') {
    cookie = readCookie('Stylish Links');
  }
  var title = cookie ? cookie : getPreferredStyleSheet();
  setActiveStyleSheet(title);
}
}

function writeStyleSheetButtonLinks() {
 if ('Emotional Supernova' == 'Technological Supernova') {
document.write('<div class="stylesheet_buttons">\n<a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Red Right Nav\'); return false;"><img class="stylesheet_button" src="http://simx.me/images/stylesheet-buttons/red-right.png" alt="Red Right Nav" /></a><a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Red Left Nav\'); return false;"><img class ="stylesheet_button" src="http://simx.me/images/stylesheet-buttons/red-left.png" alt="Red Left Nav" /></a>\n</div>');
  } else if ('Emotional Supernova' == 'Linkable Supernova') {
document.write('<div class="stylesheet_buttons">\n<a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Green Right Nav\'); return false;"><img class="stylesheet_button" src="http://simx.me/images/stylesheet-buttons/green-right.png" alt="Green Right Nav" /></a><a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Green Left Nav\'); return false;"><img class ="stylesheet_button" src="http://simx.me/images/stylesheet-buttons/green-left.png" alt="Green Left Nav" /></a>\n</div>');
  } else {
document.write('<div class="stylesheet_buttons">\n<a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Blue Right Nav\'); return false;"><img class="stylesheet_button" src="http://simx.me/images/stylesheet-buttons/blue-right.png" alt="Blue Right Nav" /></a><a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Blue Left Nav\'); return false;"><img class ="stylesheet_button" src="http://simx.me/images/stylesheet-buttons/blue-left.png" alt="Blue Left Nav" /></a>\n</div>');
}
}


// the following functions were originally created by Paul Sowden
// 
// you can access the full tutorial on JavaScript stylesheet
// switching at http://www.alistapart.com/stories/alternate/
//
// Yay standards!
//
// Modified on 2006-05-05 to accomodate two pages with the
// same JavaScript file (onload and onunload modified)

function setActiveStyleSheetAndWriteCookie(title) {
	setActiveStyleSheet(title);
 if (title != 'Halloween') {
  if (('Emotional Supernova' == 'Supernova Emotivo') || ('Emotional Supernova' == 'Emotional Supernova')) {
   createCookie('Stylish Emotions', title, 365);
  } else if ('Emotional Supernova' == 'Technological Supernova') {
   createCookie('Stylish Technology', title, 365);
  } else if ('Emotional Supernova' == 'Linkable Supernova') {
   createCookie('Stylish Links', title, 365);
  }
 }
}

function setActiveStyleSheet(title) {
  var i, a, main;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {
      a.disabled = true;
      if(a.getAttribute("title") == title) a.disabled = false;
    }
  }
}

function getActiveStyleSheet() {
  var i, a;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title") && !a.disabled) return a.getAttribute("title");
  }
  return null;
}

function getPreferredStyleSheet() {
  var i, a;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1
       && a.getAttribute("rel").indexOf("alt") == -1
       && a.getAttribute("title")
       ) return a.getAttribute("title");
  }
  return null;
}

function createCookie(name,value,days) {
  if (days) {
    var date = new Date();
    date.setTime(date.getTime()+(days*24*60*60*1000));
    var expires = "; expires="+date.toGMTString();
  }
  else expires = "";
  document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i=0;i < ca.length;i++) {
    var c = ca[i];
    while (c.charAt(0)==' ') c = c.substring(1,c.length);
    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
}
