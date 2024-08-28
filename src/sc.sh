#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the SCwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /src/sc.sh
#
#        USAGE:   Run <sc.sh -h> for more information
#
#  DESCRIPTION:   SCwrapper Run File
#
#      OPTIONS:   Run <sc.sh -h> for more information
#
# REQUIREMENTS:   Run <sc.sh -h> for more information
#
#         BUGS:   ---
#
#        NOTES:   Please edit the configuration file (/etc/sc.cfg.sh)
#                 before you start.
#
#         TODO:   See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#  CONFIG
#===============================================================================
#  DONE: Enable PID based locking? (true|false)
#  (If 'true' then parts of the script require root privileges.)
readonly PIDLOCK_ENABLED="false"

#===============================================================================
#  INIT - DO NOT EDIT
#===============================================================================
#  Run repository initialization script
. "$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/init.sh"              || \
{ printf "%s\n\n"                                                           \
    "ERROR: Could not run the repository initialization script './init.sh'. Aborting..." >&2
  return 1
}

#===============================================================================
#  PARAMETER (TEMPLATE) - DO NOT EDIT
#===============================================================================
#  Script actions <ARG_ACTION_...>
readonly ARG_ACTION_ABOUT="about"
readonly ARG_ACTION_EXIT="exit"
readonly ARG_ACTION_HELP="help"
arg_action=""

#  Log destination <ARG_LOGDEST_...>
readonly ARG_LOGDEST_BOTH="both"                  # Terminal window + System log
readonly ARG_LOGDEST_SYSLOG="syslog"              # System log
readonly ARG_LOGDEST_TERMINAL="terminal"          # Terminal window
readonly ARG_LOGDEST_LIST="BOTH SYSLOG TERMINAL"
arg_logdest=""

#  Script operation modes <ARG_MODE_...>
readonly ARG_MODE_DAEMON="daemon"                 # Daemon
readonly ARG_MODE_INTERACTIVE="interactive"       # Interactive
readonly ARG_MODE_INTERACTIVE_SUBMENU="submenu"   # Submenu
readonly ARG_MODE_SCRIPT="script"                 # Script
arg_mode="${ARG_MODE_SCRIPT}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#-------------------------------------------------------------------------------
#  Script actions <ARG_ACTION_...>
#-------------------------------------------------------------------------------
#                        DONE: DEFINE YOUR ACTIONS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#  PKCS#11-related
#-------------------------------------------------------------------------------
readonly ARG_ACTION_P11_GET_URI="p11-get-uri"

#-------------------------------------------------------------------------------
#  Used by two or more token types
#-------------------------------------------------------------------------------
readonly ARG_ACTION_ALL_CHANGE_PIN="change-pin"
readonly ARG_ACTION_ALL_CHANGE_PUK="change-puk"
readonly ARG_ACTION_ALL_CHANGE_SO_PIN="change-so-pin"
readonly ARG_ACTION_ALL_CONNECT="connect"
readonly ARG_ACTION_ALL_DELETE="delete"
readonly ARG_ACTION_ALL_EXPORT="export"
readonly ARG_ACTION_ALL_GET="get"
readonly ARG_ACTION_ALL_IMPORT="import"
readonly ARG_ACTION_ALL_INITIALIZE="initialize"
readonly ARG_ACTION_ALL_KEYPAIRGEN="keypairgen"
readonly ARG_ACTION_ALL_LIST="list"
readonly ARG_ACTION_ALL_RESET_PIN="reset-pin"
readonly ARG_ACTION_ALL_UNBLOCK_PIN="unblock-pin"
readonly ARG_ACTION_LIST_ALL="ALL_CHANGE_PIN ALL_CHANGE_PUK ALL_CHANGE_SO_PIN ALL_DELETE ALL_EXPORT ALL_GET ALL_IMPORT ALL_INITIALIZE ALL_KEYPAIRGEN ALL_LIST ALL_RESET_PIN ALL_UNBLOCK_PIN"

#-------------------------------------------------------------------------------
#  OpenSC (PKCS#15)
#-------------------------------------------------------------------------------
readonly ARG_ACTION_OPENSC_P15_ERASE_APPLICATION="erase-application"
readonly ARG_ACTION_OPENSC_P15_ERASE_CARD="erase-card"
readonly ARG_ACTION_OPENSC_P15_FINALIZE="finalize"
readonly ARG_ACTION_OPENSC_P15_STORE_PIN="store-pin"

#-------------------------------------------------------------------------------
#  SmartCard-HSM / Nitrokey HSM 2
#-------------------------------------------------------------------------------
readonly ARG_ACTION_SCHSM_BACKUP="schsm-backup"
readonly ARG_ACTION_SCHSM_DKEK_SHARE_CREATE="schsm-dkek-share-create"
readonly ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT="schsm-dkek-share-import"
readonly ARG_ACTION_SCHSM_RESTORE="schsm-restore"

#-------------------------------------------------------------------------------
#  Yubico YubiKey PIV
#-------------------------------------------------------------------------------
readonly ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY="change-management-key"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                        DONE: DEFINE YOUR ACTIONS HERE
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Other parameters <arg_...>
#-------------------------------------------------------------------------------
#  In case you define any additional constants for your parameters please use
#  the following naming convention:
#
#  Name                 Description
#  -----------------------------------------------------------------------------
#  <ARG>_DEFAULT        Default value that <arg> will be reset to,
#                       see <LIST_ARG_CLEANUP_INTERACTIVE_...> below.
#
#  <ARG>_LIST[_...]     List of allowed values, either directly or
#                       indirectly via constant pointers.
#
#  <ARG>_MAX            Maximum value
#  <ARG>_MIN            Minimum value
#
#                       DONE: DEFINE YOUR PARAMETERS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#  Token type
#-------------------------------------------------------------------------------
# See also variable 'all_p11lib' and 'all_p11lib_full'
readonly ARG_TOKEN_TYPE_OPENSC_P11="opensc-p11"
readonly ARG_TOKEN_TYPE_OPENSC_P15="opensc-p15"
readonly ARG_TOKEN_TYPE_SCHSM="schsm"
readonly ARG_TOKEN_TYPE_YUBICO="yubico"
readonly ARG_TOKEN_TYPE_LIST="OPENSC_P11 OPENSC_P15 SCHSM YUBICO"
arg_token_type="${ARG_TOKEN_TYPE_OPENSC_P11}"

#-------------------------------------------------------------------------------
#  PKCS#11-related
#-------------------------------------------------------------------------------
# PKCS#11 URI (object) filter
# See also:
#   https://datatracker.ietf.org/doc/html/rfc7512
#   'man p11tool' ('--list-...')
readonly ARG_P11_URI_FILTER_ALL="all"
readonly ARG_P11_URI_FILTER_CERTS="certs"
readonly ARG_P11_URI_FILTER_CERTS_ALL="all-certs"
readonly ARG_P11_URI_FILTER_PRIVKEYS="privkeys"
readonly ARG_P11_URI_FILTER_LIST="ALL CERTS_ALL CERTS PRIVKEYS"
arg_p11_uri_filter="${ARG_P11_URI_FILTER_ALL}"

#-------------------------------------------------------------------------------
#  PKCS#15-related
#-------------------------------------------------------------------------------
# Application ID (hexadecimal) of PKCS#15 application
# ('--aid' (pkcs15-init, pkcs15-tool))
arg_p15_id_aid=""

# PIN auth ID ('--auth-id' (pkcs15-init, pkcs15-tool))
arg_p15_id_auth=""

#-------------------------------------------------------------------------------
#  "FIPS 201 (PIV Card)"-related
#-------------------------------------------------------------------------------
# Object ID (BER-TLV Tag)
#   NIST SP 800-73-4 (Section 4.3 "Object Identifiers")
#     https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-73-4.pdf
#   Yubico
#     https://developers.yubico.com/yubico-piv-tool/Actions/read_write_objects.html
readonly ARG_PIV_BER_TLV_TAG_LIST="\
5FC107 5FC102 5FC105 5FC103 5FC106 5FC108 5FC101 5FC10A 5FC10B 5FC109 7E \
5FC10C 5FC10D 5FC10E 5FC10F 5FC110 5FC111 5FC112 5FC113 5FC114 5FC115 5FC116 \
5FC117 5FC118 5FC119 5FC11A 5FC11B 5FC11C 5FC11D 5FC11E 5FC11F 5FC120 5FC121 \
7F61 5FC122 5FC123"
arg_piv_ber_tlv_tag=""

# Key Reference Value
#   NIST SP 800-73-4 (Section 5.1 "Key References")
#     http://dx.doi.org/10.6028/NIST.SP.800-73-4
#   Yubico
#     https://developers.yubico.com/PIV/Introduction/Certificate_slots.html
readonly ARG_PIV_KEYREF_LIST="\
04 9A 9C 9D 9E 82 83 84 85 86 87 88 89 8A 8B 8C 8D 8E 8F 90 91 92 93 94 \
95 F9"
arg_piv_keyref=""

#-------------------------------------------------------------------------------
#  Used by two or more token types
#-------------------------------------------------------------------------------
# Application name of data object
# ('--application-label' (pkcs11-tool), '--application-name' (pkcs15-init))
arg_all_data_application_name=""

# Data Object Identifier (OID) ('--application-id' (pkcs11-tool, pkcs15-init))
arg_all_data_oid=""

# File(path) to import/export
arg_all_file=""

# Perform action without any further user interaction,
# see also variable 'all_force' ('--force' (sc-hsm-tool, ykman))
arg_all_force="false"

# Encoding formats ('--format' (pkcs15-init, ykman))
readonly ARG_ALL_FORMAT_DER="der"
readonly ARG_ALL_FORMAT_PEM="pem"
readonly ARG_ALL_FORMAT_PKCS12="pkcs12"
readonly ARG_ALL_FORMAT_LIST="PEM DER PKCS12"
arg_all_format="${ARG_ALL_FORMAT_PEM}"

# Lists of available encoding formats depending on requested action
# and/or object class/type
readonly ARG_ALL_FORMAT_LIST_ALL_EXPORT="PEM DER"
readonly ARG_ALL_FORMAT_LIST_ALL_IMPORT="PEM DER"
readonly ARG_ALL_FORMAT_LIST_ALL_KEYPAIRGEN="PEM DER"

# Selects which information to get/print
readonly ARG_ALL_GET_READER="reader"
readonly ARG_ALL_GET_SMARTCARD="smartcard"
readonly ARG_ALL_GET_SMARTCARD_MANUFACTURER="smartcard-manufacturer"
readonly ARG_ALL_GET_SMARTCARD_MODEL="smartcard-model"
readonly ARG_ALL_GET_SMARTCARD_SERIAL="smartcard-serial"
readonly ARG_ALL_GET_LIST="READER SMARTCARD"
arg_all_get="${ARG_ALL_GET_SMARTCARD}"

# Object ID ('--id' (pkcs11-tool, pkcs15-init, pkcs15-tool))
arg_all_id_object=""

# Slot/Reader ID ('--slot' (pkcs11-tool), '--reader' (pkcs15-tool, sc-hsm-tool))
arg_all_id_reader=""

# Key type (algorithm, length)
# '--key-type' (pkcs11-tool), '--generate-key' (pkcs15-init),
# '--algorithm' (ykman)
# Default value is set in <init_update()>
arg_all_key_type=""

# Object/Token Label ('--label' (pkcs11-tool, pkcs15-init, pkcs15-tool, sc-hsm-tool))
arg_all_label=""

# New user PIN / user PUK / security officer PIN ('--new-pin' (pkcs11-tool, pkcs15-tool, ykman), '--new-puk' (ykman))
readonly ARG_ALL_NEWPINPUK_DEFAULT_ALL=""
arg_all_newpinpuk="${ARG_ALL_NEWPINPUK_DEFAULT_ALL}"

# Password for exporting/importing password-protected files ('--passphrase' (pkcs15-init), '--password' (sc-hsm-tool, ykman))
readonly ARG_ALL_PASSWORD_CHARS_ALLOWED_ALL="[:graph:]" # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_PASSWORD_CHARS_DEFAULT_ALL="[:alnum:]" # Default characters in case secret is randomly generated
readonly ARG_ALL_PASSWORD_LEN_MIN_ALL="0"   # Minimum length
readonly ARG_ALL_PASSWORD_LEN_ALL="10"      # Default length
readonly ARG_ALL_PASSWORD_LEN_MAX_ALL=""    # Maximum length
readonly ARG_ALL_PASSWORD_DEFAULT_ALL=""    # Default value
arg_all_password="${ARG_ALL_PASSWORD_DEFAULT_ALL}"

# (Current or initial) user PIN ('--pin' (pkcs11-tool, pkcs15-init, pkcs15-tool, sc-hsm-tool, ykman))
readonly ARG_ALL_PIN_CHARS_ALLOWED_ALL="[:digit:]"  # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_PIN_CHARS_DEFAULT_ALL="${ARG_ALL_PIN_CHARS_ALLOWED_ALL}" # Default characters in case secret is randomly generated
readonly ARG_ALL_PIN_LEN_MIN_ALL="6"        # Minimum length
readonly ARG_ALL_PIN_LEN_ALL="6"            # Default length
readonly ARG_ALL_PIN_LEN_MAX_ALL="8"        # Maximum length
readonly ARG_ALL_PIN_DEFAULT_ALL=""         # Default value
arg_all_pin="${ARG_ALL_PIN_DEFAULT_ALL}"

# Print secrets (e.g. PIN, PUK, etc.) and/or <arg_all_file> content on paper? (true|false)
readonly ARG_ALL_PRINT_DEFAULT_ALL="false"
arg_all_print="${ARG_ALL_PRINT_DEFAULT_ALL}"

# Print admin related secrets (e.g. SO-PIN, Management Key, etc.) on a separate piece of paper? (true|false)
readonly ARG_ALL_PRINT_SEPARATELY_DEFAULT_ALL="false"
arg_all_print_separately="${ARG_ALL_PRINT_SEPARATELY_DEFAULT_ALL}"

# (Current or initial) user PUK ('--puk' (pkcs11-tool, pkcs15-init, ykman))
readonly ARG_ALL_PUK_CHARS_ALLOWED_ALL="[:digit:]"  # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_PUK_CHARS_DEFAULT_ALL="${ARG_ALL_PUK_CHARS_ALLOWED_ALL}" # Default characters in case secret is randomly generated
readonly ARG_ALL_PUK_LEN_MIN_ALL="8"        # Minimum length
readonly ARG_ALL_PUK_LEN_ALL="8"            # Default length
readonly ARG_ALL_PUK_LEN_MAX_ALL="8"        # Maximum length
readonly ARG_ALL_PUK_DEFAULT_ALL=""         # Default value
arg_all_puk="${ARG_ALL_PUK_DEFAULT_ALL}"

# Create PINs, PUKs, etc. randomly? (true|false)
readonly ARG_ALL_RANDOM_DEFAULT_ALL="false"
arg_all_random="${ARG_ALL_RANDOM_DEFAULT_ALL}"

# Card serial no ('--device' (ykman))
arg_all_serial=""

# (Current or initial) security officer (SO-)PIN ('--so-pin' (pkcs11-tool, pkcs15-init, sc-hsm-tool))
readonly ARG_ALL_SOPIN_CHARS_ALLOWED_ALL="[:digit:]"  # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_SOPIN_CHARS_DEFAULT_ALL="${ARG_ALL_SOPIN_CHARS_ALLOWED_ALL}" # Default characters in case secret is randomly generated
readonly ARG_ALL_SOPIN_LEN_MIN_ALL="6"        # Minimum length
readonly ARG_ALL_SOPIN_LEN_ALL="6"            # Default length
readonly ARG_ALL_SOPIN_LEN_MAX_ALL="8"        # Maximum length
readonly ARG_ALL_SOPIN_DEFAULT_ALL=""         # Default value
arg_all_sopin="${ARG_ALL_SOPIN_DEFAULT_ALL}"

# (Current or initial) security officer (SO-)PUK ('--so-puk' (pkcs15-init))
readonly ARG_ALL_SOPUK_CHARS_ALLOWED_ALL="[:digit:]"  # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_SOPUK_CHARS_DEFAULT_ALL="${ARG_ALL_SOPUK_CHARS_ALLOWED_ALL}" # Default characters in case secret is randomly generated
readonly ARG_ALL_SOPUK_LEN_MIN_ALL="8"        # Minimum length
readonly ARG_ALL_SOPUK_LEN_ALL="8"            # Default length
readonly ARG_ALL_SOPUK_LEN_MAX_ALL="8"        # Maximum length
readonly ARG_ALL_SOPUK_DEFAULT_ALL=""         # Default value
arg_all_sopuk="${ARG_ALL_SOPUK_DEFAULT_ALL}"

# Object classes and list types
readonly ARG_ALL_TYPE_ALGORITHM="algorithm"
readonly ARG_ALL_TYPE_CERT="cert"
readonly ARG_ALL_TYPE_CHAIN="chain"
readonly ARG_ALL_TYPE_DATA="data"
readonly ARG_ALL_TYPE_INFO="info"
readonly ARG_ALL_TYPE_OBJECT="object"
readonly ARG_ALL_TYPE_PRIVKEY="privkey"
readonly ARG_ALL_TYPE_PUBKEY="pubkey"
readonly ARG_ALL_TYPE_READER="reader"
readonly ARG_ALL_TYPE_SECRKEY="secrkey"
readonly ARG_ALL_TYPE_SSHKEY="sshkey"
readonly ARG_ALL_TYPE_SSHKEY_RFC4716="sshkey-rfc4716"
readonly ARG_ALL_TYPE_P15_APPLICATION="p15-application"
readonly ARG_ALL_TYPE_P15_PIN="p15-pin"
arg_all_type=""

# Internal use only
readonly ARG_ALL_TYPE_SERIAL="serial"

# Lists of available object classes and list types depending on requested action
readonly ARG_ALL_TYPE_LIST="CERT DATA OBJECT PRIVKEY PUBKEY SECRKEY CHAIN SSHKEY SSHKEY_RFC4716 ALGORITHM INFO READER P15_APPLICATION P15_PIN"
readonly ARG_ALL_TYPE_LIST_ALL_DELETE="CERT DATA PRIVKEY PUBKEY SECRKEY"
readonly ARG_ALL_TYPE_LIST_ALL_EXPORT="CERT DATA PUBKEY"
readonly ARG_ALL_TYPE_LIST_ALL_IMPORT="CERT DATA PRIVKEY PUBKEY SECRKEY"

#-------------------------------------------------------------------------------
#  OpenSC (PKCS#11)
#-------------------------------------------------------------------------------
# List of possible reader/smartcard attributes to get/print
readonly ARG_ALL_GET_LIST_OPENSC_P11="READER SMARTCARD SMARTCARD_MANUFACTURER SMARTCARD_MODEL SMARTCARD_SERIAL"

# Default key type
readonly ARG_ALL_KEY_TYPE_OPENSC_P11="\
${CFG_SC_ARG_ALL_KEY_TYPE_OPENSC_P11=:-rsa:2048}"

# Lists of available object classes and list types depending on requested action
readonly ARG_ALL_TYPE_LIST_OPENSC_P11_LIST="ALGORITHM OBJECT READER"

#-------------------------------------------------------------------------------
#  OpenSC (PKCS#15)
#-------------------------------------------------------------------------------
# Lists of available encoding formats depending on requested action and/or
# object class/type
readonly ARG_ALL_FORMAT_LIST_OPENSC_P15_IMPORT_PRIVKEY="PEM DER PKCS12"
readonly ARG_ALL_FORMAT_LIST_OPENSC_P15_IMPORT_PUBKEY="PEM DER"

# List of possible reader/smartcard attributes to get/print
readonly ARG_ALL_GET_LIST_OPENSC_P15="READER SMARTCARD SMARTCARD_MODEL SMARTCARD_SERIAL"

# Default key type
readonly ARG_ALL_KEY_TYPE_OPENSC_P15="\
${CFG_SC_ARG_ALL_KEY_TYPE_OPENSC_P15=:-rsa/2048}"

# Default length and character class for randomly generated PIN/PUK/SO-PIN/SO-PUK/Management Key
readonly ARG_ALL_PUK_CHARS_ALLOWED_OPENSC_P15="[:digit:]" # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_PUK_CHARS_DEFAULT_OPENSC_P15="${ARG_ALL_PUK_CHARS_ALLOWED_OPENSC_P15}" # Default characters in case secret is randomly generated
readonly ARG_ALL_PUK_LEN_MIN_OPENSC_P15="8"       # Minimum length
readonly ARG_ALL_PUK_LEN_OPENSC_P15="8"           # Default length
readonly ARG_ALL_PUK_LEN_MAX_OPENSC_P15="16"      # Maximum length
readonly ARG_ALL_SOPUK_CHARS_ALLOWED_OPENSC_P15="[:digit:]" # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_SOPUK_CHARS_DEFAULT_OPENSC_P15="${ARG_ALL_SOPUK_CHARS_ALLOWED_OPENSC_P15}" # Default characters in case secret is randomly generated
readonly ARG_ALL_SOPUK_LEN_MIN_OPENSC_P15="8"       # Minimum length
readonly ARG_ALL_SOPUK_LEN_OPENSC_P15="8"           # Default length
readonly ARG_ALL_SOPUK_LEN_MAX_OPENSC_P15="16"      # Maximum length

# Lists of available object classes and list types depending on requested action
readonly ARG_ALL_TYPE_LIST_OPENSC_P15_DELETE="\
CERT CHAIN DATA PRIVKEY PUBKEY SECRKEY"
readonly ARG_ALL_TYPE_LIST_OPENSC_P15_EXPORT="\
CERT DATA PUBKEY SSHKEY SSHKEY_RFC4716"
readonly ARG_ALL_TYPE_LIST_OPENSC_P15_LIST="\
ALGORITHM CERT DATA INFO OBJECT PRIVKEY PUBKEY READER SECRKEY P15_APPLICATION P15_PIN"
readonly ARG_ALL_TYPE_LIST_OPENSC_P15_LIST_PINREQUIRED="\
DATA PRIVKEY SECRKEY"

# PKCS#15 profile name and options ('--profile' (pkcs15-init))
ARG_OPENSC_P15_PROFILE_ONEPIN="pkcs15+onepin"
arg_opensc_p15_profile="pkcs15"

#-------------------------------------------------------------------------------
#  SmartCard-HSM / Nitrokey HSM 2
#-------------------------------------------------------------------------------
# List of possible reader/smartcard attributes to get/print
readonly ARG_ALL_GET_LIST_SCHSM="${ARG_ALL_GET_LIST_OPENSC_P11}"

# Default key type
readonly ARG_ALL_KEY_TYPE_SCHSM="${CFG_SC_ARG_ALL_KEY_TYPE_SCHSM:-rsa:4096}"

# Default length and character class for randomly generated PIN/PUK/SO-PIN/SO-PUK/Management Key
readonly ARG_ALL_PIN_CHARS_ALLOWED_SCHSM="[:alnum:]"  # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_PIN_CHARS_DEFAULT_SCHSM="[:digit:]"  # Default characters in case secret is randomly generated
readonly ARG_ALL_PIN_LEN_MIN_SCHSM="6"        # Minimum length
readonly ARG_ALL_PIN_LEN_SCHSM="6"            # Default length
readonly ARG_ALL_PIN_LEN_MAX_SCHSM="15"       # Maximum length
readonly ARG_ALL_SOPIN_CHARS_ALLOWED_SCHSM="[:xdigit:]" # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_SOPIN_CHARS_DEFAULT_SCHSM="[:digit:]"  # Default characters in case secret is randomly generated
readonly ARG_ALL_SOPIN_LEN_MIN_SCHSM="16"       # Minimum length
readonly ARG_ALL_SOPIN_LEN_SCHSM="16"           # Default length
readonly ARG_ALL_SOPIN_LEN_MAX_SCHSM="16"       # Maximum length

# Lists of available object classes and list types depending on requested action
readonly ARG_ALL_TYPE_LIST_SCHSM_LIST="${ARG_ALL_TYPE_LIST_OPENSC_P11_LIST}"

# Number of DKEK shares ('--dkek-shares' (sc-hsm-tool))
readonly ARG_SCHSM_DKEK_SHARES_MIN="0"
readonly ARG_SCHSM_DKEK_SHARES_MAX="99"
arg_schsm_dkek_shares=""

# Key (identifier) to backup/restore ('--key-reference' (sc-hsm-tool))
arg_schsm_key_reference="1"

# Required number of DKEK password shares
# ('--pwd-shares-threshold' (sc-hsm-tool))
readonly ARG_SCHSM_PWD_SHARES_THRESHOLD_DEFAULT_SCHSM=""
readonly ARG_SCHSM_PWD_SHARES_THRESHOLD_MIN="1"
arg_schsm_pwd_shares_threshold=""

# Total number of DKEK password shares ('--pwd-shares-total' (sc-hsm-tool))
readonly ARG_SCHSM_PWD_SHARES_TOTAL_DEFAULT_SCHSM=""
readonly ARG_SCHSM_PWD_SHARES_TOTAL_MIN="1"
readonly ARG_SCHSM_PWD_SHARES_TOTAL_MAX="99"
arg_schsm_pwd_shares_total=""

# Use an n-of-m threshold scheme for DKEK share's password? (true|false)
arg_schsm_pwd_use_threshold_scheme="false"

#-------------------------------------------------------------------------------
#  Yubico YubiKey PIV
#-------------------------------------------------------------------------------
# List of possible reader/smartcard attributes to get/print
readonly ARG_ALL_GET_LIST_YUBICO="${ARG_ALL_GET_LIST_OPENSC_P11}"

# Default key type
readonly ARG_ALL_KEY_TYPE_YUBICO="${CFG_SC_ARG_ALL_KEY_TYPE_YUBICO:-RSA2048}"
readonly ARG_ALL_KEY_TYPE_YUBICO_CHANGE_MANAGEMENT_KEY="${CFG_SC_ARG_ALL_KEY_TYPE_YUBICO_CHANGE_MANAGEMENT_KEY:-AES256}"
readonly ARG_ALL_KEY_TYPE_YUBICO_INITIALIZE="${CFG_SC_ARG_ALL_KEY_TYPE_YUBICO_INITIALIZE:-AES256}"

# List of supported key algorithms/lengths
readonly ARG_ALL_KEY_TYPE_LIST_YUBICO_CHANGE_MANAGEMENT_KEY="\
AES256 AES192 AES128 TDES"
readonly ARG_ALL_KEY_TYPE_LIST_YUBICO_INITIALIZE="${ARG_ALL_KEY_TYPE_LIST_YUBICO_CHANGE_MANAGEMENT_KEY}"
readonly ARG_ALL_KEY_TYPE_LIST_YUBICO_KEYPAIRGEN="\
RSA2048 RSA1024 ECCP256 ECCP384"

# Default length and character class for randomly generated PIN/PUK/SO-PIN/SO-PUK/Management Key
readonly ARG_ALL_PIN_CHARS_ALLOWED_YUBICO="[:alnum:]" # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_PIN_CHARS_DEFAULT_YUBICO="[:digit:]" # Default characters in case secret is randomly generated
readonly ARG_ALL_PIN_LEN_MIN_YUBICO="6"       # Minimum length
readonly ARG_ALL_PIN_LEN_YUBICO="6"           # Default length
readonly ARG_ALL_PIN_LEN_MAX_YUBICO="8"       # Maximum length
readonly ARG_ALL_PUK_CHARS_ALLOWED_YUBICO="[:print:]" # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_ALL_PUK_CHARS_DEFAULT_YUBICO="[:digit:]" # Default characters in case secret is randomly generated
readonly ARG_ALL_PUK_LEN_MIN_YUBICO="6"       # Minimum length
readonly ARG_ALL_PUK_LEN_YUBICO="8"           # Default length
readonly ARG_ALL_PUK_LEN_MAX_YUBICO="8"       # Maximum length
readonly ARG_YUBICO_MANAGEMENT_KEY_CHARS_ALLOWED_YUBICO="[:xdigit:]"  # Allowed characters (e.g. 'a-z0-9') or character class (e.g. '[:alnum:]')
readonly ARG_YUBICO_MANAGEMENT_KEY_CHARS_DEFAULT_YUBICO="a-f0-9"      # Default characters in case secret is randomly generated
readonly ARG_YUBICO_MANAGEMENT_KEY_LEN_MIN_YUBICO="32"    # Minimum length

# Lists of available object classes and list types depending on requested action
readonly ARG_ALL_TYPE_LIST_YUBICO_DELETE="CERT"
readonly ARG_ALL_TYPE_LIST_YUBICO_IMPORT="CERT DATA PRIVKEY"
readonly ARG_ALL_TYPE_LIST_YUBICO_LIST="ALGORITHM DATA INFO READER"

# '--management-key' (ykman piv ...)
readonly ARG_YUBICO_MANAGEMENT_KEY_DEFAULT_YUBICO=""
arg_yubico_management_key="${ARG_YUBICO_MANAGEMENT_KEY_DEFAULT_YUBICO}"

# '--new-management-key' (ykman piv ...)
readonly ARG_YUBICO_NEW_MANAGEMENT_KEY_DEFAULT_YUBICO=""
arg_yubico_new_management_key="${ARG_YUBICO_NEW_MANAGEMENT_KEY_DEFAULT_YUBICO}"

# PIN policy ('--pin-policy' (ykman piv ...))
# See also: https://docs.yubico.com/yesdk/users-manual/application-piv/pin-touch-policies.html
readonly ARG_YUBICO_PIN_POLICY_ALWAYS="always"
readonly ARG_YUBICO_PIN_POLICY_DEFAULT="default"
readonly ARG_YUBICO_PIN_POLICY_NEVER="never"
readonly ARG_YUBICO_PIN_POLICY_ONCE="once"
readonly ARG_YUBICO_PIN_POLICY_LIST="DEFAULT ALWAYS ONCE NEVER"
arg_yubico_pin_policy="${ARG_YUBICO_PIN_POLICY_DEFAULT}"

# Touch policy ('--touch-policy' (ykman piv ...))
# See also: https://docs.yubico.com/yesdk/users-manual/application-piv/pin-touch-policies.html
readonly ARG_YUBICO_TOUCH_POLICY_ALWAYS="always"
readonly ARG_YUBICO_TOUCH_POLICY_CACHED="cached"
readonly ARG_YUBICO_TOUCH_POLICY_DEFAULT="default"
readonly ARG_YUBICO_TOUCH_POLICY_NEVER="never"
readonly ARG_YUBICO_TOUCH_POLICY_LIST="DEFAULT ALWAYS CACHED NEVER"
arg_yubico_touch_policy="${ARG_YUBICO_TOUCH_POLICY_DEFAULT}"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                       DONE: DEFINE YOUR PARAMETERS HERE
#-------------------------------------------------------------------------------

#===============================================================================
#  GLOBAL VARIABLES (TEMPLATE) - DO NOT EDIT
#===============================================================================
# Trap handling
trap_blocked="false"        # Prevent trap execution? (true|false)
trap_triggered="false"      # <trap_...()> function was called? (true|false)

#===============================================================================
#  GLOBAL VARIABLES (CUSTOM)
#===============================================================================
#                    DONE: DEFINE YOUR GLOBAL VARIABLES HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
#-------------------------------------------------------------------------------
#  Used by two or more token types
#-------------------------------------------------------------------------------
# <arg_all_file>'s content
all_file_content=""

# Perform action without any further user interaction,
# see also argument 'arg_all_force' ('--force' (sc-hsm-tool, ykman)
all_force=""

# PKCS#11 library ('--module' (pkcs11-tool))
readonly P11LIB_OPENSC="opensc-pkcs11.so" # OpenSC, see https://github.com/OpenSC/libp11
readonly P11LIB_YUBICO="libykcs11.so"     # Yubico YubiKey, see https://developers.yubico.com/yubico-piv-tool/YKCS11/
all_p11lib="${P11LIB_OPENSC}"

# PKCS#11 library full path ('--provider' (p11tool))
all_p11lib_full=""

#-------------------------------------------------------------------------------
#  PKCS#11-related
#-------------------------------------------------------------------------------
p11_uri="" # PKCS#11 URI of selected token object, see 'p11_get_uri()'

#-------------------------------------------------------------------------------
#  PKCS#15-related
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  OpenSC (PKCS#11)
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  OpenSC (PKCS#15)
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  SmartCard-HSM / Nitrokey HSM 2
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Yubico YubiKey PIV
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  PIN/PUK/SO-PIN/SO-PUK/Management Key related
#-------------------------------------------------------------------------------
# Variable (pointer) that is required (but not changed) for the
# chosen action ('arg_mode')
all_secrets_arg_input=""

# List of variables (pointers) that will be changed depending on the
# chosen action ('arg_mode') (see also 'init_update' function)
all_secrets_arg_list_change=""

# Variable (pointer) where the new value will be saved to
# (only set if 'all_secrets_mode' is 'ALL_SECRETS_MODE_REPLACE')
all_secrets_arg_replace=""

# Defines the kind of operation related to PIN, PUK, SO-PIN, ... value
readonly ALL_SECRETS_MODE_INPUT="input"       # Just enter, no changes
readonly ALL_SECRETS_MODE_NEW="new"           # New (initial) value
readonly ALL_SECRETS_MODE_REPLACE="replace"   # Value gets replaced
all_secrets_mode=""

#-------------------------------------------------------------------------------
#  Other
#-------------------------------------------------------------------------------

#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#                    DONE: DEFINE YOUR GLOBAL VARIABLES HERE
#===============================================================================

#===============================================================================
#  GLOBAL CONSTANTS (TEMPLATE)
#===============================================================================
#-------------------------------------------------------------------------------
#  Lists of allowed actions <ARG_ACTION_...>
#-------------------------------------------------------------------------------
#  Used for auto-generating help's SYNOPSIS section and the main menu in
#  interactive mode. Please define a list of actions (separated by space) that
#  are allowed in interactive (also submenu) and/or script mode.
#  Use the variable's name but WITHOUT the <ARG_ACTION_> prefix,
#  e.g. for <ARG_ACTION_CUSTOM1> just use <CUSTOM1> in the list.
#-------------------------------------------------------------------------------
#                      DONE: DEFINE YOUR ACTION LISTS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
#  OpenSC (PKCS#11)
#  Interactive mode / Submenu mode
readonly ARG_ACTION_LIST_INTERACTIVE_OPENSC_P11="\
ALL_INITIALIZE ALL_KEYPAIRGEN ALL_IMPORT ALL_EXPORT ALL_DELETE ALL_LIST \
ALL_CHANGE_PIN ALL_RESET_PIN ALL_CHANGE_SO_PIN"
#  Classic script mode
readonly ARG_ACTION_LIST_SCRIPT_OPENSC_P11="\
HELP ALL_CHANGE_PIN ALL_CHANGE_SO_PIN ALL_CONNECT ALL_DELETE ALL_EXPORT \
ALL_GET ALL_IMPORT ALL_INITIALIZE ALL_KEYPAIRGEN ALL_LIST P11_GET_URI \
ALL_RESET_PIN"

#  OpenSC (PKCS#15)
#  Interactive mode / Submenu mode
readonly ARG_ACTION_LIST_INTERACTIVE_OPENSC_P15="\
OPENSC_P15_ERASE_CARD ALL_INITIALIZE OPENSC_P15_STORE_PIN OPENSC_P15_FINALIZE \
ALL_KEYPAIRGEN ALL_IMPORT ALL_EXPORT ALL_DELETE ALL_LIST ALL_CHANGE_PIN \
ALL_UNBLOCK_PIN ALL_CHANGE_PUK ALL_CHANGE_SO_PIN OPENSC_P15_ERASE_APPLICATION"
#  Classic script mode
readonly ARG_ACTION_LIST_SCRIPT_OPENSC_P15="\
HELP ALL_CHANGE_PIN ALL_CHANGE_PUK ALL_CHANGE_SO_PIN ALL_CONNECT ALL_DELETE \
OPENSC_P15_ERASE_APPLICATION OPENSC_P15_ERASE_CARD ALL_EXPORT \
OPENSC_P15_FINALIZE ALL_GET ALL_IMPORT ALL_INITIALIZE ALL_KEYPAIRGEN \
ALL_LIST OPENSC_P15_STORE_PIN ALL_UNBLOCK_PIN"

#  SmartCard-HSM / Nitrokey HSM 2
#  Interactive mode / Submenu mode
readonly ARG_ACTION_LIST_INTERACTIVE_SCHSM="\
ALL_INITIALIZE SCHSM_DKEK_SHARE_CREATE SCHSM_DKEK_SHARE_IMPORT ALL_KEYPAIRGEN \
ALL_IMPORT ALL_EXPORT ALL_DELETE ALL_LIST ALL_CHANGE_PIN ALL_RESET_PIN \
ALL_CHANGE_SO_PIN SCHSM_BACKUP SCHSM_RESTORE"
#  Classic script mode
readonly ARG_ACTION_LIST_SCRIPT_SCHSM="\
HELP ALL_CHANGE_PIN ALL_CHANGE_SO_PIN ALL_CONNECT ALL_DELETE ALL_EXPORT \
ALL_GET ALL_IMPORT ALL_INITIALIZE ALL_KEYPAIRGEN ALL_LIST P11_GET_URI \
ALL_RESET_PIN SCHSM_BACKUP SCHSM_DKEK_SHARE_CREATE SCHSM_DKEK_SHARE_IMPORT \
SCHSM_RESTORE"

#  Yubico YubiKey PIV
#  Interactive mode / Submenu mode
readonly ARG_ACTION_LIST_INTERACTIVE_YUBICO="\
ALL_INITIALIZE ALL_KEYPAIRGEN ALL_IMPORT ALL_EXPORT ALL_DELETE ALL_LIST \
ALL_CHANGE_PIN ALL_UNBLOCK_PIN ALL_CHANGE_PUK YUBICO_CHANGE_MANAGEMENT_KEY"
#  Classic script mode
readonly ARG_ACTION_LIST_SCRIPT_YUBICO="\
HELP YUBICO_CHANGE_MANAGEMENT_KEY ALL_CHANGE_PIN ALL_CHANGE_PUK ALL_CONNECT \
ALL_DELETE ALL_EXPORT ALL_GET ALL_IMPORT ALL_INITIALIZE ALL_KEYPAIRGEN \
ALL_LIST P11_GET_URI ALL_UNBLOCK_PIN"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                      DONE: DEFINE YOUR ACTION LISTS HERE
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#                    DONE: DEFINE YOUR PARAMETER LISTS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#  Lists of compatible parameters (script mode only)
#-------------------------------------------------------------------------------
#  Used for auto-generating help's SYNOPSIS section. Please define a list of
#  parameters (separated by space) that are allowed in script mode.
#  !!! Use the variable's name in capital letters,
#      e.g. for <arg_int> use <ARG_INT> !!!
#-------------------------------------------------------------------------------
#  OpenSC (PKCS#11)
readonly LIST_ARG_OPENSC_P11="\
ARG_ALL_DATA_APPLICATION_NAME ARG_ALL_DATA_OID ARG_ALL_FORMAT \
ARG_ALL_ID_OBJECT ARG_ALL_KEY_TYPE ARG_ALL_LABEL ARG_ALL_NEWPINPUK \
ARG_ALL_PASSWORD ARG_ALL_PIN ARG_ALL_PUK ARG_ALL_ID_READER ARG_ALL_SOPIN \
ARG_ALL_SOPUK ARG_ALL_TYPE"

#  OpenSC (PKCS#15)
readonly LIST_ARG_OPENSC_P15="\
ARG_ALL_DATA_APPLICATION_NAME ARG_ALL_DATA_OID ARG_ALL_FORMAT \
ARG_ALL_ID_OBJECT ARG_ALL_KEY_TYPE ARG_ALL_LABEL ARG_ALL_NEWPINPUK \
ARG_OPENSC_P15_PROFILE ARG_P15_ID_AID ARG_P15_ID_AUTH ARG_ALL_PASSWORD \
ARG_ALL_PIN ARG_ALL_PUK ARG_ALL_ID_READER ARG_ALL_SOPIN ARG_ALL_SOPUK \
ARG_ALL_TYPE"

#  SmartCard-HSM / Nitrokey HSM 2
readonly LIST_ARG_SCHSM="\
ARG_ALL_FORCE ARG_ALL_FORMAT ARG_ALL_ID_OBJECT ARG_ALL_KEY_TYPE ARG_ALL_LABEL \
ARG_ALL_NEWPINPUK ARG_ALL_PASSWORD ARG_ALL_PIN ARG_ALL_PUK ARG_ALL_ID_READER \
ARG_SCHSM_DKEK_SHARES ARG_SCHSM_KEY_REFERENCE ARG_SCHSM_PWD_SHARES_THRESHOLD \
ARG_SCHSM_PWD_SHARES_TOTAL ARG_ALL_SOPIN ARG_ALL_SOPUK ARG_ALL_TYPE"

#  Yubico YubiKey PIV
readonly LIST_ARG_YUBICO="\
ARG_ALL_FORCE ARG_ALL_FORMAT ARG_ALL_KEY_TYPE ARG_ALL_NEWPINPUK \
ARG_ALL_PASSWORD ARG_ALL_PIN ARG_PIV_BER_TLV_TAG ARG_PIV_KEYREF ARG_ALL_PUK \
ARG_ALL_SERIAL ARG_ALL_SOPIN ARG_ALL_SOPUK ARG_ALL_TYPE \
ARG_YUBICO_MANAGEMENT_KEY ARG_YUBICO_NEW_MANAGEMENT_KEY ARG_YUBICO_PIN_POLICY \
ARG_YUBICO_TOUCH_POLICY"

#-------------------------------------------------------------------------------
#  Lists of parameters to clear/reset (interactive mode only)
#-------------------------------------------------------------------------------
#  List of arguments that have to be cleared or reset to their default values
#  after running <run()> function (interactive mode only).
#  To assign a default value to a parameter please define a constant (above)
#  with the suffix '_DEFAULT', e.g. <ARG_STR_DEFAULT> for <arg_str>.
#  !!! Use the variable's name as defined, so usually lowercase letters !!!
#-------------------------------------------------------------------------------
#  Used by two or more token types
readonly LIST_ARG_CLEANUP_INTERACTIVE_ALL="                                 \
all_file_content                                                            \
                                                                            \
arg_all_file        arg_all_id_object   arg_all_key_type    arg_all_label   \
arg_all_newpinpuk   arg_all_password    arg_all_pin         arg_all_print   \
arg_all_print_separately                arg_all_puk         arg_all_random  \
arg_all_sopin       arg_all_sopuk       arg_all_type                        \
                                                                            \
arg_piv_ber_tlv_tag                     arg_piv_keyref"

#  OpenSC (PKCS#11)
readonly LIST_ARG_CLEANUP_INTERACTIVE_OPENSC_P11="\
${LIST_ARG_CLEANUP_INTERACTIVE_ALL}"

#  OpenSC (PKCS#15)
readonly LIST_ARG_CLEANUP_INTERACTIVE_OPENSC_P15="\
${LIST_ARG_CLEANUP_INTERACTIVE_ALL} arg_p15_id_auth"

#  SmartCard-HSM / Nitrokey HSM 2
readonly LIST_ARG_CLEANUP_INTERACTIVE_SCHSM="\
${LIST_ARG_CLEANUP_INTERACTIVE_ALL} arg_schsm_pwd_shares_threshold arg_schsm_pwd_shares_total"

#  Yubico YubiKey PIV
readonly LIST_ARG_CLEANUP_INTERACTIVE_YUBICO="\
${LIST_ARG_CLEANUP_INTERACTIVE_ALL} arg_yubico_management_key \
arg_yubico_new_management_key"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                    DONE: DEFINE YOUR PARAMETER LISTS HERE
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Custom language-specific strings <TXT_...>
#-------------------------------------------------------------------------------
#  Please do not set anything here, use '/src/lang/run.<ll>.lang.sh'
#  and <init_lang()> function (see below) instead.

#-------------------------------------------------------------------------------
#  OTHER
#-------------------------------------------------------------------------------
# Current language ID (ISO 639-1), see <init_lang()>
ID_LANG=""

# Number of running instances,
# used to check if this script was called recursively
INSTANCES=""

# Daemon mode sleep interval (in s), see <main_daemon()>
readonly T_DAEMON_SLEEP="60"

#===============================================================================
#  GLOBAL CONSTANTS (CUSTOM)
#===============================================================================
#                    DONE: DEFINE YOUR GLOBAL CONSTANTS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#  Script-independent
#-------------------------------------------------------------------------------
#  Regarding language strings (STR_L_...) please have a look at the
#  <init_lang()> function.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  PKCS#11-related
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  PKCS#15-related
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  "FIPS 201 (PIV Card)"-related
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Used by two or more token types
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  OpenSC (PKCS#11)
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  OpenSC (PKCS#15)
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  SmartCard-HSM / Nitrokey HSM 2
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Yubico YubiKey PIV
#-------------------------------------------------------------------------------
# See https://docs.yubico.com/yesdk/users-manual/application-piv/pin-puk-mgmt-key.html
readonly YUBICO_FACTORY_PIN="123456"
readonly YUBICO_FACTORY_PUK="12345678"
readonly YUBICO_FACTORY_MANAGEMENT_KEY="010203040506070801020304050607080102030405060708"

#-------------------------------------------------------------------------------
#  Other
#-------------------------------------------------------------------------------
# libccid (PC/SC driver for USB CCID smart card readers)
readonly FILE_SO_LIBCCIDTWIN="libccidtwin.so"

# Default timeout (in s) to wait for a smartcard/token to be connected
readonly T_WAIT="10"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                    DONE: DEFINE YOUR GLOBAL CONSTANTS HERE
#-------------------------------------------------------------------------------

#===============================================================================
#  FUNCTIONS (TEMPLATE)
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  args_check
#  DESCRIPTION:  Check if passed arguments are valid
#         TODO:  Not all checks are implemented yet, see 'true && \' lines.
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  All arguments are valid
#            1:  At least one argument is not valid
#===============================================================================
args_check() {
  #=============================================================================
  #  DO NOT EDIT
  #=============================================================================
  # Check if selected action is compatible with the selected mode
  ARG_ACTION_LIST_INTERACTIVE="$(lib_core_str_to --const "ARG_ACTION_LIST_INTERACTIVE_${arg_token_type}")"
  eval "readonly ARG_ACTION_LIST_INTERACTIVE=\${${ARG_ACTION_LIST_INTERACTIVE}}"
  ARG_ACTION_LIST_SCRIPT="$(lib_core_str_to --const "ARG_ACTION_LIST_SCRIPT_${arg_token_type}")"
  eval "readonly ARG_ACTION_LIST_SCRIPT=\${${ARG_ACTION_LIST_SCRIPT}}"

  lib_shtpl_arg_action_is_valid                                             && \

  #=============================================================================
  #                        TODO: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #=============================================================================

  #=============================================================================
  #  Check if mandatory arguments are set (daemon / script mode only)
  #=============================================================================
  #  Some arguments may not be listed here as <init_update()> may set their
  #  default values.
  #=============================================================================
  if    [ "${arg_action}" != "${ARG_ACTION_HELP}" ] && \
        [ "${arg_mode}" = "${ARG_MODE_DAEMON}" ]; then
    #===========================================================================
    #  Daemon mode
    #===========================================================================
    true

  elif  [ "${arg_action}" != "${ARG_ACTION_HELP}" ] && \
        [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE_SUBMENU}" ]; then
    #===========================================================================
    #  Submenu mode
    #===========================================================================
    lib_shtpl_arg_is_set "arg_token_type"

  elif  [ "${arg_action}" != "${ARG_ACTION_HELP}" ] && \
        [ "${arg_mode}" = "${ARG_MODE_SCRIPT}" ]; then
    #===========================================================================
    #  Script mode (token-/action-independent checks)
    #===========================================================================
    lib_shtpl_arg_is_set "arg_token_type" "arg_all_force" "arg_all_print" "arg_all_print_separately" "arg_all_random" && \

    #===========================================================================
    #  Script mode (checks that are specific to script mode)
    #===========================================================================
    case "${arg_action}" in
      #-------------------------------------------------------------------------
      #  PKCS#11-related
      #-------------------------------------------------------------------------
      ${ARG_ACTION_P11_GET_URI}) lib_shtpl_arg_is_set "arg_p11_uri_filter";;

      #-------------------------------------------------------------------------
      #  PKCS#15-related
      #-------------------------------------------------------------------------

      #-------------------------------------------------------------------------
      #  "FIPS 201 (PIV Card)"-related
      #-------------------------------------------------------------------------

      #-------------------------------------------------------------------------
      #  Used by two or more token types
      #-------------------------------------------------------------------------
      ${ARG_ACTION_ALL_GET}) lib_shtpl_arg_is_set "arg_all_get";;

      #-------------------------------------------------------------------------
      #  OpenSC (PKCS#11)
      #-------------------------------------------------------------------------

      #-------------------------------------------------------------------------
      #  OpenSC (PKCS#15)
      #-------------------------------------------------------------------------

      #-------------------------------------------------------------------------
      #  SmartCard-HSM / Nitrokey HSM 2
      #-------------------------------------------------------------------------

      #-------------------------------------------------------------------------
      #  Yubico YubiKey PIV
      #-------------------------------------------------------------------------
    esac                                                                    && \

    #===========================================================================
    #  Script mode (checks that are also relevant to interactive mode)
    #===========================================================================
    #  The following checks mostly follow <menu_main()>'s structure.
    #===========================================================================
    #---------------------------------------------------------------------------
    #  Select an object class / list type
    #---------------------------------------------------------------------------
    case "${arg_action}" in
      ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_ALL_LIST})
        lib_shtpl_arg_is_set "arg_all_type"
        ;;
    esac                                                                    && \

    #---------------------------------------------------------------------------
    #  Token-specific parameters (1)
    #---------------------------------------------------------------------------
    case "${arg_token_type}" in
      ${ARG_TOKEN_TYPE_OPENSC_P11})
        #-----------------------------------------------------------------------
        #  OpenSC (PKCS#11)
        #-----------------------------------------------------------------------
        ;;

      ${ARG_TOKEN_TYPE_OPENSC_P15})
        #-----------------------------------------------------------------------
        #  OpenSC (PKCS#15)
        #-----------------------------------------------------------------------
        case "${arg_action}" in
          ${ARG_ACTION_OPENSC_P15_ERASE_APPLICATION})
            lib_shtpl_arg_is_set "arg_p15_id_aid"
            ;;
          ${ARG_ACTION_ALL_INITIALIZE})
            lib_shtpl_arg_is_set "arg_opensc_p15_profile"
            ;;
        esac
        ;;

      ${ARG_TOKEN_TYPE_SCHSM})
        #-----------------------------------------------------------------------
        #  SmartCard-HSM / Nitrokey HSM 2
        #-----------------------------------------------------------------------
        ;;

      ${ARG_TOKEN_TYPE_YUBICO})
        #-----------------------------------------------------------------------
        #  Yubico YubiKey PIV
        #-----------------------------------------------------------------------
        case "${arg_action}" in
          ${ARG_ACTION_ALL_INITIALIZE}|\
          ${ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY})
            lib_shtpl_arg_is_set "arg_all_key_type"
            ;;
        esac
        ;;
    esac                                                                    && \

    #---------------------------------------------------------------------------
    #  Initialization mode
    #---------------------------------------------------------------------------
    case "${arg_action}" in
      ${ARG_ACTION_ALL_INITIALIZE})
        case "${arg_token_type}" in
          ${ARG_TOKEN_TYPE_OPENSC_P11}) lib_shtpl_arg_is_set "arg_all_label";;
        esac
        ;;
    esac                                                                    && \

    #---------------------------------------------------------------------------
    #  Specify cert/key/data object/... via its
    #  id/label/oid/application name/keyref
    #---------------------------------------------------------------------------
    case "${arg_action}" in
      ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_IMPORT})
        #-----------------------------------------------------------------------
        #  <arg_action> = <ARG_ACTION_ALL_DELETE|ARG_ACTION_ALL_EXPORT|ARG_ACTION_ALL_IMPORT>
        #-----------------------------------------------------------------------
        case "${arg_all_type}" in
          ${ARG_ALL_TYPE_DATA})
            #-------------------------------------------------------------------
            #  <arg_all_type> = <ARG_ALL_TYPE_DATA>
            #-------------------------------------------------------------------
            case "${arg_token_type}" in
              ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_OPENSC_P15}|${ARG_TOKEN_TYPE_SCHSM})
                #---------------------------------------------------------------
                #  OpenSC (PKCS#11) + OpenSC (PKCS#15) + SmartCard-HSM / Nitrokey HSM 2
                #---------------------------------------------------------------
                case "${arg_action}" in
                  ${ARG_ACTION_ALL_DELETE})
                    if lib_core_is --empty "${arg_all_data_oid}"; then
                      if ! lib_shtpl_arg_is_set "arg_all_data_application_name" "arg_all_label"; then
                        lib_shtpl_arg_error "arg_all_data_oid"
                      fi
                    fi
                    ;;
                  ${ARG_ACTION_ALL_EXPORT})
                    if lib_core_is --empty "${arg_all_label}" "${arg_all_data_oid}" "${arg_all_data_application_name}"; then
                      lib_shtpl_arg_error "arg_all_label"
                      lib_shtpl_arg_error "arg_all_data_oid"
                      lib_shtpl_arg_error "arg_all_data_application_name"
                    fi
                    ;;
                  ${ARG_ACTION_ALL_IMPORT})
                    ;;
                esac
                ;;
              ${ARG_TOKEN_TYPE_YUBICO})
                #---------------------------------------------------------------
                #  Yubico YubiKey PIV
                #---------------------------------------------------------------
                case "${arg_action}" in
                  ${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_IMPORT})
                    lib_shtpl_arg_is_set "arg_piv_ber_tlv_tag"
                    ;;
                esac
                ;;
            esac
            ;;
          *)
            #-------------------------------------------------------------------
            #  <arg_all_type> != <ARG_ALL_TYPE_DATA>
            #-------------------------------------------------------------------
            case "${arg_token_type}" in
              ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
                #---------------------------------------------------------------
                #  OpenSC (PKCS#11) + SmartCard-HSM / Nitrokey HSM 2
                #---------------------------------------------------------------
                if lib_core_is --empty "${arg_all_id_object}" "${arg_all_label}"; then
                  lib_shtpl_arg_error "arg_all_id_object"
                  lib_shtpl_arg_error "arg_all_label"
                fi
                ;;
              ${ARG_TOKEN_TYPE_OPENSC_P15})
                #---------------------------------------------------------------
                #  OpenSC (PKCS#15)
                #---------------------------------------------------------------
                case "${arg_action}" in
                  ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_EXPORT})
                    lib_shtpl_arg_is_set "arg_all_id_object"
                    ;;
                esac
                ;;
              ${ARG_TOKEN_TYPE_YUBICO})
                #---------------------------------------------------------------
                #  Yubico YubiKey PIV
                #---------------------------------------------------------------
                lib_shtpl_arg_is_set "arg_piv_keyref"
                ;;
            esac
            ;;
        esac
        ;;
      ${ARG_ACTION_ALL_KEYPAIRGEN})
        #-----------------------------------------------------------------------
        #  <arg_action> = <ARG_ACTION_ALL_KEYPAIRGEN>
        #-----------------------------------------------------------------------
        case "${arg_token_type}" in
          ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_OPENSC_P15}|${ARG_TOKEN_TYPE_SCHSM})
            #-------------------------------------------------------------------
            #  OpenSC (PKCS#11) +  OpenSC (PKCS#15) + SmartCard-HSM / Nitrokey HSM 2
            #-------------------------------------------------------------------
            if lib_core_is --empty "${arg_all_id_object}" "${arg_all_label}"; then
              lib_shtpl_arg_error "arg_all_id_object"
              lib_shtpl_arg_error "arg_all_label"
            fi
            ;;
          ${ARG_TOKEN_TYPE_YUBICO})
            #-------------------------------------------------------------------
            #  Yubico YubiKey PIV
            #-------------------------------------------------------------------
            lib_shtpl_arg_is_set "arg_piv_keyref"
            ;;
        esac
        ;;
    esac                                                                    && \

    #---------------------------------------------------------------------------
    #  All modes that read/write from/to a file
    #---------------------------------------------------------------------------
    case "${arg_action}" in
      ${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_IMPORT}|\
      ${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE}|${ARG_ACTION_SCHSM_BACKUP}|\
      ${ARG_ACTION_SCHSM_RESTORE}|${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})
        lib_shtpl_arg_is_set "arg_all_file"
        ;;
    esac                                                                    && \

    #---------------------------------------------------------------------------
    #  All modes that create a key pair
    #---------------------------------------------------------------------------
    case "${arg_action}" in
      ${ARG_ACTION_ALL_KEYPAIRGEN})
        lib_shtpl_arg_is_set "arg_all_key_type"
        ;;
    esac                                                                    && \

    #---------------------------------------------------------------------------
    #  Token-specific parameters (2)
    #---------------------------------------------------------------------------
    case "${arg_token_type}" in
      ${ARG_TOKEN_TYPE_OPENSC_P11})
        #-----------------------------------------------------------------------
        #  OpenSC (PKCS#11)
        #-----------------------------------------------------------------------
        ;;

      ${ARG_TOKEN_TYPE_OPENSC_P15})
        #-----------------------------------------------------------------------
        #  OpenSC (PKCS#15)
        #-----------------------------------------------------------------------
        ;;

      ${ARG_TOKEN_TYPE_SCHSM})
        #-----------------------------------------------------------------------
        #  SmartCard-HSM / Nitrokey HSM 2
        #-----------------------------------------------------------------------
        case "${arg_action}" in
          ${ARG_ACTION_SCHSM_BACKUP}|${ARG_ACTION_SCHSM_RESTORE})
            lib_shtpl_arg_is_set "arg_schsm_key_reference"
            ;;
        esac
        ;;

      ${ARG_TOKEN_TYPE_YUBICO})
        #-----------------------------------------------------------------------
        #  Yubico YubiKey PIV
        #-----------------------------------------------------------------------
        case "${arg_action}" in
          ${ARG_ACTION_ALL_EXPORT})
            case "${arg_all_type}" in
              ${ARG_ALL_TYPE_CERT}|${ARG_ALL_TYPE_PUBKEY})
                lib_shtpl_arg_is_set "arg_all_format"
                ;;
            esac
            ;;
          ${ARG_ACTION_ALL_KEYPAIRGEN})
            lib_shtpl_arg_is_set "arg_all_format"
            ;;
        esac                                                                && \

        case "${arg_action}" in
          ${ARG_ACTION_ALL_IMPORT})
            case "${arg_all_type}" in
              ${ARG_ALL_TYPE_PRIVKEY})
                lib_shtpl_arg_is_set "arg_yubico_pin_policy" "arg_yubico_touch_policy"
                ;;
            esac
            ;;
          ${ARG_ACTION_ALL_KEYPAIRGEN})
            lib_shtpl_arg_is_set "arg_all_file" "arg_yubico_pin_policy" "arg_yubico_touch_policy"
            ;;
        esac
        ;;
    esac
  fi                                                                        && \

  #=============================================================================
  #  Check argument types / value ranges
  #=============================================================================
  #  For more available checks, please have a look at the functions
  #  <lib_core_is()> and <lib_core_regex()> in '/lib/SHlib/lib/core.lib.sh'
  #=============================================================================
  local list                                                                && \
  local var                                                                 && \

  #=============================================================================
  #  Token type
  #=============================================================================
  #-----------------------------------------------------------------------------
  #  arg_token_type
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_token_type}"; then
    lib_core_list_contains_str_ptr \
      "${arg_token_type}" "${ARG_TOKEN_TYPE_LIST}" " " "ARG_TOKEN_TYPE_" || \
    lib_shtpl_arg_error "arg_token_type"
  fi                                                                        && \

  #=============================================================================
  #  PKCS#11-related
  #=============================================================================
  #-----------------------------------------------------------------------------
  #  arg_p11_uri_filter
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_p11_uri_filter}"; then
    lib_core_list_contains_str_ptr "${arg_p11_uri_filter}"    \
      "${ARG_P11_URI_FILTER_LIST}" " " "ARG_P11_URI_FILTER_"  || \
    lib_shtpl_arg_error "arg_p11_uri_filter" "ARG_ACTION_P11_GET_URI"
  fi                                                                        && \

  #=============================================================================
  #  PKCS#15-related
  #=============================================================================
  #-----------------------------------------------------------------------------
  #  arg_p15_id_aid
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_p15_id_aid}"; then
    lib_core_is --hex "${arg_p15_id_aid}" || \
    lib_shtpl_arg_error "arg_p15_id_aid"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_p15_id_auth
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_p15_id_auth}"; then
    lib_core_is --hex "${arg_p15_id_auth}" || \
    lib_shtpl_arg_error "arg_p15_id_auth"
  fi                                                                        && \

  #=============================================================================
  #  "FIPS 201 (PIV Card)"-related
  #=============================================================================
  #-----------------------------------------------------------------------------
  #  arg_piv_ber_tlv_tag
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_piv_ber_tlv_tag}"; then
    lib_core_list_contains_str \
      "${arg_piv_ber_tlv_tag}" "${ARG_PIV_BER_TLV_TAG_LIST}" || \
    lib_shtpl_arg_error "arg_piv_ber_tlv_tag"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_piv_keyref
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_piv_keyref}"; then
    lib_core_list_contains_str \
      "${arg_piv_keyref}" "${ARG_PIV_KEYREF_LIST}" || \
    lib_shtpl_arg_error "arg_piv_keyref"
  fi                                                                        && \

  #=============================================================================
  #  Used by two or more token types
  #=============================================================================
  #-----------------------------------------------------------------------------
  #  arg_all_data_application_name
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_all_data_oid
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_all_data_oid}"; then
    lib_core_is --oid "${arg_all_data_oid}" || \
    lib_shtpl_arg_error "arg_all_data_oid"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_all_file
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_all_file}"; then
    case "${arg_action}" in
      ${ARG_ACTION_SCHSM_BACKUP}|${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE}|\
      ${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_KEYPAIRGEN})
        touch -c "${arg_all_file}" 2>/dev/null && \
        ! lib_core_is --file "${arg_all_file}"

        ;;
      ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_SCHSM_RESTORE}|\
      ${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})
        lib_core_is --file "${arg_all_file}"
        ;;
    esac || \
    { var="$(lib_core_str_to --const "ARG_ACTION_${arg_action}")"
      if lib_core_var_is --unset "${var}"; then
        var="$(lib_core_str_to --const "ARG_ACTION_ALL_${arg_action}")"
      fi
      lib_shtpl_arg_error "arg_all_file" "${var}"
    }
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_all_force
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_all_force}"; then
    lib_core_is --bool "${arg_all_force}" || \
    lib_shtpl_arg_error "arg_all_force"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_all_format
  #-----------------------------------------------------------------------------
  { # Get specific list
    list="$(lib_core_str_to --const \
      "ARG_ALL_FORMAT_LIST_${arg_token_type}_${arg_action}_${arg_all_type}")"
    eval "list=\${${list}}"

    # In case specific list does not exist
    if lib_core_is --empty "${list}"; then
      list="$(lib_core_str_to --const \
        "ARG_ALL_FORMAT_LIST_${arg_token_type}_${arg_action}")"
      eval "list=\${${list}}"
      if lib_core_is --empty "${list}"; then
        list="$(lib_core_str_to --const \
          "ARG_ALL_FORMAT_LIST_ALL_${arg_action}")"
        eval "list=\${${list}}"
        if lib_core_is --empty "${list}"; then
          list="${ARG_ALL_FORMAT_LIST}"
        fi
      fi
    fi

    lib_core_list_contains_str_ptr \
      "${arg_all_format}" "${list}" " " "ARG_ALL_FORMAT_" || \
    lib_shtpl_arg_error "arg_all_format"
  }                                                                         && \

  #-----------------------------------------------------------------------------
  #  arg_all_get
  #-----------------------------------------------------------------------------
  { # Get specific list
    list="$(lib_core_str_to --const "ARG_ALL_GET_LIST_${arg_token_type}")"
    eval "list=\${${list}}"

    # In case specific list does not exist
    if lib_core_is --empty "${list}"; then
      list="${ARG_ALL_GET_LIST}"
    fi

    lib_core_list_contains_str_ptr \
      "${arg_all_get}" "${list}" " " "ARG_ALL_GET_" || \
    lib_shtpl_arg_error "arg_all_get" "ARG_ACTION_ALL_GET"
  }                                                                         && \

  #-----------------------------------------------------------------------------
  #  arg_all_id_object
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_all_id_object}"; then
    lib_core_is --int-pos0 "${arg_all_id_object}" || \
    lib_shtpl_arg_error "arg_all_id_object"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_all_id_reader
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_all_id_reader}"; then
    lib_core_regex --int-pos0 "${arg_all_id_reader}" || \
    lib_shtpl_arg_error "arg_all_id_reader"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_all_key_type
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_all_label
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_all_newpinpuk
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_all_password
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_all_pin
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_all_print
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_all_print}"; then
    lib_core_is --bool "${arg_all_print}" || \
    lib_shtpl_arg_error "arg_all_print"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_all_print_separately
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_all_print_separately}"; then
    lib_core_is --bool "${arg_all_print_separately}" || \
    lib_shtpl_arg_error "arg_all_print_separately"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_all_puk
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_all_random
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_all_print}"; then
    lib_core_is --bool "${arg_all_random}" || \
    lib_shtpl_arg_error "arg_all_random"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_all_serial
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_all_sopin
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_all_sopuk
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_all_type
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_all_type}"; then
    # Get specific list
    list="$(lib_core_str_to --const \
      "ARG_ALL_TYPE_LIST_${arg_token_type}_${arg_action}")"
    eval "list=\${${list}}"

    # In case specific list does not exist
    if lib_core_is --empty "${list}"; then
      list="$(lib_core_str_to --const "ARG_ALL_TYPE_LIST_ALL_${arg_action}")"
      eval "list=\${${list}}"
      if lib_core_is --empty "${list}"; then
        list="${ARG_ALL_TYPE_LIST}"
      fi
    fi

    lib_core_list_contains_str_ptr \
      "${arg_all_type}" "${list}" " " "ARG_ALL_TYPE_" || \
    lib_shtpl_arg_error "arg_all_type"
  fi                                                                        && \

  #=============================================================================
  #  OpenSC (PKCS#15)
  #=============================================================================
  #-----------------------------------------------------------------------------
  #  arg_opensc_p15_profile
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_opensc_p15_profile}"; then
    lib_core_is --not-empty "${arg_opensc_p15_profile}" || \
    lib_shtpl_arg_error "arg_opensc_p15_profile"
  fi                                                                        && \

  #=============================================================================
  #  SmartCard-HSM / Nitrokey HSM 2
  #=============================================================================
  #-----------------------------------------------------------------------------
  #  arg_schsm_dkek_shares
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_schsm_dkek_shares}"; then
    lib_math_is_within_range "${ARG_SCHSM_DKEK_SHARES_MIN}" \
      "${arg_schsm_dkek_shares}" "${ARG_SCHSM_DKEK_SHARES_MAX}" || \
    lib_shtpl_arg_error "arg_schsm_dkek_shares"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_schsm_key_reference
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_schsm_key_reference}"; then
    lib_core_is --int-pos "${arg_schsm_key_reference}" || \
    lib_shtpl_arg_error "arg_schsm_key_reference"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_schsm_pwd_shares_threshold
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_schsm_pwd_shares_threshold}"; then
    lib_math_is_within_range "${ARG_SCHSM_PWD_SHARES_THRESHOLD_MIN}" \
      "${arg_schsm_pwd_shares_threshold}" "" || \
    lib_shtpl_arg_error "arg_schsm_pwd_shares_threshold"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_schsm_pwd_shares_total
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_schsm_pwd_shares_total}"; then
    lib_math_is_within_range "${ARG_SCHSM_PWD_SHARES_TOTAL_MIN}" \
      "${arg_schsm_pwd_shares_total}" "${ARG_SCHSM_PWD_SHARES_TOTAL_MAX}" || \
    lib_shtpl_arg_error "arg_schsm_pwd_shares_total"
  fi                                                                        && \

  #=============================================================================
  #  Yubico YubiKey PIV
  #=============================================================================
  #-----------------------------------------------------------------------------
  #  arg_yubico_management_key
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_yubico_new_management_key
  #-----------------------------------------------------------------------------
  true                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_yubico_pin_policy
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_yubico_pin_policy}"; then
    lib_core_list_contains_str_ptr "${arg_yubico_pin_policy}" \
      "${ARG_YUBICO_PIN_POLICY_LIST}" " " "ARG_YUBICO_PIN_POLICY_" || \
    lib_shtpl_arg_error "arg_yubico_pin_policy"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_yubico_touch_policy
  #-----------------------------------------------------------------------------
  if lib_core_is --not-empty "${arg_yubico_touch_policy}"; then
    lib_core_list_contains_str_ptr "${arg_yubico_touch_policy}" \
      "${ARG_YUBICO_TOUCH_POLICY_LIST}" " " "ARG_YUBICO_TOUCH_POLICY_" || \
    lib_shtpl_arg_error "arg_yubico_touch_policy"
  fi                                                                        || \

  #=============================================================================
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        TODO: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #=============================================================================
  { error "${TXT_ARGS_CHECK_ERR}"
    return 1
  }
}

#===  FUNCTION  ================================================================
#         NAME:  args_read
#  DESCRIPTION:  Read passed arguments into global parameters/variables
#
#      GLOBALS:  arg_action  arg_logdest  arg_mode
#
#                arg_schsm_dkek_shares      arg_all_file             arg_all_get
#                arg_p11_uri_filter       arg_all_id_object               arg_interactive
#                arg_schsm_key_reference    arg_all_key_type         arg_all_label
#                             arg_token_type
#                arg_schsm_pwd_shares_threshold                  arg_schsm_pwd_shares_total
#                arg_all_id_reader
#
# PARAMETER  1:  Should be "$@" to get all arguments passed
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  All arguments were successfully parsed
#            1:  At least one argument could not be parsed
#===============================================================================
args_read() {
  #-----------------------------------------------------------------------------
  #  No arguments => Run script interactively
  #-----------------------------------------------------------------------------
  if [ $# -eq 0 ]; then
    arg_mode="${ARG_MODE_INTERACTIVE}"
    return
  fi

  #-----------------------------------------------------------------------------
  #  Arguments defined => Run script in script mode
  #-----------------------------------------------------------------------------
  local arg_current
  while [ $# -gt 0 ]; do
    arg_current="$1"
    case "$1" in
      #-------------------------------------------------------------------------
      #  PARAMETER (TEMPLATE)
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>
      -h|--help) arg_action="${ARG_ACTION_HELP}"; break;;

      #  Script operation modes <ARG_MODE_...>
      --submenu)
        # Possibility to run a certain submenu interactively
        arg_mode="${ARG_MODE_INTERACTIVE_SUBMENU}"
        arg_action="$2"; [ $# -ge 1 ] && { shift; }
        ;;

      #-------------------------------------------------------------------------
      #  PARAMETER (CUSTOM)
      #-------------------------------------------------------------------------
      #                 DONE: DEFINE YOUR ARGUMENT PARSING HERE
      #
      #                                   |||
      #                                  \|||/
      #                                   \|/
      #-------------------------------------------------------------------------
      #-------------------------------------------------------------------------
      #  Token type
      #-------------------------------------------------------------------------
      -T|--token-type)   arg_token_type="$2"; [ $# -ge 1 ] && { shift; };;

      #-------------------------------------------------------------------------
      #  PKCS#11-related
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>
      --${ARG_ACTION_P11_GET_URI})
        arg_action="${1#--}"
        arg_p11_uri_filter="$2"; [ $# -ge 1 ] && { shift; }
        ;;

      #  Parameter

      #-------------------------------------------------------------------------
      #  PKCS#15-related
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>

      #  Parameter
      --p15-aid)        arg_p15_id_aid="$2"; [ $# -ge 1 ] && { shift; };;
      --p15-auth-id)    arg_p15_id_auth="$2"; [ $# -ge 1 ] && { shift; };;

      #-------------------------------------------------------------------------
      #  "FIPS 201 (PIV Card)"-related
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>

      #  Parameter
      --piv-id-object|--piv-id)   arg_piv_ber_tlv_tag="$2"; [ $# -ge 1 ] && { shift; };;
      --piv-id-slot|--piv-slot)   arg_piv_keyref="$2"; [ $# -ge 1 ] && { shift; };;

      #-------------------------------------------------------------------------
      #  Used by two or more token types
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>
      --${ARG_ACTION_ALL_CHANGE_PIN}|--${ARG_ACTION_ALL_CHANGE_PUK}|\
      --${ARG_ACTION_ALL_CHANGE_SO_PIN}|--${ARG_ACTION_ALL_CONNECT}|\
      --${ARG_ACTION_ALL_DELETE}|--${ARG_ACTION_ALL_INITIALIZE}|\
      --${ARG_ACTION_ALL_RESET_PIN}|--${ARG_ACTION_ALL_UNBLOCK_PIN})
        arg_action="${1#--}"
        ;;

      --${ARG_ACTION_ALL_EXPORT}|--${ARG_ACTION_ALL_IMPORT})
        arg_action="${1#--}"
        arg_all_file="$(lib_core_expand_tilde "$2")"
        [ $# -ge 1 ] && { shift; }
        ;;

      --${ARG_ACTION_ALL_KEYPAIRGEN})
        arg_action="${1#--}"

        # Parameter's value is optional
        case "$2" in
          -*)
            # Next argument is a parameter
            ;;
          *)
            # Next argument can(!) be a value
            arg_all_file="$(lib_core_expand_tilde "$2")"
            # Only shift in case parameter has a value
            if [ $# -ge 2 ]; then shift; fi
            ;;
        esac
        ;;

      --${ARG_ACTION_ALL_GET})
        arg_action="${1#--}"
        arg_all_get="$2"; [ $# -ge 1 ] && { shift; }
        ;;
      --${ARG_ACTION_ALL_LIST})
        arg_action="${1#--}"
        arg_all_type="$2"; [ $# -ge 1 ] && { shift; }
        ;;

      # Parameter
      --data-application-name)
        arg_all_data_application_name="$2"; [ $# -ge 1 ] && { shift; };;
      --data-oid)               arg_all_data_oid="$2"; [ $# -ge 1 ] && { shift; };;
      -F|--force)               arg_all_force="true";;
      -f|--format)              arg_all_format="$2"; [ $# -ge 1 ] && { shift; };;
      -i|--id|--id-object)      arg_all_id_object="$2"; [ $# -ge 1 ] && { shift; };;
      -r|--reader|--id-reader)  arg_all_id_reader="$2"; [ $# -ge 1 ] && { shift; };;
      --serial)                 arg_all_serial="$2"; [ $# -ge 1 ] && { shift; };;
      --key-type)               arg_all_key_type="$2"; [ $# -ge 1 ] && { shift; };;
      -l|--label)               arg_all_label="$2"; [ $# -ge 1 ] && { shift; };;
      #--print)                  arg_all_print="true"; arg_all_print_separately="false";;
      #--print-separately)       arg_all_print="true"; arg_all_print_separately="true" ;;
      #--random)                 arg_all_random="true";;
      -n|--new-pin|--new-puk|--new-so-pin)
        arg_all_newpinpuk="$(lib_core_parse_credentials "$2")" && [ $# -ge 1 ] && { shift; };;
      --password)   arg_all_password="$(lib_core_parse_credentials "$2")" && [ $# -ge 1 ] && { shift; };;
      -p|--pin)     arg_all_pin="$(lib_core_parse_credentials "$2")" && [ $# -ge 1 ] && { shift; };;
      -P|--puk)     arg_all_puk="$(lib_core_parse_credentials "$2")" && [ $# -ge 1 ] && { shift; };;
      -s|--so-pin)  arg_all_sopin="$(lib_core_parse_credentials "$2")" && [ $# -ge 1 ] && { shift; };;
      -S|--so-puk)  arg_all_sopuk="$(lib_core_parse_credentials "$2")" && [ $# -ge 1 ] && { shift; };;
      -t|--type)    arg_all_type="$2"; [ $# -ge 1 ] && { shift; };;

      #-------------------------------------------------------------------------
      #  OpenSC (PKCS#11)
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>

      #  Parameter

      #-------------------------------------------------------------------------
      #  OpenSC (PKCS#15)
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>
      --${ARG_ACTION_OPENSC_P15_ERASE_APPLICATION})
        arg_action="${1#--}"
        arg_p15_id_aid="$2"; [ $# -ge 1 ] && { shift; }
        ;;

      --${ARG_ACTION_OPENSC_P15_ERASE_CARD}|\
      --${ARG_ACTION_OPENSC_P15_FINALIZE}|--${ARG_ACTION_OPENSC_P15_STORE_PIN})
        arg_action="${1#--}"
        ;;

      #  Parameter
      --opensc-p15-profile) arg_opensc_p15_profile="$2"; [ $# -ge 1 ] && { shift; };;

      #-------------------------------------------------------------------------
      #  SmartCard-HSM / Nitrokey HSM 2
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>
      --${ARG_ACTION_SCHSM_BACKUP}|--${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE}|\
      --${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT}|--${ARG_ACTION_SCHSM_RESTORE})
        arg_action="${1#--}"
        arg_all_file="$(lib_core_expand_tilde "$2")"
        [ $# -ge 1 ] && { shift; }
        ;;

      #  Parameter
      --schsm-dkek-shares)          arg_schsm_dkek_shares="$2"; [ $# -ge 1 ] && { shift; };;
      --schsm-key-reference)        arg_schsm_key_reference="$2"; [ $# -ge 1 ] && { shift; };;
      --schsm-pwd-shares-threshold) arg_schsm_pwd_shares_threshold="$2"; [ $# -ge 1 ] && { shift; };;
      --schsm-pwd-shares-total)     arg_schsm_pwd_shares_total="$2"; [ $# -ge 1 ] && { shift; };;

      #-------------------------------------------------------------------------
      #  Yubico YubiKey PIV
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>
      --${ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY})
        arg_action="${1#--}"
        ;;

      #  Parameter
      --yubico-management-key)      arg_yubico_management_key="$(lib_core_parse_credentials "$2")" && [ $# -ge 1 ] && { shift; };;
      --yubico-new-management-key)  arg_yubico_new_management_key="$(lib_core_parse_credentials "$2")" && [ $# -ge 1 ] && { shift; };;
      --yubico-pin-policy)          arg_yubico_pin_policy="$2"; [ $# -ge 1 ] && { shift; };;
      --yubico-touch-policy)        arg_yubico_touch_policy="$2"; [ $# -ge 1 ] && { shift; };;
      #-------------------------------------------------------------------------
      #                                   /|\
      #                                  /|||\
      #                                   |||
      #
      #                 DONE: DEFINE YOUR ARGUMENT PARSING HERE
      #-------------------------------------------------------------------------

      #-------------------------------------------------------------------------
      #  Last or undefined parameter
      #-------------------------------------------------------------------------
      *)
        #-----------------------------------------------------------------------
        #            DONE: DEFINE YOUR (LAST) ARGUMENT PARSING HERE
        #        PLEASE DO NOT FORGET TO DEFINE <L_RUN_HLP_PAR_LASTARG>
        #               IN '/src/lang/run.0.lang.sh' ACCORDINGLY.
        #
        #                                 |||
        #                                \|||/
        #                                 \|/
        #-----------------------------------------------------------------------
        if [ $# -eq 1 ]; then
          #  Only one argument left
          local lastarg="$(lib_core_expand_tilde "$1")"

          #  There is no optional last argument
          #  Ignore unknown argument and continue ('true')
          #  or exit program ('false')?
          false
        else
          #  More than one argument left
          #
          #  Ignore wrong argument and continue with next one ('true')
          #  or exit program ('false')?
          false
        fi
        #-----------------------------------------------------------------------
        #                                 /|\
        #                                /|||\
        #                                 |||
        #
        #            DONE: DEFINE YOUR (LAST) ARGUMENT PARSING HERE
        #        PLEASE DO NOT FORGET TO DEFINE <L_RUN_HLP_PAR_LASTARG>
        #               IN '/src/lang/run.0.lang.sh' ACCORDINGLY.
        #-----------------------------------------------------------------------
        ;;
    esac                                                  && \
    [ $# -gt 0 ]                                          && \
    shift                                                 || \
    { error "<${arg_current}> ${TXT_ARGS_READ_ERR}"
      return 1
    }
  done
}

#===  FUNCTION  ================================================================
#         NAME:  cleanup_interactive
#  DESCRIPTION:  Cleanup, executed each cycle after <run()>
#                (interactive mode only)
#===============================================================================
cleanup_interactive() {
  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  #  Reset arguments to their default values
  local list
  list="$(lib_core_str_to --const "LIST_ARG_CLEANUP_INTERACTIVE_${arg_token_type}")"
  eval "list=\${${list}}"

  # In case specific list does not exist
  list="${list:-${LIST_ARG_CLEANUP_INTERACTIVE_ALL}}"

  local arg
  local val
  for arg in ${list}; do
    val="$(lib_core_str_to --const "${arg}_DEFAULT_${arg_token_type}")"
    eval "val=\${${val}}"
    if lib_core_is --empty "${val}"; then
      val="$(lib_core_str_to --const "${arg}_DEFAULT_ALL")"
      eval "val=\${${val}}"
    fi
    eval "${arg}=\${val}"
  done

  #  Further cleanup steps
  arg_action=""

  #-----------------------------------------------------------------------------
  #         DONE: DEFINE YOUR CLEANUP COMMANDS (INTERACTIVE MODE) HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #         DONE: DEFINE YOUR CLEANUP COMMANDS (INTERACTIVE MODE) HERE
  #-----------------------------------------------------------------------------
}

#===  FUNCTION  ================================================================
#         NAME:  error
#  DESCRIPTION:  Log/Print error message and optionally exit
#          ...:  See <msg()>
#===============================================================================
error() {
  msg --error "$@"
}

#===  FUNCTION  ================================================================
#         NAME:  help
#  DESCRIPTION:  Print help message using 'less' utility
#         DONE:  Please do not hardcode any help texts here.
#                Edit '/src/lang/run.<...>.lang.sh' to define your help texts
#                and edit <help_synopsis()> below to modify the SYNOPSIS
#                section of your help.
#===============================================================================
help() {
  lib_shtpl_help
}

#===  FUNCTION  ================================================================
#         NAME:  help_synopsis
#  DESCRIPTION:  Create help's <SYNOPSIS> section
#      OUTPUTS:  Write SYNOPSIS text to <stdout>
#===============================================================================
help_synopsis() {
  local ARG_SECTION_SYNOPSIS="--synopsis"
  local ARG_SECTION_TLDR="--tldr"
  local arg_section="${1:-${ARG_SECTION_SYNOPSIS}}"

  #  Get language-dependent text strings
  local ttl_action
  local ttl_option
  local txt_interactive
  local txt_intro
  local txt_script
  eval "ttl_action=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS_ACTION}"
  eval "ttl_option=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS_OPTION}"
  eval "txt_interactive=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TXT_SYNOPSIS_INTERACTIVE}"
  eval "txt_script=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TXT_SYNOPSIS_SCRIPT}"
  case "${arg_section}" in
    ${ARG_SECTION_SYNOPSIS})
      eval "txt_intro=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TXT_SYNOPSIS_INTRO}"
      ;;
    ${ARG_SECTION_TLDR})
      eval "txt_intro=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TXT_TLDR_SYNOPSIS}"
      ;;
    *)
      return 1
      ;;
  esac

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (INTRO)
  #-----------------------------------------------------------------------------
  #  Pointer prefix used for actions and options
  local ptr_prefix
  ptr_prefix="L_$(lib_core_file_get --name "$0")"
  ptr_prefix="$(lib_core_str_to --const "${ptr_prefix}")"

  #  Last argument, see  <args_read()>, <L_RUN_HLP_PAR_LASTARG> in
  #  '/src/lang/run.0.lang.sh', and <L_RUN_<DE|EN|..>_HLP_DES_LASTARG> in
  #  '/src/lang/run.<de|en|...>.lang.sh'.
  local par_lastarg # Parameter, e.g. '<file>'
  local txt_lastarg # Parameter description, e.g. '<file> is optional'
  eval "par_lastarg=\${${ptr_prefix}_HLP_PAR_LASTARG}"
  eval "txt_lastarg=\${${ptr_prefix}_${ID_LANG}_HLP_DES_LASTARG}"

  #  SYNOPSIS strings
  local synopsis_tldr   # TL;DR (short) version
  local synopsis        # SYNOPSIS (long) version


  #-----------------------------------------------------------------------------
  #                DONE: DEFINE YOUR SYNOPSIS (INTRO) TEXT HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  TL;DR (short) version
  synopsis_tldr="\
${txt_intro}

${txt_interactive}:
> ${L_SC_ABOUT_RUN}

${txt_script}:
> ${L_SC_ABOUT_RUN} [ ${ttl_option} ]... ${ttl_action}${par_lastarg:+ ${par_lastarg}}"

  #  SYNOPSIS (long) version
  synopsis="\
${synopsis_tldr}
"

  if lib_core_is --not-empty "${txt_lastarg}"; then
    synopsis="\
${synopsis}

${par_lastarg} : ${txt_lastarg}"
  fi
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                DONE: DEFINE YOUR SYNOPSIS (INTRO) TEXT HERE
  #-----------------------------------------------------------------------------

  #  Print
  case "${arg_section}" in
    ${ARG_SECTION_TLDR})
      eval lib_msg_print_heading -311 \"\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_TLDR_SYNOPSIS}\"
      printf "%s\n" "${synopsis_tldr}"
      return
      ;;
  esac

  eval lib_msg_print_heading -111 \"\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS}\"
  printf "%s\n" "${synopsis}"
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                        \
                                                                              \
                                                                              \
      "${L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P11}
(default)"                                                                    \
      "${L_SC_ABOUT_RUN} [ -T ${ARG_TOKEN_TYPE_OPENSC_P11} ] [ ${ttl_option} ]... ${ttl_action}

${ttl_action} := $(lib_msg_print_list_ptr "${ARG_ACTION_LIST_SCRIPT_OPENSC_P11}" "L_SC_HLP_PAR_ARG_ACTION_")

${ttl_option} := $(lib_msg_print_list_ptr "${LIST_ARG_OPENSC_P11}" "L_SC_HLP_PAR_" "" "true")" \
      " " ""                                                                  \
                                                                              \
                                                                              \
      "${L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15}"                             \
      "${L_SC_ABOUT_RUN} -T ${ARG_TOKEN_TYPE_OPENSC_P15} [ ${ttl_option} ]... ${ttl_action}

${ttl_action} := $(lib_msg_print_list_ptr "${ARG_ACTION_LIST_SCRIPT_OPENSC_P15}" "L_SC_HLP_PAR_ARG_ACTION_")

${ttl_option} := $(lib_msg_print_list_ptr "${LIST_ARG_OPENSC_P15}" "L_SC_HLP_PAR_" "" "true")" \
      " " ""                                                                  \
                                                                              \
                                                                              \
      "SmartCard-HSM /
Nitrokey HSM 2"                                                               \
      "${L_SC_ABOUT_RUN} -T ${ARG_TOKEN_TYPE_SCHSM} [ ${ttl_option} ]... ${ttl_action}

${ttl_action} := $(lib_msg_print_list_ptr "${ARG_ACTION_LIST_SCRIPT_SCHSM}" "L_SC_HLP_PAR_ARG_ACTION_")

${ttl_option} := $(lib_msg_print_list_ptr "${LIST_ARG_SCHSM}" "L_SC_HLP_PAR_" "" "true")" \
      " " ""                                                                  \
                                                                              \
                                                                              \
      "${L_SC_DLG_ITM_ARG_TOKEN_TYPE_YUBICO}"                                 \
      "${L_SC_ABOUT_RUN} -T ${ARG_TOKEN_TYPE_YUBICO} [ ${ttl_option} ]... ${ttl_action}

${ttl_action} := $(lib_msg_print_list_ptr "${ARG_ACTION_LIST_SCRIPT_YUBICO}" "L_SC_HLP_PAR_ARG_ACTION_")

${ttl_option} := $(lib_msg_print_list_ptr "${LIST_ARG_YUBICO}" "L_SC_HLP_PAR_" "" "true")"

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (ACTION)
  #-----------------------------------------------------------------------------
  eval lib_msg_print_heading -211 \"\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS_ACTION}\"

  #-----------------------------------------------------------------------------
  #                DONE: DEFINE YOUR SYNOPSIS (ACTION) TEXT HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  NOTE:
  #    Please define your help texts in '/src/lang/run.<...>.lang.sh' before
  #    continuing here. To create/format the texts automatically, please use the
  #    the <lib_shtpl_arg()> function. You can find its documentation in
  #    '/lib/SHtemplateLIB/lib/shtpl.0.lib.sh'.
  #-----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  #  SYNOPSIS (ACTION) (used by two or more token types)
  #-----------------------------------------------------------------------------
  eval lib_msg_print_heading -301 \"\${L_SC_${ID_LANG}_HLP_TTL_SYNOPSIS_ACTION_ALL}\"
  eval printf \"%s\\n\\n\" \"\${L_SC_${ID_LANG}_HLP_TXT_SYNOPSIS_ACTION_ALL}\"

  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                                                      \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_CHANGE_PIN")"    "$(lib_shtpl_arg --des "ARG_ACTION_ALL_CHANGE_PIN")" " " ""     \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_CHANGE_PUK")"    "$(lib_shtpl_arg --des "ARG_ACTION_ALL_CHANGE_PUK")" " " ""     \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_CHANGE_SO_PIN")" "$(lib_shtpl_arg --des "ARG_ACTION_ALL_CHANGE_SO_PIN")" " " ""  \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_CONNECT")"       "$(lib_shtpl_arg --des "ARG_ACTION_ALL_CONNECT")" " " ""        \
                                                                                                                            \
                                                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_DELETE")"  "$(lib_shtpl_arg --des "ARG_ACTION_ALL_DELETE")

${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_OPENSC_P15}
${L_SC_HLP_TXT_HEADER_SCHSM}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_DELETE_OPENSC_P11")

$(lib_shtpl_arg --list-ptr "arg_all_type" "ALL_DELETE")

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_DELETE_OPENSC_P15")

$(lib_shtpl_arg --list-ptr "arg_all_type" "OPENSC_P15_DELETE")

${L_SC_HLP_TXT_HEADER_YUBICO}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_DELETE_YUBICO")

$(lib_shtpl_arg --list-ptr "arg_all_type" "YUBICO_DELETE")" " " ""                                                          \
                                                                                                                            \
                                                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_EXPORT")"  "$(lib_shtpl_arg --des "ARG_ACTION_ALL_EXPORT")

${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_OPENSC_P15}
${L_SC_HLP_TXT_HEADER_SCHSM}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_EXPORT_OPENSC_P11")

$(lib_shtpl_arg --list-ptr "arg_all_type" "ALL_EXPORT")

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_EXPORT_OPENSC_P15")

$(lib_shtpl_arg --list-ptr "arg_all_type" "OPENSC_P15_EXPORT")

${L_SC_HLP_TXT_HEADER_YUBICO}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_EXPORT_YUBICO")

$(lib_shtpl_arg --list-ptr "arg_all_type" "ALL_EXPORT")" " " ""                                                             \
                                                                                                                            \
                                                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_GET")"  "$(lib_shtpl_arg --des "ARG_ACTION_ALL_GET")

${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_SCHSM}
${L_SC_HLP_TXT_HEADER_YUBICO}

<type>$(lib_shtpl_arg --list-ptr "arg_all_get" "OPENSC_P11")

${L_SC_HLP_TXT_HEADER_OPENSC_P15}

<type>$(lib_shtpl_arg --list-ptr "arg_all_get" "OPENSC_P15")" " " ""                                                        \
                                                                                                                            \
                                                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_IMPORT")"  "$(lib_shtpl_arg --des "ARG_ACTION_ALL_IMPORT")

${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_SCHSM}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_IMPORT_OPENSC_P11")

$(lib_shtpl_arg --list-ptr "arg_all_type" "ALL_IMPORT")

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_IMPORT_OPENSC_P15")

$(lib_shtpl_arg --list-ptr "arg_all_type" "ALL_IMPORT")

${L_SC_HLP_TXT_HEADER_YUBICO}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_IMPORT_YUBICO")

$(lib_shtpl_arg --list-ptr "arg_all_type" "YUBICO_IMPORT")" " " ""                                                          \
                                                                                                                            \
                                                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_INITIALIZE")"  "$(lib_shtpl_arg --des "ARG_ACTION_ALL_INITIALIZE")

${L_SC_HLP_TXT_HEADER_OPENSC_P11}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_INITIALIZE_OPENSC_P11")

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_INITIALIZE_OPENSC_P15")

${L_SC_HLP_TXT_HEADER_SCHSM}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_INITIALIZE_SCHSM")

${L_SC_HLP_TXT_HEADER_YUBICO}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_INITIALIZE_YUBICO")" " " ""                                                           \
                                                                                                                            \
                                                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_KEYPAIRGEN")"  "$(lib_shtpl_arg --des "ARG_ACTION_ALL_KEYPAIRGEN")

${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_SCHSM}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_KEYPAIRGEN_OPENSC_P11")

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_KEYPAIRGEN_OPENSC_P15")

${L_SC_HLP_TXT_HEADER_YUBICO}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_KEYPAIRGEN_YUBICO")" " " ""                                                           \
                                                                                                                            \
                                                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_LIST")"  "$(lib_shtpl_arg --des "ARG_ACTION_ALL_LIST")

${L_SC_HLP_TXT_HEADER_OPENSC_P11}
$(lib_shtpl_arg --list-ptr "arg_all_type" "OPENSC_P11_LIST")

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
$(lib_shtpl_arg --des "ARG_ACTION_ALL_LIST_OPENSC_P15")

$(lib_shtpl_arg --list-ptr "arg_all_type" "OPENSC_P15_LIST")

$(lib_shtpl_arg --list-ptr "arg_all_type" "OPENSC_P15_LIST_PINREQUIRED")
$(lib_shtpl_arg --des "ARG_ACTION_ALL_LIST_OPENSC_P15_PINREQUIRED")

${L_SC_HLP_TXT_HEADER_SCHSM}
$(lib_shtpl_arg --list-ptr "arg_all_type" "SCHSM_LIST")

${L_SC_HLP_TXT_HEADER_YUBICO}
$(lib_shtpl_arg --list-ptr "arg_all_type" "YUBICO_LIST")" " " ""                                                            \
                                                                                                                            \
                                                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_P11_GET_URI")"  "$(lib_shtpl_arg --des "ARG_ACTION_P11_GET_URI"):

$(lib_shtpl_arg --list-des-def "arg_p11_uri_filter")" " " ""                                                                \
                                                                                                                            \
                                                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_RESET_PIN")"     "$(lib_shtpl_arg --des "ARG_ACTION_ALL_RESET_PIN")" " " ""      \
                                                                                                                            \
                                                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_ALL_UNBLOCK_PIN")"   "$(lib_shtpl_arg --des "ARG_ACTION_ALL_UNBLOCK_PIN")"

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (ACTION) (OpenSC PKCS#15)
  #-----------------------------------------------------------------------------
  lib_msg_print_heading -311 "${L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15}"
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                                                                            \
    "$(lib_shtpl_arg --par "ARG_ACTION_OPENSC_P15_ERASE_APPLICATION")" "$(lib_shtpl_arg --des "ARG_ACTION_OPENSC_P15_ERASE_APPLICATION")" " " ""  \
    "$(lib_shtpl_arg --par "ARG_ACTION_OPENSC_P15_ERASE_CARD")" "$(lib_shtpl_arg --des "ARG_ACTION_OPENSC_P15_ERASE_CARD")" " " ""                \
    "$(lib_shtpl_arg --par "ARG_ACTION_OPENSC_P15_FINALIZE")"   "$(lib_shtpl_arg --des "ARG_ACTION_OPENSC_P15_FINALIZE")" " " ""                  \
    "$(lib_shtpl_arg --par "ARG_ACTION_OPENSC_P15_STORE_PIN")"  "$(lib_shtpl_arg --des "ARG_ACTION_OPENSC_P15_STORE_PIN")"

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (ACTION) (SmartCard-HSM / Nitrokey HSM 2)
  #-----------------------------------------------------------------------------
  lib_msg_print_heading -311 "${L_SC_DLG_ITM_ARG_TOKEN_TYPE_SCHSM}"
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                                                                  \
    "$(lib_shtpl_arg --par "ARG_ACTION_SCHSM_BACKUP")"            "$(lib_shtpl_arg --des "ARG_ACTION_SCHSM_BACKUP")" " " ""             \
    "$(lib_shtpl_arg --par "ARG_ACTION_SCHSM_DKEK_SHARE_CREATE")" "$(lib_shtpl_arg --des "ARG_ACTION_SCHSM_DKEK_SHARE_CREATE")" " " ""  \
    "$(lib_shtpl_arg --par "ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT")" "$(lib_shtpl_arg --des "ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT")" " " ""  \
    "$(lib_shtpl_arg --par "ARG_ACTION_SCHSM_RESTORE")"           "$(lib_shtpl_arg --des "ARG_ACTION_SCHSM_RESTORE")"

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (ACTION) (Yubico YubiKey PIV)
  #-----------------------------------------------------------------------------
  lib_msg_print_heading -311 "${L_SC_DLG_ITM_ARG_TOKEN_TYPE_YUBICO}"
  lib_msg_print_propvalue "--left" "--left" "2" "" " " \
    "$(lib_shtpl_arg --par "ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY")" "$(lib_shtpl_arg --des "ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY")"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                DONE: DEFINE YOUR SYNOPSIS (ACTION) TEXT HERE
  #-----------------------------------------------------------------------------

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (OPTION)
  #-----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  #                DONE: DEFINE YOUR SYNOPSIS (OPTION) TEXT HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  NOTE:
  #    Please define your help texts in '/src/lang/run.<...>.lang.sh' before
  #    continuing here. To create/format the texts automatically, please use the
  #    the <lib_shtpl_arg()> function. You can find its documentation in
  #    '/lib/SHtemplateLIB/lib/shtpl.0.lib.sh'.
  #-----------------------------------------------------------------------------
  eval lib_msg_print_heading -211 \"\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS_OPTION}\"

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (OPTION) (Used by two or more token types)
  #-----------------------------------------------------------------------------
  eval lib_msg_print_heading -301 \"\${L_SC_${ID_LANG}_HLP_TTL_SYNOPSIS_OPTION_ALL}\"
  eval printf \"%s\\n\\n\" \"\${L_SC_${ID_LANG}_HLP_TXT_SYNOPSIS_OPTION_ALL}\"

  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                                    \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_token_type")"     "$(lib_shtpl_arg --des "arg_token_type")

$(lib_shtpl_arg --list-ptr-def "arg_token_type")" " " ""                                                  \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_all_data_application_name")" "$(lib_shtpl_arg --des "arg_all_data_application_name")" " " "" \
    "$(lib_shtpl_arg --par "arg_all_data_oid")"   "$(lib_shtpl_arg --des "arg_all_data_oid")" " " ""      \
    "$(lib_shtpl_arg --par "arg_all_force")"      "$(lib_shtpl_arg --des "arg_all_force")" " " ""         \
    "$(lib_shtpl_arg --par "arg_all_format")"     "$(lib_shtpl_arg --des "arg_all_format")

$(lib_shtpl_arg --list-ptr-def "arg_all_format" "OPENSC_P15_IMPORT_PRIVKEY")" " " ""                      \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_all_id_object")"  "$(lib_shtpl_arg --des "arg_all_id_object")" " " ""     \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_all_key_type")"   "$(lib_shtpl_arg --des "arg_all_key_type")

${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_SCHSM}
$(lib_shtpl_arg --des "ARG_ALL_KEY_TYPE_OPENSC_P11")

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
$(lib_shtpl_arg --des "ARG_ALL_KEY_TYPE_OPENSC_P15")

${L_SC_HLP_TXT_HEADER_YUBICO}
$(lib_shtpl_arg --des "ARG_ALL_KEY_TYPE_YUBICO")

Private Key
$(lib_shtpl_arg --list-val "arg_all_key_type" "YUBICO_KEYPAIRGEN")

Management Key
$(lib_shtpl_arg --list-val "arg_all_key_type" "YUBICO_CHANGE_MANAGEMENT_KEY")

$(lib_shtpl_arg --def "arg_all_key_type")" " " ""                                                         \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_all_label")"      "$(lib_shtpl_arg --des "arg_all_label")" " " ""         \
    "$(lib_shtpl_arg --par "arg_all_newpinpuk")"  "$(lib_shtpl_arg --des "arg_all_newpinpuk")" " " ""     \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_p15_id_aid")"       "$(lib_shtpl_arg --des "arg_p15_id_aid")" " " ""      \
    "$(lib_shtpl_arg --par "arg_p15_id_auth")"      "$(lib_shtpl_arg --des "arg_p15_id_auth")" " " ""     \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_piv_ber_tlv_tag")"  "$(lib_shtpl_arg --des "arg_piv_ber_tlv_tag" "1")

$(lib_shtpl_arg --list-val "arg_piv_ber_tlv_tag")

$(lib_shtpl_arg --des "arg_piv_ber_tlv_tag" "2")" " " ""                                                  \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_piv_keyref")" "$(lib_shtpl_arg --des "arg_piv_keyref" "1")

$(lib_shtpl_arg --list-val "arg_piv_keyref")

$(lib_shtpl_arg --des "arg_piv_keyref" "2")" " " ""                                                       \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_all_password")"   "$(lib_shtpl_arg --des "arg_all_password")" " " ""      \
    "$(lib_shtpl_arg --par "arg_all_pin")"        "$(lib_shtpl_arg --des "arg_all_pin")" " " ""           \
    "$(lib_shtpl_arg --par "arg_all_puk")"        "$(lib_shtpl_arg --des "arg_all_puk")" " " ""           \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_all_id_reader")"  "$(lib_shtpl_arg --des "arg_all_id_reader")" " " ""     \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_all_serial")"     "\
${L_SC_HLP_TXT_HEADER_YUBICO}
$(lib_shtpl_arg --des "ARG_ALL_SERIAL_YUBICO")" " " ""                                                    \
                                                                                                          \
                                                                                                          \
    "$(lib_shtpl_arg --par "arg_all_sopin")"      "$(lib_shtpl_arg --des "arg_all_sopin")" " " ""         \
    "$(lib_shtpl_arg --par "arg_all_sopuk")"      "$(lib_shtpl_arg --des "arg_all_sopuk")" " " ""         \
    "$(lib_shtpl_arg --par "arg_all_type")"       "$(lib_shtpl_arg --list-des "arg_all_type")"
  #-----------------------------------------------------------------------------
  #  SYNOPSIS (OPTION) (OpenSC (PKCS#15))
  #-----------------------------------------------------------------------------
  lib_msg_print_heading -311 "${L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15}"
  lib_msg_print_propvalue "--left" "--left" "2" "" " " \
    "$(lib_shtpl_arg --par "arg_opensc_p15_profile")"         "$(lib_shtpl_arg --des-def "arg_opensc_p15_profile")"
  #-----------------------------------------------------------------------------
  #  SYNOPSIS (OPTION) (SmartCard-HSM / Nitrokey HSM 2)
  #-----------------------------------------------------------------------------
  lib_msg_print_heading -311 "${L_SC_DLG_ITM_ARG_TOKEN_TYPE_SCHSM}"
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                                                              \
    "$(lib_shtpl_arg --par "arg_schsm_dkek_shares")"          "$(lib_shtpl_arg --des-def "arg_schsm_dkek_shares")" " " ""           \
    "$(lib_shtpl_arg --par "arg_schsm_key_reference")"        "$(lib_shtpl_arg --des-def "arg_schsm_key_reference")" " " ""         \
    "$(lib_shtpl_arg --par "arg_schsm_pwd_shares_threshold")" "$(lib_shtpl_arg --des-def "arg_schsm_pwd_shares_threshold")" " " ""  \
    "$(lib_shtpl_arg --par "arg_schsm_pwd_shares_total")"     "$(lib_shtpl_arg --des-def "arg_schsm_pwd_shares_total")"
  #-----------------------------------------------------------------------------
  #  SYNOPSIS (OPTION) (Yubico YubiKey PIV)
  #-----------------------------------------------------------------------------
  lib_msg_print_heading -311 "${L_SC_DLG_ITM_ARG_TOKEN_TYPE_YUBICO}"
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                                                          \
    "$(lib_shtpl_arg --par "arg_yubico_management_key")"      "$(lib_shtpl_arg --des "arg_yubico_management_key")" " " ""       \
    "$(lib_shtpl_arg --par "arg_yubico_new_management_key")"  "$(lib_shtpl_arg --des "arg_yubico_new_management_key")" " " ""   \
    "$(lib_shtpl_arg --par "arg_yubico_pin_policy")"          "$(lib_shtpl_arg --list-des-def "arg_yubico_pin_policy")" " " ""  \
    "$(lib_shtpl_arg --par "arg_yubico_touch_policy")"        "$(lib_shtpl_arg --list-des-def "arg_yubico_touch_policy")"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                DONE: DEFINE YOUR SYNOPSIS (OPTION) TEXT HERE
  #-----------------------------------------------------------------------------
}

#===  FUNCTION  ================================================================
#         NAME:  info
#  DESCRIPTION:  Log/Print info message and optionally exit
#          ...:  See <msg()>
#===============================================================================
info() {
  msg --info "$@"
}

#===  FUNCTION  ================================================================
#         NAME:  init_check_pre
#  DESCRIPTION:  Check script requirements (before argument parsing)
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  All mandatory requirements are fulfilled
#            1:  At least one mandatory requirement is not fulfilled
#===============================================================================
init_check_pre() {
  #=============================================================================
  #  Mandatory (= script will break on error)
  #=============================================================================
  #-----------------------------------------------------------------------------
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  lib_os_lib --exists "${FILE_SO_LIBCCIDTWIN}"                              && \
  if ! service pcscd status >/dev/null 2>&1; then
    lib_core_sudo service pcscd start
  fi                                                                        || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------
  { error "${TXT_INIT_CHECK_ERR}"
    return 1
  }

  #=============================================================================
  #  Optional (= script will continue on error)
  #=============================================================================
  local optionalFulfilled="true"
  #-----------------------------------------------------------------------------
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  true                                                                      || \
  optionalFulfilled="false"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------
  if ! ${optionalFulfilled}; then
    warning "${TXT_INIT_CHECK_WARN}"
    sleep 3
  fi
}

#===  FUNCTION  ================================================================
#         NAME:  init_check_post
#  DESCRIPTION:  Check script requirements (after argument parsing)
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  All mandatory requirements are fulfilled
#            1:  At least one mandatory requirement is not fulfilled
#===============================================================================
init_check_post() {
  #=============================================================================
  #  Mandatory (= script will break on error)
  #=============================================================================
  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  # Check for running log service (except when terminal is the only destination)
  case "${arg_logdest}" in
    ${ARG_LOGDEST_BOTH}|${ARG_LOGDEST_SYSLOG})
      service log status >/dev/null 2>&1        || \
      service rsyslog status >/dev/null 2>&1    || \
      service syslog-ng status >/dev/null 2>&1  || \
      lib_msg_message --terminal --error "${TXT_INIT_CHECK_ERR_LOGSERVICE}"
      ;;
    ${ARG_LOGDEST_TERMINAL})
      ;;
    *)
      lib_msg_message --terminal --error "${TXT_INVALID_ARG_1} <${arg_logdest}> ${TXT_INVALID_ARG_2} [${L_SC_HLP_PAR_ARG_LOGDEST}]. ${LIB_SHTPL_EN_TXT_HELP} ${LIB_SHTPL_EN_TXT_ABORTING}"
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11})
      lib_core_is --cmd "opensc-tool" "p11tool" "pkcs11-tool"
      ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15})
      lib_core_is --cmd "opensc-tool" "pkcs15-init" "pkcs15-tool"
      ;;
    ${ARG_TOKEN_TYPE_SCHSM})
      lib_core_is --cmd "opensc-tool" "openssl" "p11tool" "pkcs11-tool" "pkcs15-tool" "sc-hsm-tool"
      ;;
    ${ARG_TOKEN_TYPE_YUBICO})
      lib_core_is --cmd "p11tool" "ykman"
      ;;
  esac                                                                      || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------
  { error "${TXT_INIT_CHECK_ERR}"
    return 1
  }

  #=============================================================================
  #  Optional (= script will continue on error)
  #=============================================================================
  local optionalFulfilled="true"
  #-----------------------------------------------------------------------------
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  true                                                                      || \
  optionalFulfilled="false"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------
  if ! ${optionalFulfilled}; then
    warning "${TXT_INIT_CHECK_WARN}"
    sleep 3
  fi
}

#===  FUNCTION  ================================================================
#         NAME:  init_first
#  DESCRIPTION:  Lock the script (PID file) or initialize instance counter,
#                set default log destination, and install trap handler
#      OUTPUTS:  In case of ...
#                  success : An info message with the script's PID to <syslog>
#                            (only if script is NOT run within a terminal)
#                    error : An error message to either <stderr> or <syslog>
#   RETURNS  0:  Success
#            1:  Error
#===============================================================================
init_first() {
  if ${PIDLOCK_ENABLED}; then
    #  PID lock (to prevent further instances) or ...
    lib_os_ps_pidlock --lock
  else
    # ... instance counter (used to check if this script was called recursively)
    readonly INSTANCES="$(lib_core_file_get --name "$0")_instances" && \
    eval "export ${INSTANCES}=$(( ${INSTANCES} + 1 ))"
  fi                                                                        && \

  #  Set default log destination (can be overwritten in <args_read()>)
  if lib_core_is --terminal-stdin || lib_core_is --terminal-stdout; then
    arg_logdest="${ARG_LOGDEST_TERMINAL}"
  else
    arg_logdest="${ARG_LOGDEST_SYSLOG}"
  fi                                                                        && \

  #  Install trap handlers
  local sig                                                                 && \
  for sig in EXIT HUP INT QUIT TERM; do
    #---------------------------------------------------------------------------
    #       DONE: ADD FURTHER TRAP PARAMETERS HERE (and in <trap_main()>)
    #
    #                                    |||
    #                                   \|||/
    #                                    \|/
    #---------------------------------------------------------------------------
    #  Please make sure to escape your variable and put it in escaped quotes,
    #  e.g. for variable <var> use: \"\${var}\"
    trap "{
      trap_main                                                     \
        \"${sig}\"          \"true\"            \"\${I_DIR_PID}\"   \
        \"\${I_EXT_PID}\"   \"\${arg_mode}\"
    }" ${sig}
    #---------------------------------------------------------------------------
    #                                    /|\
    #                                   /|||\
    #                                    |||
    #
    #       DONE: ADD FURTHER TRAP PARAMETERS HERE (and in <trap_main()>)
    #---------------------------------------------------------------------------
  done                                                                      && \

  #  Get PID (if PID lock is disabled, then <lib_os_ps_pidlock()> will fail.)
  local pid                                                                 && \
  { pid="$(lib_os_ps_pidlock --getpid)" || \
    lib_os_ps_get_ownpid pid
  }                                                                         && \

  #-----------------------------------------------------------------------------
  #                       DONE: ADD FURTHER COMMANDS HERE
  #                   (DO NOT FORGET THE TERMINATING '&& \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                       DONE: ADD FURTHER COMMANDS HERE
  #                   (DO NOT FORGET THE TERMINATING '&& \')
  #-----------------------------------------------------------------------------

  #  Print/Log
  info --syslog "${TXT_INIT_FIRST_INFO} (PID <${pid}>)."
}

#===  FUNCTION  ================================================================
#         NAME:  init_lang
#  DESCRIPTION:  Set language-specific text constants
#      GLOBALS:  ID_LANG  ... (see 'eval ...' commands below)
#===============================================================================
init_lang() {
  ID_LANG="$(lib_os_get --lang)"

  #=============================================================================
  #  Supported Languages
  #=============================================================================
  #-----------------------------------------------------------------------------
  #            TODO: ADD SUPPORTED LANGUAGES HERE (ISO 639-1 CODES)
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  case "${ID_LANG}" in
    ${LIB_C_ID_LANG_EN}) readonly ID_LANG="${LIB_C_ID_L_EN}";;
    ${LIB_C_ID_LANG_DE}) readonly ID_LANG="${LIB_C_ID_L_DE}";;
    *) readonly ID_LANG="${LIB_C_ID_L_EN}";;
  esac
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #            TODO: ADD SUPPORTED LANGUAGES HERE (ISO 639-1 CODES)
  #-----------------------------------------------------------------------------

  #=============================================================================
  #  CUSTOM
  #=============================================================================
  #-----------------------------------------------------------------------------
  #         DONE: PUBLISH YOUR CUSTOM LANGUAGE-SPECIFIC STRINGS <L_...>
  #               (DEFINED IN '/src/lang/run.<ll>.lang.sh') HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  eval "readonly TXT_ARG_ACTION_ALL_EXPORT_YUBICO_INFO=\${L_SC_${ID_LANG}_TXT_ARG_ACTION_ALL_EXPORT_YUBICO_INFO}"
  eval "readonly TXT_ARG_ACTION_ALL_IMPORT_OPENSC_P15_INFO=\${L_SC_${ID_LANG}_TXT_ARG_ACTION_ALL_IMPORT_OPENSC_P15_INFO}"
  eval "readonly TXT_ARG_ACTION_ALL_IMPORT_YUBICO_INFO=\${L_SC_${ID_LANG}_TXT_ARG_ACTION_ALL_IMPORT_YUBICO_INFO}"
  eval "readonly TXT_ARG_ACTION_ALL_INITIALIZE_OPENSC_P15_INFO=\${L_SC_${ID_LANG}_TXT_ARG_ACTION_ALL_INITIALIZE_OPENSC_P15_INFO}"
  eval "readonly TXT_ARG_ACTION_OPENSC_P15_FINALIZE_INFO=\${L_SC_${ID_LANG}_TXT_ARG_ACTION_OPENSC_P15_FINALIZE_INFO}"
  eval "readonly TXT_ARG_ACTION_OPENSC_P15_STORE_PIN_INFO=\${L_SC_${ID_LANG}_TXT_ARG_ACTION_OPENSC_P15_STORE_PIN_INFO}"
  eval "readonly TXT_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY_INFO=\${L_SC_${ID_LANG}_TXT_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY_INFO}"
  #-----------------------------------------------------------------------------
  #                                    /|\
  #                                   /|||\
  #                                    |||
  #
  #         DONE: PUBLISH YOUR CUSTOM LANGUAGE-SPECIFIC STRINGS <L_...>
  #               (DEFINED IN '/src/lang/run.<ll>.lang.sh') HERE
  #-----------------------------------------------------------------------------

  #=============================================================================
  #  TEMPLATE - DO NOT EDIT
  #=============================================================================
  eval "readonly TXT_ARGS_CHECK_ERR=\${LIB_SHTPL_${ID_LANG}_TXT_ARGS_CHECK_ERR}"
  eval "readonly TXT_ARGS_READ_ERR=\${LIB_SHTPL_${ID_LANG}_TXT_ARGS_READ_ERR}"
  eval "readonly TXT_CONTINUE_ENTER=\${LIB_SHTPL_${ID_LANG}_TXT_CONTINUE_ENTER}"
  eval "readonly TXT_CONTINUE_YESNO=\${LIB_SHTPL_${ID_LANG}_TXT_CONTINUE_YESNO}"
  eval "readonly TXT_INIT_CHECK_ERR=\${LIB_SHTPL_${ID_LANG}_TXT_INIT_CHECK_ERR}"
  eval "readonly TXT_INIT_CHECK_ERR_LOGSERVICE=\${LIB_SHTPL_${ID_LANG}_TXT_INIT_CHECK_ERR_LOGSERVICE}"
  eval "readonly TXT_INIT_CHECK_WARN=\${LIB_SHTPL_${ID_LANG}_TXT_INIT_CHECK_WARN}"
  eval "readonly TXT_INIT_FIRST_INFO=\${LIB_SHTPL_${ID_LANG}_TXT_INIT_FIRST_INFO}"
  eval "readonly TXT_INIT_UPDATE_ERR=\${LIB_SHTPL_${ID_LANG}_TXT_INIT_UPDATE_ERR}"
  eval "readonly TXT_INVALID_ARG_1=\${LIB_SHTPL_${ID_LANG}_TXT_INVALID_ARG_1}"
  eval "readonly TXT_INVALID_ARG_2=\${LIB_SHTPL_${ID_LANG}_TXT_INVALID_ARG_2}"
  eval "readonly TXT_PROCESSING=\${LIB_SHTPL_${ID_LANG}_TXT_PROCESSING}"
}

#===  FUNCTION  ================================================================
#         NAME:  init_update
#  DESCRIPTION:  Update global variables/constants and perform initialization
#                commands that should be executed after argument parsing
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  Success
#            1:  Error
#===============================================================================
init_update() {
  #-----------------------------------------------------------------------------
  #                   DONE: DEFINE YOUR UPDATE COMMANDS HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  # Set default key type (algorithm/length) depending on token type and mode
  if  lib_core_is --not-empty "${arg_action}" && \
      lib_core_is --empty "${arg_all_key_type}"; then
    eval "arg_all_key_type=\${$(lib_core_str_to --const "ARG_ALL_KEY_TYPE_${arg_token_type}_${arg_action}")}"

    # In case mode-specific value does not exist use a default one
    if lib_core_is --empty "${arg_all_key_type}"; then
      eval "arg_all_key_type=\${$(lib_core_str_to --const "ARG_ALL_KEY_TYPE_${arg_token_type}")}"
    fi
  fi                                                                        && \

  # Set default object class / list type (non-interactive modes only)
  case "${arg_mode}" in
    ${ARG_MODE_INTERACTIVE}|${ARG_MODE_INTERACTIVE_SUBMENU}) ;;
    *) arg_all_type="${arg_all_type:-${ARG_ALL_TYPE_READER}}" ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Clear global variables that will be updated in this function
  #-----------------------------------------------------------------------------
  all_force=""                                                              && \
  all_p11lib=""                                                             && \
  all_p11lib_full=""                                                        && \
  all_secrets_arg_input=""                                                  && \
  all_secrets_arg_list_change=""                                            && \
  all_secrets_arg_replace=""                                                && \
  all_secrets_mode=""                                                       && \

  #-----------------------------------------------------------------------------
  #  Token-specific updates
  #-----------------------------------------------------------------------------
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11})
      #-------------------------------------------------------------------------
      #  OpenSC (PKCS#11)
      #-------------------------------------------------------------------------
      # Set PKCS#11 library
      all_p11lib="${P11LIB_OPENSC}"                                         && \

      # Determine if current PIN, PUK, SO-PIN, ... is required
      case "${arg_action}" in
        ${ARG_ACTION_ALL_CHANGE_PIN}|${ARG_ACTION_ALL_DELETE}|\
        ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_ALL_KEYPAIRGEN})
          # All modes that require the current user PIN
          all_secrets_arg_input="arg_all_pin"
          ;;
        ${ARG_ACTION_ALL_UNBLOCK_PIN})
          # All modes that require the current user PUK
          all_secrets_arg_input="arg_all_puk"
          ;;
        ${ARG_ACTION_ALL_CHANGE_SO_PIN}|${ARG_ACTION_ALL_RESET_PIN})
          # All modes that require the current SO-PIN
          all_secrets_arg_input="arg_all_sopin"
          ;;
      esac
      ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15})
      #-------------------------------------------------------------------------
      #  OpenSC (PKCS#15)
      #-------------------------------------------------------------------------
      # Set PKCS#11 library (needed as some <opensc_p11_...()> functions are
      # even called with PKCS#15 mode, e.g. see <opensc_p15_get()>)
      all_p11lib="${P11LIB_OPENSC}"                                         && \

      # Determine if current PIN, PUK, SO-PIN, ... is required
      case "${arg_action}" in
        ${ARG_ACTION_ALL_CHANGE_PIN}|${ARG_ACTION_ALL_DELETE}|\
        ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_ALL_KEYPAIRGEN}|\
        ${ARG_ACTION_OPENSC_P15_ERASE_APPLICATION}|\
        ${ARG_ACTION_OPENSC_P15_ERASE_CARD})
          all_secrets_arg_input="arg_all_pin"
          ;;
        ${ARG_ACTION_ALL_EXPORT})
          case "${arg_all_type}" in
            ${ARG_ALL_TYPE_DATA}) all_secrets_arg_input="arg_all_pin";;
          esac
          ;;
        ${ARG_ACTION_ALL_LIST})
          case "${arg_all_type}" in
            ${ARG_ALL_TYPE_DATA}|${ARG_ALL_TYPE_PRIVKEY}|${ARG_ALL_TYPE_SECRKEY})
              all_secrets_arg_input="arg_all_pin"
              ;;
          esac
          ;;
        ${ARG_ACTION_ALL_CHANGE_PUK}|${ARG_ACTION_ALL_UNBLOCK_PIN})
          all_secrets_arg_input="arg_all_puk"
          ;;
        ${ARG_ACTION_ALL_CHANGE_SO_PIN}|${ARG_ACTION_OPENSC_P15_STORE_PIN})
          all_secrets_arg_input="arg_all_sopin"
          ;;
      esac                                                                  && \

      # All modes that may require a (file) password
      case "${arg_action}" in
        ${ARG_ACTION_ALL_IMPORT})
          case "${arg_all_type}" in
            ${ARG_ALL_TYPE_PRIVKEY})
              all_secrets_arg_input="${all_secrets_arg_input}${all_secrets_arg_input:+ }arg_all_password"
              ;;
          esac
          ;;
      esac
      ;;
    ${ARG_TOKEN_TYPE_SCHSM})
      #-------------------------------------------------------------------------
      #  SmartCard-HSM / Nitrokey HSM 2
      #-------------------------------------------------------------------------
      # Set PKCS#11 library
      all_p11lib="${P11LIB_OPENSC}"                                         && \

      if ${arg_all_force}; then all_force="--force"; fi                     && \

      # Determine if current PIN, PUK, SO-PIN, ... is required
      case "${arg_action}" in
        ${ARG_ACTION_ALL_CHANGE_PIN}|${ARG_ACTION_ALL_DELETE}|\
        ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_ALL_KEYPAIRGEN}|\
        ${ARG_ACTION_SCHSM_BACKUP}|${ARG_ACTION_SCHSM_RESTORE})
          all_secrets_arg_input="arg_all_pin"
          ;;
        ${ARG_ACTION_ALL_CHANGE_SO_PIN}|${ARG_ACTION_ALL_RESET_PIN})
          all_secrets_arg_input="arg_all_sopin"
          ;;
      esac                                                                  && \

      # All modes that may require a (file) password
      case "${arg_action}" in
        ${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})
          if ! ${arg_schsm_pwd_use_threshold_scheme}; then
            all_secrets_arg_input="${all_secrets_arg_input}${all_secrets_arg_input:+ }arg_all_password"
          fi
          ;;
      esac
      ;;
    ${ARG_TOKEN_TYPE_YUBICO})
      #-------------------------------------------------------------------------
      #  Yubico YubiKey PIV
      #-------------------------------------------------------------------------
      # Set PKCS#11 library
      all_p11lib="${P11LIB_YUBICO}"                                         && \

      if ${arg_all_force}; then all_force="--force"; fi                     && \

      # Determine if current PIN, PUK, SO-PIN, ... is required
      case "${arg_action}" in
        ${ARG_ACTION_ALL_CHANGE_PIN})
          all_secrets_arg_input="arg_all_pin"
          ;;
        ${ARG_ACTION_ALL_EXPORT})
          case "${arg_all_type}" in
            ${ARG_ALL_TYPE_DATA}|${ARG_ALL_TYPE_PUBKEY})
              all_secrets_arg_input="arg_all_pin"
              ;;
          esac
          ;;
        ${ARG_ACTION_ALL_CHANGE_PUK}|${ARG_ACTION_ALL_UNBLOCK_PIN})
          all_secrets_arg_input="arg_all_puk"
          ;;
        ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_IMPORT}|\
        ${ARG_ACTION_ALL_KEYPAIRGEN}|${ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY})
          all_secrets_arg_input="arg_yubico_management_key"
          ;;
      esac                                                                  && \

      # All modes that may require a (file) password
      case "${arg_action}" in
        ${ARG_ACTION_ALL_IMPORT})
          case "${arg_all_type}" in
            ${ARG_ALL_TYPE_CERT}|${ARG_ALL_TYPE_PRIVKEY})
              all_secrets_arg_input="${all_secrets_arg_input}${all_secrets_arg_input:+ }arg_all_password"
              ;;
          esac
          ;;
      esac
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  All modes that set a new PIN, PUK, SO-PIN, ...
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ALL_CHANGE_PIN}|${ARG_ACTION_ALL_RESET_PIN}|\
    ${ARG_ACTION_ALL_UNBLOCK_PIN})
      all_secrets_arg_list_change="arg_all_pin"                             && \
      all_secrets_arg_replace="arg_all_newpinpuk"                           && \
      all_secrets_mode="${ALL_SECRETS_MODE_REPLACE}"
      ;;
    ${ARG_ACTION_ALL_CHANGE_PUK})
      all_secrets_arg_list_change="arg_all_puk"                             && \
      all_secrets_arg_replace="arg_all_newpinpuk"                           && \
      all_secrets_mode="${ALL_SECRETS_MODE_REPLACE}"
      ;;
    ${ARG_ACTION_ALL_CHANGE_SO_PIN})
      all_secrets_arg_list_change="arg_all_sopin"                           && \
      all_secrets_arg_replace="arg_all_newpinpuk"                           && \
      all_secrets_mode="${ALL_SECRETS_MODE_REPLACE}"
      ;;
    ${ARG_ACTION_ALL_INITIALIZE})
      case "${arg_token_type}" in
        ${ARG_TOKEN_TYPE_OPENSC_P11})
          all_secrets_arg_list_change="arg_all_pin arg_all_sopin"           && \
          all_secrets_mode="${ALL_SECRETS_MODE_NEW}"
          ;;
        ${ARG_TOKEN_TYPE_OPENSC_P15})
          case "${arg_opensc_p15_profile}" in
            ${ARG_OPENSC_P15_PROFILE_ONEPIN})
              all_secrets_arg_list_change="arg_all_pin arg_all_puk"
              ;;
            *)
              all_secrets_arg_list_change="arg_all_pin arg_all_puk arg_all_sopin arg_all_sopuk"
              ;;
          esac                                                              && \
          all_secrets_mode="${ALL_SECRETS_MODE_NEW}"
          ;;
        ${ARG_TOKEN_TYPE_SCHSM})
          all_secrets_arg_list_change="arg_all_pin arg_all_sopin"           && \
          all_secrets_mode="${ALL_SECRETS_MODE_NEW}"
          ;;
        ${ARG_TOKEN_TYPE_YUBICO})
          all_secrets_arg_list_change="arg_all_pin arg_all_puk arg_yubico_management_key" && \
          all_secrets_mode="${ALL_SECRETS_MODE_NEW}"
          ;;
      esac
      ;;
    ${ARG_ACTION_OPENSC_P15_STORE_PIN})
      all_secrets_arg_list_change="arg_all_pin arg_all_puk"                 && \
      all_secrets_mode="${ALL_SECRETS_MODE_NEW}"
      ;;
    ${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE})
      if ! ${arg_schsm_pwd_use_threshold_scheme}; then
        all_secrets_arg_list_change="arg_all_password"
        all_secrets_mode="${ALL_SECRETS_MODE_NEW}"
      fi
      ;;
    ${ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY})
      all_secrets_arg_list_change="arg_yubico_management_key"               && \
      all_secrets_arg_replace="arg_yubico_new_management_key"               && \
      all_secrets_mode="${ALL_SECRETS_MODE_REPLACE}"
      ;;
  esac                                                                      && \

  # (Optionally) generate new PIN, PUK, SO-PIN, ... randomly
  if ${arg_all_random} && lib_core_is --not-empty "${all_secrets_arg_list_change}"; then
    all_secrets_random "${all_secrets_mode}" "${all_secrets_arg_list_change}" "${all_secrets_arg_replace}"
  fi                                                                        && \

  # Set PKCS#11 library (full path)
  all_p11lib_full="$(lib_os_lib --file "${all_p11lib}")"                    || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                   DONE: DEFINE YOUR UPDATE COMMANDS HERE
  #-----------------------------------------------------------------------------
  { error "${TXT_INIT_UPDATE_ERR}"
    return 1
  }
}

#===  FUNCTION  ================================================================
#         NAME:  main
#  DESCRIPTION:  Main function
#      OUTPUTS:  (See functions listed below)
#
#                In case an error occurs during <init_...()> or <args_...()>:
#                  An error message will be printed to <stderr> and/or <syslog>,
#                  the script's help will be automatically shown, and the script
#                  exits with '1'.
#
#      RETURNS:  (See functions listed below)
#===============================================================================
main() {
  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  #   init_lang         Set language-specific text constants
  #
  #   init_first        Set default log destination, lock the script (PID file)
  #                     install trap handler and run other commands that need
  #                     to be executed right at the beginning
  #
  #   init_check_pre    Check script requirements (before argument parsing)
  #
  #   args_read         Read/Parse arguments
  #
  #   args_check        Check if passed arguments are valid
  #
  #   init_update       Update global variables/constants and perform
  #                     initialization commands that should be executed after
  #                     argument parsing
  #
  #   init_check_post   Check script requirements (after argument parsing)
  #
  #   main_daemon       Main subfunction (daemon mode)
  #   main_interactive  Main subfunction (interactive / submenu mode)
  #   main_script       Main subfunction (script mode)
  #-----------------------------------------------------------------------------
  init_lang                                                                 && \
  init_first                                                                && \
  init_check_pre                                                            && \
  args_read "$@"                                                            && \
  case "${arg_mode}" in
    ${ARG_MODE_DAEMON}|${ARG_MODE_INTERACTIVE_SUBMENU}|${ARG_MODE_SCRIPT})
      args_check      && \
      init_update     && \
      init_check_post
      ;;
    ${ARG_MODE_INTERACTIVE})
      # For further init functions see <main_interactive()>
      lib_core_is --cmd dialog opensc-tool || \
      error "${TXT_INIT_CHECK_ERR}"
      ;;
  esac                                                                      || \

  # If any error occurred show help but wait some seconds before
  # (to allow the user to read error/warning messages)
  { lib_core_is --terminal-stdout && { sleep 3; help; }; return 1; }

  # Run mode-specific subfunctions
  case "${arg_mode}" in
    ${ARG_MODE_DAEMON}) main_daemon;;
    ${ARG_MODE_INTERACTIVE}|${ARG_MODE_INTERACTIVE_SUBMENU}) main_interactive || return $?;;
    ${ARG_MODE_SCRIPT}) main_script;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  main_daemon
#  DESCRIPTION:  Main subfunction (daemon mode)
#===============================================================================
main_daemon() {
  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  # Create subshell PID directory (removed in <trap_main()>)
  lib_core_sudo mkdir -p "${I_DIR_PID}"                                     || \
  { error "Could not create subshell PID directory at <${I_DIR_PID}>. Aborting..."
    return 1
  }

  #-----------------------------------------------------------------------------
  #             DONE: DEFINE YOUR MAIN FUNCTION (DAEMON MODE) HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  return
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #             DONE: DEFINE YOUR MAIN FUNCTION (DAEMON MODE) HERE
  #-----------------------------------------------------------------------------
}

#===  FUNCTION  ================================================================
#         NAME:  main_interactive
#  DESCRIPTION:  Main subfunction (interactive / submenu mode)
#===============================================================================
main_interactive() {
  # Check for minimum terminal size (otherwise some dialogues would fail)
  lib_msg_dialog_autosize >/dev/null                                        && \

  # Show welcome message (but not in submenu mode)
  if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE}" ]; then
    lib_shtpl_about --dialog
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #          DONE: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
  #                   (DO NOT FORGET THE TERMINATING '&& \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  menu_all_connect                                                          && \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #          DONE: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
  #                   (DO NOT FORGET THE TERMINATING '&& \')
  #-----------------------------------------------------------------------------

  if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE}" ]; then
    #---------------------------------------------------------------------------
    #         DONE: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
    #                     EXCEPT WHEN BEING IN SUBMENU MODE
    #                  (DO NOT FORGET THE TERMINATING '&& \')
    #
    #                                    |||
    #                                   \|||/
    #                                    \|/
    #---------------------------------------------------------------------------
    # Ask user to choose token type once before continuing (in case of
    # submenu mode: token type is already set in the calling script)
    menu_arg_token_type && \
    #---------------------------------------------------------------------------
    #                                    /|\
    #                                   /|||\
    #                                    |||
    #
    #         DONE: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
    #                     EXCEPT WHEN BEING IN SUBMENU MODE
    #                  (DO NOT FORGET THE TERMINATING '&& \')
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    #  DO NOT EDIT
    #---------------------------------------------------------------------------
    args_check          && \
    init_update         && \
    init_check_post
  fi                                                                        && \

  # Endless loop until user exits
  local exitcode                                                            && \
  while menu_main || { clear; false; }; do
    exitcode="0"
    case "${arg_action}" in
      "")
        # See comment at the end of menu_main() function
        if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE_SUBMENU}" ]; then
          # 'submenu' mode: user has cancelled 'dialog' so exit with error
          return 2
        else
          # other modes: run cleanup procedure and get back to main menu
          cleanup_interactive
          continue
        fi
        ;;

      #-------------------------------------------------------------------------
      #    DONE: ADD <ARG_ACTION_...> WHERE PROMPT TO CONTINUE IS NOT NEEDED
      #
      #                                   |||
      #                                  \|||/
      #                                   \|/
      #-------------------------------------------------------------------------
      ${ARG_ACTION_ABOUT}|${ARG_ACTION_HELP}|${ARG_ACTION_EXIT})
        run || exitcode="$?"
        ;;
      #-------------------------------------------------------------------------
      #                                   /|\
      #                                  /|||\
      #                                   |||
      #
      #    DONE: ADD <ARG_ACTION_...> WHERE PROMPT TO CONTINUE IS NOT NEEDED
      #-------------------------------------------------------------------------

      *)
        # Run a certain command and prompt the user to continue
        clear
        lib_msg_print_heading -201 "${TXT_PROCESSING}"
        run || exitcode="$?"
        # No prompt in submenu mode
        if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE}" ]; then
          lib_msg_print_heading -2 "${TXT_CONTINUE_ENTER}"
          read -r dummy
        fi
        ;;
    esac

    # Submenu mode means "run a certain sub-menu and exit"
    [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE_SUBMENU}" ] && return ${exitcode}

    # Run cleanup procedure
    cleanup_interactive
  done
}

#===  FUNCTION  ================================================================
#         NAME:  main_script
#  DESCRIPTION:  Main subfunction (script mode)
#===============================================================================
main_script() {
  run
}

#===  FUNCTION  ================================================================
#         NAME:  msg
#  DESCRIPTION:  Log/Print error/info/warning message and optionally exit
#          ...:  See <lib_shtpl_message()> in
#                '/lib/SHtemplateLIB/lib/shtpl.0.lib.sh'
#===============================================================================
msg() {
  lib_shtpl_message "$@"
}

#===  FUNCTION  ================================================================
#         NAME:  run
#  DESCRIPTION:  Perform one certain action (cycle)
#      OUTPUTS:  Depends on <arg_action>
#      RETURNS:  Depends on <arg_action>
#===============================================================================
run() {
  case "${arg_action}" in
    #---------------------------------------------------------------------------
    #  TEMPLATE - DO NOT EDIT
    #---------------------------------------------------------------------------
    ${ARG_ACTION_ABOUT})        lib_shtpl_about --dialog;;
    ${ARG_ACTION_EXIT})         clear; exit;;
    ${ARG_ACTION_HELP})         help;;

    #---------------------------------------------------------------------------
    #  CUSTOM
    #---------------------------------------------------------------------------
    #---------------------------------------------------------------------------
    #               DONE: ADD YOUR ACTION-SPECIFIC COMMANDS HERE
    #
    #                                    |||
    #                                   \|||/
    #                                    \|/
    #---------------------------------------------------------------------------
    #---------------------------------------------------------------------------
    #  PKCS#11-related
    #---------------------------------------------------------------------------
    ${ARG_ACTION_P11_GET_URI})        p11_get_uri ;;

    #---------------------------------------------------------------------------
    #  Used by two or more token types
    #---------------------------------------------------------------------------
    ${ARG_ACTION_ALL_CHANGE_PIN})     all_change_pin ;;
    ${ARG_ACTION_ALL_CHANGE_PUK})     all_change_puk ;;
    ${ARG_ACTION_ALL_CHANGE_SO_PIN})  all_change_so_pin ;;
    ${ARG_ACTION_ALL_CONNECT})        menu_all_connect ;;
    ${ARG_ACTION_ALL_DELETE})         all_delete ;;
    ${ARG_ACTION_ALL_EXPORT})         all_export ;;
    ${ARG_ACTION_ALL_GET})            all_get ;;
    ${ARG_ACTION_ALL_IMPORT})         all_import ;;
    ${ARG_ACTION_ALL_INITIALIZE})     all_initialize ;;
    ${ARG_ACTION_ALL_KEYPAIRGEN})     all_keypairgen ;;
    ${ARG_ACTION_ALL_LIST})           all_list ;;
    ${ARG_ACTION_ALL_RESET_PIN})      all_reset_pin ;;
    ${ARG_ACTION_ALL_UNBLOCK_PIN})    all_unblock_pin ;;

    #---------------------------------------------------------------------------
    #  OpenSC (PKCS#11)
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    #  OpenSC (PKCS#15)
    #---------------------------------------------------------------------------
    ${ARG_ACTION_OPENSC_P15_ERASE_APPLICATION})  opensc_p15_erase_application ;;
    ${ARG_ACTION_OPENSC_P15_ERASE_CARD})  opensc_p15_erase_card ;;
    ${ARG_ACTION_OPENSC_P15_FINALIZE})    opensc_p15_finalize ;;
    ${ARG_ACTION_OPENSC_P15_STORE_PIN})   opensc_p15_store_pin ;;

    #---------------------------------------------------------------------------
    #  SmartCard-HSM / Nitrokey HSM 2
    #---------------------------------------------------------------------------
    ${ARG_ACTION_SCHSM_BACKUP})             schsm_backup ;;
    ${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE})  schsm_dkek_share_create ;;
    ${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})  schsm_dkek_share_import ;;
    ${ARG_ACTION_SCHSM_RESTORE})            schsm_restore ;;

    #---------------------------------------------------------------------------
    #  Yubico YubiKey PIV
    #---------------------------------------------------------------------------
    ${ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY}) yubico_change_management_key ;;
    #---------------------------------------------------------------------------
    #                                    /|\
    #                                   /|||\
    #                                    |||
    #
    #               DONE: ADD YOUR ACTION-SPECIFIC COMMANDS HERE
    #---------------------------------------------------------------------------
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  trap_main
#  DESCRIPTION:  Trap (cleanup and exit) function for this script
#      GLOBALS:  trap_triggered
# PARAMETER  1:  Signal (EXIT|HUP|INT|QUIT|TERM|...)
#            2:  Kill subshells / child processes? (true|false)
#                (default: 'true')
#            3:  Subshell(s) PID directory
#                (default: '/var/run/$(basename "$0")')
#            4:  Subshell(s) PID file extension (default: 'pid')
#            5:  Operation mode (see <arg_mode> above)
#===============================================================================
trap_main() {
  local arg_signal="${1:-${trap_main_arg_signal}}"
  local arg_sub_kill="${2:-${trap_main_arg_sub_kill:-true}}"
  local arg_sub_pid_dir="${3:-${trap_main_arg_sub_pid_dir:-/var/run/$(basename "$0")}}"
  local arg_sub_pid_ext="${4:-${trap_main_arg_sub_pid_ext:-pid}}"
  local arg_mode="${5:-${trap_main_arg_mode}}"

  #-----------------------------------------------------------------------------
  #       DONE: ADD FURTHER TRAP PARAMETERS HERE (AND IN <init_first()>)
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  IMPORTANT: For each parameter please set its temporary variable (see below,
  #             in the next 'TODO' section) as the default value, e.g.
  #               local arg_myparam="${3:-${trap_main_arg_myparam}}"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #       DONE: ADD FURTHER TRAP PARAMETERS HERE (AND IN <init_first()>)
  #-----------------------------------------------------------------------------

  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  #  Do not run trap handling immediately if it was previously blocked
  trap_triggered="true"
  if ${trap_blocked}; then
    #  Do not continue trap function but save the trap arguments for the next
    #  run (then the trap is manually triggered so probably no arguments will
    #  be passed and therefore need to be restored from the temporary variables)
    trap_main_arg_signal="${arg_signal}"
    trap_main_arg_sub_kill="${arg_sub_kill}"
    trap_main_arg_sub_pid_dir="${arg_sub_pid_dir}"
    trap_main_arg_sub_pid_ext="${arg_sub_pid_ext}"
    trap_main_arg_mode="${arg_mode}"

    #---------------------------------------------------------------------------
    #          DONE: FOR EACH ADDITIONAL TRAP PARAMETER DEFINED ABOVE
    #                    ADD ANOTHER TEMPORARY VARIABLE HERE
    #
    #                                     |||
    #                                    \|||/
    #                                     \|/
    #---------------------------------------------------------------------------
    #  Example: For <arg_myparam> add the following line:
    #             trap_main_arg_myparam="${arg_myparam}"
    #---------------------------------------------------------------------------
    #                                     /|\
    #                                    /|||\
    #                                     |||
    #
    #          DONE: FOR EACH ADDITIONAL TRAP PARAMETER DEFINED ABOVE
    #                    ADD ANOTHER TEMPORARY VARIABLE HERE
    #---------------------------------------------------------------------------

    return
  fi

  #  Get PID (if PID lock is disabled ("PIDLOCK_ENABLED"="false"), then
  #  <lib_os_ps_pidlock()> will fail.)
  local pid
  pid="$(lib_os_ps_pidlock --getpid)" || \
  lib_os_ps_get_ownpid pid
  info --syslog "Signal <${arg_signal}> received. Terminating (PID <${pid}>) ..."

  # Special Trap Handling
  case "${arg_mode}" in
    #---------------------------------------------------------------------------
    #          DONE: DEFINE MODE(S) THAT HAVE NO SPECIAL TRAP HANDLING
    #
    #                                    |||
    #                                   \|||/
    #                                    \|/
    #---------------------------------------------------------------------------
    ${ARG_MODE_DAEMON})
    #---------------------------------------------------------------------------
    #                                    /|\
    #                                   /|||\
    #                                    |||
    #
    #          DONE: DEFINE MODE(S) THAT HAVE NO SPECIAL TRAP HANDLING
    #---------------------------------------------------------------------------
      ;;

    *)
      # Modes with special trap handling
      case "${arg_signal}" in
        EXIT)
          #---------------------------------------------------------------------
          #          DONE: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
          #             IN CASE OF A NORMAL EXIT (NO OTHER SIGNAL)
          #
          #                                 |||
          #                                \|||/
          #                                 \|/
          #---------------------------------------------------------------------
          #---------------------------------------------------------------------
          #                                 /|\
          #                                /|||\
          #                                 |||
          #
          #          DONE: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
          #             IN CASE OF A NORMAL EXIT (NO OTHER SIGNAL)
          #---------------------------------------------------------------------
          ;;

        *)
          #---------------------------------------------------------------------
          #          DONE: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
          #              IN CASE OF ANY INTERRUPT/TERM/... SIGNAL
          #
          #                                 |||
          #                                \|||/
          #                                 \|/
          #---------------------------------------------------------------------
          #---------------------------------------------------------------------
          #                                 /|\
          #                                /|||\
          #                                 |||
          #
          #          DONE: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
          #              IN CASE OF ANY INTERRUPT/TERM/... SIGNAL
          #---------------------------------------------------------------------
          ;;
      esac
      ;;
  esac

  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  if ${arg_sub_kill}; then
    # SIGINT and SIGQUIT cannot be forwarded to subshells / child processes
    # as they may run in background (asynchronously).
    local sub_signal
    case "${arg_signal}" in
      INT|QUIT) sub_signal="TERM";;
      *)        sub_signal="${arg_signal}";;
    esac

    # Kill subshells / child processes
    local file
    for file in "${arg_sub_pid_dir}"/*."${arg_sub_pid_ext}"; do
      [ -f "${file}" ] || break
      lib_os_ps_kill_by_pidfile \
        "${file}" "${sub_signal}" "false" "true" "true" "false"
    done

    # Kill (other) subshells / child processes
    local subpids
    lib_os_ps_get_descendants subpids "${pid}"
    lib_os_ps_kill_by_pid "${subpids}" "${sub_signal}" "false" "true" "true"

    # Remove subshell PID directory
    if lib_core_is --dir "${arg_sub_pid_dir}"; then
      lib_core_sudo rm -rf "${arg_sub_pid_dir}"
    fi
  fi

  #  Remove (parent) PID file
  #  If PID lock is disabled ("PIDLOCK_ENABLED"="false"), then
  #  <lib_os_ps_pidlock()> will fail but without any consequences.
  lib_os_ps_pidlock --unlock
  info --syslog "Script terminated (PID <${pid}>)."

  #  Exit - Depends on signal ...
  case "${arg_signal}" in
    EXIT)
      # ... EXIT
      exit;;
    *)
      # ... other signals:
      # Clear EXIT trap handling, otherwise <trap_main()> would run again.
      trap - EXIT; exit 1;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  warning
#  DESCRIPTION:  Log/Print warning message and optionally exit
#          ...:  See <msg()>
#===============================================================================
warning() {
  msg --warning "$@"
}

#===============================================================================
#  FUNCTIONS (TEMPLATE) (MENUS)
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  menu_arg_action
#  DESCRIPTION:  Interactive menu for setting <arg_action> parameter
#      GLOBALS:  arg_action
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_action() {
  local tag1="${ARG_ACTION_ABOUT}"
  local tag2="${ARG_ACTION_HELP}"
  local tag3="${ARG_ACTION_EXIT}"

  local title
  local text
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ACTION}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ACTION}"
  eval "item1=\${LIB_SHTPL_${ID_LANG}_DLG_ITM_ABOUT}"
  eval "item2=\${LIB_SHTPL_${ID_LANG}_DLG_ITM_HELP}"
  eval "item3=\${LIB_SHTPL_${ID_LANG}_DLG_ITM_EXIT}"

  local list
  list="$(lib_core_str_to --const "ARG_ACTION_LIST_INTERACTIVE_${arg_token_type}")"
  eval "list=\${${list}}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${list}; do
        eval "tag=\${ARG_ACTION_${a}}"
        eval "item=\${L_SC_${ID_LANG}_DLG_ITM_ARG_ACTION_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --title "${title}" --menu "${text}" 0 0 0  \
      ${dlgpairs}                                               \
      "${tag1}"  "${item1}"                                     \
      "${tag2}"  "${item2}"                                     \
      "${tag3}"  "${item3}" 2>&1 1>&3)"                                     || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_action="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_main
#  DESCRIPTION:  Main menu (interactive mode)
#===============================================================================
menu_main() {
  # Check for minimum terminal size (otherwise some dialogues would fail)
  lib_msg_dialog_autosize >/dev/null                                        || \
  { sleep 3; return 1; }

  # <arg_action> can be already set if script is called with <--submenu ...>
  if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE}" ]; then
    menu_arg_action || return
  fi                                                                        && \

  #  Default actions do not depend on any further parameter
  case "${arg_action}" in
    ${ARG_ACTION_ABOUT}|${ARG_ACTION_EXIT}|${ARG_ACTION_HELP}) return;;
  esac                                                                      && \
  #-----------------------------------------------------------------------------
  #                    DONE: DEFINE YOUR MENU HANDLING HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  #  Select an object class / list type
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_EXPORT}|\
    ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_ALL_LIST})
      if lib_core_is --empty "${arg_all_type}"; then menu_arg_all_type; fi
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Select smartcard/token
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ABOUT}|${ARG_ACTION_EXIT}|${ARG_ACTION_HELP}) ;;
    *)
      if ! (  [ "${arg_action}" = "${ARG_ACTION_ALL_LIST}" ] && \
              [ "${arg_all_type}" = "${ARG_ALL_TYPE_READER}" ] ); then
        case "${arg_token_type}" in
          ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
            menu_arg_all_id_reader
            ;;
          ${ARG_TOKEN_TYPE_OPENSC_P15})
            menu_arg_all_id_reader
            ;;
          ${ARG_TOKEN_TYPE_YUBICO})
            menu_arg_all_serial
            ;;
        esac
      fi
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Token-specific parameters (1)
  #-----------------------------------------------------------------------------
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11})
      #-------------------------------------------------------------------------
      #  OpenSC (PKCS#11)
      #-------------------------------------------------------------------------
      ;;

    ${ARG_TOKEN_TYPE_OPENSC_P15})
      #-------------------------------------------------------------------------
      #  OpenSC (PKCS#15)
      #-------------------------------------------------------------------------
      case "${arg_action}" in
        ${ARG_ACTION_ALL_INITIALIZE}|${ARG_ACTION_OPENSC_P15_ERASE_CARD}|\
        ${ARG_ACTION_OPENSC_P15_FINALIZE}) ;;
        ${ARG_ACTION_ALL_LIST})
          case "${arg_all_type}" in
            ${ARG_ALL_TYPE_ALGORITHM}|${ARG_ALL_TYPE_READER}) ;;
            *) menu_arg_p15_id_aid;;
          esac
          ;;
        *) menu_arg_p15_id_aid;;
      esac && \

      case "${arg_action}" in
        ${ARG_ACTION_ALL_INITIALIZE}) menu_arg_opensc_p15_profile;;
      esac && \

      case "${arg_action}" in
        ${ARG_ACTION_ALL_CHANGE_PIN}|${ARG_ACTION_ALL_CHANGE_PUK}|\
        ${ARG_ACTION_ALL_CHANGE_SO_PIN}|${ARG_ACTION_ALL_IMPORT}|\
        ${ARG_ACTION_ALL_KEYPAIRGEN}|${ARG_ACTION_ALL_UNBLOCK_PIN}|\
        ${ARG_ACTION_OPENSC_P15_ERASE_APPLICATION}|\
        ${ARG_ACTION_OPENSC_P15_ERASE_CARD})
          menu_arg_p15_id_auth
          ;;

        ${ARG_ACTION_ALL_EXPORT})
          case "${arg_all_type}" in
            ${ARG_ALL_TYPE_DATA}) menu_arg_p15_id_auth;;
          esac
          ;;

        ${ARG_ACTION_ALL_INITIALIZE})
          case "${arg_opensc_p15_profile}" in
            ${ARG_OPENSC_P15_PROFILE_ONEPIN}) ;;
            *) menu_arg_p15_id_auth;;
          esac
          ;;

        ${ARG_ACTION_ALL_LIST})
          case "${arg_all_type}" in
            ${ARG_ALL_TYPE_DATA}|${ARG_ALL_TYPE_PRIVKEY}|${ARG_ALL_TYPE_SECRKEY})
              menu_arg_p15_id_auth
              ;;
          esac
          ;;

      esac
      ;;

    ${ARG_TOKEN_TYPE_SCHSM})
      #-------------------------------------------------------------------------
      #  SmartCard-HSM / Nitrokey HSM 2
      #-------------------------------------------------------------------------
      case "${arg_action}" in
        ${ARG_ACTION_SCHSM_BACKUP}|${ARG_ACTION_SCHSM_RESTORE})
          menu_arg_schsm_key_reference
          ;;
        ${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE}|${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})
          menu_arg_schsm_pwd_use_threshold_scheme
          ;;
      esac
      ;;

    ${ARG_TOKEN_TYPE_YUBICO})
      #-------------------------------------------------------------------------
      #  Yubico YubiKey PIV
      #-------------------------------------------------------------------------
      case "${arg_action}" in
        ${ARG_ACTION_ALL_INITIALIZE}|${ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY})
          menu_arg_all_key_type
          ;;
      esac
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  All modes that read/write from/to a file
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_IMPORT}|\
    ${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE}|${ARG_ACTION_SCHSM_BACKUP}|\
    ${ARG_ACTION_SCHSM_RESTORE}|${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})
      menu_arg_all_file
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  PINs, PUKs, etc.
  #-----------------------------------------------------------------------------
  # ===========> 'init_update' updates 'all_secrets_...' variables <============
  init_update                                                               && \

  # Request user to enter the current PIN, PUK, SO-PIN, ...
  if lib_core_is --not-empty "${all_secrets_arg_input}"; then
    menu_all_secrets "${ALL_SECRETS_MODE_INPUT}" "${all_secrets_arg_input}" ""
  fi                                                                        && \

  # Request user to either manually enter or randomly generate
  # a new PIN, PUK, SO-PIN, ...
  if lib_core_is --not-empty "${all_secrets_arg_list_change}"; then
    menu_arg_all_random                                                   && \

    # 'init_update' is also responsible for generating random values
    init_update                                                           && \

    # If randomly generated, (optionally) print PIN, PUK, SO-PIN, ... letter
    # BEFORE (re)-entering
    if ${arg_all_random}; then
      menu_arg_all_print && \
      if ${arg_all_print}; then
        if [ "${arg_action}" = "${ARG_ACTION_ALL_INITIALIZE}" ]; then
          menu_arg_all_print_separately
        fi && \
        all_secrets_print
      fi
    fi                                                                    && \

    # Request user to either set a new value or to re-enter
    # the previously randomly generated value
    menu_all_secrets "${all_secrets_mode}"                                \
      "${all_secrets_arg_list_change}" "${all_secrets_arg_replace}"       && \

    # If manually set, (optionally) print PIN, PUK, SO-PIN, ... letter
    # AFTER (re)-entering
    if ! ${arg_all_random}; then
      menu_arg_all_print && \
      if ${arg_all_print}; then
        if [ "${arg_action}" = "${ARG_ACTION_ALL_INITIALIZE}" ]; then
          menu_arg_all_print_separately
        fi && \
        all_secrets_print
      fi
    fi
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  Initialization mode
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ALL_INITIALIZE})
      case "${arg_token_type}" in
        ${ARG_TOKEN_TYPE_OPENSC_P11}) menu_arg_all_label;;
        ${ARG_TOKEN_TYPE_OPENSC_P15}) menu_arg_all_label;;
        ${ARG_TOKEN_TYPE_SCHSM})      menu_arg_schsm_dkek_shares;;
        ${ARG_TOKEN_TYPE_YUBICO})     ;;
      esac
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Specify cert/key/data object/... via its
  #  id/label/oid/application name/keyref
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_IMPORT})
      #-------------------------------------------------------------------------
      #  <arg_action> = <ARG_ACTION_ALL_DELETE|ARG_ACTION_ALL_EXPORT|ARG_ACTION_ALL_IMPORT>
      #-------------------------------------------------------------------------
      case "${arg_all_type}" in
        ${ARG_ALL_TYPE_DATA})
          #---------------------------------------------------------------------
          #  <arg_all_type> = <ARG_ALL_TYPE_DATA>
          #---------------------------------------------------------------------
          case "${arg_token_type}" in
            ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_OPENSC_P15}|${ARG_TOKEN_TYPE_SCHSM})
              #-----------------------------------------------------------------
              #  OpenSC (PKCS#11) + OpenSC (PKCS#15) + SmartCard-HSM / Nitrokey HSM 2
              #-----------------------------------------------------------------
              case "${arg_action}" in
                ${ARG_ACTION_ALL_DELETE})
                  menu_arg_all_data_oid && \
                  if [ -z "${arg_all_data_oid}" ]; then
                    menu_arg_all_data_application_name && \
                    menu_arg_all_label
                  fi
                  ;;
                ${ARG_ACTION_ALL_EXPORT})
                  # TODO: Change order?
                  menu_arg_all_label && \
                  if [ -z "${arg_all_label}" ]; then
                    menu_arg_all_data_oid && \
                    if [ -z "${arg_all_data_oid}" ]; then
                      menu_arg_all_data_application_name
                    fi
                  fi
                  ;;
                ${ARG_ACTION_ALL_IMPORT})
                  menu_arg_all_data_oid && \
                  menu_arg_all_data_application_name && \
                  menu_arg_all_label
                  ;;
              esac
              ;;
            ${ARG_TOKEN_TYPE_YUBICO})
              #-----------------------------------------------------------------
              #  Yubico YubiKey PIV
              #-----------------------------------------------------------------
              case "${arg_action}" in
                ${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_IMPORT})
                  menu_arg_piv_ber_tlv_tag
                  ;;
              esac
              ;;
          esac
          ;;
        *)
          #---------------------------------------------------------------------
          #  <arg_all_type> != <ARG_ALL_TYPE_DATA>
          #---------------------------------------------------------------------
          case "${arg_token_type}" in
            ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
              #-----------------------------------------------------------------
              #  OpenSC (PKCS#11) + SmartCard-HSM / Nitrokey HSM 2
              #-----------------------------------------------------------------
              menu_arg_all_id_object && \
              menu_arg_all_label
              ;;
            ${ARG_TOKEN_TYPE_OPENSC_P15})
              #-----------------------------------------------------------------
              #  OpenSC (PKCS#15)
              #-----------------------------------------------------------------
              menu_arg_all_id_object && \
              if [ "${arg_action}" = "${ARG_ACTION_ALL_IMPORT}" ]; then
                menu_arg_all_label
              fi
              ;;
            ${ARG_TOKEN_TYPE_YUBICO})
              #-----------------------------------------------------------------
              #  Yubico YubiKey PIV
              #-----------------------------------------------------------------
              menu_arg_piv_keyref
              ;;
          esac
          ;;
      esac
      ;;
    ${ARG_ACTION_ALL_KEYPAIRGEN})
      #-------------------------------------------------------------------------
      #  <arg_action> = <ARG_ACTION_ALL_KEYPAIRGEN>
      #-------------------------------------------------------------------------
      case "${arg_token_type}" in
        ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_OPENSC_P15}|${ARG_TOKEN_TYPE_SCHSM})
          #---------------------------------------------------------------------
          #  OpenSC (PKCS#11) +  OpenSC (PKCS#15) + SmartCard-HSM / Nitrokey HSM 2
          #---------------------------------------------------------------------
          menu_arg_all_id_object && \
          menu_arg_all_label
          ;;
        ${ARG_TOKEN_TYPE_YUBICO})
          #---------------------------------------------------------------------
          #  Yubico YubiKey PIV
          #---------------------------------------------------------------------
          menu_arg_piv_keyref
          ;;
      esac
      ;;
  esac                                                                      && \

  # #-----------------------------------------------------------------------------
  # #  All modes that read/write from/to a file
  # #-----------------------------------------------------------------------------
  # case "${arg_action}" in
  #   ${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_IMPORT}|\
  #   ${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE}|${ARG_ACTION_SCHSM_BACKUP}|\
  #   ${ARG_ACTION_SCHSM_RESTORE}|${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})
  #     menu_arg_all_file
  #     ;;
  # esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  All modes that create a key pair
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ALL_KEYPAIRGEN})
      menu_arg_all_key_type
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Token-specific parameters (2)
  #-----------------------------------------------------------------------------
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11})
      #-------------------------------------------------------------------------
      #  OpenSC (PKCS#11)
      #-------------------------------------------------------------------------
      ;;

    ${ARG_TOKEN_TYPE_OPENSC_P15})
      #-------------------------------------------------------------------------
      #  OpenSC (PKCS#15)
      #-------------------------------------------------------------------------
      case "${arg_action}" in
        ${ARG_ACTION_OPENSC_P15_STORE_PIN}) menu_arg_p15_id_auth ;;
      esac
      ;;

    ${ARG_TOKEN_TYPE_SCHSM})
      #-------------------------------------------------------------------------
      #  SmartCard-HSM / Nitrokey HSM 2
      #-------------------------------------------------------------------------
      case "${arg_action}" in
        ${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE})
          if ${arg_schsm_pwd_use_threshold_scheme}; then
            menu_arg_schsm_pwd_shares_total && \
            menu_arg_schsm_pwd_shares_threshold
          fi
          ;;
        ${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})
          if ${arg_schsm_pwd_use_threshold_scheme}; then
            menu_arg_schsm_pwd_shares_total
          fi
          ;;
      esac
      ;;

    ${ARG_TOKEN_TYPE_YUBICO})
      #-------------------------------------------------------------------------
      #  Yubico YubiKey PIV
      #-------------------------------------------------------------------------
      case "${arg_action}" in
        ${ARG_ACTION_ALL_EXPORT})
          case "${arg_all_type}" in
            ${ARG_ALL_TYPE_CERT}|${ARG_ALL_TYPE_PUBKEY})
              menu_arg_all_format
              ;;
          esac
          ;;
        ${ARG_ACTION_ALL_KEYPAIRGEN})
          menu_arg_all_format
          ;;
      esac                                                                  && \

      case "${arg_action}" in
        ${ARG_ACTION_ALL_IMPORT})
          case "${arg_all_type}" in
            ${ARG_ALL_TYPE_PRIVKEY})
              menu_arg_yubico_pin_policy && \
              menu_arg_yubico_touch_policy
              ;;
          esac
          ;;
        ${ARG_ACTION_ALL_KEYPAIRGEN})
          menu_arg_all_file             && \
          menu_arg_yubico_pin_policy    && \
          menu_arg_yubico_touch_policy
          ;;
      esac
      ;;
  esac                                                                      || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                   DONE: DEFINE YOUR UPDATE COMMANDS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------

  # Make sure that <main()> loop does not break if one of the menus above
  # throws an error but also do not perform any action in <run()> function.
  arg_action=""
}

#===============================================================================
#  FUNCTIONS (CUSTOM) (PKCS#11-related)
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  p11_get_uri
#  DESCRIPTION:  Get a PKCS#11 URI of a certain token object
#      OUTPUTS:  Write PKCS#11 URI to <stdout>
#===============================================================================
p11_get_uri() {
  menu_arg_token_type && \
  menu_p11_uri        && \
  printf "%s" "${p11_uri}"
}

#===  FUNCTION  ================================================================
#         NAME:  menu_p11_uri
#  DESCRIPTION:  Interactive menu for setting <p11_uri> parameter
#      GLOBALS:  p11_uri
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_p11_uri() {
  local title1
  local title2
  local extra
  local text
  eval "title1=\${L_SC_${ID_LANG}_DLG_TTL_P11_URI_1}"
  eval "title2=\${L_SC_${ID_LANG}_DLG_TTL_P11_URI_2}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_P11_URI}"

  local OLDIFS="$IFS"
  local IFS="${LIB_C_STR_NEWLINE}"

  local uris
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"
      uris="$(for a in \
        $(p11tool --list-token-urls --provider "${all_p11lib_full}"); do
          printf "%s\n%s\n" "$a" "."
        done)"                                                              && \

      result="$(dialog --title "${title1}" --menu "${text}" 0 0 0 \
        ${uris} 2>&1 1>&3)"                                                 && \

      uris="$(p11tool --list-${arg_p11_uri_filter}    \
                      --provider "${all_p11lib_full}" \
                      "${result}" 2>/dev/null)"                             && \
      uris="$(printf "%s" "${uris}" | sed -ne \
        "s/^[[:space:]]*URL\:[[:space:]]\{1,\}\(.\{1,\}\)$/\1/p")"          && \
      uris="$(for a in ${uris}; do printf "%s\n%s\n" "$a" "."; done)"       && \

      result="$(dialog --extra-button --extra-label "${extra}"              \
        --title "${title2}" --menu "${text}" 0 0 0                          \
        ${uris} 2>&1 1>&3)"                                                 || \

      exitcode="$?"

      case "${exitcode}" in
        3) ;;
        *) break;;
      esac
    done
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then p11_uri="${result}"; fi
  return ${exitcode}
}

#===============================================================================
#  FUNCTIONS (CUSTOM) (PKCS#15-related)
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  menu_arg_p15_id_aid
#  DESCRIPTION:  Interactive menu for setting <arg_p15_id_aid> parameter
#      GLOBALS:  arg_p15_id_aid
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_p15_id_aid() {
  local title1
  local title3
  local extra
  local text1
  local text2
  local text3
  local must_exist  # Action requires an existing object? (true|false)
  eval "title1=\${L_SC_${ID_LANG}_DLG_TTL_ARG_P15_ID_AID_1}"
  eval "title3=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  case "${arg_action}" in
    ${ARG_ACTION_ALL_CHANGE_PIN}|${ARG_ACTION_ALL_CHANGE_PUK}|\
    ${ARG_ACTION_ALL_CHANGE_SO_PIN}|${ARG_ACTION_ALL_DELETE}|\
    ${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_IMPORT}|\
    ${ARG_ACTION_ALL_KEYPAIRGEN}|${ARG_ACTION_ALL_LIST}|\
    ${ARG_ACTION_ALL_UNBLOCK_PIN}|\
    ${ARG_ACTION_OPENSC_P15_ERASE_APPLICATION}|\
    ${ARG_ACTION_OPENSC_P15_ERASE_CARD}|${ARG_ACTION_OPENSC_P15_STORE_PIN})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_P15_ID_AID_EXISTING_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_P15_ID_AID_EXISTING_2}"
      eval "text3=\${L_SC_${ID_LANG}_DLG_TXT_ARG_P15_ID_AID_EXISTING_3}"
      must_exist="true"
      ;;
    *)
      #eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_P15_ID_AID_NEW_1}"
      #eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_P15_ID_AID_NEW_2}"
      #must_exist="false"
      return 2
      ;;
  esac

  # Show dialogue with existing objects? (true|false)
  local show_existing="true"

  # Select list type for <all_list()> call below
  local arg_all_type_old
  arg_all_type_old="${arg_all_type}"
  arg_all_type="${ARG_ALL_TYPE_P15_APPLICATION}"

  local msg1
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"

      # Dialogue 1: (Optional) Show existing items
      if ${show_existing}; then
        # Get item list <msg1>
        { msg1="$(all_list 2>&1)" || \
          { dialog  --no-collapse --title "${title3}" --msgbox "${msg1}" 0 0
            false
          }
        } && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Show item list
          dialog  --no-collapse --title "${title1}" \
                  --msgbox "$(printf "%s\n\n%s" "${text1}" "${msg1}")" 0 0
        elif ${must_exist}; then
          # ... empty: (Optional) Show error dialogue and terminate
          dialog  --no-collapse --title "${title3}" --msgbox "${text3}" 0 0
          false
        fi
      fi                                                                    && \

      # Dialogue 2: Request user to ...
      if ${must_exist}; then
        # ... select/enter an (existing) item (if <must_exist> = true)

        # Prepare item list <msg1> for 'dialog'
        case "${arg_token_type}" in
          ${ARG_TOKEN_TYPE_OPENSC_P15})
            msg1="$(printf "%s" "${msg1}" | sed -ne \
              "s/^[[:space:]]*AID[[:space:]]*\:[[:space:]]\{1,\}\(.\{1,\}\)$/\1/p")"
            ;;
          *) false;;
        esac && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Request user to select an item
          msg1="$(for a in ${msg1}; do printf "%s\n%s\n" "$a" "."; done)" && \
          result="$(dialog --extra-button --extra-label "${extra}"        \
            --title "${title1}" --menu "${text2}" 0 0 0                   \
            ${msg1} 2>&1 1>&3)"
        else
          # ... empty: Request user to manually enter a value
          result="$(dialog --extra-button --extra-label "${extra}"  \
            --title "${title1}" --inputbox "${text2}" 0 0           \
            "${result:-${arg_p15_id_aid}}" 2>&1 1>&3)"
        fi
      elif lib_core_is --not-empty "${msg1}"; then
        # ... enter a (new) value with 'Go back' button (if <msg1> is not empty)
        result="$(dialog --extra-button --extra-label "${extra}"  \
          --title "${title1}" --inputbox "${text2}" 0 0           \
          "${result:-${arg_p15_id_aid}}" 2>&1 1>&3)"
      else
        # ... enter a (new) value but without 'Go back' button
        result="$(dialog --title "${title1}" --inputbox "${text2}" 0 0  \
          "${result:-${arg_p15_id_aid}}" 2>&1 1>&3)"
      fi                                                                    || \

      exitcode="$?"

      case "${exitcode}" in
        0) lib_core_is --hex "${result}" && break;;
        3) ;;
        *) break;;
      esac
    done
  exec 3>&-

  arg_all_type="${arg_all_type_old}"

  if [ "${exitcode}" -eq "0" ]; then arg_p15_id_aid="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_p15_id_auth
#  DESCRIPTION:  Interactive menu for setting <arg_p15_id_auth> parameter
#      GLOBALS:  arg_p15_id_auth
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_p15_id_auth() {
  local title1
  local title3
  local extra
  local text1
  local text2
  local text3
  local must_exist  # Action requires an existing object? (true|false)
  eval "title1=\${L_SC_${ID_LANG}_DLG_TTL_ARG_P15_ID_AUTH_1}"
  eval "title3=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  case "${arg_action}" in
    ${ARG_ACTION_ALL_INITIALIZE}|${ARG_ACTION_OPENSC_P15_STORE_PIN})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_P15_ID_AUTH_NEW_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_P15_ID_AUTH_NEW_2}"
      must_exist="false"
      ;;
    *)
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_2}"
      eval "text3=\${L_SC_${ID_LANG}_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_3}"
      must_exist="true"
      ;;
  esac

  # Show dialogue with existing objects? (true|false)
  local show_existing="true"
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P15})
      if [ "${arg_action}" = "${ARG_ACTION_ALL_INITIALIZE}" ]; then
        show_existing="false"
      fi
      ;;
  esac

  # Select list type for <all_list()> call below
  local arg_all_type_old
  arg_all_type_old="${arg_all_type}"
  arg_all_type="${ARG_ALL_TYPE_P15_PIN}"

  local msg1
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"

      # Dialogue 1: (Optional) Show existing items
      if ${show_existing}; then
        # Get item list <msg1>
        { msg1="$(all_list 2>&1)" || \
          { dialog  --no-collapse --title "${title3}" --msgbox "${msg1}" 0 0
            false
          }
        } && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Show item list
          dialog  --no-collapse --title "${title1}" \
                  --msgbox "$(printf "%s\n\n%s" "${text1}" "${msg1}")" 0 0
        elif ${must_exist}; then
          # ... empty: (Optional) Show error dialogue and terminate
          dialog  --no-collapse --title "${title3}" --msgbox "${text3}" 0 0
          false
        fi
      fi                                                                    && \

      # Dialogue 2: Request user to ...
      if ${must_exist}; then
        # ... select/enter an (existing) item (if <must_exist> = true)

        # Prepare item list <msg1> for 'dialog'
        case "${arg_token_type}" in
          ${ARG_TOKEN_TYPE_OPENSC_P15})
            msg1="$(printf "%s" "${msg1}" | sed -ne \
              "s/^[[:space:]]*ID[[:space:]]*\:[[:space:]]\{1,\}\(.\{1,\}\)$/\1/p")"
            ;;
          *) false;;
        esac && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Request user to select an item
          msg1="$(for a in ${msg1}; do printf "%s\n%s\n" "$a" "."; done)" && \
          result="$(dialog --extra-button --extra-label "${extra}"        \
            --title "${title1}" --menu "${text2}" 0 0 0                   \
            ${msg1} 2>&1 1>&3)"
        else
          # ... empty: Request user to manually enter a value
          result="$(dialog --extra-button --extra-label "${extra}"  \
            --title "${title1}" --inputbox "${text2}" 0 0           \
            "${result:-${arg_p15_id_auth}}" 2>&1 1>&3)"
        fi
      elif lib_core_is --not-empty "${msg1}"; then
        # ... enter a (new) value with 'Go back' button (if <msg1> is not empty)
        result="$(dialog --extra-button --extra-label "${extra}"  \
          --title "${title1}" --inputbox "${text2}" 0 0           \
          "${result:-${arg_p15_id_auth}}" 2>&1 1>&3)"
      else
        # ... enter a (new) value but without 'Go back' button
        result="$(dialog --title "${title1}" --inputbox "${text2}" 0 0  \
          "${result:-${arg_p15_id_auth}}" 2>&1 1>&3)"
      fi                                                                    || \

      exitcode="$?"

      case "${exitcode}" in
        0) lib_core_regex --hex "${result}" && break;;
        3) ;;
        *) break;;
      esac
    done
  exec 3>&-

  arg_all_type="${arg_all_type_old}"

  if [ "${exitcode}" -eq "0" ]; then arg_p15_id_auth="${result}"; fi
  return ${exitcode}
}

#===============================================================================
#  FUNCTIONS (CUSTOM) ("FIPS 201 (PIV Card)"-related)
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  menu_arg_piv_ber_tlv_tag
#  DESCRIPTION:  Interactive menu for setting <arg_piv_ber_tlv_tag> parameter
#      GLOBALS:  arg_piv_ber_tlv_tag
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_piv_ber_tlv_tag() {
  local title
  local text
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_PIV_BER_TLV_TAG}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_PIV_BER_TLV_TAG}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${ARG_PIV_BER_TLV_TAG_LIST}; do
        tag="$a"
        eval "item=\${L_SC_${ID_LANG}_DLG_ITM_ARG_PIV_BER_TLV_TAG_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --no-collapse --title "${title}" --menu "${text}" 0 0 0 \
      ${dlgpairs} 2>&1 1>&3)"                                               || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_piv_ber_tlv_tag="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_piv_keyref
#  DESCRIPTION:  Interactive menu for setting <arg_piv_keyref> parameter
#      GLOBALS:  arg_piv_keyref
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_piv_keyref() {
  local title
  local text
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_PIV_KEYREF}"
  case "${arg_action}" in
    ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_EXPORT})
      eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_PIV_KEYREF_EXISTING}"
      ;;
    ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_ALL_KEYPAIRGEN})
      eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_PIV_KEYREF_NEW}"
      ;;
  esac

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${ARG_PIV_KEYREF_LIST}; do
        tag="$a"
        eval "item=\${L_SC_${ID_LANG}_DLG_ITM_ARG_PIV_KEYREF_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --no-collapse --title "${title}" --menu "${text}" 0 0 0 \
      ${dlgpairs} 2>&1 1>&3)"                                               || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_piv_keyref="${result}"; fi
  return ${exitcode}
}

#===============================================================================
#  FUNCTIONS (CUSTOM) (Used by two or more token types)
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  all_change_pin
#  DESCRIPTION:  Change user PIN (using user PIN)
#===============================================================================
all_change_pin() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
                                  opensc_p11_change_pin ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_change_pin ;;
    ${ARG_TOKEN_TYPE_YUBICO})     yubico_change_pin ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_change_puk
#  DESCRIPTION:  Change user PUK (using user PUK)
#===============================================================================
all_change_puk() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_change_puk ;;
    ${ARG_TOKEN_TYPE_YUBICO})     yubico_change_puk ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_change_so_pin
#  DESCRIPTION:  Change Security Officer PIN (SO-PIN)
#===============================================================================
all_change_so_pin() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
                                  opensc_p11_change_so_pin ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_change_so_pin ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_delete
#  DESCRIPTION:  Delete certificate / private key / data
#===============================================================================
all_delete() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
                                  opensc_p11_delete ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_delete ;;
    ${ARG_TOKEN_TYPE_YUBICO})     yubico_delete ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_export
#  DESCRIPTION:  Export an object from a token to a file
#===============================================================================
all_export() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
                                  opensc_p11_export ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_export ;;
    ${ARG_TOKEN_TYPE_YUBICO})     yubico_export ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_file_print
#  DESCRIPTION:  Print a letter with <all_file_content>
#                (= <arg_all_file>'s raw content)
#   RETURNS  0:  Letter was successfully printed
#            1:  Error or user interrupt
#===============================================================================
all_file_print() {
  local title
  local text1
  eval "title=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ALL_FILE_PRINT_1}"

  local exitcode="0"

  ( # Relevant variables must be exported, otherwise the TeX template/script
    # won't be able to use it. The subshell ensures that the export is limited
    # to the commands within it.

    local arg_all_token

    # Get and export token information
    arg_all_get="${ARG_ALL_GET_SMARTCARD}"  && \
    arg_all_token="$(all_get)"              && \

    export all_file_content arg_all_file arg_all_token
    "${I_FILE_SH_TEX}"  \
      --submenu print   \
      --vars "all_file_content arg_all_file arg_all_token" \
      "${I_FILE_TEX_SC}"
  )                                                                         || \

  { exitcode="$?"
    dialog --title "${title}" --msgbox "${text1}" 0 0
  }

  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  all_get
#  DESCRIPTION:  Get/Parse information about reader/smartcard
#      OUTPUTS:  Write selected information to <stdout>
#===============================================================================
all_get() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM}|\
    ${ARG_TOKEN_TYPE_YUBICO})
                                  opensc_p11_get ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_get ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_import
#  DESCRIPTION:  Import an object from a file to a token
#===============================================================================
all_import() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
                                  opensc_p11_import ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_import ;;
    ${ARG_TOKEN_TYPE_YUBICO})     yubico_import ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_initialize
#  DESCRIPTION:  Initialize device
#===============================================================================
all_initialize() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}) opensc_p11_initialize ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_initialize ;;
    ${ARG_TOKEN_TYPE_SCHSM})      schsm_initialize ;;
    ${ARG_TOKEN_TYPE_YUBICO})     yubico_initialize ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_keypairgen
#  DESCRIPTION:  Generate (public/private) key pair
#===============================================================================
all_keypairgen() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
                                  opensc_p11_keypairgen ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_keypairgen ;;
    ${ARG_TOKEN_TYPE_YUBICO})     yubico_keypairgen ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_list
#  DESCRIPTION:  List available objects (certs, data, keys, etc.)
#===============================================================================
all_list() {
  local list
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
                                  opensc_p11_list ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_list ;;
    ${ARG_TOKEN_TYPE_YUBICO})     yubico_list ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_secrets_print
#  DESCRIPTION:  Print a letter with PIN, PUK, SO-PIN, ...
#   RETURNS  0:  Letter was successfully printed
#            1:  Error or user interrupt
#===============================================================================
all_secrets_print() {
  local title
  local text1
  eval "title=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ALL_SECRETS_PRINT_1}"

  local exitcode="0"

  ( # Secrets (PIN, PUK, etc.) and token information must be exported, otherwise
    # the TeX template/script won't be able to use it. The subshell ensures
    # that the export is limited to the commands within it.

    local arg_all_token

    # Get and export token information
    arg_all_get="${ARG_ALL_GET_SMARTCARD}"  && \
    arg_all_token="$(all_get)"              && \
    export arg_all_token                    && \

    if [ "${all_secrets_mode}" = "${ALL_SECRETS_MODE_REPLACE}" ]; then
      # In replace mode the (new) value is not stored in the original variable,
      # e.g. 'arg_all_pin', but in a second one, e.g. 'arg_all_newpinpuk'.
      #
      # However, the TeX template cannot deal with the new variable so the new
      # value must be stored in the original variable. This modification is
      # limited to the subshell so the parent variables are not touched at all.
      #
      # The original variable's pointer is stored in 'all_secrets_arg_list_change',
      # the new variable's pointer is stored in 'all_secrets_arg_replace'.
      eval "${all_secrets_arg_list_change}=\${${all_secrets_arg_replace}}"
    fi && \

    # Optionally print user secrets (PIN, PUK) and admin secrets
    # (SO-PIN, SO-PUK, Management Key) on separate documents
    if ${arg_all_print_separately}; then
      # Print letter with user secrets if PIN and/or PUK are set
      if ! lib_core_is --empty "${arg_all_pin}" "${arg_all_puk}"; then
        ( export arg_all_pin arg_all_puk
          "${I_FILE_SH_TEX}"                                \
            --submenu print                                 \
            --vars "arg_all_token arg_all_pin arg_all_puk"  \
            "${I_FILE_TEX_SC}"
        )
      fi && \

      # Print letter with admin secrets if at least one of the following
      # secrets are set: SO-PIN, SO-PUK, Management Key
      if ! lib_core_is --empty  "${arg_all_sopin}" "${arg_all_sopuk}" \
                                "${arg_yubico_management_key}"; then
        ( export arg_all_sopin arg_all_sopuk arg_yubico_management_key
          "${I_FILE_SH_TEX}"  \
            --submenu print   \
            --vars "arg_all_token arg_all_sopin arg_all_sopuk arg_yubico_management_key" \
            "${I_FILE_TEX_SC}"
        )
      fi
    else
      export arg_all_file arg_all_password arg_all_pin arg_all_puk arg_all_sopin arg_all_sopuk arg_yubico_management_key
      "${I_FILE_SH_TEX}"  \
        --submenu print   \
        --vars "arg_all_token arg_all_file arg_all_password arg_all_pin arg_all_puk arg_all_sopin arg_all_sopuk arg_yubico_management_key" \
        "${I_FILE_TEX_SC}"
    fi
  )                                                                         || \

  { exitcode="$?"
    dialog --title "${title}" --msgbox "${text1}" 0 0
  }

  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  all_secrets_random
#
#  DESCRIPTION:  Randomly create PIN, PUK, SO-PIN, ...
#
#      GLOBALS:  Depends on the variable (pointers) given via parameter <2>
#
# PARAMETER  1:  Mode, for a list of possible values see 'ALL_SECRETS_MODE_...'
#                constants at the beginning of the script
#            2:  Depends on param <1>:
#                  'ALL_SECRETS_MODE_REPLACE'
#                    Variable (pointer) that contains the old value
#                  (OTHER)
#                    Variable (pointer(s)) that will be initialized with
#                    randomized values (multiple pointers separated by space)
#            3:  Variable (pointer) that will contain the new (randomized) value
#                (only if param <1> is 'ALL_SECRETS_MODE_REPLACE')
#
#   RETURNS  0:  Parameter(s) successfully changed
#            1:  Error or user interrupt
#
#      EXAMPLE:  Randomly create new SO-PIN
#                  > menu_all_secrets "new" "arg_all_sopin"
#                Randomly replace PIN
#                  > menu_all_secrets "replace" "arg_all_pin" "arg_all_newpinpuk"
#===============================================================================
all_secrets_random() {
  # See description for 'ALL_SECRETS_MODE_...' constants
  local ARG_ACTION_NEW="${ALL_SECRETS_MODE_NEW}"
  local ARG_ACTION_REPLACE="${ALL_SECRETS_MODE_REPLACE}"
  local arg_action="${1:-${ARG_ACTION_NEW}}"

  local arg_args="$2"
  local arg_replace="$3"

  local chars
  local len
  local arg
  for arg in ${arg_args}; do
    #---------------------------------------------------------------------------
    #  Check if argument is already set (= no need to randomize)
    #---------------------------------------------------------------------------
    if [ "${arg_action}" = "${ARG_ACTION_REPLACE}" ]; then
      # In replace mode the variable (pointer) to check is not 'arg' but
      # 'arg_replace' as this variable (pointer) will contain the new value
      eval lib_core_is --not-empty "\${${arg_replace}}" && continue
    else
      eval lib_core_is --not-empty "\${${arg}}" && continue
    fi

    #---------------------------------------------------------------------------
    #  Set default character class
    #---------------------------------------------------------------------------
    # Get token-specific character class
    chars="$(lib_core_str_to --const "${arg}_CHARS_DEFAULT_${arg_token_type}")"

    # In case specific class does not exist use default one
    if lib_core_var_is --unset "${chars}"; then
      chars="$(lib_core_str_to --const "${arg}_CHARS_DEFAULT_ALL")"
    fi

    # Evaluate <chars> as it is still a pointer
    eval "chars=\${${chars}}"

    # In case all characters are allowed (meaning <chars> is empty)
    # <lib_core_str_random()> yet expects a characters class
    chars="${chars:-[:graph:]}"

    #---------------------------------------------------------------------------
    #  Set default length
    #---------------------------------------------------------------------------
    case "${arg}" in
      arg_yubico_management_key)
        #-----------------------------------------------------------------------
        #  <arg_yubico_management_key> / <arg_yubico_new_management_key>
        #-----------------------------------------------------------------------
        #  Why is <arg_yubico_new_management_key> not listed in 'case' statement
        #  above? => In case of replacement, <arg>/<arg_args> only contains
        #  the variable (pointer) with the old value and not the one with the
        #  new value.
        #
        #  The length in byte has to be doubled (*2) as each byte is
        #  represented by a hexadecimal value between 0x00 and 0xFF
        #  See also: https://docs.yubico.com/yesdk/users-manual/application-piv/pin-puk-mgmt-key.html
        case "${arg_all_key_type}" in
            AES*) len="$(( ( ${arg_all_key_type#"AES"} / 8 ) * 2 ))";;
            TDES) len="$(( 24 * 2 ))";;
            # *)
            #   # <ARG_YUBICO_MANAGEMENT_KEY_LEN_YUBICO> must not be doubled as
            #   # it already contains the default length in hex size
            #   len="${ARG_YUBICO_MANAGEMENT_KEY_LEN_YUBICO}"
            #   ;;
        esac
        ;;

      *)
        #-----------------------------------------------------------------------
        #  Other secrets
        #-----------------------------------------------------------------------
        len="$(lib_core_str_to --const "${arg}_LEN_${arg_token_type}")"
        eval "len=\${${len}}"

        # In case specific list does not exist use a default one
        if lib_core_is --empty "${len}"; then
          len="$(lib_core_str_to --const "${arg}_LEN_ALL")"
          eval "len=\${${len}}"
        fi
        ;;
    esac

    #---------------------------------------------------------------------------
    #  Set parameter
    #---------------------------------------------------------------------------
    if [ "${arg_action}" = "${ARG_ACTION_REPLACE}" ]; then
      eval "${arg_replace}=\${${arg_replace}:-$(lib_core_str_random "${len}" "${chars}")}"
    else
      eval "${arg}=\$(lib_core_str_random \"${len}\" \"${chars}\")"
    fi
  done
}

#===  FUNCTION  ================================================================
#         NAME:  all_reset_pin
#  DESCRIPTION:  Reset user PIN (using SO-PIN)
#===============================================================================
all_reset_pin() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM}) opensc_p11_reset_pin ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_unblock_pin
#  DESCRIPTION:  Unblock user PIN (using user PUK)
#===============================================================================
all_unblock_pin() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}) opensc_p11_unblock_pin ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_unblock_pin ;;
    ${ARG_TOKEN_TYPE_YUBICO})     yubico_unblock_pin ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  all_verify_pinpuk
#  DESCRIPTION:  Verify PIN, PUK, SO-PIN, ...
# PARAMETER  1:  Variable identifier, e.g. 'arg_all_pin'
#            2:  Value (secret) to be verified
#===============================================================================
all_verify_pinpuk() {
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM}|\
    ${ARG_TOKEN_TYPE_YUBICO})     opensc_p11_verify_pinpuk "$@" ;;
    ${ARG_TOKEN_TYPE_OPENSC_P15}) opensc_p15_verify_pinpuk "$@" ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  menu_all_connect
#  DESCRIPTION:  Interactive menu for connecting a smartcard/token
#   RETURNS  0:  Token successfully connected
#            1:  Token not connected or timeout occured
#===============================================================================
menu_all_connect() {
  local title1
  local title2
  local text1
  local text2
  eval "title1=\${L_SC_${ID_LANG}_DLG_TTL_ALL_CONNECT}"
  eval "title2=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ALL_CONNECT_1}"
  eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ALL_CONNECT_2}"

  local result
  local exitcode
  exec 3>&1
    dialog  --title "${title1}" --msgbox "${text1}" 0 0

    while true; do
      exitcode="0"
      if opensc-tool --list-readers | grep -q -E '^[[:digit:]]+\s+Yes' ; then
        break
      else
        dialog --title "${title2}" --yesno "${text2}" 0 0 || \
        { exitcode="$?"
          break
        }
      fi
    done
  exec 3>&-

  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_all_secrets
#
#  DESCRIPTION:  Interactive menu for entering/changing secrets like
#                PIN, PUK, SO-PIN, SO-PUK, Management Key, File Password
#
#      GLOBALS:  Depends on the variable (pointers) given via parameter <2>
#
# PARAMETER  1:  Mode, for a list of possible values see 'ALL_SECRETS_MODE_...'
#                constants at the beginning of the script
#            2:  Depends on param <1>:
#                  'ALL_SECRETS_MODE_REPLACE'
#                    Variable (pointer) that contains the old value
#                  (OTHER)
#                    Variable (pointer(s)) for which the user is requested to
#                    enter/set a value (multiple pointers separated by space)
#            3:  Variable (pointer) that contains the new value
#                (only if param <1> is 'ALL_SECRETS_MODE_REPLACE')
#
#   RETURNS  0:  Parameter(s) successfully changed
#            1:  Error or user interrupt
#
#      EXAMPLE:  Enter (existing) PUK
#                  > menu_all_secrets "input" "arg_all_puk"
#                Enter new SO-PIN
#                  > menu_all_secrets "new" "arg_all_sopin"
#                Replace PIN by entering its existing and its new value
#                  > menu_all_secrets "replace" "arg_all_pin" "arg_all_newpinpuk"
#===============================================================================
menu_all_secrets() {
  # See description for 'ALL_SECRETS_MODE_...' constants
  local ARG_ACTION_INPUT="${ALL_SECRETS_MODE_INPUT}"
  local ARG_ACTION_NEW="${ALL_SECRETS_MODE_NEW}"
  local ARG_ACTION_REPLACE="${ALL_SECRETS_MODE_REPLACE}"
  local arg_action="${1:-${ARG_ACTION_INPUT}}"

  local arg_args="$2"
  local arg_replace="$3"

  local title1
  local title2
  local text11
  local text12
  local text13
  local text21
  local text22

  local arg
  for arg in ${arg_args}; do
    #---------------------------------------------------------------------------
    #  Set dialog titles/texts
    #---------------------------------------------------------------------------
    title1="$(lib_core_str_to --const "L_SC_${ID_LANG}_DLG_TTL_${arg}")"
    eval "title1=\${${title1}}"
    eval "title2=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
    case "${arg_action}" in
      ${ARG_ACTION_INPUT})
        eval "text11=\${L_SC_${ID_LANG}_DLG_TXT_ALL_SECRETS_EXISTING_1}"
        eval "text11=\"${text11}\""
        eval "text21=\${L_SC_${ID_LANG}_DLG_TXT_ALL_SECRETS_EXISTING_21}"
        eval "text21=\"${text21}\""
        eval "text22=\${L_SC_${ID_LANG}_DLG_TXT_ALL_SECRETS_EXISTING_22}"
        eval "text22=\"${text22}\""
        ;;
      ${ARG_ACTION_NEW}|${ARG_ACTION_REPLACE})
        text11="$(lib_core_str_to --const "L_SC_${ID_LANG}_DLG_TXT_ALL_SECRETS_NEW_11_${arg_token_type}")"
        eval "text11=\${${text11}}"
        eval "text11=\"${text11}\""
        text12="$(lib_core_str_to --const "L_SC_${ID_LANG}_DLG_TXT_ALL_SECRETS_NEW_12")"
        eval "text12=\${${text12}}"
        eval "text12=\"${text12}\""
        text13="$(lib_core_str_to --const "L_SC_${ID_LANG}_DLG_TXT_ALL_SECRETS_NEW_13")"
        eval "text13=\${${text13}}"
        eval "text13=\"${text13}\""
        text21="$(lib_core_str_to --const "L_SC_${ID_LANG}_DLG_TXT_ALL_SECRETS_NEW_21")"
        eval "text21=\${${text21}}"
        eval "text21=\"${text21}\""
        text22="$(lib_core_str_to --const "L_SC_${ID_LANG}_DLG_TXT_ALL_SECRETS_NEW_22")"
        eval "text22=\${${text22}}"
        eval "text22=\"${text22}\""
        ;;
    esac

    local chars
    local len
    local len_min
    local len_max
    #---------------------------------------------------------------------------
    #  Set allowed characters
    #---------------------------------------------------------------------------
    # Get token-specific character class
    chars="$(lib_core_str_to --const "${arg}_CHARS_ALLOWED_${arg_token_type}")"

    # In case specific class does not exist use default one
    if lib_core_var_is --unset "${chars}"; then
      chars="$(lib_core_str_to --const "${arg}_CHARS_ALLOWED_ALL")"
    fi

    # Evaluate <chars> at is still a pointer
    eval "chars=\${${chars}}"

    # <chars> can either be a character class ([:...:]) or still empty ("")
    # meaning that all characters are allowed
    if lib_core_is --empty "${chars}"; then
      chars="."
    else
      chars="[${chars}]"
    fi

    #---------------------------------------------------------------------------
    #  Set minimum/maximum length
    #---------------------------------------------------------------------------
    case "${arg}" in
      arg_yubico_management_key)
        #-----------------------------------------------------------------------
        #  <arg_yubico_management_key> / <arg_yubico_new_management_key>
        #-----------------------------------------------------------------------
        #  Why is <arg_yubico_new_management_key> not listed in 'case' statement
        #  above? => In case of replacement, <arg>/<arg_args> only contains
        #  the variable (pointer) with the old value and not the one with the
        #  new value.
        case "${arg_action}" in
          ${ARG_ACTION_NEW}|${ARG_ACTION_REPLACE})
            #-------------------------------------------------------------------
            #  Management key is set or changed
            #-------------------------------------------------------------------
            #  The length in byte has to be doubled (*2) as each byte is
            #  represented by a hexadecimal value between 0x00 and 0xFF
            #  See also: https://docs.yubico.com/yesdk/users-manual/application-piv/pin-puk-mgmt-key.html
            case "${arg_all_key_type}" in
              AES*)
                len_min="$(( ( ${arg_all_key_type#"AES"} / 8 ) * 2 ))"
                len_max="${len_min}"
                ;;
              TDES)
                len_min="$(( 24 * 2 ))"
                len_max="${len_min}"
                ;;
            esac
            ;;
          ${ARG_ACTION_INPUT})
            #-------------------------------------------------------------------
            #  Management key is just request but not changed
            #-------------------------------------------------------------------
            #  No maximum length as we do not know the key's algorithm/length
            len_min="${ARG_YUBICO_MANAGEMENT_KEY_LEN_MIN_YUBICO}"
            len_max=""
            ;;
        esac
        ;;

      *)
        #-----------------------------------------------------------------------
        #  Other secrets
        #-----------------------------------------------------------------------
        # Get token-specific lengths
        len_min="$(lib_core_str_to --const "${arg}_LEN_MIN_${arg_token_type}")"
        len_max="$(lib_core_str_to --const "${arg}_LEN_MAX_${arg_token_type}")"

        # In case specific lengths does not exist use default ones
        if lib_core_is --empty "${len_min}"; then
          len_min="$(lib_core_str_to --const "${arg}_LEN_MIN_ALL")"
        fi
        if lib_core_is --empty "${len_max}"; then
          len_max="$(lib_core_str_to --const "${arg}_LEN_MAX_ALL")"
        fi

        # <len_min> and <len_max> are still pointers
        eval "len_min=\${${len_min}}"
        eval "len_max=\${${len_max}}"

        # <len_min> must be set
        len_min="${len_min:-0}"
        ;;
    esac

    local msg12
    local msg22
    local result1 # First input
    local result2 # Second input (for verfication)
    local exitcode
    exec 3>&1
      while true; do
        exitcode="0"

        #-----------------------------------------------------------------------
        #  First input
        #-----------------------------------------------------------------------
        if ${arg_all_random} && [ "${arg_action}" != "${ARG_ACTION_INPUT}" ]; then
          #---------------------------------------------------------------------
          #  Argument is randomly generated => Skip first input
          #---------------------------------------------------------------------
          # In replace mode the argmument (pointer) containing the new
          # (randomly generated) value is located in 'arg_replace'
          case "${arg_action}" in
            ${ARG_ACTION_REPLACE}) eval "result1=\${${arg_replace}}" ;;
            *) eval "result1=\${${arg}}" ;;
          esac

          # Show argument if it is randomly generated but not printed
          if ! ${arg_all_print}; then
            msg12="$(printf "%s" "${text12}"; lib_msg_print_heading -120 "${result1}" "55")"
            dialog --no-collapse --title "${title1}" --msgbox "${msg12}" 0 0
          fi
        else
          #---------------------------------------------------------------------
          #  Argument is NOT randonly generated => Request input
          #---------------------------------------------------------------------
          result1="$(dialog --no-collapse --title "${title1}" \
            --passwordbox "${text11}" 0 0 2>&1 1>&3)"                       || \
          exitcode="$?"

          case "${exitcode}" in
            0)
              # Ensure that the entered value matches the criterias defined above
              if lib_core_regex "${chars}{${len_min},${len_max}}" "${result1}"; then
                # OK
                if [ "${arg_action}" = "${ARG_ACTION_INPUT}" ]; then
                  # In case of input mode verify the PIN, PUK, SO-PIN, ... before continuing
                  msg22="$(all_verify_pinpuk "${arg}" "${result1}")"          || \
                  { msg22="$(printf "%s\n\n%s" "${text22}" "${msg22}")"
                    dialog --no-collapse --title "${title2}" --msgbox "${msg22}" 0 0
                    continue
                  }
                fi
              else
                # Error
                dialog --no-collapse --title "${title2}" --msgbox "${text21}" 0 0
                continue
              fi
              ;;
            *) break;;
          esac
        fi

        #-----------------------------------------------------------------------
        #  Second input
        #-----------------------------------------------------------------------
        # Skip second input if PIN, PUK, SO-PIN, ... is only entered but not changed
        case "${arg_action}" in
          ${ARG_ACTION_INPUT}) break;;
        esac

        result2="$(dialog --no-collapse --title "${title1}" \
          --passwordbox "${text13}" 0 0 2>&1 1>&3)"                           || \
        exitcode="$?"

        case "${exitcode}" in
          0)
            # Only continue if both inputs are identical
            if [ "${result1}" = "${result2}" ]; then
              break
            else
              dialog  --no-collapse --title "${title2}" --msgbox "${text22}" 0 0
            fi
            ;;
          *) break;;
        esac
      done
    exec 3>&-

    #---------------------------------------------------------------------------
    #  Finally set variable
    #---------------------------------------------------------------------------
    if [ "${exitcode}" -eq "0" ]; then
      case "${arg_action}" in
        ${ARG_ACTION_INPUT})    eval "${arg}=\${result1}" ;;
        ${ARG_ACTION_NEW})      eval "${arg}=\${result2}" ;;
        ${ARG_ACTION_REPLACE})
          # In replace mode the variable (pointer) to be changed
          # is stored in 'arg_replace'
          eval "${arg_replace}=\${result2}"
          ;;
      esac
    else
      break
    fi
  done

  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_data_application_name
#  DESCRIPTION:  Interactive menu for setting <arg_all_data_application_name>
#                parameter
#      GLOBALS:  arg_all_data_application_name
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_all_data_application_name() {
  local title1
  local title3
  local extra
  local text1
  local text2
  local must_exist  # Action requires an existing object? (true|false)
  eval "title1=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_DATA_APPLICATION_NAME_1}"
  eval "title3=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  case "${arg_action}" in
    ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_EXPORT})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_2}"
      eval "text3=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_3}"
      must_exist="true"
      ;;
    ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_ALL_KEYPAIRGEN})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_NEW_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_NEW_2}"
      must_exist="false"
      ;;
  esac

  # Show dialogue with existing objects? (true|false)
  local show_existing="true"

  # Select list type for <all_list()> call below
  local arg_all_type_old
  arg_all_type_old="${arg_all_type}"
  if ! ${must_exist}; then arg_all_type="${ARG_ALL_TYPE_DATA}"; fi

  local msg1
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"

      # Dialogue 1: (Optional) Show existing items
      if ${show_existing}; then
        # Get item list <msg1>
        { msg1="$(all_list 2>&1)" || \
          { dialog  --no-collapse --title "${title3}" --msgbox "${msg1}" 0 0
            false
          }
        } && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Show item list
          dialog  --no-collapse --title "${title1}" \
                  --msgbox "$(printf "%s\n\n%s" "${text1}" "${msg1}")" 0 0
        elif ${must_exist}; then
          # ... empty: (Optional) Show error dialogue and terminate
          dialog  --no-collapse --title "${title3}" --msgbox "${text3}" 0 0
          false
        fi
      fi                                                                    && \

      # Dialogue 2: Request user to ...
      if ${must_exist}; then
        # ... select/enter an (existing) item (if <must_exist> = true)

        # Prepare item list <msg1> for 'dialog'
        case "${arg_token_type}" in
          ${ARG_TOKEN_TYPE_OPENSC_P11})
            msg1="$(printf "%s" "${msg1}" | sed -ne \
              "s/^[[:space:]]*application[[:space:]]*\:[[:space:]]\{1,\}\(.\{1,\}\)$/\1/p")"
            ;;
          ${ARG_TOKEN_TYPE_OPENSC_P15})
            msg1="$(printf "%s" "${msg1}" | sed -ne \
              "s/^[[:space:]]*applicationName[[:space:]]*\:[[:space:]]\{1,\}\(.\{1,\}\)$/\1/p")"
            ;;
          *) false;;
        esac && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Request user to select an item
          msg1="$(for a in ${msg1}; do printf "%s\n%s\n" "$a" "."; done)" && \
          result="$(dialog --extra-button --extra-label "${extra}"        \
            --title "${title1}" --menu "${text2}" 0 0 0                   \
            ${msg1} 2>&1 1>&3)"
        else
          # ... empty: Request user to manually enter a value
          result="$(dialog --extra-button --extra-label "${extra}"  \
            --title "${title1}" --inputbox "${text2}" 0 0           \
            "${result:-${arg_all_data_application_name}}" 2>&1 1>&3)"
        fi
      elif lib_core_is --not-empty "${msg1}"; then
        # ... enter a (new) value with 'Go back' button (if <msg1> is not empty)
        result="$(dialog --extra-button --extra-label "${extra}"  \
          --title "${title1}" --inputbox "${text2}" 0 0           \
          "${result:-${arg_all_data_application_name}}" 2>&1 1>&3)"
      else
        # ... enter a (new) value but without 'Go back' button
        result="$(dialog --title "${title1}" --inputbox "${text2}" 0 0  \
          "${result:-${arg_all_data_application_name}}" 2>&1 1>&3)"
      fi                                                                    || \

      exitcode="$?"

      case "${exitcode}" in
        0) break;;
        3) ;;
        *) break;;
      esac
    done
  exec 3>&-

  arg_all_type="${arg_all_type_old}"

  if [ "${exitcode}" -eq "0" ]; then arg_all_data_application_name="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_data_oid
#  DESCRIPTION:  Interactive menu for setting <arg_all_data_oid> parameter
#      GLOBALS:  arg_all_data_oid
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_all_data_oid() {
  local title1
  local title3
  local extra
  local text1
  local text2
  local must_exist  # Action requires an existing object? (true|false)
  eval "title1=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_DATA_OID_1}"
  eval "title3=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  case "${arg_action}" in
    ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_EXPORT})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_DATA_OID_EXISTING_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_DATA_OID_EXISTING_2}"
      eval "text3=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_DATA_OID_EXISTING_3}"
      must_exist="true"
      ;;
    ${ARG_ACTION_ALL_IMPORT})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_DATA_OID_NEW_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_DATA_OID_NEW_2}"
      must_exist="false"
      ;;
  esac

  # Show dialogue with existing objects? (true|false)
  local show_existing="true"

  # Select list type for <all_list()> call below
  local arg_all_type_old
  arg_all_type_old="${arg_all_type}"
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P15})
      arg_all_type="${ARG_ALL_TYPE_DATA}"
      ;;
  esac

  local msg1
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"

      # Dialogue 1: (Optional) Show existing items
      if ${show_existing}; then
        # Get item list <msg1>
        { msg1="$(all_list 2>&1)" || \
          { dialog  --no-collapse --title "${title3}" --msgbox "${msg1}" 0 0
            false
          }
        } && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Show item list
          dialog  --no-collapse --title "${title1}" \
                  --msgbox "$(printf "%s\n\n%s" "${text1}" "${msg1}")" 0 0
        elif ${must_exist}; then
          # ... empty: (Optional) Show error dialogue and terminate
          dialog  --no-collapse --title "${title3}" --msgbox "${text3}" 0 0
          false
        fi
      fi                                                                    && \

      # Dialogue 2: Request user to ...
      if ${must_exist}; then
        # ... select/enter an (existing) item (if <must_exist> = true)

        # Prepare item list <msg1> for 'dialog'
        case "${arg_token_type}" in
          ${ARG_TOKEN_TYPE_OPENSC_P11})
            msg1="$(printf "%s" "${msg1}" | sed -ne \
              "s/^[[:space:]]*app_id[[:space:]]*\:[[:space:]]\{1,\}\(.\{1,\}\)$/\1/p")"
            ;;
          ${ARG_TOKEN_TYPE_OPENSC_P15})
            msg1="$(printf "%s" "${msg1}" | sed -ne \
              "s/^[[:space:]]*applicationOID[[:space:]]*\:[[:space:]]\{1,\}\(.\{1,\}\)$/\1/p")"
            ;;
          *) false;;
        esac && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Request user to select an item
          msg1="$(for a in ${msg1}; do printf "%s\n%s\n" "$a" "."; done)" && \
          result="$(dialog --extra-button --extra-label "${extra}"        \
            --title "${title1}" --menu "${text2}" 0 0 0                   \
            ${msg1} 2>&1 1>&3)"
        else
          # ... empty: Request user to manually enter a value
          result="$(dialog --extra-button --extra-label "${extra}"  \
            --title "${title1}" --inputbox "${text2}" 0 0           \
            "${result:-${arg_all_data_oid}}" 2>&1 1>&3)"
        fi
      elif lib_core_is --not-empty "${msg1}"; then
        # ... enter a (new) value with 'Go back' button (if <msg1> is not empty)
        result="$(dialog --extra-button --extra-label "${extra}"  \
          --title "${title1}" --inputbox "${text2}" 0 0           \
          "${result:-${arg_all_data_oid}}" 2>&1 1>&3)"
      else
        # ... enter a (new) value but without 'Go back' button
        result="$(dialog --title "${title1}" --inputbox "${text2}" 0 0  \
          "${result:-${arg_all_data_oid}}" 2>&1 1>&3)"
      fi                                                                    || \

      exitcode="$?"

      case "${exitcode}" in
        0)
          if  lib_core_is --empty "${result}" || \
              lib_core_regex --oid "${result}"; then
                break
          fi
          ;;
        3) ;;
        *) break;;
      esac
    done
  exec 3>&-

  arg_all_type="${arg_all_type_old}"

  if [ "${exitcode}" -eq "0" ]; then arg_all_data_oid="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_file
#  DESCRIPTION:  Interactive menu for setting <arg_all_file> parameter
#      GLOBALS:  arg_all_file
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_all_file() {
  # Get token-/action-specific title
  local title
  title="$(lib_core_str_to --const "L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_FILE_${arg_token_type}_${arg_action}")"

  # In case specific title does not exist use default one
  if lib_core_var_is --unset "${title}"; then
    title="$(lib_core_str_to --const "L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_FILE_ALL_${arg_action}")"
    if lib_core_var_is --unset "${title}"; then
      title="L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_FILE"
    fi
  fi

  # Evaluate <title> as it is still a pointer
  eval "title=\${${title}}"

  # Get action-specific text
  local text
  case "${arg_action}" in
    ${ARG_ACTION_SCHSM_BACKUP}|${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE}|\
    ${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_KEYPAIRGEN})
      eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_FILE_OUT}"
      ;;
    ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_SCHSM_RESTORE}|\
    ${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})
      eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_FILE_IN}"
      ;;
  esac

  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"
      dialog --title "${title}" --msgbox "${text}" 0 0                      && \
      result="$(dialog --title "${title}"                                   \
        --fselect "${result:-${arg_all_file:-~/}}" 0 0 2>&1 1>&3)"          && \
      result="$(lib_core_expand_tilde "${result}")"                         || \
      exitcode="$?"

      #  Show prompt again if <result>
      #    - is not a valid filepath (<ARG_ACTION_SCHSM_BACKUP>|...)
      #    - is already existing (<ARG_ACTION_SCHSM_BACKUP>|...)
      #    - does not exist  (<ARG_ACTION_ALL_IMPORT>|...)
      #  unless the user has pressed the 'Cancel' button
      case "${exitcode}" in
        0)
          { case "${arg_action}" in
              ${ARG_ACTION_SCHSM_BACKUP}|${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE}|\
              ${ARG_ACTION_ALL_EXPORT}|${ARG_ACTION_ALL_KEYPAIRGEN})
                touch -c "${result}" 2>/dev/null && \
                ! lib_core_is --file "${result}"
                ;;
              ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_SCHSM_RESTORE}|\
              ${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})
                lib_core_is --file "${result}"
                ;;
            esac
          } && \
          break
          ;;
        *)
          break
          ;;
      esac
    done
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_all_file="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_format
#  DESCRIPTION:  Interactive menu for setting <arg_all_format> parameter
#      GLOBALS:  arg_all_format
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_all_format() {
  local title
  local text
  local item1
  local item2
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_FORMAT}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_FORMAT}"

  local list
  list="$(lib_core_str_to --const \
    "ARG_ALL_FORMAT_LIST_${arg_token_type}_${arg_action}_${arg_all_type}")"
  eval "list=\${${list}}"

  # In case specific list does not exist
  if lib_core_is --empty "${list}"; then
    list="$(lib_core_str_to --const \
      "ARG_ALL_FORMAT_LIST_${arg_token_type}_${arg_action}")"
    eval "list=\${${list}}"
    if lib_core_is --empty "${list}"; then
      list="$(lib_core_str_to --const \
        "ARG_ALL_FORMAT_LIST_ALL_${arg_action}")"
      eval "list=\${${list}}"
      if lib_core_is --empty "${list}"; then
        list="${ARG_ALL_FORMAT_LIST}"
      fi
    fi
  fi

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${list}; do
        eval "tag=\${ARG_ALL_FORMAT_${a}}"
        eval "item=\${L_SC_${ID_LANG}_DLG_ITM_ARG_ALL_FORMAT_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --title "${title}" --menu "${text}" 0 0 0  \
      ${dlgpairs} 2>&1 1>&3)"                                               || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_all_format="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_id_object
#  DESCRIPTION:  Interactive menu for setting <arg_all_id_object> parameter
#      GLOBALS:  arg_all_id_object
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_all_id_object() {
  local title1
  local title3
  local extra
  local text1
  local text2
  local must_exist  # Action requires an existing object? (true|false)
  eval "title1=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_ID_OBJECT_1}"
  eval "title3=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  case "${arg_action}" in
    ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_EXPORT})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_2}"
      eval "text3=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_3}"
      must_exist="true"
      ;;
    ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_ALL_KEYPAIRGEN})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_ID_OBJECT_NEW_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_ID_OBJECT_NEW_2}"
      must_exist="false"
      ;;
  esac

  # Show dialogue with existing objects? (true|false)
  local show_existing="true"

  # Select list type for <all_list()> call below
  local arg_all_type_old
  arg_all_type_old="${arg_all_type}"
  if ! ${must_exist}; then arg_all_type="${ARG_ALL_TYPE_OBJECT}"; fi

  local msg1
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"

      # Dialogue 1: (Optional) Show existing items
      if ${show_existing}; then
        # Get item list <msg1>
        { msg1="$(all_list 2>&1)" || \
          { dialog  --no-collapse --title "${title3}" --msgbox "${msg1}" 0 0
            false
          }
        } && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Show item list
          dialog  --no-collapse --title "${title1}" \
                  --msgbox "$(printf "%s\n\n%s" "${text1}" "${msg1}")" 0 0
        elif ${must_exist}; then
          # ... empty: (Optional) Show error dialogue and terminate
          dialog  --no-collapse --title "${title3}" --msgbox "${text3}" 0 0
          false
        fi
      fi                                                                    && \

      # Dialogue 2: Request user to ...
      if ${must_exist}; then
        # ... select/enter an (existing) item (if <must_exist> = true)

        # Prepare item list <msg1> for 'dialog'
        case "${arg_token_type}" in
          ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_OPENSC_P15}|\
          ${ARG_TOKEN_TYPE_SCHSM})
            msg1="$(printf "%s" "${msg1}" | sed -ne \
              "s/^[[:space:]]*ID[[:space:]]*\:[[:space:]]\{1,\}\(.\{1,\}\)$/\1/p")"
            ;;
          *) false;;
        esac && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Request user to select an item
          msg1="$(for a in ${msg1}; do printf "%s\n%s\n" "$a" "."; done)" && \
          result="$(dialog --extra-button --extra-label "${extra}"        \
            --title "${title1}" --menu "${text2}" 0 0 0                   \
            ${msg1} 2>&1 1>&3)"
        else
          # ... empty: Request user to manually enter a value
          result="$(dialog --extra-button --extra-label "${extra}"  \
            --title "${title1}" --inputbox "${text2}" 0 0           \
            "${result:-${arg_all_id_object}}" 2>&1 1>&3)"
        fi
      elif lib_core_is --not-empty "${msg1}"; then
        # ... enter a (new) value with 'Go back' button (if <msg1> is not empty)
        result="$(dialog --extra-button --extra-label "${extra}"  \
          --title "${title1}" --inputbox "${text2}" 0 0           \
          "${result:-${arg_all_id_object}}" 2>&1 1>&3)"
      else
        # ... enter a (new) value but without 'Go back' button
        result="$(dialog --title "${title1}" --inputbox "${text2}" 0 0  \
          "${result:-${arg_all_id_object}}" 2>&1 1>&3)"
      fi                                                                    || \

      exitcode="$?"

      case "${exitcode}" in
        0) lib_core_regex --int-pos0 "${result}" && break;;
        3) ;;
        *) break;;
      esac
    done
  exec 3>&-

  arg_all_type="${arg_all_type_old}"

  if [ "${exitcode}" -eq "0" ]; then arg_all_id_object="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_id_reader
#  DESCRIPTION:  Interactive menu for setting <arg_all_id_reader> parameter
#         TODO:  Currently this function also displays empty readers
#                (= readers without a smartcard).
#      GLOBALS:  arg_all_id_reader
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_all_id_reader() {
  local title1
  local title3
  local text1
  local text2
  local text3
  local extra
  local must_exist  # Action requires an existing object? (true|false)
  eval "title1=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_ID_READER_1}"
  eval "title3=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_ID_READER_1}"
  eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_ID_READER_2}"
  eval "text3=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_ID_READER_3}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  must_exist="true"

  # Show dialogue with existing objects? (true|false)
  local show_existing="true"

  # Select list type for <all_list()> call below
  local arg_all_type_old
  arg_all_type_old="${arg_all_type}"
  arg_all_type="${ARG_ALL_TYPE_READER}"

  local msg1
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"

      # Dialogue 1: (Optional) Show existing items
      if ${show_existing}; then
        # Get item list <msg1>
        { msg1="$(all_list 2>&1)" || \
          { dialog  --no-collapse --title "${title3}" --msgbox "${msg1}" 0 0
            false
          }
        } && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Show item list
          msg1="$(printf "%s\n\n%s" "${text1}" "${msg1}")"
          dialog  --no-collapse --title "${title1}" --msgbox "${msg1}" 0 0
        elif ${must_exist}; then
          # ... empty: (Optional) Show error dialogue and terminate
          dialog  --no-collapse --title "${title3}" --msgbox "${text3}" 0 0
          false
        fi
      fi                                                                    && \

      # Dialogue 2: Request user to ...
      if ${must_exist}; then
        # ... select/enter an (existing) item (if <must_exist> = true)

        # Prepare item list <msg1> for 'dialog'
        case "${arg_token_type}" in
          ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
            msg1="$(printf "%s" "${msg1}" | sed -ne \
              "s/^[[:space:]]*Slot[[:space:]]\{1,\}\([[:digit:]]\{1,\}\)[[:space:]]\{1,\}.*$/\1/p")"
            ;;
          ${ARG_TOKEN_TYPE_OPENSC_P15})
            msg1="$(printf "%s" "${msg1}" | sed -ne \
              "s/^[[:space:]]*\([[:digit:]]\{1,\}\)[[:space:]]\{1,\}.*$/\1/p")"
            ;;
          *) false;;
        esac && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Request user to select an item
          msg1="$(for a in ${msg1}; do printf "%s\n%s\n" "$a" "Slot/Reader#$a"; done)" && \
          result="$(dialog --extra-button --extra-label "${extra}"        \
            --title "${title1}" --menu "${text2}" 0 0 0                   \
            ${msg1} 2>&1 1>&3)"
        else
          # ... empty: Request user to manually enter a value
          result="$(dialog --extra-button --extra-label "${extra}"  \
            --title "${title1}" --inputbox "${text2}" 0 0           \
            "${result:-${arg_all_id_reader}}" 2>&1 1>&3)"
        fi
      elif lib_core_is --not-empty "${msg1}"; then
        # ... enter a (new) value with 'Go back' button (if <msg1> is not empty)
        result="$(dialog --extra-button --extra-label "${extra}"  \
          --title "${title1}" --inputbox "${text2}" 0 0           \
          "${result:-${arg_all_id_reader}}" 2>&1 1>&3)"
      else
        # ... enter a (new) value but without 'Go back' button
        result="$(dialog --title "${title1}" --inputbox "${text2}" 0 0  \
          "${result:-${arg_all_id_reader}}" 2>&1 1>&3)"
      fi                                                                    || \

      exitcode="$?"

      case "${exitcode}" in
        0) lib_core_regex --int-pos0 "${result}" && break;;
        3) ;;
        *) break;;
      esac
    done
  exec 3>&-

  arg_all_type="${arg_all_type_old}"

  if [ "${exitcode}" -eq "0" ]; then arg_all_id_reader="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_key_type
#  DESCRIPTION:  Interactive menu for setting <arg_all_key_type> parameter
#      GLOBALS:  arg_all_key_type
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_all_key_type() {
  # Get token-/action-specific title
  local title
  title="$(lib_core_str_to --const "L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_KEY_TYPE_${arg_token_type}_${arg_action}")"

  # In case specific title does not exist use default one
  if lib_core_var_is --unset "${title}"; then
    title="$(lib_core_str_to --const "L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_KEY_TYPE_ALL_${arg_action}")"
    if lib_core_var_is --unset "${title}"; then
      title="L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_KEY_TYPE"
    fi
  fi

  # Evaluate <title> as it is still a pointer
  eval "title=\${${title}}"

  # Get texts
  local text1
  local text2
  local text3
  local extra
  eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_KEY_TYPE_1}"
  text2="$(lib_core_str_to --const "${arg_token_type}")"
  eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_KEY_TYPE_2_${text2}}"
  eval "text3=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_KEY_TYPE_3}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"

  # Get token-/action-specific list
  local list
  list="$(lib_core_str_to --const \
    "ARG_ALL_KEY_TYPE_LIST_${arg_token_type}_${arg_action}")"
  eval "list=\${${list}}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local msg1
  local dlgpairs
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"
      case "${arg_token_type}" in
        ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM})
          msg1="$(printf "%s\n\n%s" "${text1}"                          \
            "$(pkcs11-tool --list-mechanisms                            \
                ${all_p11lib:+--module ${all_p11lib}}                   \
                ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}} \
            )"                                                          \
          )"                                                            && \
          dialog  --no-collapse --title "${title}"                      \
                  --msgbox "${msg1}" 0 0                                && \

          result="$(dialog --extra-button --extra-label "${extra}"      \
            --title "${title}" --inputbox "${text2}" 0 0                \
            "${result:-${arg_all_key_type}}" 2>&1 1>&3)"
          ;;

        ${ARG_TOKEN_TYPE_YUBICO})
          dlgpairs="$(for a in ${list}; do
            tag="$a"
            item="$a"
            #eval "item=\${L_SC_${ID_LANG}_DLG_ITM_ARG_ALL_KEY_TYPE_${a}}"
            printf "%s\n%s\n" "${tag}" "${item}"
          done)"                                                        && \
          IFS="${LIB_C_STR_NEWLINE}"                                    && \
          result="$(dialog --title "${title}" --menu "${text3}" 0 0 0   \
            ${dlgpairs} 2>&1 1>&3)"
          ;;

        *)
          result="$(dialog --title "${title}" --inputbox "${text2}" 0 0 \
            "${result:-${arg_all_key_type}}" 2>&1 1>&3)"
          ;;
      esac                                                                  || \
      exitcode="$?"

      case "${exitcode}" in
        0) lib_core_is --not-empty "${result}" && break;;
        3) ;;
        *) break;;
      esac
    done
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_all_key_type="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_label
#  DESCRIPTION:  Interactive menu for setting <arg_all_label> parameter
#      GLOBALS:  arg_all_label
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_all_label() {
  local title1
  local title3
  local extra
  local text1
  local text2
  local must_exist  # Action requires an existing object? (true|false)
  eval "title1=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_LABEL_1}"
  eval "title3=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  case "${arg_action}" in
    ${ARG_ACTION_ALL_DELETE}|${ARG_ACTION_ALL_EXPORT})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_LABEL_EXISTING_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_LABEL_EXISTING_2}"
      eval "text3=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_LABEL_EXISTING_3}"
      must_exist="true"
      ;;
    ${ARG_ACTION_ALL_IMPORT}|${ARG_ACTION_ALL_INITIALIZE}|\
    ${ARG_ACTION_ALL_KEYPAIRGEN})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_LABEL_NEW_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_LABEL_NEW_2}"
      must_exist="false"
      ;;
  esac

  # Show dialogue with existing objects? (true|false)
  local show_existing="true"

  # Select list type for <all_list()> call below
  local arg_all_type_old
  arg_all_type_old="${arg_all_type}"
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P15})
      if ! ${must_exist}; then arg_all_type="${ARG_ALL_TYPE_OBJECT}"; fi
      if [ "${arg_action}" = "${ARG_ACTION_ALL_INITIALIZE}" ]; then
        show_existing="false"
      fi
      ;;
    *)
      arg_all_type="${ARG_ALL_TYPE_OBJECT}"
      ;;
  esac

  local msg1
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"

      # Dialogue 1: (Optional) Show existing items
      if ${show_existing}; then
        # Get item list <msg1>
        { msg1="$(all_list 2>&1)" || \
          { dialog  --no-collapse --title "${title3}" --msgbox "${msg1}" 0 0
            false
          }
        } && \

        # If item list <msg1> is ...
        if lib_core_is --not-empty "${msg1}"; then
          # ... not empty: Show item list
          msg1="$(printf "%s\n\n%s" "${text1}" "${msg1}")"
          dialog  --no-collapse --title "${title1}" --msgbox "${msg1}" 0 0
        elif ${must_exist}; then
          # ... empty: (Optional) Show error dialogue and terminate
          dialog  --no-collapse --title "${title3}" --msgbox "${text3}" 0 0
          false
        fi
      fi                                                                    && \

      # Dialogue 2: Request user to ...
      if lib_core_is --not-empty "${msg1}"; then
        # ... enter an existing or a new value (if <msg1> is not empty)
        result="$(dialog --extra-button --extra-label "${extra}"  \
          --title "${title1}" --inputbox "${text2}" 0 0           \
          "${result:-${arg_all_label}}" 2>&1 1>&3)"
      else
        # ... enter an existing or a new value but without 'Go back' button
        result="$(dialog --title "${title1}" --inputbox "${text2}" 0 0  \
          "${result:-${arg_all_label}}" 2>&1 1>&3)"
      fi                                                                    || \

      exitcode="$?"

      if [ "${exitcode}" -ne "3" ]; then break; fi
    done
  exec 3>&-

  arg_all_type="${arg_all_type_old}"

  if [ "${exitcode}" -eq "0" ]; then arg_all_label="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_print
#  DESCRIPTION:  Interactive menu for setting <arg_all_print> parameter
#      GLOBALS:  arg_all_print
#===============================================================================
menu_arg_all_print() {
  local title
  local text1

  case "${arg_action}" in
    ${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE})
      if lib_core_is --file "${arg_all_file}"; then
        eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_PRINT_FILE}"
        eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_PRINT_FILE}"
      else
        eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_PRINT_SECRETS}"
        eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_PRINT_SECRETS}"
      fi
      ;;
    *)
      eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_PRINT_SECRETS}"
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_PRINT_SECRETS}"
      ;;
  esac

  exec 3>&1
    dialog --title "${title}" --yesno "${text1}" 0 0                        && \
    arg_all_print="true"                                                    || \
    arg_all_print="false"
  exec 3>&-
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_print_separately
#  DESCRIPTION:  Interactive menu for setting <arg_all_print_separately> parameter
#      GLOBALS:  arg_all_print_separately
#===============================================================================
menu_arg_all_print_separately() {
  local title
  local text1
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_PRINT_SEPARATELY}"
  eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_PRINT_SEPARATELY}"

  exec 3>&1
    dialog --title "${title}" --yesno "${text1}" 0 0                        && \
    arg_all_print_separately="true"                                         || \
    arg_all_print_separately="false"
  exec 3>&-
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_random
#  DESCRIPTION:  Interactive menu for setting <arg_all_random> parameter
#      GLOBALS:  arg_all_random
#===============================================================================
menu_arg_all_random() {
  local title
  local text1
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_RANDOM}"
  eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_RANDOM}"

  exec 3>&1
    dialog --title "${title}" --yesno "${text1}" 0 0                        && \
    arg_all_random="true"                                                   || \
    arg_all_random="false"
  exec 3>&-
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_serial
#  DESCRIPTION:  Interactive menu for setting <arg_all_serial> parameter
#      GLOBALS:  arg_all_serial
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_all_serial() {
  local title1
  local title2
  local text1
  local text2
  eval "title1=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_SERIAL_1}"
  eval "title2=\${LIB_SHTPL_${ID_LANG}_DLG_TTL_ERROR}"
  eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_SERIAL_1}"
  eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_SERIAL_2}"

  # Select list type for <all_list()> call below
  local arg_all_type_old
  arg_all_type_old="${arg_all_type}"
  arg_all_type="${ARG_ALL_TYPE_SERIAL}"

  local list
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_YUBICO}) list="$(yubico_list)" ;;
  esac

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    { dlgpairs="$(for a in ${list}; do
        tag="$a"
        item="."
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                && \
      lib_core_is --not-empty "${dlgpairs}" || \
      { dialog  --no-collapse --title "${title2}" --msgbox "${text2}" 0 0
        false
      }
    }                                                                       && \

    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --title "${title1}" --menu "${text1}" 0 0 0  \
        ${dlgpairs} 2>&1 1>&3)"                                             || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"
  arg_all_type="${arg_all_type_old}"

  if [ "${exitcode}" -eq "0" ]; then arg_all_serial="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_all_type
#  DESCRIPTION:  Interactive menu for setting <arg_all_type> parameter
#      GLOBALS:  arg_all_type
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_all_type() {
  local title
  local text
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_ALL_TYPE}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_ALL_TYPE}"

  local list
  list="$(lib_core_str_to --const \
    "ARG_ALL_TYPE_LIST_${arg_token_type}_${arg_action}")"
  eval "list=\${${list}}"

  # In case specific list does not exist
  if lib_core_is --empty "${list}"; then
    list="$(lib_core_str_to --const "ARG_ALL_TYPE_LIST_ALL_${arg_action}")"
    eval "list=\${${list}}"
    if lib_core_is --empty "${list}"; then
      list="${ARG_ALL_TYPE_LIST}"
    fi
  fi

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${list}; do
        eval "tag=\${ARG_ALL_TYPE_${a}}"
        eval "item=\${L_SC_${ID_LANG}_DLG_ITM_ARG_ALL_TYPE_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --title "${title}" --menu "${text}" 0 0 0  \
      ${dlgpairs} 2>&1 1>&3)"                                               || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_all_type="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_token_type
#  DESCRIPTION:  Interactive menu for setting <arg_token_type> parameter
#      GLOBALS:  arg_token_type
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_token_type() {
  local title
  local text
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_TOKEN_TYPE}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_TOKEN_TYPE}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${ARG_TOKEN_TYPE_LIST}; do
        eval "tag=\${ARG_TOKEN_TYPE_${a}}"
        eval "item=\${L_SC_${ID_LANG}_DLG_ITM_ARG_TOKEN_TYPE_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --title "${title}" --menu "${text}" 0 0 0  \
      ${dlgpairs} 2>&1 1>&3)"                                               || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_token_type="${result}"; fi
  return ${exitcode}
}

#===============================================================================
#  FUNCTIONS (CUSTOM) (OpenSC (PKCS#11))
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_change_pin
#  DESCRIPTION:  Change user PIN (using user PIN)
#===============================================================================
opensc_p11_change_pin() {
  ( export arg_all_pin arg_all_newpinpuk
    pkcs11-tool --change-pin                                \
      --login ${arg_all_pin:+--pin env:arg_all_pin}         \
      ${arg_all_newpinpuk:+--new-pin env:arg_all_newpinpuk} \
      ${all_p11lib:+--module ${all_p11lib}}                 \
      ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_change_so_pin
#  DESCRIPTION:  Change security officer PIN (SO-PIN)
#===============================================================================
opensc_p11_change_so_pin() {
  ( export arg_all_sopin arg_all_newpinpuk
    pkcs11-tool --change-pin                                \
      --login --login-type so                               \
      ${arg_all_sopin:+--so-pin env:arg_all_sopin}          \
      ${arg_all_newpinpuk:+--new-pin env:arg_all_newpinpuk} \
      ${all_p11lib:+--module ${all_p11lib}}                 \
      ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_delete
#  DESCRIPTION:  Delete certificate / private key / data
#===============================================================================
opensc_p11_delete() {
  ( export arg_all_pin
    pkcs11-tool --delete-object --type ${arg_all_type}      \
      --login                                               \
      ${arg_all_pin:+--pin env:arg_all_pin}                 \
      ${arg_all_data_application_name:+--application-label ${arg_all_data_application_name}} \
      ${arg_all_data_oid:+--application-id ${arg_all_data_oid}} \
      ${arg_all_id_object:+--id ${arg_all_id_object}}       \
      ${arg_all_label:+--label "${arg_all_label}"}          \
      ${all_p11lib:+--module ${all_p11lib}}                 \
      ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_export
#  DESCRIPTION:  Export an object from a token to a file
#===============================================================================
opensc_p11_export() {
  pkcs11-tool --read-object --type ${arg_all_type}        \
    --output-file "${arg_all_file}"                       \
    ${arg_all_data_application_name:+--application-label ${arg_all_data_application_name}} \
    ${arg_all_data_oid:+--application-id ${arg_all_data_oid}} \
    ${arg_all_id_object:+--id ${arg_all_id_object}}       \
    ${arg_all_label:+--label "${arg_all_label}"}          \
    ${all_p11lib:+--module ${all_p11lib}}                 \
    ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}}
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_get
#  DESCRIPTION:  Get/Parse information about reader/smartcard
#      OUTPUTS:  Write selected information to <stdout>
#===============================================================================
opensc_p11_get() {
  case "${arg_all_get}" in
    ${ARG_ALL_GET_READER})
      opensc-tool --list-readers | tail +3 | tr -s " " | cut -d " " -f3-
      ;;

    *)
      local input
      local token_manufacturer
      local token_model
      local serial_num

      input="$(                                                             \
        pkcs11-tool --list-slots ${all_p11lib:+--module ${all_p11lib}}      \
      )"                                                                    && \
      { token_manufacturer="$(printf "%s" "${input}" \
          | sed -ne "s/^[[:space:]]*token manufacturer[[:space:]]*:[[:space:]]*\(.*\)$/\1/p")"
        token_model="$(printf "%s" "${input}" \
          | sed -ne "s/^[[:space:]]*token model[[:space:]]*:[[:space:]]*\(.*\)$/\1/p")"
        serial_num="$(printf "%s" "${input}" \
          | sed -ne "s/^[[:space:]]*serial num[[:space:]]*:[[:space:]]*\(.*\)$/\1/p")"

        case "${arg_all_get}" in
          ${ARG_ALL_GET_SMARTCARD})
            printf "%s" "${token_manufacturer}${token_model:+ ${token_model}}${serial_num:+ (${serial_num})}"
            ;;
          ${ARG_ALL_GET_SMARTCARD_MANUFACTURER})
            printf "%s" "${token_manufacturer}"
            ;;
          ${ARG_ALL_GET_SMARTCARD_MODEL})
            printf "%s" "${token_model}"
            ;;
          ${ARG_ALL_GET_SMARTCARD_SERIAL})
            printf "%s" "${serial_num}"
            ;;
        esac
      }
      ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_import
#  DESCRIPTION:  Import an object from a file to a token
#===============================================================================
opensc_p11_import() {
  ( export arg_all_pin
    pkcs11-tool --write-object "${arg_all_file}" --type ${arg_all_type} \
      --login                                                           \
      ${arg_all_pin:+--pin env:arg_all_pin}                             \
      ${arg_all_data_application_name:+--application-label ${arg_all_data_application_name}} \
      ${arg_all_data_oid:+--application-id ${arg_all_data_oid}}         \
      ${arg_all_id_object:+--id ${arg_all_id_object}}                   \
      ${arg_all_label:+--label "${arg_all_label}"}                      \
      ${all_p11lib:+--module ${all_p11lib}}                             \
      ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_initialize
#  DESCRIPTION:  Initialize device
#===============================================================================
opensc_p11_initialize() {
  ( export arg_all_pin arg_all_sopin
    pkcs11-tool --init-token --init-pin --label "${arg_all_label}"  \
      ${arg_all_pin:+--pin env:arg_all_pin}                         \
      ${arg_all_sopin:+--so-pin env:arg_all_sopin}                  \
      ${all_p11lib:+--module ${all_p11lib}}                         \
      ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_keypairgen
#  DESCRIPTION:  Generate (public/private) key pair
#===============================================================================
opensc_p11_keypairgen() {
  local login_type
  case "${arg_token_type}" in
    ${ARG_TOKEN_TYPE_OPENSC_P11}|${ARG_TOKEN_TYPE_SCHSM}) login_type="user" ;;
    ${ARG_TOKEN_TYPE_YUBICO}) login_type="so" ;;
  esac

  ( export arg_all_pin arg_all_sopin
    pkcs11-tool --keypairgen --key-type ${arg_all_key_type} \
      --login --login-type ${login_type}                    \
      ${arg_all_pin:+--pin env:arg_all_pin}                 \
      ${arg_all_sopin:+--so-pin env:arg_all_sopin}          \
      ${arg_all_id_object:+--id ${arg_all_id_object}}       \
      ${arg_all_label:+--label "${arg_all_label}"}          \
      ${all_p11lib:+--module ${all_p11lib}}                 \
      ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_list
#  DESCRIPTION:  List available objects (certs, data, keys, etc.)
#===============================================================================
opensc_p11_list() {
  local list
  case "${arg_all_type}" in
    ${ARG_ALL_TYPE_ALGORITHM})  list="mechanisms";;
    ${ARG_ALL_TYPE_OBJECT})     list="objects";;
    ${ARG_ALL_TYPE_READER})     list="slots";;
    *)                          list="objects";;
  esac

  case "${arg_all_type}" in
    ${ARG_ALL_TYPE_READER})
      pkcs11-tool --list-${list}                            \
        ${all_p11lib:+--module ${all_p11lib}}
      ;;

    *)
      pkcs11-tool --list-${list}                            \
        ${all_p11lib:+--module ${all_p11lib}}               \
        ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}}
      ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_reset_pin
#  DESCRIPTION:  Reset user PIN (using SO-PIN)
#===============================================================================
opensc_p11_reset_pin() {
  ( export arg_all_sopin arg_all_newpinpuk
    pkcs11-tool --init-pin                                  \
      --login --login-type so                               \
      ${arg_all_sopin:+--so-pin env:arg_all_sopin}          \
      ${arg_all_newpinpuk:+--new-pin env:arg_all_newpinpuk} \
      ${all_p11lib:+--module ${all_p11lib}}                 \
      ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_unblock_pin
#  DESCRIPTION:  Unblock user PIN (using user PUK)
#===============================================================================
opensc_p11_unblock_pin() {
  ( export arg_all_puk arg_all_newpinpuk
    pkcs11-tool --unlock-pin                                \
      --login --login-type context-specific                 \
      ${arg_all_puk:+--puk env:arg_all_puk}                 \
      ${arg_all_newpinpuk:+--new-pin env:arg_all_newpinpuk} \
      ${all_p11lib:+--module ${all_p11lib}}                 \
      ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p11_verify_pinpuk
#  DESCRIPTION:  Verify PIN, PUK, SO-PIN, ...
# PARAMETER  1:  Variable identifier, e.g. 'arg_all_pin'
#            2:  Value (secret) to be verified
#   RETURNS  0:  Secret successfully verified
#          ...:  Error (return value depends on 'pkcs11-tool')
#===============================================================================
opensc_p11_verify_pinpuk() {
  local arg="$1"
  local val="$2"

  local login_type
  local param
  case "${arg}" in
    arg_all_pin) param="pin"; login_type="user" ;;
    arg_all_sopin) param="so-pin"; login_type="so" ;;
    *) return ;;
  esac

  ( export val
    pkcs11-tool --show-info                             \
      --login --login-type ${login_type}                \
      --${param} env:val                                \
      ${all_p11lib:+--module ${all_p11lib}}             \
      ${arg_all_id_reader:+--slot-index ${arg_all_id_reader}} \
    2>&1 1>/dev/null
  )
}

#===============================================================================
#  FUNCTIONS (CUSTOM) (OpenSC (PKCS#15))
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  menu_arg_opensc_p15_profile
#  DESCRIPTION:  Interactive menu for setting <arg_opensc_p15_profile> parameter
#      GLOBALS:  arg_opensc_p15_profile
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_opensc_p15_profile() {
  local title
  local text
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_OPENSC_P15_PROFILE}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_OPENSC_P15_PROFILE}"

  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"
      result="$(dialog --title "${title}" --inputbox "${text}" 0 0  \
        "${arg_opensc_p15_profile}" 2>&1 1>&3)"                             || \
      exitcode="$?"

      case "${exitcode}" in
        0) if lib_core_regex --opensc-p15-profile "${result}"; then break; fi ;;
        *) break ;;
      esac
    done
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_opensc_p15_profile="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_change_pinpuk
#  DESCRIPTION:  Change PIN, PUK, SO-PIN, ...
# PARAMETER  1:  Current PIN, PUK, SO-PIN, ...
#   RETURNS  0:  Secret successfully changed
#          ...:  Error (return value depends on 'pkcs15-tool')
#===============================================================================
opensc_p15_change_pinpuk() {
  local val="$1"
  ( export val arg_all_newpinpuk
    pkcs15-tool --change-pin                                \
      ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
      ${val:+--pin env:val}                                 \
      ${arg_all_newpinpuk:+--new-pin env:arg_all_newpinpuk} \
      ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_change_pin
#  DESCRIPTION:  Change user PIN (using user PIN)
#===============================================================================
opensc_p15_change_pin() {
  opensc_p15_change_pinpuk "${arg_all_pin}"
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_change_puk
#  DESCRIPTION:  Change user PUK (using user PUK)
#===============================================================================
opensc_p15_change_puk() {
  opensc_p15_change_pinpuk "${arg_all_puk}"
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_change_so_pin
#  DESCRIPTION:  Change security officer PIN (SO-PIN)
#===============================================================================
opensc_p15_change_so_pin() {
  opensc_p15_change_pinpuk "${arg_all_sopin}"
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_delete
#  DESCRIPTION:  Delete certificate / private key / data
#===============================================================================
opensc_p15_delete() {
  local pin
  pin="${arg_all_sopin:-${arg_all_pin}}"

  ( export pin
    case "${arg_all_type}" in
      ${ARG_ALL_TYPE_DATA})
        pkcs15-init --delete-objects ${arg_all_type}            \
          ${arg_all_data_oid:+--application-id ${arg_all_data_oid}} \
          ${arg_all_data_oid:-${arg_all_data_application_name:+--application-name "${arg_all_data_application_name}"}} \
          ${arg_all_data_oid:-${arg_all_label:+--label "${arg_all_label}"}} \
                                                                \
          --verify-pin                                          \
          ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
          ${pin:+--pin env:pin}                                 \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;

      *)
        pkcs15-init --delete-objects ${arg_all_type}            \
          ${arg_all_id_object:+--id ${arg_all_id_object}}       \
                                                                \
          --verify-pin                                          \
          ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
          ${pin:+--pin env:pin}                                 \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;
    esac
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_erase_application
#  DESCRIPTION:  Erase PKCS#15 application
#         TODO:  Function not tested yet
#===============================================================================
opensc_p15_erase_application() {
  local pin
  pin="${arg_all_sopin:-${arg_all_pin}}"

  ( export pin
    pkcs15-init --erase-application ${arg_p15_id_aid}       \
                                                            \
      ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
      ${pin:+--pin env:pin}                                 \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_erase_card
#  DESCRIPTION:  Erase PKCS#15 structure (certain models only)
#===============================================================================
opensc_p15_erase_card() {
  local pin
  pin="${arg_all_sopin:-${arg_all_pin}}"

  ( export pin
    pkcs15-init --erase-card --use-default-transport-keys   \
                                                            \
      ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
      ${pin:+--pin env:pin}                                 \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_export
#  DESCRIPTION:  Export an object from a token to a file
#===============================================================================
opensc_p15_export() {
  local pin
  pin="${arg_all_sopin:-${arg_all_pin}}"

  ( export pin
    case "${arg_all_type}" in
      ${ARG_ALL_TYPE_CERT})
        pkcs15-tool --read-certificate ${arg_all_id_object}     \
          --output "${arg_all_file}"                            \
                                                                \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;

      ${ARG_ALL_TYPE_DATA})
        # TODO: Change order?
        local p15_data_object
        if [ -n "${arg_all_label}" ]; then
          p15_data_object="${arg_all_label}"
        elif [ -n "${arg_all_data_oid}" ]; then
          p15_data_object="${arg_all_data_oid}"
        elif [ -n "${arg_all_data_application_name}" ]; then
          p15_data_object="${arg_all_data_application_name}"
        else
          false
        fi && \

        pkcs15-tool --read-data-object "${p15_data_object}"     \
          --output "${arg_all_file}"                            \
                                                                \
          ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
          ${pin:+--pin env:pin}                                 \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;

      ${ARG_ALL_TYPE_PUBKEY})
        pkcs15-tool --read-public-key ${arg_all_id_object}      \
          --output "${arg_all_file}"                            \
                                                                \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;

      ${ARG_ALL_TYPE_SSHKEY})
        pkcs15-tool --read-ssh-key ${arg_all_id_object}         \
          --output "${arg_all_file}"                            \
                                                                \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;

      ${ARG_ALL_TYPE_SSHKEY_RFC4716})
        pkcs15-tool --read-ssh-key ${arg_all_id_object} --rfc4716 \
          --output "${arg_all_file}"                              \
                                                                  \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}              \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;
    esac
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_finalize
#  DESCRIPTION:  Finish initialization (certain models only)
#===============================================================================
opensc_p15_finalize() {
  pkcs15-init --finalize \
    ${arg_all_id_reader:+--reader ${arg_all_id_reader}} && \
  info "${TXT_ARG_ACTION_OPENSC_P15_FINALIZE_INFO}"
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_get
#  DESCRIPTION:  Get/Parse information about reader/smartcard
#      OUTPUTS:  Write selected information to <stdout>
#===============================================================================
opensc_p15_get() {
  case "${arg_all_get}" in
    ${ARG_ALL_GET_READER})
      opensc_p11_get
      ;;

    *)
      local input
      local token_model
      local serial_num

      input="$(pkcs15-tool                                              \
        --list-info                                                     \
        ${arg_all_id_reader:+--reader ${arg_all_id_reader}} 2>/dev/null \
      )"                                                                    && \
      { token_model="$(printf "%s" "${input}" \
          | sed -ne "s/^[[:space:]]*PKCS#15 Card \[\(.*\)\]:[[:space:]]*$/\1/p")"
        serial_num="$(printf "%s" "${input}" \
          | sed -ne "s/^[[:space:]]*Serial number[[:space:]]*:[[:space:]]*\(.*\)$/\1/p")"

        case "${arg_all_get}" in
          ${ARG_ALL_GET_SMARTCARD})
            printf "%s" "${token_model:+ ${token_model}}${serial_num:+ (${serial_num})}"
            ;;
          ${ARG_ALL_GET_SMARTCARD_MODEL})
            printf "%s" "${token_model}"
            ;;
          ${ARG_ALL_GET_SMARTCARD_SERIAL})
            printf "%s" "${serial_num}"
            ;;
        esac
      }
      ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_import
#  DESCRIPTION:  Import an object from a file to a token
#===============================================================================
opensc_p15_import() {
  local pin
  pin="${arg_all_sopin:-${arg_all_pin}}"

  ( export pin
    case "${arg_all_type}" in
      ${ARG_ALL_TYPE_CERT})
        pkcs15-init                                             \
          --store-certificate "${arg_all_file}"                 \
          ${arg_all_format:+--format ${arg_all_format}}         \
                                                                \
          ${arg_all_id_object:+--id ${arg_all_id_object}}       \
          ${arg_all_label:+--label "${arg_all_label}"}          \
                                                                \
          ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
          ${pin:+--pin env:pin}                                 \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;

      ${ARG_ALL_TYPE_DATA})
        pkcs15-init                                                   \
          --store-data "${arg_all_file}"                              \
          ${arg_all_data_application_name:+--application-name "${arg_all_data_application_name}"} \
          ${arg_all_data_oid:+--application-id ${arg_all_data_oid}}   \
                                                                      \
          ${arg_all_label:+--label "${arg_all_label}"}                \
                                                                      \
          ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}            \
          ${pin:+--pin env:pin}                                       \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}                  \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;

      ${ARG_ALL_TYPE_PRIVKEY})
        pkcs15-init                                               \
          --store-private-key "${arg_all_file}"                   \
          ${arg_all_password:+--passphrase env:arg_all_password}  \
          ${arg_all_format:+--format ${arg_all_format}}           \
                                                                  \
          ${arg_all_id_object:+--id ${arg_all_id_object}}         \
          ${arg_all_label:+--label "${arg_all_label}"}            \
                                                                  \
          ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}        \
          ${pin:+--pin env:pin}                                   \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}              \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;

      ${ARG_ALL_TYPE_PUBKEY})
        pkcs15-init                                             \
          --store-public-key "${arg_all_file}"                  \
          ${arg_all_format:+--format ${arg_all_format}}         \
                                                                \
          ${arg_all_id_object:+--id ${arg_all_id_object}}       \
          ${arg_all_label:+--label "${arg_all_label}"}          \
                                                                \
          ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
          ${pin:+--pin env:pin}                                 \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;

      ${ARG_ALL_TYPE_SECRKEY})
        pkcs15-init                                             \
          --store-secret-key "${arg_all_file}"                  \
          --secret-key-algorithm ${arg_all_key_type}            \
                                                                \
          ${arg_all_id_object:+--id ${arg_all_id_object}}       \
          ${arg_all_label:+--label "${arg_all_label}"}          \
                                                                \
          ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
          ${pin:+--pin env:pin}                                 \
          ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
        ;;
    esac
  )                                                                         && \

  info "${TXT_ARG_ACTION_ALL_IMPORT_OPENSC_P15_INFO}"
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_initialize
#  DESCRIPTION:  Initialize device
#===============================================================================
opensc_p15_initialize() {
  ( export arg_all_pin arg_all_puk arg_all_sopin arg_all_sopuk
    case "${arg_opensc_p15_profile}" in
      ${ARG_OPENSC_P15_PROFILE_ONEPIN})
        # Only user PIN and PUK
        pkcs15-init --create-pkcs15                           \
          --profile "${arg_opensc_p15_profile}"               \
          --use-default-transport-keys                        \
          ${arg_all_label:+--label "${arg_all_label}"}        \
          ${arg_all_pin:+--pin env:arg_all_pin}               \
          ${arg_all_puk:+--puk env:arg_all_puk}               \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}} && \

        info "${TXT_ARG_ACTION_ALL_INITIALIZE_OPENSC_P15_INFO}"
        ;;

      *)
        # Initialize with SO-PIN and SO-PUK
        pkcs15-init --create-pkcs15                           \
          --profile "${arg_opensc_p15_profile}"               \
          --use-default-transport-keys                        \
          ${arg_all_label:+--label "${arg_all_label}"}        \
          ${arg_all_sopin:+--so-pin env:arg_all_sopin}        \
          ${arg_all_sopuk:+--so-puk env:arg_all_sopuk}        \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}} && \

        info "${TXT_ARG_ACTION_ALL_INITIALIZE_OPENSC_P15_INFO}" && \

        # Add user PIN and PUK
        pkcs15-init --store-pin                               \
          ${arg_all_pin:+--pin env:arg_all_pin}               \
          ${arg_all_puk:+--puk env:arg_all_puk}               \
          ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}    \
          ${arg_all_label:+--label "${arg_all_label}"}        \
                                                              \
          ${arg_all_sopin:+--so-pin env:arg_all_sopin}        \
          ${arg_all_id_reader:+--reader ${arg_all_id_reader}} && \

        info "${TXT_ARG_ACTION_OPENSC_P15_STORE_PIN_INFO}"
        ;;
    esac
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_keypairgen
#  DESCRIPTION:  Generate (public/private) key pair
#===============================================================================
opensc_p15_keypairgen() {
  local pin
  pin="${arg_all_sopin:-${arg_all_pin}}"

  ( export pin
    pkcs15-init --generate-key "${arg_all_key_type}"        \
                                                            \
      ${arg_all_id_object:+--id ${arg_all_id_object}}       \
      ${arg_all_label:+--label "${arg_all_label}"}          \
                                                            \
      ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
      ${pin:+--pin env:pin}                                 \
      ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_list
#  DESCRIPTION:  List available objects (certs, data, keys, etc.)
#===============================================================================
opensc_p15_list() {
  local list
  local verify_pin
  case "${arg_all_type}" in
    ${ARG_ALL_TYPE_ALGORITHM})
      opensc-tool --list-algorithms \
        ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
      return
      ;;
    ${ARG_ALL_TYPE_CERT})       list="certificates";;
    ${ARG_ALL_TYPE_DATA})       list="data-objects"; verify_pin="--verify-pin";;
    ${ARG_ALL_TYPE_INFO})       list="info";;
    ${ARG_ALL_TYPE_OBJECT})
      pkcs15-tool --dump                                    \
        ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}          \
        ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
      return
      ;;
    ${ARG_ALL_TYPE_PRIVKEY})    list="keys"; verify_pin="--verify-pin";;
    ${ARG_ALL_TYPE_PUBKEY})     list="public-keys";;
    ${ARG_ALL_TYPE_READER})     opensc-tool --list-readers; return;;
    ${ARG_ALL_TYPE_SECRKEY})    list="secret-keys"; verify_pin="--verify-pin";;
    ${ARG_ALL_TYPE_P15_APPLICATION}) list="applications";;
    ${ARG_ALL_TYPE_P15_PIN})    list="pins";;
  esac

  local pin
  pin="${arg_all_sopin:-${arg_all_pin}}"

  ( export pin
    pkcs15-tool --list-${list}                              \
      ${verify_pin}                                         \
                                                            \
      ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
      ${pin:+--pin env:pin}                                 \
      ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_store_pin
#  DESCRIPTION:  Add a new user PIN, PUK
#===============================================================================
opensc_p15_store_pin() {
  ( export arg_all_pin arg_all_puk arg_all_sopin
    pkcs15-init --store-pin                               \
      ${arg_all_pin:+--pin env:arg_all_pin}               \
      ${arg_all_puk:+--puk env:arg_all_puk}               \
      ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}    \
      ${arg_all_label:+--label "${arg_all_label}"}        \
                                                          \
      ${arg_all_sopin:+--so-pin env:arg_all_sopin}        \
      ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}          \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_unblock_pin
#  DESCRIPTION:  Unblock user PIN (using user PUK)
#===============================================================================
opensc_p15_unblock_pin() {
  ( export arg_all_newpinpuk arg_all_puk
    pkcs15-tool --unblock-pin                               \
      ${arg_all_newpinpuk:+--new-pin env:arg_all_newpinpuk} \
                                                            \
      ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}      \
      ${arg_all_puk:+--puk env:arg_all_puk}                 \
      ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}            \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  opensc_p15_verify_pinpuk
#  DESCRIPTION:  Verify PIN, PUK, SO-PIN, ...
# PARAMETER  1:  Variable identifier, e.g. 'arg_all_pin'
#            2:  Value (secret) to be verified
#   RETURNS  0:  Secret successfully verified
#          ...:  Error (return value depends on 'pkcs15-tool')
#===============================================================================
opensc_p15_verify_pinpuk() {
  local arg="$1"
  local val="$2"

  ( export val
    pkcs15-tool --verify-pin                              \
                                                          \
      ${arg_p15_id_auth:+--auth-id ${arg_p15_id_auth}}    \
      --pin env:val                                       \
      ${arg_p15_id_aid:+--aid ${arg_p15_id_aid}}          \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}} \
    2>&1 1>/dev/null
  )
}

#===============================================================================
#  FUNCTIONS (CUSTOM) (SmartCard-HSM / Nitrokey HSM 2)
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  menu_arg_schsm_dkek_shares
#  DESCRIPTION:  Interactive menu for setting <arg_schsm_dkek_shares> parameter
#      GLOBALS:  arg_schsm_dkek_shares
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_schsm_dkek_shares() {
  local title
  local text1
  local text2
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_SCHSM_DKEK_SHARES}"
  eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_SCHSM_DKEK_SHARES_1}"
  eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_SCHSM_DKEK_SHARES_2}"

  local result
  local exitcode="0"
  exec 3>&1
    # Create DKEK? (Yes/No)
    dialog --title "${title}" --yesno "${text1}" 0 0                        && \

    # Yes: How many shares shall be created?
    { result="$(dialog --title "${title}" --rangebox "${text2}" 0 0 \
        ${ARG_SCHSM_DKEK_SHARES_MIN} ${ARG_SCHSM_DKEK_SHARES_MAX}   \
        ${arg_schsm_dkek_shares:-1} 2>&1 1>&3)"                     || \
      exitcode="$?"
    }                                                                       || \

    # No
    { exitcode="$?"
      arg_schsm_dkek_shares=""
    }
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_schsm_dkek_shares="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_schsm_key_reference
#  DESCRIPTION:  Interactive menu for setting
#                <arg_schsm_key_reference> parameter
#      GLOBALS:  arg_schsm_key_reference
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_schsm_key_reference() {
  local title
  local extra
  local text1
  local text2
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_SCHSM_KEY_REFERENCE}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  case "${arg_action}" in
    ${ARG_ACTION_SCHSM_BACKUP})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_BACKUP_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_BACKUP_2}"
      ;;
    ${ARG_ACTION_SCHSM_RESTORE})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_RESTORE_1}"
      eval "text2=\${L_SC_${ID_LANG}_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_RESTORE_2}"
      ;;
  esac

  local msg1
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"
      msg1="$(printf "%s\n\n%s" "${text1}" "$(pkcs15-tool --dump)")"        && \
      dialog --title "${title}" --msgbox "${msg1}" 0 0                      && \
      result="$(dialog --extra-button --extra-label "${extra}"  \
        --title "${title}" --inputbox "${text2}" 0 0            \
        "${result:-${arg_schsm_key_reference}}" 2>&1 1>&3)"                 || \
      exitcode="$?"

      case "${exitcode}" in
        0) lib_core_regex --int-pos0 "${result}" && break;;
        3) ;;
        *) break;;
      esac
    done
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_schsm_key_reference="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_schsm_pwd_shares_threshold
#  DESCRIPTION:  Interactive menu for setting
#                <arg_schsm_pwd_shares_threshold> parameter
#      GLOBALS:  arg_schsm_pwd_shares_threshold
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_schsm_pwd_shares_threshold() {
  local title
  local text
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_SCHSM_PWD_SHARES_THRESHOLD}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_SCHSM_PWD_SHARES_THRESHOLD}"

  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title}" --rangebox "${text}" 0 0      \
      ${ARG_SCHSM_PWD_SHARES_TOTAL_MIN} ${arg_schsm_pwd_shares_total} \
      ${arg_schsm_pwd_shares_threshold:-2} 2>&1 1>&3)"                      || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then
    arg_schsm_pwd_shares_threshold="${result}"
  fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_schsm_pwd_shares_total
#  DESCRIPTION:  Interactive menu for setting
#                <arg_schsm_pwd_shares_total> parameter
#      GLOBALS:  arg_schsm_pwd_shares_total
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_schsm_pwd_shares_total() {
  local title
  local text
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_SCHSM_PWD_SHARES_TOTAL}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_SCHSM_PWD_SHARES_TOTAL}"

  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title}" --rangebox "${text}" 0 0          \
      ${ARG_SCHSM_PWD_SHARES_TOTAL_MIN} ${ARG_SCHSM_PWD_SHARES_TOTAL_MAX} \
      ${arg_schsm_pwd_shares_total:-4}                                    \
      2>&1 1>&3)"                                                           || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_schsm_pwd_shares_total="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_schsm_pwd_use_threshold_scheme
#  DESCRIPTION:  Interactive menu for setting
#                <arg_schsm_pwd_use_threshold_scheme> parameter
#      GLOBALS:  arg_schsm_pwd_use_threshold_scheme
#===============================================================================
menu_arg_schsm_pwd_use_threshold_scheme() {
  local title
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME}"

  local text1
  case "${arg_action}" in
    ${ARG_ACTION_SCHSM_DKEK_SHARE_CREATE})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME_CREATE}"
      ;;
    ${ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT})
      eval "text1=\${L_SC_${ID_LANG}_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME_IMPORT}"
      ;;
  esac

  exec 3>&1
    dialog --title "${title}" --yesno "${text1}" 0 0                        && \
    arg_schsm_pwd_use_threshold_scheme="true"                               || \
    arg_schsm_pwd_use_threshold_scheme="false"
  exec 3>&-
}

#===  FUNCTION  ================================================================
#         NAME:  schsm_backup
#  DESCRIPTION:  Backup DKEK share
#===============================================================================
schsm_backup() {
  ( export arg_all_pin
    sc-hsm-tool                                       \
      --wrap-key "${arg_all_file}"                    \
      --key-reference ${arg_schsm_key_reference}      \
      ${arg_all_pin:+--pin env:arg_all_pin}           \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  schsm_dkek_share_create
#  DESCRIPTION:  Create DKEK share
#===============================================================================
schsm_dkek_share_create() {
  ( export arg_all_password
    sc-hsm-tool                                             \
      --create-dkek-share "${arg_all_file}"                 \
      ${arg_all_password:+--password env:arg_all_password}  \
      ${arg_schsm_pwd_shares_threshold:+--pwd-shares-threshold ${arg_schsm_pwd_shares_threshold}} \
      ${arg_schsm_pwd_shares_total:+--pwd-shares-total ${arg_schsm_pwd_shares_total}}             \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  ) && \

  case "${arg_mode}" in
    ${ARG_MODE_INTERACTIVE}|${ARG_MODE_INTERACTIVE_SUBMENU})
      menu_arg_all_print && \
      if ${arg_all_print}; then
        all_file_content="$(openssl base64 -in "${arg_all_file}")"
        all_file_print
      fi
      ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  schsm_dkek_share_import
#  DESCRIPTION:  Import DKEK share
#===============================================================================
schsm_dkek_share_import() {
  ( export arg_all_password
    sc-hsm-tool                                             \
      --import-dkek-share "${arg_all_file}"                 \
      ${arg_all_password:+--password env:arg_all_password}  \
      ${arg_schsm_pwd_shares_total:+--pwd-shares-total ${arg_schsm_pwd_shares_total}} \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  schsm_initialize
#  DESCRIPTION:  Initialize device
#===============================================================================
schsm_initialize() {
  ( export arg_all_sopin arg_all_pin
    sc-hsm-tool                                                         \
      --initialize                                                      \
      ${arg_all_sopin:+--so-pin env:arg_all_sopin}                      \
      ${arg_all_pin:+--pin env:arg_all_pin}                             \
      ${arg_schsm_dkek_shares:+--dkek-shares ${arg_schsm_dkek_shares}}  \
      ${arg_all_label:+--label "${arg_all_label}"}                      \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===  FUNCTION  ================================================================
#         NAME:  schsm_restore
#  DESCRIPTION:  Restore (Import) private key, description and certificate
#===============================================================================
schsm_restore() {
  ( export arg_all_pin
    sc-hsm-tool                                       \
      --unwrap-key "${arg_all_file}"                  \
      --key-reference ${arg_schsm_key_reference}      \
      ${arg_all_pin:+--pin env:arg_all_pin}           \
      ${all_force}                                    \
      ${arg_all_id_reader:+--reader ${arg_all_id_reader}}
  )
}

#===============================================================================
#  FUNCTIONS (CUSTOM) (Yubico YubiKey PIV)
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  menu_arg_yubico_pin_policy
#  DESCRIPTION:  Interactive menu for setting
#                <menu_arg_yubico_pin_policy> parameter
#      GLOBALS:  menu_arg_yubico_pin_policy
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_yubico_pin_policy() {
  local title
  local text
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_YUBICO_PIN_POLICY}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_YUBICO_PIN_POLICY}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${ARG_YUBICO_PIN_POLICY_LIST}; do
        eval "tag=\${ARG_YUBICO_PIN_POLICY_${a}}"
        eval "item=\${L_SC_${ID_LANG}_DLG_ITM_ARG_YUBICO_PIN_POLICY_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --title "${title}" --menu "${text}" 0 0 0  \
      ${dlgpairs} 2>&1 1>&3)"                                               || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"
  if [ "${exitcode}" -eq "0" ]; then arg_yubico_pin_policy="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_yubico_touch_policy
#  DESCRIPTION:  Interactive menu for setting
#                <arg_yubico_touch_policy> parameter
#      GLOBALS:  arg_yubico_touch_policy
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_yubico_touch_policy() {
  local title
  local text
  eval "title=\${L_SC_${ID_LANG}_DLG_TTL_ARG_YUBICO_TOUCH_POLICY}"
  eval "text=\${L_SC_${ID_LANG}_DLG_TXT_ARG_YUBICO_TOUCH_POLICY}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${ARG_YUBICO_TOUCH_POLICY_LIST}; do
        eval "tag=\${ARG_YUBICO_TOUCH_POLICY_${a}}"
        eval "item=\${L_SC_${ID_LANG}_DLG_ITM_ARG_YUBICO_TOUCH_POLICY_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --title "${title}" --menu "${text}" 0 0 0  \
      ${dlgpairs} 2>&1 1>&3)"                                               || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_yubico_touch_policy="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_change_management_key
#  DESCRIPTION:  Change management key
#===============================================================================
yubico_change_management_key() {
  # TODO: Support for "PIV PIN-only mode"
  ykman                                                     \
    ${arg_all_serial:+--device ${arg_all_serial}}           \
    piv access change-management-key                        \
      ${arg_all_pin:+--pin ${arg_all_pin}}                  \
      --touch                                               \
      ${arg_yubico_new_management_key:+--new-management-key ${arg_yubico_new_management_key}} \
      ${arg_yubico_management_key:+--management-key ${arg_yubico_management_key}}             \
      ${arg_all_key_type:+--algorithm ${arg_all_key_type}}  \
      ${arg_all_pin:+--protect}                             \
      ${all_force}                                                          && \

  info "${TXT_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY_INFO}"
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_change_pin
#  DESCRIPTION:  Change user PIN (using user PIN)
#===============================================================================
yubico_change_pin() {
  ykman                                             \
    ${arg_all_serial:+--device ${arg_all_serial}}   \
    piv access change-pin                           \
      ${arg_all_pin:+--pin ${arg_all_pin}}          \
      ${arg_all_newpinpuk:+--new-pin ${arg_all_newpinpuk}}
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_change_puk
#  DESCRIPTION:  Change user PUK (using user PUK)
#===============================================================================
yubico_change_puk() {
  ykman                                           \
    ${arg_all_serial:+--device ${arg_all_serial}} \
    piv access change-puk                         \
      ${arg_all_puk:+--puk ${arg_all_puk}}        \
      ${arg_all_newpinpuk:+--new-puk ${arg_all_newpinpuk}}
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_convert_algorithm
#  DESCRIPTION:  Map 'ykman' algorithm notation to 'pkcs11-tool' notation
#                and vice versa
# PARAMETER  1:  algorithm to convert
#      OUTPUTS:  Write converted algorithm to <stdout>
#===============================================================================
yubico_convert_algorithm() {
  local arg_algorithm_in="$1"

  local algorithm_out
  case "${arg_algorithm_in}" in
    # pkcs11-tool => ykman
    rsa:1024)       algorithm_out="RSA1024";;
    rsa:2048)       algorithm_out="RSA2048";;
    EC:prime256v1)  algorithm_out="ECCP256";;
    EC:secp384r1)   algorithm_out="ECCP384";;

    # ykman => pkcs11-tool
    RSA1024) algorithm_out="rsa:1024";;
    RSA2048) algorithm_out="rsa:2048";;
    ECCP256) algorithm_out="EC:prime256v1";;
    ECCP384) algorithm_out="EC:secp384r1";;
  esac

  printf "%s" "${algorithm_out}"
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_convert_slot_id
#  DESCRIPTION:  Map FIPS 201 (PIV Card) "Key Reference Value" (NIST SP 800-73-4)
#                to PKCS#11 IDs and vice versa
#       SOURCE:  https://developers.yubico.com/yubico-piv-tool/YKCS11/
# PARAMETER  1:  ID to convert
#      OUTPUTS:  Write converted ID to <stdout>
#===============================================================================
yubico_convert_slot_id() {
  local arg_id_in="$1"

  local id_out
  case "${arg_id_in}" in
    # PKCS#11 ID => PIV Key Reference Value
    1)  id_out="9a";;
    2)  id_out="9c";;
    3)  id_out="9d";;
    4)  id_out="9e";;
    5)  id_out="82";;
    6)  id_out="83";;
    7)  id_out="84";;
    8)  id_out="85";;
    9)  id_out="86";;
    10) id_out="87";;
    11) id_out="88";;
    12) id_out="89";;
    13) id_out="8a";;
    14) id_out="8b";;
    15) id_out="8c";;
    16) id_out="8d";;
    17) id_out="8e";;
    18) id_out="8f";;
    19) id_out="90";;
    20) id_out="91";;
    21) id_out="92";;
    22) id_out="93";;
    23) id_out="94";;
    24) id_out="95";;
    25) id_out="f9";;

    # PIV Key Reference Value => PKCS#11 ID
    9a) id_out="1";;
    9c) id_out="2";;
    9d) id_out="3";;
    9e) id_out="4";;
    82) id_out="5";;
    83) id_out="6";;
    84) id_out="7";;
    85) id_out="8";;
    86) id_out="9";;
    87) id_out="10";;
    88) id_out="11";;
    89) id_out="12";;
    8a) id_out="13";;
    8b) id_out="14";;
    8c) id_out="15";;
    8d) id_out="16";;
    8e) id_out="17";;
    8f) id_out="18";;
    90) id_out="19";;
    91) id_out="20";;
    92) id_out="21";;
    93) id_out="22";;
    94) id_out="23";;
    95) id_out="24";;
    f9) id_out="25";;
  esac

  printf "%s" "${id_out}"
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_delete
#  DESCRIPTION:  Delete certificate / private key / data
#===============================================================================
yubico_delete() {
  # TODO: Support for "PIV PIN-only mode"
  case "${arg_all_type}" in
    ${ARG_ALL_TYPE_CERT})
      ykman                                           \
        ${arg_all_serial:+--device ${arg_all_serial}} \
        piv certificates delete                       \
        ${arg_yubico_management_key:+--management-key ${arg_yubico_management_key}} \
        ${arg_all_pin:+--pin ${arg_all_pin}}          \
        ${arg_piv_keyref}
      ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_export
#  DESCRIPTION:  Export an object from a token to a file
#===============================================================================
yubico_export() {
  # TODO: Support for "PIV PIN-only mode"
  case "${arg_all_type}" in
    ${ARG_ALL_TYPE_CERT})
      ykman                                           \
        ${arg_all_serial:+--device ${arg_all_serial}} \
        piv certificates export                       \
          --format ${arg_all_format}                  \
          ${arg_piv_keyref}                           \
          "${arg_all_file}"
      ;;

    ${ARG_ALL_TYPE_DATA})
      ykman                                           \
        ${arg_all_serial:+--device ${arg_all_serial}} \
        piv objects export                            \
          ${arg_all_pin:+--pin ${arg_all_pin}}        \
          ${arg_piv_ber_tlv_tag}                      \
          "${arg_all_file}"
      ;;

    ${ARG_ALL_TYPE_PUBKEY})
      ykman                                           \
        ${arg_all_serial:+--device ${arg_all_serial}} \
        piv keys export                               \
          --format ${arg_all_format}                  \
          --verify                                    \
          ${arg_all_pin:+--pin ${arg_all_pin}}        \
          ${arg_piv_keyref}                           \
          "${arg_all_file}"
      ;;
  esac                                                                      && \

  lib_msg_echo --info "${TXT_ARG_ACTION_ALL_EXPORT_YUBICO_INFO}" "false" "" \
    "${L_SC_HLP_PAR_ARG_ALL_SERIAL}"      "${arg_all_serial}"               \
    "${L_SC_HLP_PAR_ARG_ALL_TYPE}"        "${arg_all_type}"                 \
    "${L_SC_HLP_PAR_ARG_ALL_FORMAT}"      "${arg_all_format}"               \
    "${L_SC_HLP_PAR_ARG_PIV_BER_TLV_TAG}" "${arg_piv_ber_tlv_tag}"          \
    "${L_SC_HLP_PAR_ARG_PIV_KEYREF}"      "${arg_piv_keyref}"               \
    "${L_SC_HLP_PAR_ARG_ALL_FILE}"        "${arg_all_file}"
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_import
#  DESCRIPTION:  Import an object from a file to a token
#===============================================================================
yubico_import() {
  # TODO: Support for "PIV PIN-only mode"
  case "${arg_all_type}" in
    ${ARG_ALL_TYPE_CERT})
      ykman                                                     \
        ${arg_all_serial:+--device ${arg_all_serial}}           \
        piv certificates import                                 \
          ${arg_yubico_management_key:+--management-key ${arg_yubico_management_key}} \
          ${arg_all_pin:+--pin ${arg_all_pin}}                  \
          ${arg_all_password:+--password "${arg_all_password}"} \
          --verify                                              \
          ${arg_piv_keyref}                                     \
          "${arg_all_file}"
      ;;

    ${ARG_ALL_TYPE_DATA})
      ykman                                           \
        ${arg_all_serial:+--device ${arg_all_serial}} \
        piv objects import                            \
          ${arg_all_pin:+--pin ${arg_all_pin}}        \
          ${arg_yubico_management_key:+--management-key ${arg_yubico_management_key}} \
          ${arg_piv_ber_tlv_tag}                      \
          "${arg_all_file}"
      ;;

    ${ARG_ALL_TYPE_PRIVKEY})
      ykman                                                                   \
        ${arg_all_serial:+--device ${arg_all_serial}}                         \
        piv keys import                                                       \
          ${arg_all_pin:+--pin ${arg_all_pin}}                                \
          ${arg_yubico_management_key:+--management-key ${arg_yubico_management_key}} \
          ${arg_yubico_pin_policy:+--pin-policy ${arg_yubico_pin_policy}}     \
          ${arg_yubico_touch_policy:+--pin-policy ${arg_yubico_touch_policy}} \
          ${arg_all_password:+--password ${arg_all_password}}                 \
          ${arg_piv_keyref}                                                   \
          "${arg_all_file}"
      ;;
  esac                                                                      && \

  lib_msg_echo --info "${TXT_ARG_ACTION_ALL_IMPORT_YUBICO_INFO}" "false" "" \
    "${L_SC_HLP_PAR_ARG_ALL_SERIAL}"          "${arg_all_serial}"           \
    "${L_SC_HLP_PAR_ARG_ALL_TYPE}"            "${arg_all_type}"             \
    "${L_SC_HLP_PAR_ARG_PIV_BER_TLV_TAG}"     "${arg_piv_ber_tlv_tag}"      \
    "${L_SC_HLP_PAR_ARG_PIV_KEYREF}"          "${arg_piv_keyref}"           \
    "${L_SC_HLP_PAR_ARG_YUBICO_PIN_POLICY}"   "${arg_yubico_pin_policy}"    \
    "${L_SC_HLP_PAR_ARG_YUBICO_TOUCH_POLICY}" "${arg_yubico_touch_policy}"  \
    "${L_SC_HLP_PAR_ARG_ALL_FILE}"            "${arg_all_file}"
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_initialize
#  DESCRIPTION:  Initialize device
#===============================================================================
yubico_initialize() {
  # Step 1 - Reset PIV application
  ykman                                           \
    ${arg_all_serial:+--device ${arg_all_serial}} \
    piv reset                                     \
      ${all_force}                                || \

  # Only continue in case reset was successfull
  return

  # (Optional) Step 2 - Change default PIN
  if lib_core_is --not-empty "${arg_all_pin}"; then
    arg_all_newpinpuk="${arg_all_pin}"
    arg_all_pin="${YUBICO_FACTORY_PIN}"
    yubico_change_pin
  fi

  # (Optional) Step 3 - Change default PUK
  if lib_core_is --not-empty "${arg_all_puk}"; then
    arg_all_newpinpuk="${arg_all_puk}"
    arg_all_puk="${YUBICO_FACTORY_PUK}"
    yubico_change_puk
  fi

  # (Optional) Step 4 - Change default management key
  if lib_core_is --not-empty "${arg_yubico_management_key}"; then
    arg_yubico_new_management_key="${arg_yubico_management_key}"
    arg_yubico_management_key="${YUBICO_FACTORY_MANAGEMENT_KEY}"

    # TODO: <arg_all_pin> must be empty, otherwise
    #       <yubico_change_management_key()> assumes "PIV PIN-only mode"
    arg_all_pin=""

    yubico_change_management_key
  fi
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_keypairgen
#  DESCRIPTION:  Generate (public/private) key pair
#===============================================================================
yubico_keypairgen() {
  # TODO: Support for "PIV PIN-only mode"
  ykman                                           \
    ${arg_all_serial:+--device ${arg_all_serial}} \
    piv keys generate                             \
      ${arg_yubico_management_key:+--management-key ${arg_yubico_management_key}} \
      ${arg_all_pin:+--pin ${arg_all_pin}}        \
      --algorithm ${arg_all_key_type}             \
      --format ${arg_all_format}                  \
      --pin-policy ${arg_yubico_pin_policy}       \
      --touch-policy ${arg_yubico_touch_policy}   \
      ${arg_piv_keyref}                           \
      "${arg_all_file}"
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_list
#  DESCRIPTION:  List available objects (certs, data, keys, etc.)
#===============================================================================
yubico_list() {
  case "${arg_all_type}" in
    ${ARG_ALL_TYPE_ALGORITHM}|${ARG_ALL_TYPE_DATA}) opensc_p11_list;;
    ${ARG_ALL_TYPE_INFO})
      ykman                                           \
        ${arg_all_serial:+--device ${arg_all_serial}} \
        piv info
      ;;
    ${ARG_ALL_TYPE_READER}) ykman list;;
    ${ARG_ALL_TYPE_SERIAL}) ykman list --serials;;
    *)                      opensc_p11_list;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  yubico_unblock_pin
#  DESCRIPTION:  Unblock user PIN (using user PUK)
#===============================================================================
yubico_unblock_pin() {
  ykman                                               \
    ${arg_all_serial:+--device ${arg_all_serial}}     \
    piv access unblock-pin                            \
      ${arg_all_puk:+--puk ${arg_all_puk}}            \
      ${arg_all_newpinpuk:+--new-pin ${arg_all_newpinpuk}}
}

#===============================================================================
#  MAIN
#===============================================================================
main "$@"
