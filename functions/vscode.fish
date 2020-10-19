#!/bin/bash fish

function extensions
    code --list-extensions | xargs -L 1 echo code --install-extension
end