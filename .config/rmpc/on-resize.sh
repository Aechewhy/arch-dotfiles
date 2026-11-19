#!/usr/bin/env bash

if [[ "$COLS" -gt 100 ]]; then
  rmpc remote --pid "$PID" set theme "$HOME/.config/rmpc/themes/big.ron"
else
  rmpc remote --pid "$PID" set theme "$HOME/.config/rmpc/themes/small.ron"
fi
