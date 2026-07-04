<?php
/**
 * PHP 内置服务器路由脚本
 * 静态文件直接返回，其他请求交给 index.php
 */
if (php_sapi_name() === 'cli-server') {
    $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $uri = urldecode($uri);
    $file = __DIR__ . $uri;

    // 如果请求的是真实存在的静态文件，直接返回
    if ($uri !== '/' && file_exists($file)) {
        return false;
    }
}

// 其他请求交给 ThinkPHP 入口
require __DIR__ . '/index.php';
