<?php
// Polyfills for functions removed in PHP 7/8 that MoniWiki 1.2.5 still calls.
if (!function_exists('each')) {
    function each(&$arr) {
        $k = key($arr);
        if ($k === null) return false;
        $v = current($arr); next($arr);
        return array(1 => $v, 'value' => $v, 0 => $k, 'key' => $k);
    }
}
if (!function_exists('create_function')) {
    function create_function($args, $code) {
        return eval('return function(' . $args . ') {' . $code . '};');
    }
}
if (!function_exists('split')) {
    function split($pat, $str, $limit = -1) {
        return preg_split('#' . str_replace('#', '\#', $pat) . '#', $str, $limit);
    }
}
if (!function_exists('ereg')) {
    function ereg($pat, $str, &$regs = null) {
        $r = preg_match('#' . str_replace('#', '\#', $pat) . '#', $str, $regs);
        return $r ? max(1, strlen($regs[0])) : false;
    }
    function eregi($pat, $str, &$regs = null) {
        $r = preg_match('#' . str_replace('#', '\#', $pat) . '#i', $str, $regs);
        return $r ? max(1, strlen($regs[0])) : false;
    }
    function ereg_replace($pat, $rep, $str) {
        return preg_replace('#' . str_replace('#', '\#', $pat) . '#', $rep, $str);
    }
    function eregi_replace($pat, $rep, $str) {
        return preg_replace('#' . str_replace('#', '\#', $pat) . '#i', $rep, $str);
    }
}
if (!function_exists('get_magic_quotes_gpc')) {
    function get_magic_quotes_gpc() { return false; }
    function get_magic_quotes_runtime() { return false; }
}
if (!function_exists('set_magic_quotes_runtime')) {
    function set_magic_quotes_runtime($v) { return false; }
}
