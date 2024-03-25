#!/usr/bin/env bash

# ja-netfilter path
JANETFILTER_PATH=$(echo $HOME)/My\ Drive/ja-netfilter/ja-netfilter.jar

file=/Applications/IntelliJ\ IDEA.app/Contents/bin/idea.vmoptions

echo "ja-netfilter path: $JANETFILTER_PATH"

text="--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED\n--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED\n-javaagent:$JANETFILTER_PATH=jetbrains"
echo "Text to append: $text"

# Append a string to the end of the file
echo $text >> $file
