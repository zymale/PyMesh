
if (UMFPACK_INCLUDES AND UMFPACK_LIBRARIES)
  set(UMFPACK_FIND_QUIETLY TRUE)
endif (UMFPACK_INCLUDES AND UMFPACK_LIBRARIES)

find_package(BLAS)

if(BLAS_FOUND)

  find_path(UMFPACK_INCLUDES
    NAMES
    umfpack.h
    PATHS
    $ENV{UMFPACKDIR}
    $ENV{SUITESPARSE_INC}
    $ENV{SUITESPARSE_ROOT}
    $ENV{SUITESPARSE_ROOT}/include
    ${INCLUDE_INSTALL_DIR}
    /opt/local/include
    /usr/local/include
    /usr/include
    PATH_SUFFIXES
    suitesparse
  )

  find_library(UMFPACK_LIBRARIES umfpack
      PATHS
      $ENV{UMFPACKDIR}
      $ENV{SUITESPARSE_LIB}
      $ENV{SUITESPARSE_ROOT}
      $ENV{SUITESPARSE_ROOT}/lib
      ${LIB_INSTALL_DIR}
      /opt/local/lib
      /usr/local/lib
      /usr/lib
      )

  if(UMFPACK_LIBRARIES)

    get_filename_component(UMFPACK_LIBDIR ${UMFPACK_LIBRARIES} PATH)

    find_library(AMD_LIBRARY amd PATHS ${UMFPACK_LIBDIR} $ENV{UMFPACKDIR} ${LIB_INSTALL_DIR})
    if (AMD_LIBRARY)
      set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${AMD_LIBRARY})
    #else (AMD_LIBRARY)
    #  set(UMFPACK_LIBRARIES FALSE)
    endif (AMD_LIBRARY)

  endif(UMFPACK_LIBRARIES)

  if(UMFPACK_LIBRARIES)

    find_library(COLAMD_LIBRARY colamd PATHS ${UMFPACK_LIBDIR} $ENV{UMFPACKDIR} ${LIB_INSTALL_DIR})
    if (COLAMD_LIBRARY)
      set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${COLAMD_LIBRARY})
    #else (COLAMD_LIBRARY)
    #  set(UMFPACK_LIBRARIES FALSE)
    endif (COLAMD_LIBRARY)

  endif(UMFPACK_LIBRARIES)

  if (UMFPACK_LIBRARIES)
      find_library(UMFPACK_CONFIG_LIB suitesparseconfig PATHS ${UMFPACK_LIBDIR} $ENV{UMFPACKDIR} ${LIB_INSTALL_DIR})
      if (UMFPACK_CONFIG_LIB)
          set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${UMFPACK_CONFIG_LIB})
      endif (UMFPACK_CONFIG_LIB)
  endif (UMFPACK_LIBRARIES)

  if(UMFPACK_LIBRARIES)
    set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${BLAS_LIBRARIES})
  endif(UMFPACK_LIBRARIES)

endif(BLAS_FOUND)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Umfpack DEFAULT_MSG
                                  UMFPACK_INCLUDES UMFPACK_LIBRARIES)

mark_as_advanced(UMFPACK_INCLUDES UMFPACK_LIBRARIES AMD_LIBRARY COLAMD_LIBRARY)

