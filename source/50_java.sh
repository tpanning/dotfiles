# Use alternatives configuration if it's available, otherwise assume /usr/java/latest is correct
if [ -a /etc/alternatives/java_sdk ] ; then
    export JAVA_HOME="/etc/alternatives/java_sdk"
else
    export JAVA_HOME="/usr/java/latest"
fi
