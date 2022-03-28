#!/bin/sh
# Oxygen environment setup script

export JDK_JAVA_OPTIONS="--add-opens=java.base/java.lang=ALL-UNNAMED\
 --add-opens=java.base/java.net=ALL-UNNAMED\
 --add-opens=java.base/java.util=ALL-UNNAMED\
 --add-opens=java.base/java.util.regex=ALL-UNNAMED\
 --add-opens=java.base/sun.net.util=ALL-UNNAMED\
 --add-opens=java.base/sun.net.www.protocol.http=ALL-UNNAMED\
 --add-opens=java.base/sun.net.www.protocol.https=ALL-UNNAMED\
 --add-opens=java.desktop/java.awt=ALL-UNNAMED\
 --add-opens=java.desktop/java.awt.dnd=ALL-UNNAMED\
 --add-opens=java.desktop/javax.swing=ALL-UNNAMED\
 --add-opens=java.desktop/javax.swing.text=ALL-UNNAMED\
 --add-opens=java.desktop/javax.swing.plaf.basic=ALL-UNNAMED\
 --add-opens=java.xml/com.sun.org.apache.xerces.internal.xni=ALL-UNNAMED\
 --add-opens=javafx.graphics/com.sun.javafx.tk=ALL-UNNAMED\
 --add-opens=javafx.web/javafx.scene.web=ALL-UNNAMED"

# Check OS
OS=`uname -s`

if [ "$OS" = "Darwin" ]
then
export "JDK_JAVA_OPTIONS=$JDK_JAVA_OPTIONS\
 --add-opens=java.desktop/com.apple.eawt=ALL-UNNAMED\
 --add-opens=java.desktop/com.apple.laf=ALL-UNNAMED"
fi
