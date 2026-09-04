#!/bin/bash

PORT="${PORT:-8080}"

exec code-server \
    --bind-addr "0.0.0.0:${PORT}" \
    --auth password \
    /workspace
