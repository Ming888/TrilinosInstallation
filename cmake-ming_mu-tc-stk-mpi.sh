#!/bin/sh

CWD=`pwd`

#rm -f CMakeCache.txt
echo ===================================================================
echo "Deleting CMakeCache.txt and CMakeFiles."
#rm -rf CMakeCache.txt CMakeFiles/
rm -Rf CMakeCache.txt CMakeFiles

echo "  "
mkdir ../trilinos-build
cd ../trilinos-build

echo "  "
echo "Performing the cmake of the package:"
echo " " 

export TRILINOS_HOME=${PWD}/../trilinos-dev

#export TPL_INSTALL_DIRECTORY=/home/ming/trilinos-TPLs/install
export TPL_INSTALL_DIRECTORY=/home/ming/collaboration_Ming_Gong/codes/trilinos/trilinos-TPLs/install3
#export MPI_INSTALL_DIRECTORY=/usr/lib/openmpi
echo "PATH = ${PATH}"

BUILD_MODE=${1:-DEBUG}
buildMode=`echo ${BUILD_MODE} | tr '[:upper:]' '[:lower:]'`
CXX_COMPILER_NAME=`mpicxx --version`
CXX_COMPILER_LOCATION=`which mpicxx`

EXTRA_ARGS=$@

echo ""
echo "Build mode = ${BUILD_MODE}"
echo ""
echo "c++ compiler : ${CXX_COMPILER_NAME}"
echo ""
echo "c++ compiler location: ${CXX_COMPILER_LOCATION}"
echo ""
sleep 3

cmake \
\
  -D BUILD_SHARED_LIBS:BOOL=ON \
  -D CMAKE_INSTALL_PREFIX:PATH="${PWD}/../install/trilinos-dev-${buildMode}" \
  -D Trilinos_GENERATE_REPO_VERSION_FILE:BOOL=ON \
  -D Trilinos_WARNINGS_AS_ERRORS_FLAGS:STRING="" \
  -D Trilinos_ENABLE_TESTS:BOOL=OFF \
  -D Trilinos_ENABLE_EXAMPLES:BOOL=OFF \
\
  -D CMAKE_BUILD_TYPE:STRING=${BUILD_MODE} \
\
  -D Teuchos_ENABLE_LONG_LONG_INT:BOOL=ON \
  -D Trilinos_ENABLE_TESTS:BOOL=OFF \
  -D Trilinos_ENABLE_ALL_OPTIONAL_PACKAGES:BOOL=ON \
  -D CMAKE_CXX_FLAGS:STRING="-g" \
  -D CMAKE_C_FLAGS:STRING="-g" \
\
  -D Trilinos_ENABLE_TrilinosCouplings:BOOL=ON \
    -D TrilinosCouplings_ENABLE_TESTS:STRING=ON \
    -D TrilinosCouplings_ENABLE_EXAMPLES:STRING=ON \
  -D Trilinos_ENABLE_SEACAS=ON \
    -D Trilinos_ENABLE_SEACASIoss:BOOL=ON \
    -D Trilinos_ENABLE_SEACASExodus:BOOL=ON \
    -D SEACASExodus_ENABLE_MPI:BOOL=ON \
  -D Trilinos_ENABLE_STKClassic:BOOL=OFF \
\
  -D Trilinos_ENABLE_Pamgen:BOOL=ON \
\
  -D Trilinos_ENABLE_STK:BOOL=ON \
  -D Trilinos_ENABLE_STKIO:BOOL=ON \
  -D Trilinos_ENABLE_STKMesh:BOOL=ON \
\
  -D Teuchos_ENABLE_STACKTRACE:BOOL=OFF \
\
  -D TPL_ENABLE_MPI:BOOL=ON \
  -D TPL_ENABLE_BLAS:BOOL=ON \
  -D TPL_ENABLE_LAPACK:BOOL=ON \
  -D DART_TESTING_TIMEOUT:STRING=30 \
  -D TPL_ENABLE_BoostLib=ON \
  -D TPL_ENABLE_Boost=ON \
  -D TPL_ENABLE_Netcdf=ON \
    -D Netcdf_LIBRARY_DIRS=${TPL_INSTALL_DIRECTORY}/lib \
    -D Netcdf_INCLUDE_DIRS=${TPL_INSTALL_DIRECTORY}/include \
  -D TPL_ENABLE_GLM=OFF \
  -D TPL_ENABLE_Matio=OFF \
  -D TPL_ENABLE_X11=OFF \
\
  $EXTRA_ARGS \
  ${TRILINOS_HOME}

