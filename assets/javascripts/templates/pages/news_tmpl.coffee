app.templates.newsPage = ->
  """ <h1 class="_lined-heading">Changelog</h1>
      <p class="_note">For the latest news and updates,
        subscribe to the <a href="http://eepurl.com/HnLUz">newsletter</a>
        or follow <a href="https://twitter.com/DevDocs">@DevDocs</a>.
      <div class="_news">#{app.templates.newsList app.news}</div> """

app.templates.newsList = (news) ->
  result = ''
  result += newsItem new Date(value[0]), value[1..] for value in news
  result

MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

newsItem = (date, news) ->
  date = """<span class="_news-date">#{MONTHS[date.getUTCMonth()]} #{date.getUTCDate()}</span>"""
  result = ''

  for text, i in news
    text = text.split "\n"
    title = """<span class="_news-title">#{text.shift()}</span>"""
    result += """<div class="_news-row">#{if i is 0 then date else ''} #{title} #{text.join '<br>'}</div>"""

  result

app.news = [
  [ 1389484800000, # January 12, 2013
    """ Added <code class="_label">Alt + g</code> shortcut for searching on Google. """
  ], [
    1386979200000, # December 14, 2013
    """ New <a href="/postgresql/">PostgreSQL</a> documentation """
  ], [
    1386892800000, # December 13, 2013
    """ New <a href="/git/">Git</a> and <a href="/redis/">Redis</a> documentations """
  ], [
    1385424000000, # November 26, 2013
    """ New <a href="/python/">Python</a> documentation """
  ], [
    1384819200000, # November 19, 2013
    """ New <a href="/rails/">Ruby on Rails</a> documentation """
  ], [
    1384560000000, # November 16, 2013
    """ New <a href="/ruby/">Ruby</a> documentation """
  ], [
    1382572800000, # October 24, 2013
    """ DevDocs is now <a href="https://github.com/Thibaut/devdocs">open source</a>. """
  ], [
    1381276800000, # October 9, 2013
    """ DevDocs is now available as a <a href="https://chrome.google.com/webstore/detail/devdocs/mnfehgbmkapmjnhcnbodoamcioleeooe">Chrome web app</a>. """
  ], [
    1379808000000, # September 22, 2013
    """ New <a href="/php/">PHP</a> documentation """
  ], [
    1378425600000, # September 6, 2013
    """ New <a href="/lodash/">Lo-Dash</a> documentation """,
    """ On mobile devices you can now search a specific documentation by typing its name and <code class="_label">Space</code>. """
  ], [
    1377993600000, # September 1, 2013
    """ New <a href="/jqueryui/">jQuery UI</a> and <a href="/jquerymobile/">jQuery Mobile</a> documentations """
  ], [
    1377648000000, # August 28, 2013
    """ New smartphone interface
        Tested on iOS 6+ and Android 4.1+ """
  ], [
    1377388800000, # August 25, 2013
    """ New <a href="/ember/">Ember.js</a> documentation """
  ], [
    1376784000000, # August 18, 2013
    """ New <a href="/coffeescript/">CoffeeScript</a> documentation """,
    """ URL search now automatically opens the first result. """
  ], [
    1376352000000, # August 13, 2013
    """ New <a href="/angular/">Angular.js</a> documentation """
  ], [
    1376179200000, # August 11, 2013
    """ New <a href="/sass/">Sass</a> and <a href="/less/">Less</a> documentations """
  ], [
    1375660800000, # August 5, 2013
    """ New <a href="/node/">Node.js</a> documentation """
  ], [
    1375488000000, # August 3, 2013
    """ Added support for OpenSearch """
  ], [
    1375142400000, # July 30, 2013
    """ New <a href="/backbone/">Backbone.js</a> documentation """
  ], [
    1374883200000, # July 27, 2013
    """ You can now customize the list of documentations.
        New docs will be hidden by default, but you'll see a notification when there are new releases. """,
    """ New <a href="/http/">HTTP</a> documentation """
  ], [
    1373846400000, # July 15, 2013
    """ URL search now works with single documentations: <a href="/#q=js%20sort">devdocs.io/#q=js sort</a> """
  ], [
    1373673600000, # July 13, 2013
    """ Added syntax highlighting """,
    """ Added documentation versions """
  ], [
    1373500800000, # July 11, 2013
    """ New <a href="/underscore/">Underscore.js</a> documentation """,
    """ Improved compatibility with tablets
        A mobile version is planned as soon as other high priority features have been implemented. """
  ], [
    1373414400000, # July 10, 2013
    """ You can now search specific documentations.
        Simply type the documentation's name and press <code class="_label">Tab</code>.
        The name is fuzzy matched so you can use abbreviations like <code>js</code> for <code>JavaScript</code>. """
  ], [
    1373241600000, # July 8, 2013
    """ Improved search with fuzzy matching and better results
        For example, searching <code>jqmka</code> now returns <code>jQuery.makeArray()</code>. """,
    """ DevDocs finally has an icon. """,
    """ <code class="_label">space</code> has replaced <code class="_label">alt + space</code> for scrolling down. """
  ], [
    1373068800000, # July 6, 2013
    """ New <a href="/dom/">DOM</a> and <a href="/dom_events/">DOM Events</a> documentations
        DevDocs now includes almost all reference documents available on the Mozilla Developer Network.
        Big thank you to Mozilla and all the people that contributed to MDN. """,
    """ Implemented URL search: <a href="/#q=sort">devdocs.io/#q=sort</a> """
  ], [
    1372723200000, # July 2, 2013
    """ New <a href="/javascript/">JavaScript</a> documentation """
  ], [
    1372377600000, # June 28, 2013
    """ DevDocs made the front page of Hacker News!
        Hi everyone &mdash; thanks for trying DevDocs.
        Please bear with me while I fix bugs and scramble to add more docs.
        This is only v1. There's a lot more to come. """
  ], [
    1371513600000, # June 18, 2013
    """ Initial release """
  ]
]
