#  function that installs node

function installNode {
        echo ""

        if which node > /dev/null; then
                echo "node.js is already installed, skipping..."
        else
                curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
                sudo apt-get install -y nodejs
        fi

        echo "Node.js version:"
        node -v
        echo ""
}
