<?php

// Parse the Accept-Language header
$langs = array();
if(isset($_SERVER['HTTP_ACCEPT_LANGUAGE']))
{
  // Parse language
  // e.g. en-ca,en;q=0.8,en-us;q=0.6,de-de;q=0.4,de;q=0.2
  preg_match_all(
    '/([a-z]{1,8}(-[a-z]{1,8})?)\s*(;\s*q\s*=\s*(1|0\.[0-9]+))?/i',
    $_SERVER['HTTP_ACCEPT_LANGUAGE'],
    $lang);

  if(count($lang[1]) > 0)
  {
    // Create key-value pair
    $langs = array_combine($lang[1], $lang[4]);

    // Use default q value of 1
    foreach ($langs as $lang => $val)
    {
      if ($val === '')
        $langs[$lang] = 1;
    }

    // Sort based on q value
    arsort($langs, SORT_NUMERIC);
  }
}

<%# Find all language codes %>
<%
home         = @items.find { |i| i.identifier == '/en/' }
translations = translations_of(home)
codes        = translations.map { |t| language_code_of(t) }
%>

<%# Build PHP array of language codes %>
$codes = array(<%= codes.join(', ') %>);


// Show correct site
foreach($langs as $request_lang => $qval)
{
  foreach($codes as $code)
  {
    if(strpos($request_lang, $code) === 0)
      redirect($code);
  }
}
redirect('en');


function redirect($lang)
{
  global $base_url;
  
  // Set HTTP status code
  if ($_SERVER['SERVER_PROTOCOL'] == 'HTTP/1.1')
    header('HTTP/1.1 303 See Other');
  else
    header('HTTP/1.0 302 Moved Temporarily');
  
  // Set location
  header('Location: ' . $base_url . '/' . $lang . '/');
  
  // Stop!
  exit();
}

$base_url = '<%= @site.config[:base_url] %>';


?> 
