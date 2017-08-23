#!/bin/sh

export LD_LIBRARY_PATH=/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/
#cd ~/.minecraft/ && java -Djava.net.preferIPv4Stack=true -Xmx1024M -Xms512M -cp minecraft.jar net.minecraft.LauncherFrame
cd ~/.minecraft/ && java -Djava.net.preferIPv4Stack=true -Xmx1024M -Xms512M -jar Minecraft.jar

