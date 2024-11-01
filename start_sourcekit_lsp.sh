#!/bin/bash
# Check for the --version flag
if [[ "$1" == "--version" ]]; then
    exit 0  # Return an empty result with a successful exit code
fi

# This wrapper script is provided because lspconfig tries to invoke sourcekit-lsp --version and
# sourcekit-lsp does not provide a --version flag, returning an error.
exec /usr/bin/sourcekit-lsp "$@"

