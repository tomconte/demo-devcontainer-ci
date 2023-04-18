#!/bin/bash

if [ $(uname -m) = "aarch64" ]
then

    # Build for aarch64
    git clone -b v4.x https://github.com/Azure/azure-functions-core-tools.git
    cd azure-functions-core-tools
    dotnet build Azure.Functions.Cli.sln
    dotnet publish src/Azure.Functions.Cli/Azure.Functions.Cli.csproj --runtime linux-arm64 --output /usr/local/share/azure-functions-core-tools
    ln -s /usr/local/share/azure-functions-core-tools/func /usr/local/bin
    cd ..
    rm -rf azure-functions-core-tools

else

    # x86_64
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/
    echo "deb [arch=amd64] https://packages.microsoft.com/debian/$(lsb_release -rs | cut -d'.' -f 1)/prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list

    apt-get update
    apt-get install azure-functions-core-tools-4

fi
