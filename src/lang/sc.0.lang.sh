#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the SCwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /src/lang/sc.0.lang.sh
#
#        USAGE:   ---
#                 (This is a constant file, so please do NOT run it.)
#
#  DESCRIPTION:   String Constants Files for '/src/sc.sh'
#                 Used to generate help texts, interactive dialogues,
#                 and other  terminal/log messages.
#
#         BUGS:   ---
#
#        NOTES:   ---
#
#         TODO:   See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#  NAMING CONVENTION
#===============================================================================
#  Please make sure that your constants follow the naming convention below.
#  This ensures that <help()> and 'dialog' menus can be created more or less
#  automatically.
#
#===============================================================================
#  Language-independent constants, to be stored within THIS file
#===============================================================================
#-------------------------------------------------------------------------------
#  Used in help, section "ABOUT" and welcome dialogue
#-------------------------------------------------------------------------------
#  Constant                       Description
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_ABOUT_...                See 'ABOUT THIS REPOSITORY' section below.
#
#-------------------------------------------------------------------------------
#  About this repository
#-------------------------------------------------------------------------------
#  Constant                       Description
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_ABOUT_...                See 'ABOUT THIS REPOSITORY' section below.
#
#-------------------------------------------------------------------------------
#  Used in help, section "SYNOPSIS"
#-------------------------------------------------------------------------------
#  Constant                       Description             Example (value)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_HLP_PAR_<REF>            Parameter cmd switch    -i|--int <int>
#  (L_RUN_HLP_PAR_ARG_INT)
#
#-------------------------------------------------------------------------------
#  Used in help, sections "REFERENCES"
#-------------------------------------------------------------------------------
#  Constant                       Description         Example (value)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_HLP_TXT_REFERENCES_<I>   Reference           https://www.example.com
#  (L_RUN_HLP_TXT_REFERENCES_1)
#
#===============================================================================
#  Language-specific constants, to be stored within ANOTHER file,
#  e.g. within 'run.en.sh' for English, 'run.de.sh' for German, etc.
#===============================================================================
#-------------------------------------------------------------------------------
#  Used in interactive ('dialog') menus
#  (For more information on dialog please run 'dialog --help' or 'man dialog')
#-------------------------------------------------------------------------------
#  Constant                             Description       Parameter (dialog)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_<LL>_DLG_ITM_<REF>             List item         <item1>...
#  (L_RUN_EN_DLG_ITM_ARG_ITEM_ITEM1)
#
#  L_<S>_<LL>_DLG_TTL_<REF>             Title             [--title <title>]
#  (L_RUN_EN_DLG_TTL_ARG_ITEM)
#
#  L_<S>_<LL>_DLG_TXT_<REF>             Text              <text>
#  (L_RUN_EN_DLG_TXT_ARG_ITEM)
#
#-------------------------------------------------------------------------------
#  Used in help, section "SYNOPSIS"
#-------------------------------------------------------------------------------
#  Constant                   Description             Example (value)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_<LL>_HLP_DES_<REF>   Parameter description   Help <arg_int>
#  (L_RUN_EN_HLP_DES_ARG_INT)
#
#  L_<S>_<LL>_HLP_REF_<REF>   Reference description   Use '-i|--int <int>' to
#  (L_RUN_EN_HLP_REF_ARG_INT)                         specify <arg_int>'s value.
#
#-------------------------------------------------------------------------------
#  Used in help, sections "EXAMPLES" "NOTES" "REFERENCES" "REQUIREMENTS" "TLDR"
#-------------------------------------------------------------------------------
#  Constant                             Description       Example (value)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_<LL>_HLP_TTL_EXAMPLES_<I>      Example (Title)   Show Help
#  (L_RUN_EN_HLP_TTL_EXAMPLES_1)
#
#  L_<S>_<LL>_HLP_TXT_EXAMPLES_<I>      Example (Text)    ./run.sh --help
#  (L_RUN_EN_HLP_TXT_EXAMPLES_1)
#
#  L_<S>_<LL>_HLP_TXT_NOTES_<I>         Note (Text)       This is the first note.
#  (L_RUN_EN_HLP_TXT_NOTES_1)
#
#  L_<S>_<LL>_HLP_TTL_REQUIREMENTS_<I>  Requirements (Title)  General
#  (L_RUN_EN_HLP_TTL_REQUIREMENTS_1)
#
#  L_<S>_<LL>_HLP_TXT_REQUIREMENTS_<I>  Requirements (Text)   To run this ...
#  (L_RUN_EN_HLP_TXT_REQUIREMENTS_1)
#
#  L_<S>_<LL>_HLP_TTL_TLDR_<I>          TL;DR (Title)     Requirements
#  (L_RUN_EN_HLP_TTL_TLDR_1)
#
#  L_<S>_<LL>_HLP_TXT_TLDR_<I>          TL;DR (Text)      Please install ...
#  (L_RUN_EN_HLP_TXT_TLDR_1)
#
#-------------------------------------------------------------------------------
#  Used in terminal output (<stdout>/<stderr>)
#-------------------------------------------------------------------------------
#  Constant             Description                               Example (value)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_<LL>_TXT_<T>   Custom language-specific text constants   Text 1 (English)
#  (L_RUN_EN_TXT_TEXT1)
#
#===============================================================================
#  Reference
#===============================================================================
#  <...>  Description                                           Example(s)
#  -----------------------------------------------------------------------------
#  <I>    Index/Counter, starting from 1                        1
#
#  <LL>   Language ID (ISO 639-1)                               EN
#
#  <REF>  Function, parameter, or parameter list value          HELP
#         this constant refers to                               ARG_ACTION
#                                                               ARG_ACTION_HELP
#
#  <S>    "Reverse" script name without '.sh'                   RUN
#
#  <T>    Identifier that describes what the string is about    ERR_NOT_FOUND
#===============================================================================

#===============================================================================
#  ABOUT THIS REPOSITORY - DO NOT DELETE
#===============================================================================
#  Author name and mail address (multiple authors separated by newline)
readonly L_SC_ABOUT_AUTHORS="Florian Kemser and the SCwrapper contributors"

#  (Optional) One-line description of what the project is about.
#  Please start with a low letter and leave the terminating '.' out.
readonly L_SC_ABOUT_DESCRIPTION="a collection of shell scripts to interactively initialize and manage certain smartcards, USB tokens, and hardware security modules (HSMs)"

#  (Optional) Institution (multiple lines allowed)
readonly L_SC_ABOUT_INSTITUTION=""

#  (Optional) Project license (SPDX-License-Identifier)
#
#  For the full SPDX license list please have a look at
#  'https://spdx.org/licenses/'. However, only some licenses
#  are supported, see </lib/SHtemplateLIB/lib/licenses> folder.
#
#  If you are not sure which license to choose
#  just have a look at e.g. 'https://choosealicense.com'.
readonly L_SC_ABOUT_LICENSE="GPL-3.0-or-later"

#  (Optional) ASCII logo to display when running the script in interactive ('dialog') mode
readonly L_SC_ABOUT_LOGO=""

#  Project title, e.g. 'My Project'
readonly L_SC_ABOUT_PROJECT="SCwrapper"

#  DO NOT EDIT
readonly L_SC_ABOUT_RUN="./$(basename "$0")"

#  (Optional) Release/Version number, e.g. '1.1.0'
readonly L_SC_ABOUT_VERSION="1.0.0"

#  (Optional) Project year(s), e.g. '2023', '2023-2024'
readonly L_SC_ABOUT_YEARS="2022-2024"

#===============================================================================
#  PARAMETER (TEMPLATE) - DO NOT EDIT
#===============================================================================
#  Script actions <ARG_ACTION_...>
readonly L_SC_HLP_PAR_ARG_ACTION_HELP="${LIB_SHTPL_HLP_PAR_ARG_ACTION_HELP}"

#  Log destination <ARG_LOGDEST_...>
readonly L_SC_HLP_PAR_ARG_LOGDEST="${LIB_SHTPL_HLP_PAR_ARG_LOGDEST}"

#  Script operation modes <ARG_MODE_...>
readonly L_SC_HLP_PAR_ARG_MODE_DAEMON="${LIB_SHTPL_HLP_PAR_ARG_MODE_DAEMON}"
readonly L_SC_HLP_PAR_ARG_MODE_INTERACTIVE_SUBMENU="${LIB_SHTPL_HLP_PAR_ARG_MODE_INTERACTIVE_SUBMENU}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Script actions <ARG_ACTION_...>
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  PKCS#11-related
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ACTION_P11_GET_URI="--p11-get-uri <type>"

#-------------------------------------------------------------------------------
#  PKCS#15-related
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  "FIPS 201 (PIV Card)"-related
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  OpenSC (PKCS#11)
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  OpenSC (PKCS#15)
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ACTION_OPENSC_P15_ERASE_APPLICATION="--erase-application <aid>"
readonly L_SC_HLP_PAR_ARG_ACTION_OPENSC_P15_ERASE_CARD="--erase-card"
readonly L_SC_HLP_PAR_ARG_ACTION_OPENSC_P15_FINALIZE="--finalize"
readonly L_SC_HLP_PAR_ARG_ACTION_OPENSC_P15_STORE_PIN="--store-pin"

#-------------------------------------------------------------------------------
#  SmartCard-HSM / Nitrokey HSM 2
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ACTION_SCHSM_BACKUP="--schsm-backup <file>"
readonly L_SC_HLP_PAR_ARG_ACTION_SCHSM_DKEK_SHARE_CREATE="--schsm-dkek-share-create <file>"
readonly L_SC_HLP_PAR_ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT="--schsm-dkek-share-import <file>"
readonly L_SC_HLP_PAR_ARG_ACTION_SCHSM_RESTORE="--schsm-restore <file>"

#-------------------------------------------------------------------------------
#  Yubico YubiKey PIV
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY="--change-management-key"

#-------------------------------------------------------------------------------
#  Used by two or more token types
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_CHANGE_PIN="--change-pin"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_CHANGE_PUK="--change-puk"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_CHANGE_SO_PIN="--change-so-pin"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_CONNECT="--connect"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_DELETE="--delete"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_EXPORT="--export <file>"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_GET="--get <type>"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_IMPORT="--import <file>"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_INITIALIZE="--initialize"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_KEYPAIRGEN="--keypairgen [<file>]"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_LIST="--list <type>"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_RESET_PIN="--reset-pin"
readonly L_SC_HLP_PAR_ARG_ACTION_ALL_UNBLOCK_PIN="--unblock-pin"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (Token type)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_token_type
#-------------------------------------------------------------------------------
readonly L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P11="OpenSC PKCS#11"
readonly L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15="OpenSC PKCS#15"
readonly L_SC_DLG_ITM_ARG_TOKEN_TYPE_SCHSM="SmartCard-HSM / Nitrokey HSM 2"
readonly L_SC_DLG_ITM_ARG_TOKEN_TYPE_YUBICO="Yubico YubiKey PIV"

readonly L_SC_HLP_PAR_ARG_TOKEN_TYPE="-T|--token-type <type>"
readonly L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11="-T opensc-p11"
readonly L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15="-T opensc-p15"
readonly L_SC_HLP_PAR_ARG_TOKEN_TYPE_SCHSM="-T schsm"
readonly L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO="-T yubico"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (PKCS#11-related)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  p11_uri
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  p11_uri_filter
#-------------------------------------------------------------------------------

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (PKCS#15-related)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_p15_id_aid
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_P15_ID_AID="--p15-aid <id>"

#-------------------------------------------------------------------------------
#  arg_p15_id_auth
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_P15_ID_AUTH="--p15-auth-id <id>"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...>  ("FIPS 201 (PIV Card)"-related)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_piv_ber_tlv_tag
#-------------------------------------------------------------------------------
readonly L_SC_DLG_TXT_ARG_PIV_BER_TLV_TAG="\
  NIST SP 800-73-4 (Section 4.3 \"Object Identifiers\")
    https://doi.org/10.6028/NIST.SP.800-73-4
  Yubico
    https://developers.yubico.com/yubico-piv-tool/Actions/read_write_objects.html"
readonly L_SC_HLP_PAR_ARG_PIV_BER_TLV_TAG="--piv-id <id>"

#-------------------------------------------------------------------------------
#  arg_piv_keyref
#-------------------------------------------------------------------------------
readonly L_SC_DLG_TXT_ARG_PIV_KEYREF_SEEALSO="\
  NIST SP 800-73-4 (Section 5.1 \"Key References\")
    https://doi.org/10.6028/NIST.SP.800-73-4
  Yubico
    https://developers.yubico.com/PIV/Introduction/Certificate_slots.html"
readonly L_SC_HLP_PAR_ARG_PIV_KEYREF="--piv-slot <id>"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...>  (Used by two or more token types)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  all_connect
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  all_secrets
#-------------------------------------------------------------------------------
#  SmartCard-HSM / Nitrokey HSM 2
readonly L_SC_DLG_TXT_ALL_SECRETS_NEW_11_SCHSM="\
  https://github.com/OpenSC/OpenSC/wiki/SmartCardHSM#using-pkcs11-tool
  https://raymii.org/s/articles/Get_Started_With_The_Nitrokey_HSM.html"

#  Yubico YubiKey PIV
readonly L_SC_DLG_TXT_ALL_SECRETS_NEW_11_YUBICO="\
  https://docs.yubico.com/yesdk/users-manual/application-piv/pin-puk-mgmt-key.html"

#-------------------------------------------------------------------------------
#  arg_all_data_application_name
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_DATA_APPLICATION_NAME="--data-application-name <name>"

#-------------------------------------------------------------------------------
#  arg_all_data_oid
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_DATA_OID="--data-oid <oid>"

#-------------------------------------------------------------------------------
#  arg_all_file
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_FILE="<file>"

#-------------------------------------------------------------------------------
#  arg_all_force
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_FORCE="-F|--force"

#-------------------------------------------------------------------------------
#  arg_all_format
#-------------------------------------------------------------------------------
readonly L_SC_DLG_ITM_ARG_ALL_FORMAT_DER="DER"
readonly L_SC_DLG_ITM_ARG_ALL_FORMAT_PEM="PEM"
readonly L_SC_DLG_ITM_ARG_ALL_FORMAT_PKCS12="PKCS#12"
readonly L_SC_HLP_PAR_ARG_ALL_FORMAT="-f|--format <format>"

#-------------------------------------------------------------------------------
#  arg_all_id_object
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_ID_OBJECT="-i|--id <id>"

#-------------------------------------------------------------------------------
#  arg_all_id_reader
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_ID_READER="-r|--reader <id>"

#-------------------------------------------------------------------------------
#  arg_all_key_type
#-------------------------------------------------------------------------------
readonly L_SC_DLG_TXT_ARG_ALL_KEY_TYPE_2_YUBICO="\
  https://developers.yubico.com/PIV/Introduction/YubiKey_and_PIV.html"
readonly L_SC_HLP_PAR_ARG_ALL_KEY_TYPE="--key-type <type>"

#-------------------------------------------------------------------------------
#  arg_all_label
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_LABEL="-l|--label <label>"

#-------------------------------------------------------------------------------
#  arg_all_newpinpuk
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_NEWPINPUK="\
-n|--new-pin|--new-puk|
--new-so-pin <val>"

#-------------------------------------------------------------------------------
#  arg_all_password
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_PASSWORD="--password <pwd>"

#-------------------------------------------------------------------------------
#  arg_all_pin
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_PIN="-p|--pin <pin>"

#-------------------------------------------------------------------------------
#  arg_all_print
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_PRINT="--print"

#-------------------------------------------------------------------------------
#  arg_all_print_separately
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_PRINT_SEPARATELY="--print-separately"

#-------------------------------------------------------------------------------
#  arg_all_puk
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_PUK="-P|--puk <puk>"

#-------------------------------------------------------------------------------
#  arg_all_random
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_RANDOM="--random"

#-------------------------------------------------------------------------------
#  arg_all_serial
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_SERIAL="--serial <serial no>"

#-------------------------------------------------------------------------------
#  arg_all_sopin
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_SOPIN="-s|--so-pin <so pin>"

#-------------------------------------------------------------------------------
#  arg_all_sopuk
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_SOPUK="-S|--so-puk <so puk>"

#-------------------------------------------------------------------------------
#  arg_all_type
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_ALL_TYPE="-t|--type <type>"
readonly L_SC_HLP_PAR_ARG_ALL_TYPE_PRIVKEY="${L_SC_HLP_PAR_ARG_ALL_TYPE}"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...>  (OpenSC (PKCS#11))
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...>  (OpenSC (PKCS#15))
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_opensc_p15_profile
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_OPENSC_P15_PROFILE="--opensc-p15-profile <profile>"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...>  (SmartCard-HSM / Nitrokey HSM 2)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_schsm_dkek_shares
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_SCHSM_DKEK_SHARES="--schsm-dkek-shares <int>"

#-------------------------------------------------------------------------------
#  arg_schsm_key_reference
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_SCHSM_KEY_REFERENCE="--schsm-key-reference <id>"

#-------------------------------------------------------------------------------
#  arg_schsm_pwd_shares_threshold
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_SCHSM_PWD_SHARES_THRESHOLD="--schsm-pwd-shares-threshold <int>"

#-------------------------------------------------------------------------------
#  arg_schsm_pwd_shares_total
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_SCHSM_PWD_SHARES_TOTAL="--schsm-pwd-shares-total <int>"

#-------------------------------------------------------------------------------
#  arg_schsm_pwd_use_threshold_scheme
#-------------------------------------------------------------------------------
readonly L_SC_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME="https://github.com/OpenSC/OpenSC/wiki/SmartCardHSM#using-a-n-of-m-threshold-scheme"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...>  (Yubico YubiKey PIV)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_yubico_management_key
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_YUBICO_MANAGEMENT_KEY="--yubico-management-key <key>"

#-------------------------------------------------------------------------------
#  arg_yubico_new_management_key
#-------------------------------------------------------------------------------
readonly L_SC_HLP_PAR_ARG_YUBICO_NEW_MANAGEMENT_KEY="--yubico-new-management-key <key>"

#-------------------------------------------------------------------------------
#  arg_yubico_pin_policy
#-------------------------------------------------------------------------------
readonly L_SC_DLG_TXT_ARG_YUBICO_PIN_POLICY="https://docs.yubico.com/yesdk/users-manual/application-piv/pin-touch-policies.html"
readonly L_SC_HLP_PAR_ARG_YUBICO_PIN_POLICY="--yubico-pin-policy <pol>"

#-------------------------------------------------------------------------------
#  arg_yubico_touch_policy
#-------------------------------------------------------------------------------
readonly L_SC_DLG_TXT_ARG_YUBICO_TOUCH_POLICY="${L_SC_DLG_TXT_ARG_YUBICO_PIN_POLICY}"
readonly L_SC_HLP_PAR_ARG_YUBICO_TOUCH_POLICY="--yubico-touch-policy <pol>"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Last argument (parameter), see also <args_read()> in '/src/run.sh'
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
readonly L_SC_HLP_PAR_LASTARG=""

#===============================================================================
#  HELP
#===============================================================================
#-------------------------------------------------------------------------------
#  TEXTS
#-------------------------------------------------------------------------------
#  Headers
readonly L_SC_HLP_TXT_HEADER_OPENSC_P11="***** ${L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P11} ('${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}') *****"
readonly L_SC_HLP_TXT_HEADER_OPENSC_P15="***** ${L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15} ('${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}') *****"
readonly L_SC_HLP_TXT_HEADER_SCHSM="***** ${L_SC_DLG_ITM_ARG_TOKEN_TYPE_SCHSM} ('${L_SC_HLP_PAR_ARG_TOKEN_TYPE_SCHSM}') *****"
readonly L_SC_HLP_TXT_HEADER_YUBICO="***** ${L_SC_DLG_ITM_ARG_TOKEN_TYPE_YUBICO} ('${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO}') *****"

#-------------------------------------------------------------------------------
#  EXAMPLES
#-------------------------------------------------------------------------------
#  Example 1 | Initialize token
readonly L_SC_HLP_TXT_EXAMPLES_1="\
export pin=\"1111\"
export puk=\"123456\"
export sopin=\"123456\"
export sopuk=\"123456\"
export password=\"secret\"
export mgmtkey=\"010203040506070801020304050607080102030405060708\"


${L_SC_HLP_TXT_HEADER_OPENSC_P11}
./sc.sh -T opensc-p11 --initialize --label mytoken --pin env:pin --so-pin env:sopin


${L_SC_HLP_TXT_HEADER_OPENSC_P15}
# Step 1 - Erase PKCS#15 structure (certain models only)
  ./sc.sh -T opensc-p15 --erase-card

# Step 2 - Initialize token (all models)
# Token supports a separate SO-PIN/SO-PUK pair
  ./sc.sh -T opensc-p15 --initialize --pin env:pin --puk env:puk --so-pin env:sopin --so-puk env:sopuk
# Token only supports one PIN/PUK pair
  ./sc.sh -T opensc-p15 --initialize --opensc-p15-profile pkcs15+onepin --pin env:pin --puk env:puk

# Step 3 - Finish initialization (certain models only)
  ./sc.sh -T opensc-p15 --finalize


${L_SC_HLP_TXT_HEADER_SCHSM}
# Initialize without any DKEK (= key backup/restore disabled)
./sc.sh -T schsm --initialize --pin env:pin --so-pin env:sopin

# Initialize with 1 DKEK share, with a single password (no threshold scheme)
./sc.sh -T schsm --initialize --pin env:pin --so-pin env:sopin --schsm-dkek-shares 1
./sc.sh -T schsm --schsm-dkek-share-create dkek-share-1.pbe --password env:password
./sc.sh -T schsm --schsm-dkek-share-import dkek-share-1.pbe

# Initialize with 1 DKEK share and a 2-of-4 threshold scheme
./sc.sh -T schsm --initialize --pin env:pin --so-pin env:sopin --schsm-dkek-shares 1
./sc.sh -T schsm --schsm-dkek-share-create dkek-share-1.pbe --schsm-pwd-shares-threshold 2 --schsm-pwd-shares-total 4
./sc.sh -T schsm --schsm-dkek-share-import dkek-share-1.pbe --schsm-pwd-shares-total 2


${L_SC_HLP_TXT_HEADER_YUBICO}
./sc.sh -T yubico --initialize --pin env:pin --puk env:puk --yubico-management-key env:mgmtkey"

#  Example 2 | Generate public-private key pair
readonly L_SC_HLP_TXT_EXAMPLES_2="\
${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_SCHSM}
./sc.sh -T <...> --keypairgen --id 10 --key-type rsa:2048
./sc.sh -T <...> --keypairgen --label mykey --key-type rsa:2048

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
./sc.sh -T opensc-p15 --keypairgen --id 10 --key-type rsa/2048
./sc.sh -T opensc-p15 --keypairgen --label mykey --key-type rsa/2048

${L_SC_HLP_TXT_HEADER_YUBICO}
./sc.sh -T yubico --keypairgen \"pubkey.pem\" --format pem --piv-slot 9A --key-type RSA2048"

#  Example 3 | Import certificate / key / data object
readonly L_SC_HLP_TXT_EXAMPLES_3="\
${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_SCHSM}
./sc.sh -T <...>  --import cert.der   --type cert     --id 10   --label mycert
./sc.sh -T <...>  --import key.der    --type privkey  --id 20   --label mykey
./sc.sh -T <...>  --import data.file  --type data     --id 30   --label mydata

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
./sc.sh -T opensc-p15   --import cert.pem   --type cert     --id 10   --label mycert
./sc.sh -T opensc-p15   --import cert.der   --type cert     --id 10   --label mycert  --format der
./sc.sh -T opensc-p15   --import key.pem    --type privkey  --id 20   --label mykey
./sc.sh -T opensc-p15   --import key.p12    --type privkey  --id 20   --label mykey   --format pkcs12
./sc.sh -T opensc-p15   --import data.file  --type data               --label mydata

${L_SC_HLP_TXT_HEADER_YUBICO}
./sc.sh -T yubico   --import cert.pem   --type cert     --piv-slot 9A   --format pem
./sc.sh -T yubico   --import key.der    --type privkey  --piv-slot 9A   --format der
./sc.sh -T yubico   --import data.file  --type data     --piv-id"

#  Example 4 | Export certificate / data object
readonly L_SC_HLP_TXT_EXAMPLES_4="\
${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_SCHSM}
./sc.sh -T <...>    --export cert.der   --type cert   ( --id 10 | --label mycert )
./sc.sh -T <...>    --export data.file  --type data   --label mydata

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
./sc.sh -T opensc-p15   --export cert.der   --type cert   --id 10
./sc.sh -T opensc-p15   --export data.file  --type data   --label mydata

${L_SC_HLP_TXT_HEADER_YUBICO}
./sc.sh -T yubico   --export cert.der   --type cert   --piv-slot 9A   --format der
./sc.sh -T yubico   --export cert.pem   --type cert   --piv-slot 9A   --format pem
./sc.sh -T yubico   --export data.file  --type data   --piv-id 5FC108"

#  Example 5 | Delete certificate / key / data object
readonly L_SC_HLP_TXT_EXAMPLES_5="\
${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_SCHSM}
./sc.sh -T <...>  --delete  --type cert     ( --id 10 | --label mycert )
./sc.sh -T <...>  --delete  --type privkey  ( --id 20 | --label mykey )
./sc.sh -T <...>  --delete  --type data     --label mydata  --data-application-name <name>
./sc.sh -T <...>  --delete  --type data     --data-oid <oid>

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
./sc.sh -T opensc-p15   --delete  --type cert     --id 10
./sc.sh -T opensc-p15   --delete  --type privkey  --id 20
./sc.sh -T opensc-p15   --delete  --type data     --label mydata  --data-application-name <name>
./sc.sh -T opensc-p15   --delete  --type data     --data-oid <oid>

${L_SC_HLP_TXT_HEADER_YUBICO}
./sc.sh -T yubico --delete --type cert --piv-slot 9A"

#  Example 6 | PIN Management (Change/Reset/Unblock)
readonly L_SC_HLP_TXT_EXAMPLES_6="\
export oldpin=\"1111\"
export newpin=\"2222\"
export puk=\"123456\"
export sopin=\"123456\"

./sc.sh -T <...> --change-pin  --pin env:oldpin    --new-pin env:newpin
./sc.sh -T <...> --reset-pin   --so-pin env:sopin  --new-pin env:newpin
./sc.sh -T <...> --unblock-pin --puk env:puk       --new-pin env:newpin"

#  Example 7 | SmartCard-HSM / Nitrokey HSM 2 | Backup and restore private key
readonly L_SC_HLP_TXT_EXAMPLES_7="\
./sc.sh -T schsm  --schsm-backup  wrap-key.bin  --schsm-key-reference 1
./sc.sh -T schsm  --schsm-restore wrap-key.bin  --schsm-key-reference 10"

#-------------------------------------------------------------------------------
#  NOTES
#-------------------------------------------------------------------------------
#  Note 1
readonly L_SC_HLP_TXT_NOTES_1_SCHSM="\
  https://github.com/OpenSC/OpenSC/wiki/SmartCardHSM#using-pkcs11-tool
  https://raymii.org/s/articles/Get_Started_With_The_Nitrokey_HSM.html"
readonly L_SC_HLP_TXT_NOTES_1_YUBICO="\
  https://docs.yubico.com/yesdk/users-manual/application-piv/pin-puk-mgmt-key.html"
readonly L_SC_HLP_TXT_NOTES_1_PIV="\
  https://doi.org/10.6028/NIST.SP.800-73-4"

#-------------------------------------------------------------------------------
#  REFERENCES
#-------------------------------------------------------------------------------
#  References | General
readonly L_SC_HLP_TXT_REFERENCES_1="https://ccid.apdu.fr/ccid/section.html"
readonly L_SC_HLP_TXT_REFERENCES_2="https://doi.org/10.6028/NIST.SP.800-73-4"

#  References | OpenSC (General)
readonly L_SC_HLP_TXT_REFERENCES_3="https://github.com/OpenSC/OpenSC/wiki"
readonly L_SC_HLP_TXT_REFERENCES_4="https://github.com/OpenSC/OpenSC/wiki/Smart-card-readers-%28Linux-and-Mac-OS-X%29"
readonly L_SC_HLP_TXT_REFERENCES_5="https://github.com/OpenSC/OpenSC/wiki/Supported-hardware-%28smart-cards-and-USB-tokens%29"
readonly L_SC_HLP_TXT_REFERENCES_6="https://github.com/OpenSC/OpenSC/wiki/JavaCards"
readonly L_SC_HLP_TXT_REFERENCES_7="https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html"

#  References | OpenSC (PKCS#11)
readonly L_SC_HLP_TXT_REFERENCES_8="https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#pkcs11-tool"

#  References | OpenSC (PKCS#15)
readonly L_SC_HLP_TXT_REFERENCES_9="https://github.com/OpenSC/OpenSC/wiki/Card-personalization"
readonly L_SC_HLP_TXT_REFERENCES_10="https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#pkcs15-init"
readonly L_SC_HLP_TXT_REFERENCES_11="https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#pkcs15-tool"
readonly L_SC_HLP_TXT_REFERENCES_12="https://access.redhat.com/documentation/de-de/red_hat_enterprise_linux/8/html/managing_systems_using_the_rhel_8_web_console/storing-a-certificate-on-the-smart-card_configuring-smart-card-authentication-with-the-web-console"
readonly L_SC_HLP_TXT_REFERENCES_13="https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_smart_card_authentication/configuring-smart-card-authentication-with-the-web-console_managing-smart-card-authentication"

#  References | SmartCard-HSM / Nitrokey HSM 2
readonly L_SC_HLP_TXT_REFERENCES_14="https://github.com/OpenSC/OpenSC/wiki/SmartCardHSM#using-pkcs11-tool"
readonly L_SC_HLP_TXT_REFERENCES_15="https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#sc-hsm-tool"
readonly L_SC_HLP_TXT_REFERENCES_16="https://raymii.org/s/articles/Get_Started_With_The_Nitrokey_HSM.html"

#  References | Yubico YubiKey PIV
readonly L_SC_HLP_TXT_REFERENCES_17="https://www.yubico.com/us/store/compare"
readonly L_SC_HLP_TXT_REFERENCES_18="https://developers.yubico.com/PIV/Introduction/"
readonly L_SC_HLP_TXT_REFERENCES_19="https://developers.yubico.com/PIV/Introduction/YubiKey_and_PIV.html"
readonly L_SC_HLP_TXT_REFERENCES_20="https://developers.yubico.com/PIV/Introduction/Certificate_slots.html"
readonly L_SC_HLP_TXT_REFERENCES_21="https://developers.yubico.com/PIV/Introduction/Admin_access.html"
readonly L_SC_HLP_TXT_REFERENCES_22="https://developers.yubico.com/PIV/Introduction/Yubico_extensions.html"
readonly L_SC_HLP_TXT_REFERENCES_23="https://docs.yubico.com/yesdk/users-manual/application-piv/piv-overview.html"
readonly L_SC_HLP_TXT_REFERENCES_24="https://docs.yubico.com/yesdk/users-manual/application-piv/slots.html"
readonly L_SC_HLP_TXT_REFERENCES_25="https://docs.yubico.com/yesdk/users-manual/application-piv/pin-puk-mgmt-key.html"
readonly L_SC_HLP_TXT_REFERENCES_26="https://docs.yubico.com/yesdk/users-manual/application-piv/pin-only.html"
readonly L_SC_HLP_TXT_REFERENCES_27="https://docs.yubico.com/yesdk/users-manual/application-piv/pin-touch-policies.html"
readonly L_SC_HLP_TXT_REFERENCES_28="https://developers.yubico.com/yubico-piv-tool/Actions/read_write_objects.html"
readonly L_SC_HLP_TXT_REFERENCES_29="https://docs.yubico.com/software/yubikey/tools/ykman/PIV_Commands.html"


#-------------------------------------------------------------------------------
#  REQUIREMENTS
#-------------------------------------------------------------------------------
#  Requirements 1 | All token types
readonly L_SC_HLP_TXT_REQUIREMENTS_11="\
  General: PCSClite, USB PC/SC CCID driver
   Debian: > sudo apt install pcscd libccid"
readonly L_SC_HLP_TXT_REQUIREMENTS_12="\
    - https://github.com/OpenSC/OpenSC/wiki/Smart-card-readers-%28Linux-and-Mac-OS-X%29
    - https://ccid.apdu.fr/ccid/section.html"

#  Requirements 2 | Interactive Mode

#  Requirements 3 | PIN/PUK Letter
readonly L_SC_HLP_TXT_REQUIREMENTS_31="/tex/sc.tex"
readonly L_SC_HLP_TXT_REQUIREMENTS_32="https://github.com/fkemser/SCwrapper#pinpuk-letter-optional"

#  Requirements 4 | OpenSC (PKCS#11) and SmartCard-HSM / Nitrokey HSM 2
readonly L_SC_HLP_TXT_REQUIREMENTS_41="\
  General: GnuTLS, OpenSC, OpenSC (PKCS#11 module)
   Debian: > sudo apt install gnutls-bin opensc opensc-pkcs11"
readonly L_SC_HLP_TXT_REQUIREMENTS_42="\
    - https://github.com/OpenSC/OpenSC/wiki/Supported-hardware-%28smart-cards-and-USB-tokens%29
    - https://github.com/OpenSC/OpenSC/wiki/JavaCards"

#  Requirements 5 | OpenSC (PKCS#15)
readonly L_SC_HLP_TXT_REQUIREMENTS_51="\
  General: OpenSC
   Debian: > sudo apt install opensc"
readonly L_SC_HLP_TXT_REQUIREMENTS_52="\
    - https://github.com/OpenSC/OpenSC/wiki/Supported-hardware-%28smart-cards-and-USB-tokens%29
    - https://github.com/OpenSC/OpenSC/wiki/JavaCards"

#  Requirements 6 | SmartCard-HSM / Nitrokey HSM 2
readonly L_SC_HLP_TXT_REQUIREMENTS_61="\
  General: OpenSSL
   Debian: > sudo apt install openssl"

#  Requirements 7 | Yubico YubiKey PIV
readonly L_SC_HLP_TXT_REQUIREMENTS_71="\
  General: GnuTLS, Yubico PIV tool (PKCS#11 module), YubiKey Manager
   Debian: > sudo apt install gnutls-bin ykcs11 yubikey-manager"
readonly L_SC_HLP_TXT_REQUIREMENTS_72="\
  - https://www.yubico.com/us/store/compare"
readonly L_SC_HLP_TXT_REQUIREMENTS_73="https://docs.yubico.com/yesdk/users-manual/application-piv/pin-only.html"

#-------------------------------------------------------------------------------
#  TL;DR
#-------------------------------------------------------------------------------
readonly L_SC_HLP_TXT_TLDR_1_INSTALL="\
Debian
> sudo apt install dialog gnutls-bin opensc opensc-pkcs11 openssl \\
                   pcscd libccid ykcs11 yubikey-manager"
readonly L_SC_HLP_TXT_TLDR_1_KERNEL="5.15.90.1-microsoft-standard-WSL2"
readonly L_SC_HLP_TXT_TLDR_1_OS="Debian GNU/Linux 12 (bookworm)"
readonly L_SC_HLP_TXT_TLDR_1_PACKAGES="\
Dialog (1.3-20201126-1), GnuTLS (3.7.1-5), OpenSC (0.21.0-1),
            OpenSC (PKCS#11 module) (0.21.0-1), OpenSSL (3.0.11),
            PCSClite (1.9.1-1), USB PC/SC CCID driver (1.4.34-1),
            Yubico PIV tool (PKCS#11 module) (2.2.0-1),
            YubiKey Manager (4.0.0~a1-4)"