function writeLinkableSupernovaLinks() {
	var linked_list = '';
	linked_list += '<ul>';
	for (i=0; i < 10; i++) {
		linked_list += '<li><a href="' + linkableSupernovaRecentEntries[i][1] + '">' + linkableSupernovaRecentEntries[i][0] + '</a></li>';
	}
	linked_list += '</ul>';
	document.write(linked_list);
}

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
 if ('Technological Supernova' == 'Technological Supernova') {

    document.write('<link rel="stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/red-right-nav.css" title="Red Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/red-left-nav.css" title="Red Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/blue-right-nav.css" title="Blue Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/blue-left-nav.css" title="Blue Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/green-right-nav.css" title="Green Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/green-left-nav.css" title="Green Left Nav" />\n');
    setActiveStyleSheet('Red Left Nav');
  } else if ('Technological Supernova' == 'Linkable Supernova') {
    document.write('<link rel="stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/green-right-nav.css" title="Green Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/green-left-nav.css" title="Green Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/red-right-nav.css" title="Red Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/red-left-nav.css" title="Red Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/blue-right-nav.css" title="Blue Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/blue-left-nav.css" title="Blue Left Nav" />\n');
  } else {
    document.write('<link rel="stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/blue-right-nav.css" title="Blue Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/blue-left-nav.css" title="Blue Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/red-right-nav.css" title="Red Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/red-left-nav.css" title="Red Left Nav" />\n');
    document.write('<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/green-right-nav.css" title="Green Right Nav" />\n<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/green-left-nav.css" title="Green Left Nav" />\n');
  }
  document.write('<link rel="alternate stylesheet" type="text/css" href="http://homepage.mac.com/simx/stylesheets/halloween-right-nav.css" title="Halloween" />\n');
}

function activateStylesheetFromCookie() {
  var cookie;
  var curdate = new Date();
  var month = curdate.getMonth();
  var date = curdate.getDate();
  if ((month == 9) && (date == 31)) {
setActiveStyleSheet('Halloween');
} else {
  if (('Technological Supernova' == 'Supernova Emotivo') || ('Technological Supernova' == 'Emotional Supernova')) {
    cookie = readCookie('Stylish Emotions');
  } else if ('Technological Supernova' == 'Technological Supernova') {
    cookie = readCookie('Stylish Technology');
  } else if ('Technological Supernova' == 'Linkable Supernova') {
    cookie = readCookie('Stylish Links');
  }
  var title = cookie ? cookie : getPreferredStyleSheet();
  setActiveStyleSheet(title);
}
}

function writeStyleSheetButtonLinks() {
 if ('Technological Supernova' == 'Technological Supernova') {
document.write('<div class="stylesheet_buttons">\n<a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Red Right Nav\'); return false;"><img class="stylesheet_button" src="http://homepage.mac.com/simx/stylesheets/red-right.png" alt="Red Right Nav" /></a><a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Red Left Nav\'); return false;"><img class ="stylesheet_button" src="http://homepage.mac.com/simx/stylesheets/red-left.png" alt="Red Left Nav" /></a>\n</div>');
  } else if ('Technological Supernova' == 'Linkable Supernova') {
document.write('<div class="stylesheet_buttons">\n<a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Green Right Nav\'); return false;"><img class="stylesheet_button" src="http://homepage.mac.com/simx/stylesheets/green-right.png" alt="Green Right Nav" /></a><a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Green Left Nav\'); return false;"><img class ="stylesheet_button" src="http://homepage.mac.com/simx/stylesheets/green-left.png" alt="Green Left Nav" /></a>\n</div>');
  } else {
document.write('<div class="stylesheet_buttons">\n<a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Blue Right Nav\'); return false;"><img class="stylesheet_button" src="http://homepage.mac.com/simx/stylesheets/blue-right.png" alt="Blue Right Nav" /></a><a href="#" onclick="setActiveStyleSheetAndWriteCookie(\'Blue Left Nav\'); return false;"><img class ="stylesheet_button" src="http://homepage.mac.com/simx/stylesheets/blue-left.png" alt="Blue Left Nav" /></a>\n</div>');
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
  if (('Technological Supernova' == 'Supernova Emotivo') || ('Technological Supernova' == 'Emotional Supernova')) {
   createCookie('Stylish Emotions', title, 365);
  } else if ('Technological Supernova' == 'Technological Supernova') {
   createCookie('Stylish Technology', title, 365);
  } else if ('Technological Supernova' == 'Linkable Supernova') {
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

function writeiTunesWidgetCookie(enabledString) {
 createCookie('myiTunesWidgets',enabledString,365);
}

function enableiTunesWidgets() {
 var widgetDiv = document.getElementById('myiTunesWidgets');
 widgetDiv.style.display = 'inline';
 writeiTunesWidgetCookie('enabled');
 
 var enableButtonDiv = document.getElementById('enableiTunesWidgetsButtonDiv');
 enableButtonDiv.style.display = 'none';
 
 var disableButtonDiv = document.getElementById('disableiTunesWidgetsButtonDiv');
 disableButtonDiv.style.display = 'inline';
}

function disableiTunesWidgets() {
 var widgetDiv = document.getElementById('myiTunesWidgets');
 widgetDiv.style.display = 'none';
 writeiTunesWidgetCookie('disabled');
 
 var enableButtonDiv = document.getElementById('enableiTunesWidgetsButtonDiv');
 enableButtonDiv.style.display = 'inline';
 
 var disableButtonDiv = document.getElementById('disableiTunesWidgetsButtonDiv');
 disableButtonDiv.style.display = 'none';
}


// the following are for .mac comments

function onPageLoad()
{
    evalAndIgnoreException('initComments();');
    evalAndIgnoreException('commentLayerLinkAssist();');
    return true;
}

function evalAndIgnoreException(s)
{
  try
  {
    eval(s);
  }
  catch (e)
  {
  }
}

function commentLayerLinkAssist()
{
    if (location.hash == '#comment_layer')
    {
        var node = document.getElementById('comment_layer');
        if (node)
        {
            var offsetY = node.offsetTop;
            while (node.offsetParent != null)
            {
                node = node.offsetParent;
                offsetY = offsetY + node.offsetTop;
            }
            window.scrollTo(0, offsetY - 53); // -53 because of the top banner
        }
    }
}


// Aliases
function initCommentSummary()
{
	initSummaryComments();
}

function insertCommentCountStrings()
{
	initSummaryComments();
}

function initSummaryComments() 
{
	setLocale();
	var commentCount;
	for (var entry in entryURLs) {
		if (entryURLs[entry].comments || entryURLs[entry].count > 0) {
			commentCount = document.getElementById('comments_' + entryURLs[entry].order);
			if (commentCount !== null) {
				commentCount.innerHTML = commentCountString(entryURLs[entry].count);
			} 
			commentCount = null;
		} 
	}
}

function oogity()
{
alert('yes, thats right, oogity!');
}

// this function writes the SCRIPT tag that contains the comments for the page
function OMGWTFBBQITISTOOLATETOWRITEJAVASCRIPT(url)
{
	var location_array;
	if (typeof(fakeURLPathname) == "undefined") {
		location_array = location.pathname.split('/');
	} else {
		location_array = fakeURLPathname.split('/');
	}
	var amended_location_string = '';
	var i = 0;
	var count = location_array.length;
	for (i = 0; i < (count-1); i++) {
		if (location_array[i] != '') amended_location_string = amended_location_string + location_array[i] + '/';
	}
	var time = new Date().getTime();
	document.write('<script src="' + 'http://web.mac.com/' + amended_location_string + url + '?wsc=summary.js&ts=' + time + '" type="text/javascript"></script>');
}

// this function writes the A tag that tells how many comments there are for that entry
function initPersonWhoHasNoNameComments(url,displayURL) 
{
	setLocale();
	var commentCount;

	var commentsURL = url;
	if ( (displayURL !== '') && (displayURL !== undefined) ) {
		commentsURL = displayURL;
	}

	var location_array = url.split('/');
	var count = location_array.length;
	if (entryURLs[location_array[count-1]].comments) {
		if (commentCount !== null) {
				document.write('<a href="' + commentsURL + '#comments">' + commentCountString(entryURLs[location_array[count-1]].count) + '</a>');
		} 
		commentCount = null;
	}
}





// comments.js

/* Copyright (c) 2006 by Apple Computer, Inc.  All Rights Reserved. */

var commentJavascriptVersion = "$Revision: 1.39 $";
var commentWindow;

// global strings
var commentsAppURL = 'http://www.mac.com/WebObjects/Comments.woa/wa/comment';
var manageCommentsAppURL = 'http://www.mac.com/WebObjects/Comments.woa/wa/manage';
var windowRules = 'menubar=no,resizable=no,height=580,width=435';
var commentsURL;
if (typeof(fakeURLPathname)=="undefined") {
	commentsURL = 'http://web.mac.com' + location.pathname + '?wsc=entry.js&ts=' + new Date().getTime();
} else {
	commentsURL = 'http://web.mac.com' + fakeURLPathname + '?wsc=entry.js&ts=' + new Date().getTime();
}

function data(o)
{
	// there are comments
	comments.read = true;
	comments.update(o);
}

// Load localization
document.write('<script src="http://www.mac.com/1/up/comments/scripts/loc.js" type="text/javascript" charset="utf-8"></script>');

// Load utility objects
document.write('<script src="http://www.mac.com/1/up/comments/scripts/utility.js" type="text/javascript" charset="utf-8"></script>');

// Called from the window.onload method
function initComments()
{
	browser.detect();
	setLocale();
	decorations.init();
	if (commentsActivated) {
		comments.fetch();
	} 
	else {
		decorations.hide('comment_layer'); // commenting never turned on
	}
}

var comments = {

	read: false,
	count: 0,
	canComment: false,
	hasComments: false,
	itemOrder: ['authorblock','dateblock','commenttext','attachments','separator'],
	view : 0,
	
	// fetch comments from iDisk
	fetch: function()
	{
		var c = comments;
		
		// Find and remove JSON loading script element
		var JSONScript = document.getElementById('view_' + c.view);
		var head = document.getElementsByTagName('head')[0];
		if (JSONScript !== null) {
			head.removeChild(JSONScript);
			c.view = c.view + 1;
		}
		
		JSONScript = document.createElement('script');
		
		// Create new JSON script element, new script element will call comments.update()
		JSONScript.setAttribute('id','view_' + c.view);
		if (typeof(fakeURLPathname) == "undefined") {
			JSONScript.setAttribute('src','http://web.mac.com' + location.pathname + '?wsc=entry.js&ts=' + new Date().getTime());
		} else {
			JSONScript.setAttribute('src','http://web.mac.com' + fakeURLPathname + '?wsc=entry.js&ts=' + new Date().getTime());
		}
		JSONScript.setAttribute('type','text/javascript');
		JSONScript.setAttribute('charset','utf-8');
		head.appendChild(JSONScript);
	},
	
	// Callback from JSON result
	update: function(JSONResult)
	{
		var c = comments;
		
		// Update Flags and Counts
	
		// canComment
		if (JSONResult.commentsEnabled == 'true') {
			c.canComment = true;
		} 
		else {
			c.canComment = false;
		}		
		
		// hasComments
		if (JSONResult.items !== null && JSONResult.items.length > 0) {
			c.hasComments = true;
		}
		else {
			c.hasComments = false;
		}
		
		// count
		if (JSONResult.items !== null) {
			c.count = JSONResult.items.length;
		}
		else {
			c.count = 0;
		}
		
		if (!c.canComment && c.count == 0) {
			decorations.hide('comment_layer'); // entries w/o comments created when the blog allowed commenting
		}	
		else if (c.count > 0) {
			c.load(JSONResult.items);
			if (!c.canComment) {
				decorations.hide('comment_footer'); // entries w/comments while the blog allowed commenting
			}
		}
		else {
			decorations.hide('comment_title'); // entry w/o comments, but blog allows commenting
		}
		
		// update page decorations
		decorations.update_count();
		decorations.update_manage_comments();
		decorations.update_post_link();
		
		pngs.fix();
		
	},
	
	// insert comments into page
	load: function(items)
	{
		
		var c = comments;
		var commentlist;
		
		commentlist = document.getElementById('comment_list');

		if (commentlist === null) { return; }
			
		var comment;	
		var id;
		
		for (var i = 0; i < items.length; i ++) {
	
			// remember to replace '-' with '_' and prefix the UUID of the comment so that it's a valid element id.
			id = 'comment_' + items[i].commentID.replace(/\-/g,'_');
		
			// don't reinsert already existing comments
			if(document.getElementById(id) === null) {
		
				comment = document.createElement('div');
				comment.className = 'commentblock';
	
				
				var anchor = document.createElement('a');
				if (anchor != null) { 
					anchor.setAttribute('name',id);
					anchor.setAttribute('id',id);
					comment.appendChild(anchor);
				}
				
				// loop over properties in comment, if a property has a callback function defined, then call it
				for (var j = 0; j < c.itemOrder.length; j++) {
					if (render[c.itemOrder[j]] !== undefined) {
						render[c.itemOrder[j]](comment,items[i]);
					}			
				}
						
				commentlist.appendChild(comment);
				comment = null;
			
			}
			
		}
	
	}
}

var decorations = {
	list: ['count','manage_comments','post_link','comment_layer','comment_footer','comment_title'],
	init: function ()
	{
		var d = decorations;
		
		// loop over properties in decorations
		for (var i = 0; i < d.list.length; i++) {
			d[d.list[i]] = d.collect(d.list[i]);
		}	
	},

	// collect gathers all the placeholders for a placeholder of type name and returns them in the array collection
	collect: function(name)
	{
		var collection = [];
		var e, i = 0;
		
		// look for the base version of the item name # to remove
		e = document.getElementById(name);
		if (e !== null) { collection.push(e); }
		
		// loop over name_N until you cannot find
		e = document.getElementById(name + '_' + i);		
		while (e !== null) {
			collection.push(e);
			i ++;
			e = document.getElementById(name + '_' + i);
		}
		return collection;
	},
	
	update_count: function()
	{
		var d = decorations;
		
		for (var i = 0; i < d.count.length; i ++) {
			if (comments.hasComments) {
			
				d.show('comment_title');
				
				var s = document.createTextNode(commentCountString(comments.count));
				var r = d.count[i].firstChild;
				
				if (d.count[i].hasChildNodes && r != null) {
					d.count[i].replaceChild(s,r);
				}
				else {
					d.count[i].appendChild(s);
				}
				
			} 
		}	
	},
	
	update_manage_comments: function()
	{
		var d = decorations;
		
		for (var i = 0; i < d.manage_comments.length; i ++) {
		
			var r = d.manage_comments[i].firstChild;

			// insert control if none found
			if (comments.hasComments && r == null) {
				var managelink = document.createElement('a');
				var commentcontrolGlyph = document.createElement('img');
				
				// use element's class name to determine which image to use
				switch (d.manage_comments[i].className) {
					case 'light':
						commentcontrolGlyph.src = 'http://www.mac.com/1/up/comments/images/lockIcon_dark.png';
						break;
					case 'dark':
					default:
						commentcontrolGlyph.src = 'http://www.mac.com/1/up/comments/images/lockIcon_light.png';				
				}
				
				commentcontrolGlyph.alt = localeStringForKey('managecomments');
				commentcontrolGlyph.title = localeStringForKey('managecomments');
				commentcontrolGlyph.id = 'manage_comments_icon_' + i;
				managelink.appendChild(commentcontrolGlyph);
				if (typeof(fakeURLPathname) == "undefined") {
					managelink.href = manageCommentsAppURL + '?url=' + encodeURIComponent(decodeURIComponent(location.pathname)); // prevent double encoding
				} else {
					managelink.href = manageCommentsAppURL + '?url=' + encodeURIComponent(decodeURIComponent(fakeURLPathname));
				}

				d.manage_comments[i].appendChild(managelink);
				
				pngs.add('manage_comments_icon_' + i);
				
				managelink = null;				
				commentcontrolGlyph = null;
			}
		}
	},
	
	update_post_link: function()
	{
		var d = decorations;
		
		for (var i = 0; i < d.post_link.length; i ++) {
			
			var r = d.post_link[i].firstChild;
		
			if (comments.canComment && r == null) {
				var commentlink = document.createElement('a');
				var s = document.createTextNode(localeStringForKey('addcomment'));
				commentlink.appendChild(s);
				commentlink.href = '#';
				commentlink.onclick = function() 
				{
					var name;
					var thePathname;
					if (typeof(fakeURLPathname) == "undefined") {
						thePathname = location.pathname;
					} else {
						thePathname = fakeURLPathname;
					}					


					// compute window name from blog entry ID
					var path = thePathname.split('/');
					if (path.length > 0) {
						name = path[path.length - 1];
					}
					else {
						name = 'entry.html';
					}
					name = name.replace('.html','');
					name = 'comment_' + name.replace(/\-/g,'_');
					commentWindow = window.open(commentsAppURL + '?url=' + encodeURIComponent(decodeURIComponent(thePathname)),name,windowRules); // prevent double encoding & clean up window name
					listenForChildWindow(); // start listener
					return false;	
				}
				commentlink.style.fontWeight = 'bold';
				commentlink.title = localeStringForKey('addcommentcaption');
				d.post_link[i].appendChild(commentlink);	
				commentlink = null;
			}
		}
	},
		
	hide: function(name)
	{	
		var d = decorations;
		var set = d[name];
		for (var i = 0; i < set.length; i++) {
			if (set[i] !== null) { set[i].style.display = 'none'; }
		}
	},
	
	show: function(name)
	{
		var d = decorations;
		var set = d[name];
		for (var i = 0; i < set.length; i++) {
			if (set[i] !== null) { set[i].style.display = 'block'; }
		}
	}

};

// Callback Functions For Rendering Comments
var render = {
	commenttext: function(comment,data) 
	{
		var	body = document.createElement('div');
		body.className = 'commenttext';
		body.style.overflow = 'auto';


		commentText = data.body.replace(/\<A href=\"(.*?)\" rel=\"nofollow\"\>(.*?)\<\/A\>/gi,'$2');
		commentText = commentText.replace(/\&lt;img (.*?)\]/gi,'<img $1>');
		commentText = commentText.replace(/\&lt;\/img\&gt;/gi,'</img>');
		commentText = commentText.replace(/\&lt;a (.*?)\&gt;/gi,'<a $1>');
		commentText = commentText.replace(/\&lt;\/a\&gt;/gi,'</a>');
		commentText = commentText.replace(/\&lt;u\&gt;/gi,'<u>');
		commentText = commentText.replace(/\&lt;\/u\&gt;/gi,'</u>');
		commentText = commentText.replace(/\&lt;b\&gt;/gi,'<b>');
		commentText = commentText.replace(/\&lt;\/b\&gt;/gi,'</b>');
		commentText = commentText.replace(/\&lt;i\&gt;/gi,'<i>');
		commentText = commentText.replace(/\&lt;\/i\&gt;/gi,'</i>');
		commentText = commentText.replace(/\&lt;blockquote\&gt;/gi,'<blockquote>');
		commentText = commentText.replace(/\&lt;\/blockquote\&gt;/gi,'</blockquote>');
		commentText = commentText.replace(/\&lt;pre\&gt;/gi,'<pre>');
		commentText = commentText.replace(/\&lt;\/pre\&gt;/gi,'</pre>');
		commentText = commentText.replace(/\&lt;code\&gt;/gi,'<code>');
		commentText = commentText.replace(/\&lt;\/code\&gt;/gi,'</code>');
		commentText = commentText.replace(/\&lt;q\&gt;/gi,'<q>');
		commentText = commentText.replace(/\&lt;\/q\&gt;/gi,'</q>');
		commentText = commentText.replace(/\n\&lt;p\&gt;/gi,'<p>');
		commentText = commentText.replace(/\&lt;p\&gt;/gi,'<p>');
		commentText = commentText.replace(/\&lt;\/p\&gt;\n/gi,'</p>');
		commentText = commentText.replace(/\&lt;\/p\&gt;/gi,'</p>');
		commentText = commentText.replace(/\&lt;em\&gt;/gi,'<em>');
		commentText = commentText.replace(/\&lt;\/em\&gt;/gi,'</em>');

		commentText = commentText.replace(/\[img (.*?)\]/gi,'<img $1>');
		commentText = commentText.replace(/\[\/img\]/gi,'</img>');
		commentText = commentText.replace(/\[a (.*?)\]/gi,'<a $1>');
		commentText = commentText.replace(/\[\/a\]/gi,'</a>');
		commentText = commentText.replace(/\[u\]/gi,'<u>');
		commentText = commentText.replace(/\[\/u\]/gi,'</u>');
		commentText = commentText.replace(/\[b\]/gi,'<b>');
		commentText = commentText.replace(/\[\/b\]/gi,'</b>');
		commentText = commentText.replace(/\[i\]/gi,'<i>');
		commentText = commentText.replace(/\[\/i\]/gi,'</i>');
		commentText = commentText.replace(/\[blockquote\]/gi,'<blockquote>');
		commentText = commentText.replace(/\[\/blockquote\]/gi,'</blockquote>');
		commentText = commentText.replace(/\[pre\]/gi,'<pre>');
		commentText = commentText.replace(/\[\/pre\]/gi,'</pre>');
		commentText = commentText.replace(/\[code\]/gi,'<code>');
		commentText = commentText.replace(/\[\/code\]/gi,'</code>');
		commentText = commentText.replace(/\[q\]/gi,'<q>');
		commentText = commentText.replace(/\[\/q\]/gi,'</q>');
		commentText = commentText.replace(/\n\[p\]/gi,'<p>');
		commentText = commentText.replace(/\[p\]/gi,'<p>');
		commentText = commentText.replace(/\[\/p\]\n/gi,'</p>');
		commentText = commentText.replace(/\[\/p\]/gi,'</p>');
		commentText = commentText.replace(/\[em\]/gi,'<p>');
		commentText = commentText.replace(/\[\/em\]/gi,'</p>');

		commentText = commentText.replace(/<br><p>/gi,'<p>');
		commentText = commentText.replace(/<\/p><br>/gi,'</p>');


		commentText = commentText.replace(/>\:\)/g,'<img src="http://homepage.mac.com/simx/smilies/devil.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(-.-\)/g,'<img src="http://homepage.mac.com/simx/smilies/sleeping.png" style="margin: 0px;">');
		commentText = commentText.replace(/-_-/g,'<img src="http://homepage.mac.com/simx/smilies/sleeping.png" style="margin: 0px;">');
		commentText = commentText.replace(/-.-/g,'<img src="http://homepage.mac.com/simx/smilies/sleeping.png" style="margin: 0px;">');
		commentText = commentText.replace(/>-\)/g,'<img src="http://homepage.mac.com/simx/smilies/alien.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(->\)/g,'<img src="http://homepage.mac.com/simx/smilies/arrow.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(pirate\)/g,'<img src="http://homepage.mac.com/simx/smilies/chris.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:pirate\:/g,'<img src="http://homepage.mac.com/simx/smilies/chris.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(phone\)/g,'<img src="http://homepage.mac.com/simx/smilies/phone.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:phone\:/g,'<img src="http://homepage.mac.com/simx/smilies/phone.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(santa\)/g,'<img src="http://homepage.mac.com/simx/smilies/santa.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:santa\:/g,'<img src="http://homepage.mac.com/simx/smilies/santa.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(sheep\)/g,'<img src="http://homepage.mac.com/simx/smilies/shaun.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:sheep\:/g,'<img src="http://homepage.mac.com/simx/smilies/shaun.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(shaun\)/g,'<img src="http://homepage.mac.com/simx/smilies/shaun.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:shaun\:/g,'<img src="http://homepage.mac.com/simx/smilies/shaun.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(\*\:\)/g,'<img src="http://homepage.mac.com/simx/smilies/shuriken.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(sorcerer\)/g,'<img src="http://homepage.mac.com/simx/smilies/sorcerer.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:sorcerer\:/g,'<img src="http://homepage.mac.com/simx/smilies/sorcerer.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(zorro\)/g,'<img src="http://homepage.mac.com/simx/smilies/zorro.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:zorro\:/g,'<img src="http://homepage.mac.com/simx/smilies/zorro.png" style="margin: 0px;">');
		commentText = commentText.replace(/o_O/g,'<img src="http://homepage.mac.com/simx/smilies/blink.png" style="margin: 0px;">');
		commentText = commentText.replace(/O_o/g,'<img src="http://homepage.mac.com/simx/smilies/blink.png" style="margin: 0px;">');
		commentText = commentText.replace(/o_0/g,'<img src="http://homepage.mac.com/simx/smilies/blink.png" style="margin: 0px;">');
		commentText = commentText.replace(/0_o/g,'<img src="http://homepage.mac.com/simx/smilies/blink.png" style="margin: 0px;">');
		commentText = commentText.replace(/>\:\(/g,'<img src="http://homepage.mac.com/simx/smilies/angry.png" style="margin: 0px;">');
		commentText = commentText.replace(/>\:-\(/g,'<img src="http://homepage.mac.com/simx/smilies/angry.png" style="margin: 0px;">');
		commentText = commentText.replace(/X\(/g,'<img src="http://homepage.mac.com/simx/smilies/angry.png" style="margin: 0px;">');
		commentText = commentText.replace(/X-\(/g,'<img src="http://homepage.mac.com/simx/smilies/angry.png" style="margin: 0px;">');
		commentText = commentText.replace(/x\(/g,'<img src="http://homepage.mac.com/simx/smilies/angry.png" style="margin: 0px;">');
		commentText = commentText.replace(/x-\(/g,'<img src="http://homepage.mac.com/simx/smilies/angry.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\">/g,'<img src="http://homepage.mac.com/simx/smilies/blushing.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\*>/g,'<img src="http://homepage.mac.com/simx/smilies/blushing.png" style="margin: 0px;">');
		commentText = commentText.replace(/B\)/g,'<img src="http://homepage.mac.com/simx/smilies/cool.png" style="margin: 0px;">');
		commentText = commentText.replace(/B-\)/g,'<img src="http://homepage.mac.com/simx/smilies/cool.png" style="margin: 0px;">');
		commentText = commentText.replace(/8\)/g,'<img src="http://homepage.mac.com/simx/smilies/cool.png" style="margin: 0px;">');
		commentText = commentText.replace(/8-\)/g,'<img src="http://homepage.mac.com/simx/smilies/cool.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\'\(/g,'<img src="http://homepage.mac.com/simx/smilies/crying.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-z/g,'<img src="http://homepage.mac.com/simx/smilies/dizzy.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:z/g,'<img src="http://homepage.mac.com/simx/smilies/dizzy.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\\/g,'<img src="http://homepage.mac.com/simx/smilies/ermm.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-\\/g,'<img src="http://homepage.mac.com/simx/smilies/ermm.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-\//g,'<img src="http://homepage.mac.com/simx/smilies/ermm.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(\:\)/g,'<img src="http://homepage.mac.com/simx/smilies/fear.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(ph33r\)/g,'<img src="http://homepage.mac.com/simx/smilies/fear.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:ph33r\:/g,'<img src="http://homepage.mac.com/simx/smilies/fear.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(ph34r\)/g,'<img src="http://homepage.mac.com/simx/smilies/fear.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:ph34r\:/g,'<img src="http://homepage.mac.com/simx/smilies/fear.png" style="margin: 0px;">');
		commentText = commentText.replace(/<_</g,'<img src="http://homepage.mac.com/simx/smilies/getlost.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-D/g,'<img src="http://homepage.mac.com/simx/smilies/grin.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:D/g,'<img src="http://homepage.mac.com/simx/smilies/grin.png" style="margin: 0px;">');
		commentText = commentText.replace(/\^_\^/g,'<img src="http://homepage.mac.com/simx/smilies/happy.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-\)\)/g,'<img src="http://homepage.mac.com/simx/smilies/happy.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\)\)/g,'<img src="http://homepage.mac.com/simx/smilies/happy.png" style="margin: 0px;">');
		commentText = commentText.replace(/O\:\)/g,'<img src="http://homepage.mac.com/simx/smilies/innocent.png" style="margin: 0px;">');
		commentText = commentText.replace(/o\:\)/g,'<img src="http://homepage.mac.com/simx/smilies/innocent.png" style="margin: 0px;">');
		commentText = commentText.replace(/o\:-\)/g,'<img src="http://homepage.mac.com/simx/smilies/innocent.png" style="margin: 0px;">');
		commentText = commentText.replace(/O\:-\)/g,'<img src="http://homepage.mac.com/simx/smilies/innocent.png" style="margin: 0px;">');
		commentText = commentText.replace(/0\:\)/g,'<img src="http://homepage.mac.com/simx/smilies/innocent.png" style="margin: 0px;">');
		commentText = commentText.replace(/0\:-\)/g,'<img src="http://homepage.mac.com/simx/smilies/innocent.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\*/g,'<img src="http://homepage.mac.com/simx/smilies/kiss.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-\*/g,'<img src="http://homepage.mac.com/simx/smilies/kiss.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(LOL\)/g,'<img src="http://homepage.mac.com/simx/smilies/laughing.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:LOL\:/g,'<img src="http://homepage.mac.com/simx/smilies/laughing.png" style="margin: 0px;">');
		commentText = commentText.replace(/LOL/g,'<img src="http://homepage.mac.com/simx/smilies/laughing.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(lol\)/g,'<img src="http://homepage.mac.com/simx/smilies/laughing.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:lol\:/g,'<img src="http://homepage.mac.com/simx/smilies/laughing.png" style="margin: 0px;">');
		commentText = commentText.replace(/lol/g,'<img src="http://homepage.mac.com/simx/smilies/laughing.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\|/g,'<img src="http://homepage.mac.com/simx/smilies/noexpression.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-\|/g,'<img src="http://homepage.mac.com/simx/smilies/noexpression.png" style="margin: 0px;">');
		commentText = commentText.replace(/>_</g,'<img src="http://homepage.mac.com/simx/smilies/pinch.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\(/g,'<img src="http://homepage.mac.com/simx/smilies/sad.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-\(/g,'<img src="http://homepage.mac.com/simx/smilies/sad.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-O/g,'<img src="http://homepage.mac.com/simx/smilies/shocked.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:O/g,'<img src="http://homepage.mac.com/simx/smilies/shocked.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-o/g,'<img src="http://homepage.mac.com/simx/smilies/shocked.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:o/g,'<img src="http://homepage.mac.com/simx/smilies/shocked.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-0/g,'<img src="http://homepage.mac.com/simx/smilies/shocked.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:0/g,'<img src="http://homepage.mac.com/simx/smilies/shocked.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:&/g,'<img src="http://homepage.mac.com/simx/smilies/sick.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-&/g,'<img src="http://homepage.mac.com/simx/smilies/sick.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\)/g,'<img src="http://homepage.mac.com/simx/smilies/smile.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-\)/g,'<img src="http://homepage.mac.com/simx/smilies/smile.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(teehee\)/g,'<img src="http://homepage.mac.com/simx/smilies/stuart.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:teehee\:/g,'<img src="http://homepage.mac.com/simx/smilies/stuart.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:P/g,'<img src="http://homepage.mac.com/simx/smilies/tongue.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-P/g,'<img src="http://homepage.mac.com/simx/smilies/tongue.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:p/g,'<img src="http://homepage.mac.com/simx/smilies/tongue.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-p/g,'<img src="http://homepage.mac.com/simx/smilies/tongue.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\]/g,'<img src="http://homepage.mac.com/simx/smilies/turned.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:s/g,'<img src="http://homepage.mac.com/simx/smilies/unsure.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-S/g,'<img src="http://homepage.mac.com/simx/smilies/unsure.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-s/g,'<img src="http://homepage.mac.com/simx/smilies/unsure.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:S/g,'<img src="http://homepage.mac.com/simx/smilies/unsure.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(woot\)/g,'<img src="http://homepage.mac.com/simx/smilies/w00t.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(w00t\)/g,'<img src="http://homepage.mac.com/simx/smilies/w00t.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(wOOt\)/g,'<img src="http://homepage.mac.com/simx/smilies/w00t.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:woot\:/g,'<img src="http://homepage.mac.com/simx/smilies/w00t.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:w00t\:/g,'<img src="http://homepage.mac.com/simx/smilies/w00t.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:wOOt\:/g,'<img src="http://homepage.mac.com/simx/smilies/w00t.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:\?/g,'<img src="http://homepage.mac.com/simx/smilies/wassat.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-\"/g,'<img src="http://homepage.mac.com/simx/smilies/whistling.png" style="margin: 0px;">');
		commentText = commentText.replace(/;\)/g,'<img src="http://homepage.mac.com/simx/smilies/wink.png" style="margin: 0px;">');
		commentText = commentText.replace(/;-\)/g,'<img src="http://homepage.mac.com/simx/smilies/wink.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:x/g,'<img src="http://homepage.mac.com/simx/smilies/wub.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:X/g,'<img src="http://homepage.mac.com/simx/smilies/wub.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-X/g,'<img src="http://homepage.mac.com/simx/smilies/wub.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:-x/g,'<img src="http://homepage.mac.com/simx/smilies/wub.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(cat\)/g,'<img src="http://homepage.mac.com/simx/smilies/cat.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:cat\:/g,'<img src="http://homepage.mac.com/simx/smilies/cat.png" style="margin: 0px;">');
		commentText = commentText.replace(/\%\%-/g,'<img src="http://homepage.mac.com/simx/smilies/clover.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(!\)/g,'<img src="http://homepage.mac.com/simx/smilies/excl.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(flowers\)/g,'<img src="http://homepage.mac.com/simx/smilies/flowers.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:flowers\:/g,'<img src="http://homepage.mac.com/simx/smilies/flowers.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(heart\)/g,'<img src="http://homepage.mac.com/simx/smilies/heart.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:heart\:/g,'<img src="http://homepage.mac.com/simx/smilies/heart.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(homestar\)/g,'<img src="http://homepage.mac.com/simx/smilies/homestar.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:homestar\:/g,'<img src="http://homepage.mac.com/simx/smilies/homestar.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(nuke\)/g,'<img src="http://homepage.mac.com/simx/smilies/nuke.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:nuke\:/g,'<img src="http://homepage.mac.com/simx/smilies/nuke.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(geek\)/g,'<img src="http://homepage.mac.com/simx/smilies/online2long.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:geek\:/g,'<img src="http://homepage.mac.com/simx/smilies/online2long.png" style="margin: 0px;">');
		commentText = commentText.replace(/\:rolleyes\:/g,'<img src="http://homepage.mac.com/simx/smilies/rolleyes.png" style="margin: 0px;">');
		commentText = commentText.replace(/\(rolleyes\)/g,'<img src="http://homepage.mac.com/simx/smilies/rolleyes.png" style="margin: 0px;">');
		body.innerHTML = commentText.replace(/\r\n/g,'<br />');

		comment.appendChild(body);
		body = null;	
	},
	authorblock: function(comment,data)
	{
		if (data.authorID !== '') {
			var author = document.createElement('div');
			var authorID = document.createTextNode(data.authorID);
			var fn = null;
			author.className = 'authorblock vcard';
			var url = this.authorurl(data);
			if (url != null) {
				url.appendChild(authorID);
				author.appendChild(url);
			} 
			else {
				fn = document.createElement('span');
				fn.className = 'fn';
				fn.appendChild(authorID);
				author.appendChild(fn);
			}
			comment.appendChild(author);
			author = null;
		} 
		else {
			return;
		}
	},
	authorurl: function(data)
	{
		var author = null;
		
		if (data.authorURL !== undefined && data.authorURL !== '') {
			author = document.createElement('a');
			author.setAttribute('href', data.authorURL);
		} 
		else {
			return null;
		}
		
		if (data.authorURL.indexOf('mailto:') > -1) {
			author.className = 'email fn';
		}			
		else if (data.authorURL.indexOf('http://') > -1) {
			author.className = 'url fn';
		}
		else {
			author.className = 'fn';
		}
		
		return author;
	},
	dateblock: function(comment,data)
	{
		var date = document.createElement('div');
		date.className = 'dateblock';
		date.innerHTML = data.createDate;
		comment.appendChild(date);
		date = null;	
	},
	attachments: function(comment,data)
	{
		
		var attachment;
		var preview;
		var link;
		var desc;
		
		if (data.attachments === undefined) { return; }
		
		for (var i = 0; i < data.attachments.length; i++) {
		
			// container
			attachment = document.createElement('div');
			
			// thumbnail w/link
			link = document.createElement('a');
			link.title = data.attachments[i].mimetype;
			if (typeof(fakeURLPathname) == "undefined") {
				link.href = location.pathname + data.attachments[i].urlDownload;
			} else {
				link.href = fakeURLPathname + data.attachments[i].urlDownload;
			}
			
			preview = document.createElement('img');
			preview.id = 'attachment_' + data.commentID.replace(/\-/g,'_') + '_' + i;
			
			// deal with multiple definitions of thumbnail here
			if (data.attachments[i].urlPreview !== undefined) {
				preview.src = data.attachments[i].urlPreview;
			} 
			else if (data.attachments[i].previewUrl !== undefined) {
				preview.src = data.attachments[i].previewUrl;			
			}
			else {
				preview.src = 'http://www.mac.com/1/up/comments/images/attach_generic_big.png';
			}
			link.appendChild(preview);
			attachment.appendChild(link);
		
			// handle image v. other attachment
			if (!this.isImage(data.attachments[i].mimetype)) {
			
				var space = document.createTextNode('\xA0');
				attachment.appendChild(space);
				space = null;
			
				desc = document.createElement('a');
				desc.className = 'description';
				if (typeof(fakeURLPathname) == "undefined") {
					desc.href = location.pathname + data.attachments[i].urlDownload;
				} else {
					desc.href = fakeURLPathname + data.attachments[i].urlDownload;
				}
				

				if (data.attachments[i].displayname !== undefined) {
					desc.innerHTML = this.formatDisplayName(data.attachments[i].displayname,data.attachments[i].size);
				} 
				else {
					desc.innerHTML = this.formatDisplayName(data.attachments[i].filename,data.attachments[i].size);				
				}
				attachment.className = 'fileattachment';
				pngs.add(preview.id);				
				attachment.appendChild(desc);
			}
			else {
				attachment.className = 'imageblock';			
			}

			comment.appendChild(attachment);
			
			// cleanup 
			attachment = null;
			preview = null;
			link = null;
			desc = null;
		}
	},
	separator: function(comment)
	{
		var separator = document.createElement('div');
		separator.className = 'separator';
		separator.innerHTML = '&nbsp;';
		comment.appendChild(separator);
		separator = null;	
	},
	
	bytesToString: function(str)
	{
		var bytes = Number(str);
		
		if (bytes < 1024) {
			return localeStringForKey('bytes', bytes.toLocaleString());
		}
		else if (bytes < 1048756) {
			var kb = bytes / 1024.0;
			return localeStringForKey('KB', Number(kb.toFixed(1)).toLocaleString());
		}
		else if (bytes < 1073741824) {
			var mb = bytes / 1048756.0
			return localeStringForKey('MB', Number(mb.toFixed(1)).toLocaleString());
		}
		else {
			var gb = bytes / 1073741824.0;
			return localeStringForKey('GB', Number(gb.toFixed(1)).toLocaleString());
		}	
	},
	
	isImage: function(mimetype)
	{
		switch (mimetype.toLowerCase()) {
			case 'image/gif' :
			case 'image/jpg' :
			case 'image/jpeg':
			case 'image/pjpeg':
				return true;
			default:
				return false;
		}
	},
	
	formatDisplayName: function(displayname,size)
	{
		return displayname + '&#160;&#160;&#160;' + this.bytesToString(size);
	}
};

// Listen for the child comment entry window to close, then reload yourself.
function listenForChildWindow()
{
	if (!browser.safari && commentWindow.closed) {
		comments.fetch();
		commentWindow = null; // gc
	} 
	else if (browser.safari && commentWindow.name == 'canreload') {
		comments.fetch();
	} 
	else {
		setTimeout(listenForChildWindow,500);
	}
}