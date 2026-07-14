#!/usr/bin/env bash

echo "==============================================="
echo " Production Platform Project - Tool Verification"
echo "==============================================="
echo

check_tool() {
    TOOL_NAME=$1
    VERSION_CMD=$2

    printf "%-20s : " "$TOOL_NAME"

    if command -v "$TOOL_NAME" >/dev/null 2>&1; then
        eval "$VERSION_CMD" 2>/dev/null | head -n 1
    else
        echo "❌ NOT INSTALLED"
    fi
}

check_tool git "git --version"
check_tool docker "docker --version"
check_tool aws "aws --version"
check_tool terraform "terraform version"
check_tool kubectl "kubectl version --client"
check_tool helm "helm version --short"
check_tool eksctl "eksctl version"
check_tool jq "jq --version"
check_tool yq "yq --version"
check_tool k9s "k9s version"

echo
echo "==============================================="
echo "WSL Information"
echo "==============================================="

echo "User      : $(whoami)"
echo "Hostname  : $(hostname)"
echo "OS        : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
echo "Kernel    : $(uname -r)"
echo "Directory : $(pwd)"

echo
echo "==============================================="
echo "AWS Configuration"
echo "==============================================="

if aws sts get-caller-identity >/dev/null 2>&1; then
    aws sts get-caller-identity
else
    echo "❌ AWS CLI configured but credentials not found."
fi

echo
echo "==============================================="
echo "Docker"
echo "==============================================="

if command -v docker >/dev/null 2>&1; then
    docker info >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "✅ Docker daemon is running."
    else
        echo "⚠️ Docker installed but daemon is NOT running."
    fi
fi

echo
echo "==============================================="
echo "Summary Complete"
echo "==============================================="
