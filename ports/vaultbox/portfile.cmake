# vcpkg port for VaultBox (header-only C++ library, depends on Crypto++).
# VaultBox has no CMake build, so this port installs the public headers directly.
# Set the SHA512: build once with SHA512 "0" and paste the value vcpkg prints.

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO devharsh/VaultBox
    REF "v${VERSION}"        # create the tag first: git tag -a v1.0.0 -m "Release 1.0.0"; git push origin v1.0.0
    SHA512 cc66c506e960179a3da5b5b2346a9eaa8e9ba40c2fd498a84ee4a4e5186fc14f50647a506608ae61f57f012108cdcc4cd99f021fdd1b02d11c850598c6dfece5
    HEAD_REF main
)

# Headers live in the VaultBox/ subdirectory of the repo.
file(GLOB VAULTBOX_HEADERS "${SOURCE_PATH}/VaultBox/*.h" "${SOURCE_PATH}/VaultBox/*.hpp")
if(NOT VAULTBOX_HEADERS)
    message(FATAL_ERROR "No headers found under ${SOURCE_PATH}/VaultBox - adjust the glob to the real header location.")
endif()
file(INSTALL ${VAULTBOX_HEADERS} DESTINATION "${CURRENT_PACKAGES_DIR}/include/vaultbox")

# Header-only: nothing to build; vcpkg requires a usage/copyright file.
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

# Optional usage hint shown after install:
file(WRITE "${CURRENT_PACKAGES_DIR}/share/vaultbox/usage"
"vaultbox is header-only and depends on cryptopp.\n#include <vaultbox/lib.hpp>\nLink Crypto++: find_package(cryptopp CONFIG REQUIRED); target_link_libraries(main PRIVATE cryptopp::cryptopp)\n")
