# -----------------------------------------------------------------------------
#   BALL - Biochemical ALgorithms Library
#   A C++ framework for molecular modeling and structural bioinformatics.
# -----------------------------------------------------------------------------
#
# Copyright (C) 1996-2012, the BALL Team:
#  - Andreas Hildebrandt
#  - Oliver Kohlbacher
#  - Hans-Peter Lenhof
#  - Eberhard Karls University, Tuebingen
#  - Saarland University, Saarbrücken
#  - others
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library (BALL/source/LICENSE); if not, write
#  to the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
#  Boston, MA  02111-1307  USA
#
# -----------------------------------------------------------------------------
# $Maintainer: Philipp Thiel $
# $Authors: Philipp Thiel $
# -----------------------------------------------------------------------------

MSG_CONFIGURE_PACKAGE_BEGIN("${PACKAGE_NAME}")

IF(MSVC)
	SET(OPENBABEL_BUILD_COMMAND ${MSBUILD} "/m:${THREADS}" "openbabel.sln")
ELSE()
	SET(OPENBABEL_BUILD_COMMAND make "-j${THREADS}")
ENDIF()

ExternalProject_Add("${PACKAGE_NAME}"

	URL "${CONTRIB_ARCHIVES_PATH}/${${PACKAGE_NAME}_archive}"
	PREFIX ${PROJECT_BINARY_DIR}
	BUILD_IN_SOURCE 0

	LOG_DOWNLOAD ${CUSTOM_LOG_DOWNLOAD}
	LOG_UPDATE ${CUSTOM_LOG_UPDATE}
	LOG_CONFIGURE ${CUSTOM_LOG_CONFIGURE}
	LOG_BUILD ${CUSTOM_LOG_BUILD}
	LOG_INSTALL ${CUSTOM_LOG_INSTALL}

	CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CONTRIB_INSTALL_BASE}
		   -DCMAKE_BUILD_TYPE=${CONTRIB_BUILD_TYPE}
		   -DMINIMAL_BUILD=ON
		   -DBUILD_GUI=OFF
		   -DWITH_INCHI=OFF
		   -DENABLE_TESTS=OFF
		   -DOPENBABEL_USE_SYSTEM_INCHI=OFF
		   -DOB_USE_PREBUILT_BINARIES=OFF

	BUILD_COMMAND ${OPENBABEL_BUILD_COMMAND}
)

# On Mac OS X we have to use absolute paths as install names for dylibs
IF(APPLE)
	FIX_DYLIB_INSTALL_NAMES(libopenbabel)
ENDIF()

MSG_CONFIGURE_PACKAGE_END("${PACKAGE_NAME}")
