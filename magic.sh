#!/bin/bash

# Run this file before commit
dfmt --brace_style=otbs --indent_style=tab --inplace --max_line_length=1000 --soft_max_line_length=1000 **/*.d
