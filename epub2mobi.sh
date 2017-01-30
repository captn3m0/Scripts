#!/bin/bash

find . -iname "*.epub" -print0 |xargs -0 -L1 -I {} ebook-convert '{}' .mobi