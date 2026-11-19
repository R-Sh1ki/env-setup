# Enable a proxy for this shell and its child processes.
proxy_on() {
    local address='127.0.0.1:7890'

    export http_proxy="http://$address" https_proxy="http://$address"
    export HTTP_PROXY="$http_proxy" HTTPS_PROXY="$https_proxy"
    export all_proxy="socks5://$address" ALL_PROXY="socks5://$address"
    print 'Proxy enabled.'
}

# Leave bypass rules (no_proxy / NO_PROXY) unchanged.
proxy_off() {
    unset http_proxy https_proxy all_proxy
    unset HTTP_PROXY HTTPS_PROXY ALL_PROXY
    print 'Proxy disabled.'
}
