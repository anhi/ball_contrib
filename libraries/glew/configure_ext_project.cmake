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

# Download package
SET(PACKAGE_TARBALL "glew-1.12.0.tgz")
SET(PACKAGE_MD5 "01246c7ecd135d99be031aa63f86dca1")
DOWNLOAD_PACKAGE_TARBALL(${PACKAGE_TARBALL} ${PACKAGE_MD5})


IF(OS_WINDOWS)

	# Windows

ELSE()

	# Linux / Darwin

	# Generate Makefile patch: the generated Makefile has GLEW_DEST set to CONTRIB_INSTALL_BASE
	CONFIGURE_FILE("${CONTRIB_LIBRARY_PATH}/${PACKAGE_NAME}/patches/makefile_glew_dest.diff.in"
		       "${CONTRIB_BINARY_PATCHES}/${PACKAGE_NAME}/makefile_glew_dest.diff")

	ExternalProject_Add(${PACKAGE_NAME}

		URL "${CONTRIB_PACKAGE_PATH}/${PACKAGE_TARBALL}"
		PREFIX ${PROJECT_BINARY_DIR}

		BUILD_IN_SOURCE 1

		LOG_DOWNLOAD 1
		LOG_UPDATE 1
		LOG_CONFIGURE 1
		LOG_BUILD 1
		LOG_INSTALL 1

		CONFIGURE_COMMAND ""
		BUILD_COMMAND make
		INSTALL_COMMAND make install
	)

	# Apply Makefile patch
	ExternalProject_Add_Step(${PACKAGE_NAME} patch_1
		WORKING_DIRECTORY "${CONTRIB_BINARY_SRC}/${PACKAGE_NAME}/"
		COMMAND patch Makefile < "${CONTRIB_BINARY_PATCHES}/${PACKAGE_NAME}/makefile_glew_dest.diff"
		DEPENDEES patch
	)

ENDIF()

MSG_CONFIGURE_PACKAGE_END("${PACKAGE_NAME}")