# Use -Dlog4j.debug for Log4J startup debugging info
# Use -Xms512M -Xmx512M to start with 512MB of heap memory. Set size according to your needs.

JRE_FOLDER="../jre/bin"
JAVA_CMD="java"
if [ -d "$JRE_FOLDER" ]; then
    JAVA_CMD="../jre/bin/java"
fi

# Java 9+ blocks deep reflection into JDK internals. The bundled XStream 1.3.1
# (SFS config loading) and the embedded JRuby runtime both rely on it.
JAVA_OPTS="--add-opens=java.base/java.lang=ALL-UNNAMED \
  --add-opens=java.base/java.util=ALL-UNNAMED \
  --add-opens=java.base/java.text=ALL-UNNAMED \
  --add-opens=java.base/java.io=ALL-UNNAMED \
  --add-opens=java.base/java.nio.channels=ALL-UNNAMED \
  --add-opens=java.base/sun.nio.ch=ALL-UNNAMED \
  --add-opens=java.desktop/java.awt.font=ALL-UNNAMED"

CPATH="./:lib/*:lib/apache-tomcat/bin/*:extensions/__lib__/*"
exec ${JAVA_CMD} ${JAVA_OPTS} -cp ${CPATH} -Dfile.encoding=UTF-8 com.smartfoxserver.v2.Main $1 $2
