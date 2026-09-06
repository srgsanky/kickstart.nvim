#!/bin/bash

# Neovim Prerequisite Installer for macOS
# This script installs system-level dependencies required by the current Neovim configuration.

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Checking and installing Neovim pre-requisites...${NC}"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${RED}Homebrew not found. Please install Homebrew first: https://brew.sh/${NC}"
    exit 1
fi

# List of packages to install
# tree-sitter: Required for nvim-treesitter parsers
# ripgrep: Required for Telescope live_grep
# fd: Required for Telescope find_files
# jq: Required for JSON formatting
# diffutils: Required for GNU diff (better-whitespace)
# node: Required for npm (pyright, etc.)
# make: Required for building some plugins (fzf-native, luasnip)
# deno: Required for denops.vim and plugins like highlight-undo.nvim
PACKAGES=(
    "tree-sitter"
    "ripgrep"
    "fd"
    "jq"
    "diffutils"
    "node"
    "make"
    "deno"
)

for package in "${PACKAGES[@]}"; do
    if brew list "$package" &> /dev/null; then
        echo -e "${GREEN}✓ $package is already installed${NC}"
    else
        echo -e "${BLUE}Installing $package...${NC}"
        brew install "$package"
    fi
done

echo -e "${GREEN}All pre-requisites have been installed successfully!${NC}"
echo -e "You can now start Neovim and run :TSUpdate if needed."
