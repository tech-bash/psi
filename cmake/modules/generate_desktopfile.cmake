cmake_minimum_required( VERSION 3.10.0 )

set(DESKTOP_FILE "${PROJECT_SOURCE_DIR}/linux/psi.desktop")
set(DESKTOP_FILE_SEC_PART "${PROJECT_SOURCE_DIR}/linux/psi-extra-action1.desktop")
file(READ ${DESKTOP_FILE} DESK_FILE_CONTENTS)
file(READ ${DESKTOP_FILE_SEC_PART} ACTION_CONTENTS)
set(OUT_DESK_FILE "${CMAKE_CURRENT_BINARY_DIR}/${VERBOSED_NAME}.desktop")
string(APPEND DESK_FILE_CONTENTS ${ACTION_CONTENTS})
unset(ACTION_CONTENTS)

set(EXEC_REGEXP "Exec=psi ")
set(NAME_REGEXP "Name=Psi")
set(ICON_REGEXP "Icon=psi")
set(WMCLASS_REGEXP "StartupWMClass=Psi")
if(PSI_PLUS)
    set(WMCLASS_NAME "Psi-plus")
else()
    set(WMCLASS_NAME "Psi")
endif()

file(WRITE ${OUT_DESK_FILE} "")
#hack for desktop file generaion
string(REGEX REPLACE "${EXEC_REGEXP}" "Exec=${VERBOSED_NAME} " FIX1 "${DESK_FILE_CONTENTS}")
string(REGEX REPLACE "${ICON_REGEXP}" "Icon=${VERBOSED_NAME}" FIX2 "${FIX1}")
if(IS_WEBENGINE AND VERBOSE_PROGRAM_NAME)
    string(REGEX REPLACE "${NAME_REGEXP}" "Name=${CLIENT_NAME} Webengine" FIX3 "${FIX2}")
elseif(IS_WEBKIT AND VERBOSE_PROGRAM_NAME)
    string(REGEX REPLACE "${NAME_REGEXP}" "Name=${CLIENT_NAME} Webkit" FIX3 "${FIX2}")
else()
    string(REGEX REPLACE "${NAME_REGEXP}" "Name=${CLIENT_NAME}" FIX3 "${FIX2}")
endif()
string(REGEX REPLACE "${WMCLASS_REGEXP}" "StartupWMClass=${WMCLASS_NAME}" FIX4 "${FIX3}")
if(FIX4)
    file(APPEND ${OUT_DESK_FILE} "${FIX4}")
elseif(FIX3)
    file(APPEND ${OUT_DESK_FILE} "${FIX3}")
elseif(FIX2)
    file(APPEND ${OUT_DESK_FILE} "${FIX2}")
else()
    file(APPEND ${OUT_DESK_FILE} "${FIX1}")
endif()
unset(DESK_FILE_CONTENTS)

message(STATUS "${OUT_DESK_FILE} file generated")
