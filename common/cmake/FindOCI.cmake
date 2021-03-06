# Locate oci
# This module defines
# OCI_LIBRARY_DIRS
# OCI_INCLUDE_DIRS, where to find the headers
#

FIND_PATH(OCI_INCLUDE_DIRS oci.h
    $ENV{ORACLE_HOME}/rdbms/public/
    $ENV{ORACLE_HOME}/oci/include/
)

IF (WIN32)
  SET(LIBORASDK "oci.lib")
ELSEIF(APPLE)
  SET(LIBORASDK "liborasdk.dylib")
ELSEIF(UNIX)
  SET(LIBORASDK "liborasdk.so")
ENDIF()

IF(MSVC OR APPLE)
    FIND_PATH(OCI_LIBRARY_DIRS ${LIBORASDK}
        $ENV{ORACLE_HOME}/lib/
        $ENV{ORACLE_HOME}/oci/lib/msvc/
    )
ENDIF()

SET(OCI_FOUND "NO")
IF((OCI_LIBRARY_DIRS OR (NOT MSVC AND NOT APPLE)) AND OCI_INCLUDE_DIRS)
    SET(OCI_FOUND "YES")
    SET(OCI_LIBRARY ${OCI_LIBRARY_DIRS}/${LIBORASDK})
ENDIF()