#!/bin/bash fish

function replace_homepath_with_tilde
    set -l path (echo ~)
    string replace -r $path '~' $argv[1]
end

function specs    
    set -l NODE_ENV (nvm current)
    set -l MAC_OSX_PRODUCT  (sw_vers -productName)
    set -l MAC_OSX_VERSION  (sw_vers -productVersion)
    set -l CPU  (sysctl -n machdep.cpu.brand_string)
    set -l CPU_CORES  (string trim (string replace -r -a '[^\\d]+' ' ' (sysctl hw.physicalcpu)))
    set -l CPU_BIT  (string replace -r '(^\\d\\d)' ' ' (uname -m))
    set -l YARN_VERSION (yarn -v)
    set -l YARN_LOCATION (which yarn)
    set -l NPM_VERSION (npm -v)
    set -l NPM_LOCATION (replace_homepath_with_tilde | which npm)
    set -l PYTHON_LOCATION (which python)
    set -l PYTHON_VERSION (string match -r '(\d\.\d\d?\.\d\d?)' ' ' (printf '%s' (python -c 'import sys; print(sys.version)')))
    set -l CHROME_VERSION (string replace -r -a '[^\d\d\.\0\.\d\d\d\d\.?\d?\d?]+' ' ' (/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --version))
    set -l FIREFOX_VERSION (string replace -r -a '[^\d\d\.\0\.\d?\d?]+' ' ' (/Applications/Firefox.app/Contents/MacOS/firefox-bin --version))
    set -l SAFARI_VERSION (string replace -r -a '[^\d\d\.\0]+' ' ' (safaridriver --version))

    echo
    echo "  System:"
    echo "    OS: "$MAC_OSX_PRODUCT" "$MAC_OSX_VERSION
    echo "    CPU: ("$CPU_CORES") "$CPU_BIT" "$CPU
    echo "  Shell: "$FISH_VERSION" - "$SHELL
    echo "  Binaries:"
    echo "    Node: "$NODE_ENV" - "$NVM_INC
    echo "    Yarn: "$YARN_VERSION" - "$YARN_LOCATION
    echo "    npm: "$NPM_VERSION" - "$NPM_LOCATION
    echo "  Languages:"
    echo "    Python: "$PYTHON_VERSION[1]" - "$PYTHON_LOCATION
    echo "  Browsers:"
    echo "    Chrome: "$CHROME_VERSION
    echo "    Firefox: "$FIREFOX_VERSION
    echo "    Safari: "$SAFARI_VERSION
    echo
end


function gist
    "open https://gist.github.com/anthonytranDev"
end 

function apps
    ls -la /Applications/
end

function dateiso
    date -u +"%Y-%m-%dT%H:%M:%SZ"
end