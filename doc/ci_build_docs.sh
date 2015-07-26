#!/bin/bash -e

asciidoc -a icons -a toc -a toplevels=2 -a stylesheet=$PWD/asciidoc.css -a max-width=800px -o tutorial.html README
asciidoc -a icons -a stylesheet=$PWD/asciidoc.css -a max-width=800px -o amazon_ec2.html amazon_ec2.asc
asciidoc -a icons -a stylesheet=$PWD/asciidoc.css -a max-width=800px -o swift-config.html swift.conf.asc

# Temporary hack to set font of coe examples to small and bold

sed --in-place -e '/monospaced/,/}/s/font-size: inherit;/font-size: small; font-weight: bold;/' tutorial.html


