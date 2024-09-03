#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the SCwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /src/lang/sc.en.lang.sh
#
#        USAGE:   ---
#                 (This is a constant file, so please do NOT run it.)
#
#  DESCRIPTION:   --English-- String Constants File for '/src/sc.sh'
#                 Used to generate help texts, interactive dialogues,
#                 and other terminal/log messages.
#
#         BUGS:   ---
#
#        NOTES:   ---
#
#         TODO:   See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#  !!! IMPORTANT !!!
#===============================================================================
#  All constants (identifiers) must follow a certain naming convention,
#  see '/src/lang/run.0.lang.sh'.

#===============================================================================
#  PARAMETER (TEMPLATE) - DO NOT EDIT
#===============================================================================
#  Script actions <ARG_ACTION_...>
readonly L_SC_EN_HLP_DES_ARG_ACTION_HELP="${LIB_SHTPL_EN_HLP_DES_ARG_ACTION_HELP}"

#  Log destination <ARG_LOGDEST_...>
readonly L_SC_EN_HLP_DES_ARG_LOGDEST="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST}"
readonly L_SC_EN_HLP_DES_ARG_LOGDEST_BOTH="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST_BOTH}"
readonly L_SC_EN_HLP_DES_ARG_LOGDEST_SYSLOG="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST_SYSLOG}"
readonly L_SC_EN_HLP_DES_ARG_LOGDEST_TERMINAL="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST_TERMINAL}"

#  Script operation modes <ARG_MODE_...>
readonly L_SC_EN_HLP_DES_ARG_MODE_DAEMON="${LIB_SHTPL_EN_HLP_DES_ARG_MODE_DAEMON}"
readonly L_SC_EN_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU="${LIB_SHTPL_EN_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (Token type)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_token_type
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_TOKEN_TYPE="Token Type"
readonly L_SC_EN_DLG_TXT_ARG_TOKEN_TYPE="Please select your token type. To set up a (non-listed) OpenSC-compatible token please select 'opensc-p15'."

readonly L_SC_EN_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P11="${L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P11}"
readonly L_SC_EN_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15="${L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15}"
readonly L_SC_EN_DLG_ITM_ARG_TOKEN_TYPE_SCHSM="${L_SC_DLG_ITM_ARG_TOKEN_TYPE_SCHSM}"
readonly L_SC_EN_DLG_ITM_ARG_TOKEN_TYPE_YUBICO="${L_SC_DLG_ITM_ARG_TOKEN_TYPE_YUBICO}"

readonly L_SC_EN_HLP_DES_ARG_TOKEN_TYPE="Select the token type to use"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (PKCS#11-related)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  p11_uri
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_P11_URI_1="PKCS#11 URI (Token)"
readonly L_SC_EN_DLG_TTL_P11_URI_2="PKCS#11 URI (Object)"
readonly L_SC_EN_DLG_TXT_P11_URI="Please select one of the following URIs:"

#-------------------------------------------------------------------------------
#  p11_uri_filter
#-------------------------------------------------------------------------------
readonly L_SC_EN_HLP_DES_ARG_P11_URI_FILTER_ALL="All available objects"
readonly L_SC_EN_HLP_DES_ARG_P11_URI_FILTER_CERTS="Only certificates that have an associated private key"
readonly L_SC_EN_HLP_DES_ARG_P11_URI_FILTER_CERTS_ALL="All available certificates"
readonly L_SC_EN_HLP_DES_ARG_P11_URI_FILTER_PRIVKEYS="All available private keys"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (PKCS#15-related)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_p15_id_aid
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_P15_ID_AID_1="PKCS#15 Application (AID)"

readonly L_SC_EN_DLG_TXT_ARG_P15_ID_AID_EXISTING_1="\
===============================
 List of existing applications
==============================="
readonly L_SC_EN_DLG_TXT_ARG_P15_ID_AID_EXISTING_2="Please select the application id (AID) of the PKCS#15 application to bind to:"
readonly L_SC_EN_DLG_TXT_ARG_P15_ID_AID_EXISTING_3="No PKCS#15 application found."

readonly L_SC_EN_DLG_TXT_ARG_P15_ID_AID_NEW_1="${L_SC_EN_DLG_TXT_ARG_P15_ID_AID_EXISTING_1}"
readonly L_SC_EN_DLG_TXT_ARG_P15_ID_AID_NEW_2="Please specify a (hexadecimal) application id (AID) that has not been assigned yet."

readonly L_SC_EN_HLP_DES_ARG_P15_ID_AID="Set the hexadecimal application id (AID) of the PKCS#15 application to bind to. Run '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15} --list p15-application' to list all available PKCS#15 applications."
readonly L_SC_EN_HLP_REF_ARG_P15_ID_AID="Use '${L_SC_HLP_PAR_ARG_P15_ID_AID}' to specify the target application when using multi-application cards."

#-------------------------------------------------------------------------------
#  arg_p15_id_auth
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_P15_ID_AUTH_1="PIN/PUK (Auth ID)"

readonly L_SC_EN_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_1="\
=======================
 List of existing PINs
======================="
readonly L_SC_EN_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_2="Please select the auth id of the PIN/PUK to use:"
readonly L_SC_EN_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_3="No PIN/PUK found."

readonly L_SC_EN_DLG_TXT_ARG_P15_ID_AUTH_NEW_1="${L_SC_EN_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_1}"
readonly L_SC_EN_DLG_TXT_ARG_P15_ID_AUTH_NEW_2="Please specify a (hexadecimal) auth id that has not been assigned yet."

readonly L_SC_EN_HLP_DES_ARG_P15_ID_AUTH="Specify the hexadecimal auth id of the PIN/PUK pair to use/create. Run '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15} --list p15-pin' to list all available PKCS#15 PINs."
readonly L_SC_EN_HLP_REF_ARG_P15_ID_AUTH="Use '${L_SC_HLP_PAR_ARG_P15_ID_AUTH}' to specify the hexadecimal auth id of PIN/PUK pair to use/create."

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> ("FIPS 201 (PIV Card)"-related)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_piv_ber_tlv_tag
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_PIV_BER_TLV_TAG="PIV Card | Object ID (BER-TLV Tag)"
readonly L_SC_EN_DLG_TXT_ARG_PIV_BER_TLV_TAG="\
Please choose one of the following tags.

${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
${L_SC_DLG_TXT_ARG_PIV_BER_TLV_TAG}"

readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC107="Card Capability Container"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC102="Card Holder Unique Identifier"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC105="X.509 Certificate for PIV Authentication"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC103="Cardholder Fingerprints"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC106="Security Object"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC108="Cardholder Facial Image"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC101="X.509 Certificate for Card Authentication"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10A="X.509 Certificate for Digital Signature"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10B="X.509 Certificate for Key Management"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC109="Printed Information"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_7E="Discovery Object"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10C="Key History Object"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10D="Retired X.509 Certificate for Key Management 1"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10E="Retired X.509 Certificate for Key Management 2"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10F="Retired X.509 Certificate for Key Management 3"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC110="Retired X.509 Certificate for Key Management 4"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC111="Retired X.509 Certificate for Key Management 5"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC112="Retired X.509 Certificate for Key Management 6"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC113="Retired X.509 Certificate for Key Management 7"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC114="Retired X.509 Certificate for Key Management 8"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC115="Retired X.509 Certificate for Key Management 9"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC116="Retired X.509 Certificate for Key Management 10"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC117="Retired X.509 Certificate for Key Management 11"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC118="Retired X.509 Certificate for Key Management 12"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC119="Retired X.509 Certificate for Key Management 13"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11A="Retired X.509 Certificate for Key Management 14"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11B="Retired X.509 Certificate for Key Management 15"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11C="Retired X.509 Certificate for Key Management 16"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11D="Retired X.509 Certificate for Key Management 17"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11E="Retired X.509 Certificate for Key Management 18"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11F="Retired X.509 Certificate for Key Management 19"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC120="Retired X.509 Certificate for Key Management 20"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC121="Cardholder Iris Images"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_7F61="Biometric Information Templates Group Template"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC122="Secure Messaging Certificate Signer"
readonly L_SC_EN_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC123="Pairing Code Reference Data Container"

readonly L_SC_EN_HLP_DES_ARG_PIV_BER_TLV_TAG_1="PIV object identifier (BER-TLV Tag)"
readonly L_SC_EN_HLP_DES_ARG_PIV_BER_TLV_TAG_2="\
See also:
${L_SC_DLG_TXT_ARG_PIV_BER_TLV_TAG}"

readonly L_SC_EN_HLP_REF_ARG_PIV_BER_TLV_TAG="Use '${L_SC_HLP_PAR_ARG_PIV_BER_TLV_TAG}' to specify the PIV object id (BER-TLV tag) to use"

#-------------------------------------------------------------------------------
#  arg_piv_keyref
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_PIV_KEYREF="PIV Card | Key Reference Value"

readonly L_SC_EN_DLG_TXT_ARG_PIV_KEYREF_SEEALSO="\
${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
${L_SC_DLG_TXT_ARG_PIV_KEYREF_SEEALSO}"
readonly L_SC_EN_DLG_TXT_ARG_PIV_KEYREF_EXISTING="\
Please choose the slot holding the object to operate on.

${L_SC_EN_DLG_TXT_ARG_PIV_KEYREF_SEEALSO}"
readonly L_SC_EN_DLG_TXT_ARG_PIV_KEYREF_NEW="\
Please choose the slot where the object to create/import should be stored.

${L_SC_EN_DLG_TXT_ARG_PIV_KEYREF_SEEALSO}"

readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_04="PIV Secure Messaging Key"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_9A="PIV Authentication Key"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_9B="PIV Card Application Administration Key"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_9C="Digital Signature Key"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_9D="Key Management Key"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_9E="Card Authentication Key"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_82="Retired Key Management Key 1"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_83="Retired Key Management Key 2"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_84="Retired Key Management Key 3"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_85="Retired Key Management Key 4"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_86="Retired Key Management Key 5"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_87="Retired Key Management Key 6"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_88="Retired Key Management Key 7"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_89="Retired Key Management Key 8"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_8A="Retired Key Management Key 9"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_8B="Retired Key Management Key 10"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_8C="Retired Key Management Key 11"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_8D="Retired Key Management Key 12"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_8E="Retired Key Management Key 13"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_8F="Retired Key Management Key 14"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_90="Retired Key Management Key 15"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_91="Retired Key Management Key 16"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_92="Retired Key Management Key 17"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_93="Retired Key Management Key 18"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_94="Retired Key Management Key 19"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_95="Retired Key Management Key 20"
readonly L_SC_EN_DLG_ITM_ARG_PIV_KEYREF_F9="Attestation (see URL above)"

readonly L_SC_EN_HLP_DES_ARG_PIV_KEYREF_1="PIV slot (key reference value)"
readonly L_SC_EN_HLP_DES_ARG_PIV_KEYREF_2="\
See also:
${L_SC_DLG_TXT_ARG_PIV_KEYREF_SEEALSO}"

readonly L_SC_EN_HLP_REF_ARG_PIV_KEYREF="Use '${L_SC_HLP_PAR_ARG_PIV_KEYREF}' to specify the PIV slot to operate on"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (Used by two or more token types)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_all_data_application_name
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_DATA_APPLICATION_NAME_1="Application Name (Data Object)"

readonly L_SC_EN_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_1="\
===============================
 List of existing data objects
==============================="
readonly L_SC_EN_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_2="Please select the application name of the data object to operate on:"
readonly L_SC_EN_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_3="No data object found."

readonly L_SC_EN_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_NEW_1="${L_SC_EN_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_1}"
readonly L_SC_EN_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_NEW_2="Please specify the application name of the data object to import:"

readonly L_SC_EN_HLP_DES_ARG_ALL_DATA_APPLICATION_NAME="Specify the application name of the data object to import. Only with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}' or '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}'. Run '${L_SC_ABOUT_RUN} --list data' to list all available data objects."
readonly L_SC_EN_HLP_REF_ARG_ALL_DATA_APPLICATION_NAME="Optionally use '${L_SC_HLP_PAR_ARG_ALL_DATA_APPLICATION_NAME}' to specify the data object's application name."

#-------------------------------------------------------------------------------
#  arg_all_data_oid
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_DATA_OID_1="Object Identifier (OID)"

readonly L_SC_EN_DLG_TXT_ARG_ALL_DATA_OID_EXISTING_1="${L_SC_EN_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_1}"
readonly L_SC_EN_DLG_TXT_ARG_ALL_DATA_OID_EXISTING_2="Please select the object identifier (OID) of the data object to operate on:"
readonly L_SC_EN_DLG_TXT_ARG_ALL_DATA_OID_EXISTING_3="${L_SC_EN_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_3}"

readonly L_SC_EN_DLG_TXT_ARG_ALL_DATA_OID_NEW_1="${L_SC_EN_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_1}"
readonly L_SC_EN_DLG_TXT_ARG_ALL_DATA_OID_NEW_2="Please enter the object identifier (OID) of the object to operate on. ${LIB_SHTPL_EN_DLG_TXT_OPTIONAL}"

readonly L_SC_EN_HLP_DES_ARG_ALL_DATA_OID="Specify the data object's identifier (OID). Run '${L_SC_ABOUT_RUN} --list data' to list all available data objects."
readonly L_SC_EN_HLP_REF_ARG_ALL_DATA_OID="Optionally use '${L_SC_HLP_PAR_ARG_ALL_DATA_OID}' to specify the data object's identifier (OID)."

#-------------------------------------------------------------------------------
#  arg_all_file
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_FILE="${LIB_SHTPL_EN_DLG_TTL_FILE_IN} / ${LIB_SHTPL_EN_DLG_TTL_FILE_OUT}"

readonly L_SC_EN_DLG_TTL_ARG_ALL_FILE_ALL_EXPORT="${LIB_SHTPL_EN_DLG_TTL_FILE_OUT} (.bin|.der|.pem)"
readonly L_SC_EN_DLG_TTL_ARG_ALL_FILE_ALL_IMPORT="${LIB_SHTPL_EN_DLG_TTL_FILE_IN} (.bin|.der|.pem)"
readonly L_SC_EN_DLG_TTL_ARG_ALL_FILE_ALL_KEYPAIRGEN="Public Key (.der|.pem)"

readonly L_SC_EN_DLG_TTL_ARG_ALL_FILE_OPENSC_P11_IMPORT="${LIB_SHTPL_EN_DLG_TTL_FILE_IN} (.bin|.der)"

readonly L_SC_EN_DLG_TTL_ARG_ALL_FILE_SCHSM_IMPORT="${L_SC_EN_DLG_TTL_ARG_ALL_FILE_OPENSC_P11_IMPORT}"
readonly L_SC_EN_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_BACKUP="Private Key (DKEK-encrypted) (.bin)"
readonly L_SC_EN_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_DKEK_SHARE_CREATE="DKEK Share File (.pbe)"
readonly L_SC_EN_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_DKEK_SHARE_IMPORT="${L_SC_EN_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_DKEK_SHARE_CREATE}"
readonly L_SC_EN_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_RESTORE="${L_SC_EN_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_BACKUP}"

readonly L_SC_EN_DLG_TXT_ARG_ALL_FILE_IN="${LIB_SHTPL_EN_DLG_TXT_FILE_IN}"
readonly L_SC_EN_DLG_TXT_ARG_ALL_FILE_OUT="${LIB_SHTPL_EN_DLG_TXT_FILE_OUT_NOOVERRIDE}"

#-------------------------------------------------------------------------------
#  arg_all_force
#-------------------------------------------------------------------------------
readonly L_SC_EN_HLP_DES_ARG_ALL_FORCE="Perform action without any further user interaction. Only with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_SCHSM} ${L_SC_HLP_PAR_ARG_ACTION_SCHSM_RESTORE}' or '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO} (${L_SC_HLP_PAR_ARG_ACTION_ALL_INITIALIZE}|${L_SC_HLP_PAR_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY})'."

#-------------------------------------------------------------------------------
#  arg_all_format
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_FORMAT="Key Format"
readonly L_SC_EN_DLG_TXT_ARG_ALL_FORMAT="Please choose one of the following file formats.

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"

readonly L_SC_EN_DLG_ITM_ARG_ALL_FORMAT_DER="${L_SC_DLG_ITM_ARG_ALL_FORMAT_DER}"
readonly L_SC_EN_DLG_ITM_ARG_ALL_FORMAT_PEM="${L_SC_DLG_ITM_ARG_ALL_FORMAT_PEM}"
readonly L_SC_EN_DLG_ITM_ARG_ALL_FORMAT_PKCS12="${L_SC_DLG_ITM_ARG_ALL_FORMAT_PKCS12}"

readonly L_SC_EN_HLP_DES_ARG_ALL_FORMAT="Certificate or key format to use. 'pkcs12' is only possible with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15} ${L_SC_HLP_PAR_ARG_ACTION_ALL_IMPORT} --type privkey'."
readonly L_SC_EN_HLP_REF_ARG_ALL_FORMAT="Use '${L_SC_HLP_PAR_ARG_ALL_FORMAT}' to specify the certificate/key format."

#-------------------------------------------------------------------------------
#  arg_all_id_object
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_ID_OBJECT_1="Object ID"

readonly L_SC_EN_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_1="\
==========================
 List of existing objects
=========================="
readonly L_SC_EN_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_2="Please enter/choose the ID of the object to operate on."
readonly L_SC_EN_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_3="No object found."

readonly L_SC_EN_DLG_TXT_ARG_ALL_ID_OBJECT_NEW_1="${L_SC_EN_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_1}"
readonly L_SC_EN_DLG_TXT_ARG_ALL_ID_OBJECT_NEW_2="Please specify an ID that has not been assigned yet."

readonly L_SC_EN_HLP_DES_ARG_ALL_ID_OBJECT="ID of the object to create or operate on. Run '${L_SC_ABOUT_RUN} --list object' to list all available objects."
readonly L_SC_EN_HLP_REF_ARG_ALL_ID_OBJECT="Object ID must be specified via '${L_SC_HLP_PAR_ARG_ALL_ID_OBJECT}'."

#-------------------------------------------------------------------------------
#  arg_all_id_reader
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_ID_READER_1="Reader/Slot ID"

readonly L_SC_EN_DLG_TXT_ARG_ALL_ID_READER_1="\
=========================
 List of available slots
========================="
readonly L_SC_EN_DLG_TXT_ARG_ALL_ID_READER_2="Please enter/select the (decimal) ID/index of the slot/reader to use. If you have only one device connected then this should be '0'."
readonly L_SC_EN_DLG_TXT_ARG_ALL_ID_READER_3="No reader/slot found."

readonly L_SC_EN_HLP_DES_ARG_ALL_ID_READER="Specify slot/reader to use by its decimal ID/index <id>. Run '${L_SC_ABOUT_RUN} --list reader' to list all available slots/readers."

#-------------------------------------------------------------------------------
#  arg_all_key_type
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_KEY_TYPE="Private Key"
readonly L_SC_EN_DLG_TTL_ARG_ALL_KEY_TYPE_YUBICO_CHANGE_MANAGEMENT_KEY="Management Key"
readonly L_SC_EN_DLG_TTL_ARG_ALL_KEY_TYPE_YUBICO_INITIALIZE="${L_SC_EN_DLG_TTL_ARG_ALL_KEY_TYPE_YUBICO_CHANGE_MANAGEMENT_KEY}"

readonly L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_1="\
======================
 Supported Mechanisms
======================"

readonly L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_2_ALL="Please enter type and length by using the following form (without '' <>):
"
readonly L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_2_OPENSC_P11="${L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_2_ALL}
  '<type>:<length>', e.g. 'rsa:4096', 'EC:prime256v1'

${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
For more information please have a look at the manpage by running 'man pkcs11-tool', parameter \"--key-type\".

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_2_OPENSC_P15="${L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_2_ALL}
  '<type>/<length>', e.g. 'rsa/2048', 'ec/prime256v1'

${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
For more information please have a look at the manpage by running 'man pkcs15-init', section \"Key generation\".

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_2_SCHSM="${L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_2_OPENSC_P11}"
readonly L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_2_YUBICO="${L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_2_ALL}
  '<TYPE><length>', e.g. 'RSA2048', 'ECCP384'

${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
  ${L_SC_DLG_TXT_ARG_ALL_KEY_TYPE_2_YUBICO}

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"

readonly L_SC_EN_DLG_TXT_ARG_ALL_KEY_TYPE_3="Please choose an algorithm from the following list.

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"

readonly L_SC_EN_HLP_DES_ARG_ALL_KEY_TYPE="Type and length of the key to create. Run '${L_SC_ABOUT_RUN} --list algorithm' to get a list of algorithms supported by the token. Depending on the token type this value must follow one of the following forms (without ''):"
readonly L_SC_EN_HLP_DES_ARG_ALL_KEY_TYPE_OPENSC_P11="'<type>:<length>', e.g. 'rsa:4096' or 'EC:prime256v1'"
readonly L_SC_EN_HLP_DES_ARG_ALL_KEY_TYPE_OPENSC_P15="'<type>/<length>', e.g. 'rsa/2048' or 'ec/prime256v1'"
readonly L_SC_EN_HLP_DES_ARG_ALL_KEY_TYPE_SCHSM="${L_SC_EN_HLP_DES_ARG_ALL_KEY_TYPE_OPENSC_P11}"
readonly L_SC_EN_HLP_DES_ARG_ALL_KEY_TYPE_YUBICO="'<TYPE><length>', e.g. 'RSA2048' or 'ECCP384'. Only the following values are allowed:"

readonly L_SC_EN_HLP_REF_ARG_ALL_KEY_TYPE="Optionally use '${L_SC_HLP_PAR_ARG_ALL_KEY_TYPE}' to specify key type/length."

#-------------------------------------------------------------------------------
#  arg_all_label
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_LABEL_1="Object/Token Label"

readonly L_SC_EN_DLG_TXT_ARG_ALL_LABEL_EXISTING_1="\
==========================
 List of existing objects
=========================="
readonly L_SC_EN_DLG_TXT_ARG_ALL_LABEL_EXISTING_2="Please enter the label of the object to operate on. ${LIB_SHTPL_EN_DLG_TXT_OPTIONAL}"
readonly L_SC_EN_DLG_TXT_ARG_ALL_LABEL_EXISTING_3="${L_SC_EN_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_3}"

readonly L_SC_EN_DLG_TXT_ARG_ALL_LABEL_NEW_1="\
==========================
 List of existing objects
=========================="
readonly L_SC_EN_DLG_TXT_ARG_ALL_LABEL_NEW_2="Please specify a label that has not been assigned yet. ${LIB_SHTPL_EN_DLG_TXT_OPTIONAL}"

readonly L_SC_EN_HLP_DES_ARG_ALL_LABEL="Label (name) of the object to operate on (or the token label when '${L_SC_HLP_PAR_ARG_ACTION_ALL_INITIALIZE}' is used). Run '${L_SC_ABOUT_RUN} --list object' to list all available objects."

readonly L_SC_EN_HLP_REF_ARG_ALL_LABEL="Object to create or operate on must be specified via '${L_SC_HLP_PAR_ARG_ALL_LABEL}'."
readonly L_SC_EN_HLP_REF_ARG_ALL_LABEL_OPTIONAL="Optionally use '${L_SC_HLP_PAR_ARG_ALL_LABEL}' to specify object label (name)."
readonly L_SC_EN_HLP_REF_ARG_ALL_LABEL_ID_OBJECT="Object must be specified via '${L_SC_HLP_PAR_ARG_ALL_ID_OBJECT}' and/or '${L_SC_HLP_PAR_ARG_ALL_LABEL}'."
readonly L_SC_EN_HLP_REF_ARG_ALL_LABEL_ID_OBJECT_OPTIONAL="Optionally use '${L_SC_HLP_PAR_ARG_ALL_ID_OBJECT}' and/or '${L_SC_HLP_PAR_ARG_ALL_LABEL}' to specify an object."

#-------------------------------------------------------------------------------
#  arg_all_newpinpuk
#-------------------------------------------------------------------------------
readonly L_SC_EN_HLP_DES_ARG_ALL_NEWPINPUK="New user PIN, PUK, or security officer PIN. Use this option only in case you change an existing value. With '${L_SC_HLP_PAR_ARG_ACTION_ALL_INITIALIZE}' or '${L_SC_HLP_PAR_ARG_ACTION_OPENSC_P15_STORE_PIN}' please use other options, e.g. '${L_SC_HLP_PAR_ARG_ALL_PIN}'. See also (1) and (2)."

#-------------------------------------------------------------------------------
#  arg_all_password
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_PASSWORD="File Password (optional)"
readonly L_SC_EN_HLP_DES_ARG_ALL_PASSWORD="Password for exporting/importing password-protected files. See also (1) and (2)."
readonly L_SC_EN_HLP_REF_ARG_ALL_PASSWORD="For password-protected files use '${L_SC_HLP_PAR_ARG_ALL_PASSWORD}' to specify/set the password"

#-------------------------------------------------------------------------------
#  arg_all_pin
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_PIN="User PIN"
readonly L_SC_EN_HLP_DES_ARG_ALL_PIN="\
(Current or initial) user PIN. See also (1) and (2).

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
${L_SC_EN_HLP_REF_ARG_P15_ID_AUTH}"
readonly L_SC_EN_HLP_REF_ARG_ALL_PIN="Use '${L_SC_HLP_PAR_ARG_ALL_PIN}' to specify the PIN to use"
readonly L_SC_EN_HLP_REF_ARG_ALL_PIN_SOPIN="Use '${L_SC_HLP_PAR_ARG_ALL_PIN}' or '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' to specify the PIN or SO-PIN to use"

#-------------------------------------------------------------------------------
#  arg_all_print
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_PRINT_FILE="Print file?"
readonly L_SC_EN_DLG_TTL_ARG_ALL_PRINT_SECRETS="Print secrets?"

readonly L_SC_EN_DLG_TXT_ARG_ALL_PRINT_FILE="\
It is highly recommended to print the file's content in case the file gets corrupted. Would you like to print the file?"
readonly L_SC_EN_DLG_TXT_ARG_ALL_PRINT_SECRETS="\
Would you like to print your (new) secrets (PIN, PUK, password, etc.) ?

${LIB_SHTPL_EN_DLG_TXT_ATTENTION}
In case there is currently more than one token connected: Please remove the other tokens before(!) continuing."

#-------------------------------------------------------------------------------
#  arg_all_print_separately
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_PRINT_SEPARATELY="Print admin related secrets separately?"
readonly L_SC_EN_DLG_TXT_ARG_ALL_PRINT_SEPARATELY="Would you like to print SO-PIN/SO-PUK/Management Key on a separate document?"
readonly L_SC_EN_HLP_DES_ARG_ALL_PRINT_SEPARATELY="Like '${L_SC_HLP_PAR_ARG_ALL_PRINT}' but print SO-PIN/SO-PUK/Management Key on a separate document"

#-------------------------------------------------------------------------------
#  arg_all_puk
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_PUK="User PUK"
readonly L_SC_EN_HLP_DES_ARG_ALL_PUK="\
(Current or initial) user PUK. See also (1) and (2).

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
${L_SC_EN_HLP_REF_ARG_P15_ID_AUTH}"

#-------------------------------------------------------------------------------
#  arg_all_random
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_RANDOM="Create secrets (PIN, PUK, password, etc.) randomly?"
readonly L_SC_EN_DLG_TXT_ARG_ALL_RANDOM="Would you like to generate your (new) secrets (PIN, PUK, password, etc.) randomly?"
readonly L_SC_EN_HLP_DES_ARG_ALL_RANDOM="Randomly generate secrets (PIN, PUK, password, etc.)"

#-------------------------------------------------------------------------------
#  arg_all_serial
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_SERIAL_1="Token Serial No"

readonly L_SC_EN_DLG_TXT_ARG_ALL_SERIAL_1="Please select your token according to its serial number."
readonly L_SC_EN_DLG_TXT_ARG_ALL_SERIAL_2="No token found."

readonly L_SC_EN_HLP_DES_ARG_ALL_SERIAL_YUBICO="Specify token to use by its serial number. Run '${L_SC_ABOUT_RUN} --list reader' to list all available tokens."

#-------------------------------------------------------------------------------
#  arg_all_sopin
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_SOPIN="Security Officer PIN (SO-PIN)"
readonly L_SC_EN_HLP_DES_ARG_ALL_SOPIN="\
(Current or initial) security officer PIN (SO-PIN). See also (1) and (2).

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
${L_SC_EN_HLP_REF_ARG_P15_ID_AUTH}"
readonly L_SC_EN_HLP_REF_ARG_ALL_SOPIN="Use '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' to specify the SO-PIN to use."

#-------------------------------------------------------------------------------
#  arg_all_sopuk
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_SOPUK="Security Officer PUK (SO-PUK)"
readonly L_SC_EN_HLP_DES_ARG_ALL_SOPUK="\
(Current or initial) security officer PUK (SO-PUK). See also (1) and (2).

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
${L_SC_EN_HLP_REF_ARG_P15_ID_AUTH}"

#-------------------------------------------------------------------------------
#  arg_all_type
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_ALL_TYPE="Object Type"
readonly L_SC_EN_DLG_TXT_ARG_ALL_TYPE="Please one of the following object types."

readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_ALGORITHM="Supported Mechanisms (algorithms, key lengths, ...)"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_CERT="Certificate"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_CHAIN="Certificate Chain"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_DATA="Data Object"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_INFO="General Information"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_OBJECT="(All) Objects"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_PRIVKEY="Private Key"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_PUBKEY="Public Key"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_READER="Available Reader/Slots"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_SECRKEY="Secret Key"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_SSHKEY="SSH Key"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_SSHKEY_RFC4716="SSH Key (RFC4716)"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_P15_APPLICATION="PKCS#15 Application"
readonly L_SC_EN_DLG_ITM_ARG_ALL_TYPE_P15_PIN="PKCS#15 PIN"

readonly L_SC_EN_HLP_DES_ARG_ALL_TYPE="Specify object type. Some types are only available with certain token types."
readonly L_SC_EN_HLP_REF_ARG_ALL_TYPE="Object type must be specified using '${L_SC_HLP_PAR_ARG_ALL_TYPE}'"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (OpenSC (PKCS#11))
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (OpenSC (PKCS#15))
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_opensc_p15_profile
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_OPENSC_P15_PROFILE="OpenSC PKCS#15 Profile"
readonly L_SC_EN_DLG_TXT_ARG_OPENSC_P15_PROFILE="\
Please set the OpenSC PKCS#15 profile to load by using the following form:

  '<profile>[+<option>]...', e.g. 'pkcs15+onepin' (without '')

Some tokens only support one user PIN/PUK pair (but no additional SO-PIN/SO-PUK) and therefore require 'pkcs15+onepin' here.

${LIB_SHTPL_EN_DLG_TXT_SEEALSO} 'man pkcs15-init', parameter \"--profile\"

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"

readonly L_SC_EN_HLP_DES_ARG_OPENSC_P15_PROFILE="\
Specify OpenSC PKCS#15 profile to load during initialization in the form of '<profile>[+<option>]...', e.g. 'pkcs15+onepin' in case your token only supports one user PIN/PUK pair but no separate SO-PIN/SO-PUK.

For more information please have a look at the manpage by running 'man pkcs15-init', parameter \"--profile\"."

readonly L_SC_EN_HLP_REF_ARG_OPENSC_P15_PROFILE="Use '${L_SC_HLP_PAR_ARG_OPENSC_P15_PROFILE}' to specify the OpenSC PKCS#15 profile to load during initialization, e.g. 'pkcs15+onepin' in case your token only supports one user PIN/PUK pair but no additional SO-PIN/SO-PUK."

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (SmartCard-HSM / Nitrokey HSM 2)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_schsm_dkek_shares
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_SCHSM_DKEK_SHARES="DKEK Shares"
readonly L_SC_EN_DLG_TXT_ARG_SCHSM_DKEK_SHARES_1="\
To use the key backup/restore feature, the HSM must be initialized with a Device Key Encryption Key (DKEK). Would you like to do so?

${LIB_SHTPL_EN_DLG_TXT_ATTENTION}
In case you select 'No' no DKEK will be created and the key backup/restore feature will be disabled."
readonly L_SC_EN_DLG_TXT_ARG_SCHSM_DKEK_SHARES_2="\
Please enter the number of shares that the Device Key Encryption Key (DKEK) will be divided among.

If you set this to '0' a random DKEK will be created meaning that keys backed up with this DKEK can only be restored to the same HSM (not recommended).

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_SC_EN_HLP_DES_ARG_SCHSM_DKEK_SHARES="Specify number of DKEK shares (files) that are necessary to recreate the Device Key Encryption Key (DKEK). All DKEK shares are needed to backup/restore the keys. Usually you set <int> to '1'. Leave this parameter out or set <int> to '' to disable DKEK creation and the key backup/restore feature. Set <int> to '0' to create a random DKEK meaning that keys backed up with this DKEK can only be restored in the same HSM. Please do not confuse this with DKEK password n-of-m threshold scheme. Use '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_ACTION_SCHSM_DKEK_SHARE_CREATE}' to create the DKEK share(s)."

#-------------------------------------------------------------------------------
#  arg_schsm_key_reference
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_SCHSM_KEY_REFERENCE="Key Identifier"

readonly L_SC_EN_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_BACKUP_1="Please note: The ID of each object is stored in the 'Key ref' field (decimal value outside the brackets).

==========================
 List of existing objects
=========================="
readonly L_SC_EN_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_BACKUP_2="Please enter the ID of the object to be backed up."

readonly L_SC_EN_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_RESTORE_1="${L_SC_EN_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_BACKUP_1}"
readonly L_SC_EN_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_RESTORE_2="Please specify an ID that has not been assigned yet."

readonly L_SC_EN_HLP_DES_ARG_SCHSM_KEY_REFERENCE="Specify key (identifier) to backup/restore. Run 'pkcs15-tool --dump' to show available keys to backup or free reference ids to use for restore (in the command's output the relevant value is the 'Key ref' field)."

#-------------------------------------------------------------------------------
#  arg_schsm_pwd_shares_threshold
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_SCHSM_PWD_SHARES_THRESHOLD="DKEK Password Shares (Threshold)"
readonly L_SC_EN_DLG_TXT_ARG_SCHSM_PWD_SHARES_THRESHOLD="Please enter the threshold (minimum) number of password shares required for deciphering the DKEK share."
readonly L_SC_EN_HLP_DES_ARG_SCHSM_PWD_SHARES_THRESHOLD="Threshold (minimum) number of password shares required for deciphering the DKEK share"

#-------------------------------------------------------------------------------
#  arg_schsm_pwd_shares_total
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_SCHSM_PWD_SHARES_TOTAL="DKEK Password Shares (Total)"
readonly L_SC_EN_DLG_TXT_ARG_SCHSM_PWD_SHARES_TOTAL="Please enter the total number of password shares used for enciphering the DKEK share:"
readonly L_SC_EN_HLP_DES_ARG_SCHSM_PWD_SHARES_TOTAL="Total number of password shares used to encipher the DKEK share"

#-------------------------------------------------------------------------------
#  arg_schsm_pwd_use_threshold_scheme
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME="Use an n-of-m threshold scheme?"
readonly L_SC_EN_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME_CREATE="\
Would like to establish an n-of-m threshold scheme? If yes, then the password will be randomly created and divided into m shares where n shares are needed to decrypt the DKEK share for import.

${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
  ${L_SC_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME}"
readonly L_SC_EN_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME_IMPORT="\
Was the DKEK share enciphered by using a shared password (n-of-m threshold scheme) (\"Yes\") or a single password (\"No\")?

${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
  ${L_SC_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME}"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (Yubico YubiKey PIV)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_yubico_management_key
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_YUBICO_MANAGEMENT_KEY="Management Key (hexadecimal (0-9 a-f) without '0x')"
readonly L_SC_EN_HLP_DES_ARG_YUBICO_MANAGEMENT_KEY="Specify current management key in hex form (without '0x'). Length depends on '${L_SC_HLP_PAR_ARG_ALL_KEY_TYPE}', e.g. 32 bytes for AES256. See also (1) and (2)."
readonly L_SC_EN_HLP_REF_ARG_YUBICO_MANAGEMENT_KEY="Use '${L_SC_HLP_PAR_ARG_YUBICO_MANAGEMENT_KEY}' to specify the current management key."

#-------------------------------------------------------------------------------
#  arg_yubico_new_management_key
#-------------------------------------------------------------------------------
readonly L_SC_EN_HLP_DES_ARG_YUBICO_NEW_MANAGEMENT_KEY="Specify new management key in hex form (without '0x'). Length depends on '${L_SC_HLP_PAR_ARG_ALL_KEY_TYPE}', e.g. 32 bytes for AES256. See also (1) and (2)."
readonly L_SC_EN_HLP_REF_ARG_YUBICO_NEW_MANAGEMENT_KEY="Use '${L_SC_HLP_PAR_ARG_YUBICO_NEW_MANAGEMENT_KEY}' to specify the new management key."

#-------------------------------------------------------------------------------
#  arg_yubico_pin_policy
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_YUBICO_PIN_POLICY="PIN Policy"
readonly L_SC_EN_DLG_TXT_ARG_YUBICO_PIN_POLICY="
Please select a policy from the following list. The policy defines if or how often a user must confirm key-related operations by entering the user PIN.

${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
  ${L_SC_DLG_TXT_ARG_YUBICO_PIN_POLICY}"

readonly L_SC_EN_DLG_ITM_ARG_YUBICO_PIN_POLICY_ALWAYS="Always"
readonly L_SC_EN_DLG_ITM_ARG_YUBICO_PIN_POLICY_DEFAULT="Default"
readonly L_SC_EN_DLG_ITM_ARG_YUBICO_PIN_POLICY_NEVER="Never"
readonly L_SC_EN_DLG_ITM_ARG_YUBICO_PIN_POLICY_ONCE="Once (per session)"

readonly L_SC_EN_HLP_DES_ARG_YUBICO_PIN_POLICY="PIN policy, defines if or how often a user must confirm key-related operations by entering the user PIN. See also: ${L_SC_DLG_TXT_ARG_YUBICO_PIN_POLICY}

Possible values are:"

#-------------------------------------------------------------------------------
#  arg_yubico_touch_policy
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ARG_YUBICO_TOUCH_POLICY="Touch Policy"
readonly L_SC_EN_DLG_TXT_ARG_YUBICO_TOUCH_POLICY="Please select a policy from the following list. The policy defines if or how often a user must confirm key-related operations by pushing YubiKey's button.

${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
  ${L_SC_DLG_TXT_ARG_YUBICO_TOUCH_POLICY}"

readonly L_SC_EN_DLG_ITM_ARG_YUBICO_TOUCH_POLICY_ALWAYS="Always"
readonly L_SC_EN_DLG_ITM_ARG_YUBICO_TOUCH_POLICY_CACHED="Cached (A touch is not needed if the YubiKey had been touched within the last 15 seconds.)"
readonly L_SC_EN_DLG_ITM_ARG_YUBICO_TOUCH_POLICY_DEFAULT="Default"
readonly L_SC_EN_DLG_ITM_ARG_YUBICO_TOUCH_POLICY_NEVER="Never"

readonly L_SC_EN_HLP_DES_ARG_YUBICO_TOUCH_POLICY="Touch policy, defines if or how often a user must confirm key-related operations by pushing YubiKey's button. See also: ${L_SC_DLG_TXT_ARG_YUBICO_TOUCH_POLICY}

Possible values are:"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Last argument (parameter), see also <args_read()> in '/src/run.sh'
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
readonly L_SC_EN_HLP_DES_LASTARG=""

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Script actions <ARG_ACTION_...>
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Main Menu Title/Text
readonly L_SC_EN_DLG_TTL_ARG_ACTION="${L_SC_ABOUT_PROJECT}"
readonly L_SC_EN_DLG_TXT_ARG_ACTION="What would you like to do?"

#-------------------------------------------------------------------------------
#  PKCS#11-related
#-------------------------------------------------------------------------------
#  ARG_ACTION_P11_GET_URI
readonly L_SC_EN_HLP_DES_ARG_ACTION_P11_GET_URI="Interactively select a token object and get its PKCS#11 URI. Only with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}', '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_SCHSM}', or '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO}'. <type> acts as an object filter, possible values are"

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
#  ARG_ACTION_OPENSC_P15_ERASE_APPLICATION
readonly L_SC_EN_DLG_ITM_ARG_ACTION_OPENSC_P15_ERASE_APPLICATION="Erase PKCS#15 application"
readonly L_SC_EN_HLP_DES_ARG_ACTION_OPENSC_P15_ERASE_APPLICATION="${L_SC_EN_DLG_ITM_ARG_ACTION_OPENSC_P15_ERASE_APPLICATION} with the (hexadecimal) application identifier <aid>, see also '${L_SC_HLP_PAR_ARG_P15_ID_AID}'. ${L_SC_EN_HLP_REF_ARG_ALL_PIN_SOPIN}."

#  ARG_ACTION_OPENSC_P15_ERASE_CARD
readonly L_SC_EN_DLG_ITM_ARG_ACTION_OPENSC_P15_ERASE_CARD="Erase PKCS#15 structure (certain models only)"
readonly L_SC_EN_HLP_DES_ARG_ACTION_OPENSC_P15_ERASE_CARD="${L_SC_EN_DLG_ITM_ARG_ACTION_OPENSC_P15_ERASE_CARD}. ${L_SC_EN_HLP_REF_ARG_ALL_PIN_SOPIN}."

#  ARG_ACTION_OPENSC_P15_FINALIZE
readonly L_SC_EN_DLG_ITM_ARG_ACTION_OPENSC_P15_FINALIZE="Finish initialization (certain models only)"
readonly L_SC_EN_HLP_DES_ARG_ACTION_OPENSC_P15_FINALIZE="${L_SC_EN_DLG_ITM_ARG_ACTION_OPENSC_P15_FINALIZE}. Depending on the model this may prevent you from adding new private/secret keys and/or PIN/PUK pairs. For further information please have a look at OpenSC's model-specific wiki pages:
  ${L_SC_HLP_TXT_REFERENCES_3}"
readonly L_SC_EN_TXT_ARG_ACTION_OPENSC_P15_FINALIZE_INFO="Token successfully finalized."

#  ARG_ACTION_OPENSC_P15_STORE_PIN
readonly L_SC_EN_DLG_ITM_ARG_ACTION_OPENSC_P15_STORE_PIN="Add another user PIN/PUK pair"
readonly L_SC_EN_HLP_DES_ARG_ACTION_OPENSC_P15_STORE_PIN="${L_SC_EN_DLG_ITM_ARG_ACTION_OPENSC_P15_STORE_PIN}. Use '${L_SC_HLP_PAR_ARG_ALL_PIN}' and '${L_SC_HLP_PAR_ARG_ALL_PUK}' to set PIN and PUK. ${L_SC_EN_HLP_REF_ARG_P15_ID_AUTH} ${L_SC_EN_HLP_REF_ARG_ALL_LABEL_OPTIONAL}"
readonly L_SC_EN_TXT_ARG_ACTION_OPENSC_P15_STORE_PIN_INFO="PIN/PUK successfully added."

#-------------------------------------------------------------------------------
#  SmartCard-HSM / Nitrokey HSM 2
#-------------------------------------------------------------------------------
#  ARG_ACTION_SCHSM_BACKUP
readonly L_SC_EN_DLG_ITM_ARG_ACTION_SCHSM_BACKUP="Backup private key"
readonly L_SC_EN_HLP_DES_ARG_ACTION_SCHSM_BACKUP="Export private key and store it in <file> (DKEK-encrypted). Use it with '${L_SC_HLP_PAR_ARG_SCHSM_KEY_REFERENCE}' to specify the key (identifier) to use. ${L_SC_EN_HLP_REF_ARG_ALL_PIN}."

#  ARG_ACTION_SCHSM_DKEK_SHARE_CREATE
readonly L_SC_EN_DLG_ITM_ARG_ACTION_SCHSM_DKEK_SHARE_CREATE="Create Device Key Encryption Key (DKEK) Share"
readonly L_SC_EN_HLP_DES_ARG_ACTION_SCHSM_DKEK_SHARE_CREATE="\
Create an encrypted DKEK share and save it into <file>. Please print the file's content on paper in case the file gets corrupted. To get a printable version, run 'openssl base64 -in <file>'.

Use '${L_SC_HLP_PAR_ARG_ALL_PASSWORD}' to specify an encryption password, otherwise you will be prompted for one.

Use '${L_SC_HLP_PAR_ARG_SCHSM_PWD_SHARES_THRESHOLD}' and '${L_SC_HLP_PAR_ARG_SCHSM_PWD_SHARES_TOTAL}' to establish an n-of-m threshold scheme. Do not(!) use '${L_SC_HLP_PAR_ARG_ALL_PASSWORD}' in this case, you will be prompted for the password shares. See also: ${L_SC_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME}"

#  ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT
readonly L_SC_EN_DLG_ITM_ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT="Import Device Key Encryption Key (DKEK) Share"
readonly L_SC_EN_HLP_DES_ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT="\
Decrypt and write DKEK share from <file> to the HSM.

Use '${L_SC_HLP_PAR_ARG_ALL_PASSWORD}' to specify the decryption password, otherwise you will be prompted for one.

Use it with '${L_SC_HLP_PAR_ARG_SCHSM_PWD_SHARES_TOTAL}' in case your DKEK share requires <int> password shares to restore it. Do not(!) use '${L_SC_HLP_PAR_ARG_ALL_PASSWORD}' in this case, you will be prompted for the password shares. See also: ${L_SC_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME}"

#  ARG_ACTION_SCHSM_RESTORE
readonly L_SC_EN_DLG_ITM_ARG_ACTION_SCHSM_RESTORE="Restore private key"
readonly L_SC_EN_HLP_DES_ARG_ACTION_SCHSM_RESTORE="Restore private key from <file> (DKEK-encrypted). Use it with '${L_SC_HLP_PAR_ARG_SCHSM_KEY_REFERENCE}' to specify the key reference to use. This mode requires running '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_ACTION_ALL_INITIALIZE} ${L_SC_HLP_PAR_ARG_SCHSM_DKEK_SHARES}' and '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT}' beforehand. ${L_SC_EN_HLP_REF_ARG_ALL_PIN}."

#-------------------------------------------------------------------------------
#  Yubico YubiKey PIV
#-------------------------------------------------------------------------------
#  ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY
readonly L_SC_EN_DLG_ITM_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY="Change management key"
readonly L_SC_EN_HLP_DES_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY="${L_SC_EN_DLG_ITM_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY}. ${L_SC_EN_HLP_REF_ARG_YUBICO_MANAGEMENT_KEY} ${L_SC_EN_HLP_REF_ARG_YUBICO_NEW_MANAGEMENT_KEY}"
readonly L_SC_EN_TXT_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY_INFO="Management key successfully changed."

#-------------------------------------------------------------------------------
#  Used by two or more token types
#-------------------------------------------------------------------------------
#  ARG_ACTION_ALL_CHANGE_PIN
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_CHANGE_PIN="Change user PIN (requires user PIN)"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_CHANGE_PIN="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_CHANGE_PIN}. See also '${L_SC_HLP_PAR_ARG_ALL_PIN}' and '${L_SC_HLP_PAR_ARG_ALL_NEWPINPUK}'."

#  ARG_ACTION_ALL_CHANGE_PUK
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_CHANGE_PUK="Change user PUK"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_CHANGE_PUK="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_CHANGE_PUK}. Only with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}' or '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO}'. See also '${L_SC_HLP_PAR_ARG_ALL_PUK}' and '${L_SC_HLP_PAR_ARG_ALL_NEWPINPUK}'."

#  ARG_ACTION_ALL_CHANGE_SO_PIN
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_CHANGE_SO_PIN="Change security officer PIN (SO-PIN)"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_CHANGE_SO_PIN="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_CHANGE_SO_PIN}. Only with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}', '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}', or '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_SCHSM}'. See also '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' and '${L_SC_HLP_PAR_ARG_ALL_NEWPINPUK}'."

#  ARG_ACTION_ALL_CONNECT
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_CONNECT="Prompt the user interactively to connect a token. Returns '0' (token connected) or '1' (no token found)."

#  ARG_ACTION_ALL_DELETE
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_DELETE="Delete a certificate, key, or data object on the token"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_DELETE="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_DELETE}. ${L_SC_EN_HLP_REF_ARG_ALL_TYPE}."
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_DELETE_OPENSC_P11="\
${L_SC_EN_HLP_REF_ARG_ALL_PIN_SOPIN}.

  <type> = data
Use '${L_SC_HLP_PAR_ARG_ALL_DATA_OID}' or '${L_SC_HLP_PAR_ARG_ALL_DATA_APPLICATION_NAME}' and '${L_SC_HLP_PAR_ARG_ALL_LABEL}' to specify the data object to delete.

  <type> != data
Use '${L_SC_HLP_PAR_ARG_ALL_ID_OBJECT}' and/or '${L_SC_HLP_PAR_ARG_ALL_LABEL}' (not with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}') to specify the object to delete."
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_DELETE_OPENSC_P15="${L_SC_EN_HLP_REF_ARG_P15_ID_AID}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_DELETE_SCHSM="${L_SC_EN_HLP_DES_ARG_ACTION_ALL_DELETE_OPENSC_P11}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_DELETE_YUBICO="${L_SC_EN_HLP_REF_ARG_PIV_KEYREF}. ${L_SC_EN_HLP_REF_ARG_YUBICO_MANAGEMENT_KEY}"

#  ARG_ACTION_ALL_EXPORT
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_EXPORT="Export a certificate, public key, or data object from the token to a <file>"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_EXPORT="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_EXPORT}. ${L_SC_EN_HLP_REF_ARG_ALL_TYPE}."
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_EXPORT_OPENSC_P11="\

  <type> = data
Use '${L_SC_HLP_PAR_ARG_ALL_LABEL}', '${L_SC_HLP_PAR_ARG_ALL_DATA_OID}' or '${L_SC_HLP_PAR_ARG_ALL_DATA_APPLICATION_NAME}' to specify the data object to export.

  <type> != data
Use '${L_SC_HLP_PAR_ARG_ALL_ID_OBJECT}' and/or '${L_SC_HLP_PAR_ARG_ALL_LABEL}' (not with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}') to specify the object to export."
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_EXPORT_OPENSC_P15="${L_SC_EN_HLP_REF_ARG_ALL_PIN_SOPIN} (only if <type> = data). ${L_SC_EN_HLP_REF_ARG_P15_ID_AID}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_EXPORT_SCHSM="${L_SC_EN_HLP_DES_ARG_ACTION_ALL_EXPORT_OPENSC_P11}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_EXPORT_YUBICO="${L_SC_EN_HLP_REF_ARG_ALL_FORMAT} ${L_SC_EN_HLP_REF_ARG_PIV_KEYREF} (only if <type> = { cert | pubkey }). ${L_SC_EN_HLP_REF_ARG_PIV_BER_TLV_TAG} (only if <type> = data). ${L_SC_EN_HLP_REF_ARG_ALL_PIN} (only if <type> = { data | pubkey })."
readonly L_SC_EN_TXT_ARG_ACTION_ALL_EXPORT_YUBICO_INFO="Export successful."

#  ARG_ACTION_ALL_GET
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_GET="Get information about the smartcard or its reader. Exactly one (1) token must be connected at that time."

#  ARG_ACTION_ALL_IMPORT
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_IMPORT="Import a certificate, key, or data object from a <file> to the token"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_IMPORT="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_IMPORT}. ${L_SC_EN_HLP_REF_ARG_ALL_TYPE}. ${L_SC_EN_HLP_REF_ARG_ALL_PASSWORD}."
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_IMPORT_OPENSC_P11="\
${L_SC_EN_HLP_REF_ARG_ALL_LABEL_ID_OBJECT} <file> must be DER-encoded. To convert from PEM to DER format, just run 'openssl x509 -in <file_in>.pem -out <file_out>.der -outform der'. ${L_SC_EN_HLP_REF_ARG_ALL_PIN}.

  <type> = data
${L_SC_EN_HLP_REF_ARG_ALL_DATA_OID} ${L_SC_EN_HLP_REF_ARG_ALL_DATA_APPLICATION_NAME}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_IMPORT_OPENSC_P15="\
${L_SC_EN_HLP_REF_ARG_ALL_PIN_SOPIN}. ${L_SC_EN_HLP_REF_ARG_P15_ID_AID}

  <type> = data
${L_SC_EN_HLP_REF_ARG_ALL_LABEL_OPTIONAL} ${L_SC_EN_HLP_REF_ARG_ALL_DATA_OID} ${L_SC_EN_HLP_REF_ARG_ALL_DATA_APPLICATION_NAME}

  <type> != data
${L_SC_EN_HLP_REF_ARG_ALL_LABEL_ID_OBJECT_OPTIONAL} ${L_SC_EN_HLP_REF_ARG_ALL_FORMAT}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_IMPORT_SCHSM="${L_SC_EN_HLP_DES_ARG_ACTION_ALL_IMPORT_OPENSC_P11}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_IMPORT_YUBICO="${L_SC_EN_HLP_REF_ARG_ALL_FORMAT} ${L_SC_EN_HLP_REF_ARG_PIV_KEYREF} (only if <type> = { cert | privkey }). ${L_SC_EN_HLP_REF_ARG_PIV_BER_TLV_TAG} (only if <type> = data). ${L_SC_EN_HLP_REF_ARG_YUBICO_MANAGEMENT_KEY}"
readonly L_SC_EN_TXT_ARG_ACTION_ALL_IMPORT_OPENSC_P15_INFO="Import successful."
readonly L_SC_EN_TXT_ARG_ACTION_ALL_IMPORT_YUBICO_INFO="${L_SC_EN_TXT_ARG_ACTION_ALL_IMPORT_OPENSC_P15_INFO}"

#  ARG_ACTION_ALL_INITIALIZE
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_INITIALIZE="Initialize token"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_INITIALIZE="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_INITIALIZE}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_INITIALIZE_OPENSC_P11="\
Set token label, SO-PIN, and PIN. ${L_SC_EN_HLP_REF_ARG_ALL_LABEL}

Use '${L_SC_HLP_PAR_ARG_ALL_PIN}' and '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' to set PIN and SO-PIN."
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_INITIALIZE_OPENSC_P15="\
Create initial PKCS#15 data structure. ${L_SC_EN_HLP_REF_ARG_ALL_LABEL_OPTIONAL}

Use '${L_SC_HLP_PAR_ARG_ALL_PIN}', '${L_SC_HLP_PAR_ARG_ALL_PUK}', '${L_SC_HLP_PAR_ARG_ALL_SOPIN}', and '${L_SC_HLP_PAR_ARG_ALL_SOPUK}' to set PIN, PUK, SO-PIN, and SO-PUK. Please note that certain models only support one PIN/PUK pair but no additional SO-PIN/SO-PUK.

${L_SC_EN_HLP_REF_ARG_OPENSC_P15_PROFILE}

With certain models it is necessary to run '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_ACTION_OPENSC_P15_ERASE_CARD}' before and/or '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_ACTION_OPENSC_P15_FINALIZE}' after initialization."
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_INITIALIZE_SCHSM="Remove all existing keys, certificates and files. Use it with '${L_SC_HLP_PAR_ARG_SCHSM_DKEK_SHARES}' to enable private key backup/restore, this can not(!) be done at a later stage.

Use '${L_SC_HLP_PAR_ARG_ALL_PIN}' and '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' to set PIN and SO-PIN."
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_INITIALIZE_YUBICO="Wipe all PIV-related data and restore PIV application to factory settings.

Use '${L_SC_HLP_PAR_ARG_ALL_PIN}', '${L_SC_HLP_PAR_ARG_ALL_PUK}', and '${L_SC_HLP_PAR_ARG_YUBICO_MANAGEMENT_KEY}' to set PIN, PUK, and management key."
readonly L_SC_EN_TXT_ARG_ACTION_ALL_INITIALIZE_OPENSC_P15_INFO="Token successfully initialized."

#  ARG_ACTION_ALL_KEYPAIRGEN
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_KEYPAIRGEN="Generate a public-private key pair"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_KEYPAIRGEN="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_KEYPAIRGEN}. <file> is only possible (and mandatory) with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO}'. ${L_SC_EN_HLP_REF_ARG_ALL_KEY_TYPE}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_KEYPAIRGEN_OPENSC_P11="${L_SC_EN_HLP_REF_ARG_ALL_LABEL_ID_OBJECT} ${L_SC_EN_HLP_REF_ARG_ALL_PIN}."
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_KEYPAIRGEN_OPENSC_P15="${L_SC_EN_HLP_REF_ARG_ALL_LABEL_ID_OBJECT_OPTIONAL} ${L_SC_EN_HLP_REF_ARG_ALL_PIN_SOPIN}. ${L_SC_EN_HLP_REF_ARG_P15_ID_AID}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_KEYPAIRGEN_YUBICO="It is mandatory to set <file> to specify where the (generated) public key should be saved to. ${L_SC_EN_HLP_REF_ARG_ALL_FORMAT} ${L_SC_EN_HLP_REF_ARG_PIV_KEYREF}. ${L_SC_EN_HLP_REF_ARG_YUBICO_MANAGEMENT_KEY}"

#  ARG_ACTION_ALL_LIST
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_LIST="List available objects, supported mechanisms, etc."
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_LIST="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_LIST}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_LIST_OPENSC_P15="${L_SC_EN_HLP_REF_ARG_P15_ID_AID}"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_LIST_OPENSC_P15_PINREQUIRED="${L_SC_EN_HLP_REF_ARG_ALL_PIN_SOPIN} (certain models only)."
readonly L_SC_EN_HLP_PAR_ARG_ACTION_ALL_LIST_ALGORITHM="Run '${L_SC_ABOUT_RUN} --list algorithm' to get a list of algorithms supported by the token."
readonly L_SC_EN_HLP_REF_ARG_ACTION_ALL_LIST_DATA="Run '${L_SC_ABOUT_RUN} --list data' to list all available data objects."
readonly L_SC_EN_HLP_REF_ARG_ACTION_ALL_LIST_OBJECT="Run '${L_SC_ABOUT_RUN} --list object' to list all available objects."
readonly L_SC_EN_HLP_REF_ARG_ACTION_ALL_LIST_P15_APPLICATION="Run '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15} --list p15-application' to list all available PKCS#15 applications."
readonly L_SC_EN_HLP_REF_ARG_ACTION_ALL_LIST_P15_PIN="Run '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15} --list p15-pin' to list all available PKCS#15 PINs."

#  ARG_ACTION_ALL_RESET_PIN
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_RESET_PIN="Reset user PIN (requires SO-PIN)"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_RESET_PIN="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_RESET_PIN}. Only with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}' or '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_SCHSM}'. See also '${L_SC_HLP_PAR_ARG_ALL_NEWPINPUK}' and '${L_SC_HLP_PAR_ARG_ALL_SOPIN}'."

#  ARG_ACTION_ALL_UNBLOCK_PIN
readonly L_SC_EN_DLG_ITM_ARG_ACTION_ALL_UNBLOCK_PIN="Reset user PIN (requires user PUK)"
readonly L_SC_EN_HLP_DES_ARG_ACTION_ALL_UNBLOCK_PIN="${L_SC_EN_DLG_ITM_ARG_ACTION_ALL_UNBLOCK_PIN}. Only with '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}', '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}', or '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO}'. See also '${L_SC_HLP_PAR_ARG_ALL_NEWPINPUK}' and '${L_SC_HLP_PAR_ARG_ALL_PUK}'."

#===============================================================================
#  GLOBAL VARIABLES (CUSTOM)
#===============================================================================

#===============================================================================
#  FUNCTIONS (CUSTOM) (MENUS)
#===============================================================================
#-------------------------------------------------------------------------------
#  all_connect
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TTL_ALL_CONNECT="Connect token"
readonly L_SC_EN_DLG_TXT_ALL_CONNECT_1="\
Please connect your smartcard(s)/token and press <Return> to continue.

${LIB_SHTPL_EN_DLG_TXT_ATTENTION}
In case you received this message related to a printing job: Exactly one (1) smartcard/token must be connected."
readonly L_SC_EN_DLG_TXT_ALL_CONNECT_2="\
Smartcard/Token was not detected. Please check if your device is connected and if it is compatible with this script. For more information on supported devices please have a look in the help.

Try again?"

#-------------------------------------------------------------------------------
#  all_file_print
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TXT_ALL_FILE_PRINT_1="${LIB_SHTPL_EN_DLG_TXT_ERROR} For more information please have a look at the help, section \"${LIB_SHTPL_EN_TXT_HELP_TTL_REQUIREMENTS} - PIN/PUK Letter (optional)\"."

#-------------------------------------------------------------------------------
#  all_secrets
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_11="Please define your (new) --\${title1}--. Please note there are some requirements:"

#  OpenSC (PKCS#11)
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_11_OPENSC_P11="\
${L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_11}

PIN:    6 - 8 characters, digits (0-9) only
PUK:    Exactly 8 characters, digits only
SO-PIN: 6 - 8 characters, digits only

${LIB_SHTPL_EN_DLG_TXT_STDIN_HIDDEN}"

#  OpenSC (PKCS#15)
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_11_OPENSC_P15="\
${L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_11}

PIN:    6 - 8 characters, digits (0-9) only
PUK:    8 - 16 (*) characters, digits only
SO-PIN: 6 - 8 characters, digits only
SO-PUK: 8 - 16 (*) characters, digits only

(*) To conform with 'FIPS-201 (PIV Card)' standard it must be exactly 8 characters long.

${LIB_SHTPL_EN_DLG_TXT_STDIN_HIDDEN}"

#  SmartCard-HSM / Nitrokey HSM 2
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_11_SCHSM="\
${L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_11}

PIN:    6 - 15 characters, ASCII only
SO-PIN: Exactly 16 hexadecimal (0-9 a-f) characters
Password (DKEK Share): >= 10 characters, any

Firmware versions before 1.0 have some restrictions, e.g.
  - Device has to be reinitialized to reset the user PIN,
    losing all certs/data/keys
  - Security Officer PIN (SO-PIN) can only be set once(!)
    during first initialization

${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
${L_SC_DLG_TXT_ALL_SECRETS_NEW_11_SCHSM}

${LIB_SHTPL_EN_DLG_TXT_STDIN_HIDDEN}"

#  Yubico YubiKey PIV
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_11_YUBICO="\
${L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_11}

PIN:            6 - 8 characters, ASCII only
PUK:            6 - 8 characters, any (ASCII only recommended)
Management Key: Exactly 32 (AES128), 48 (AES192, TDES), 64 (AES256)
                characters, hexadecimal (0-9 a-f) only

${LIB_SHTPL_EN_DLG_TXT_SEEALSO}
${L_SC_DLG_TXT_ALL_SECRETS_NEW_11_YUBICO}

${LIB_SHTPL_EN_DLG_TXT_STDIN_HIDDEN}"

readonly L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_12="Please note your new --\${title1}-- :"
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_13="Please enter your new --\${title1}-- (again). ${LIB_SHTPL_EN_TXT_STDIN_HIDDEN}"
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_21="The entered --\${title1}-- either contains invalid characters or is too short/long."
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_22="The entered values do not match."

readonly L_SC_EN_DLG_TXT_ALL_SECRETS_EXISTING_1="Please enter your current --\${title1}--. ${LIB_SHTPL_EN_TXT_STDIN_HIDDEN}"
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_EXISTING_21="${L_SC_EN_DLG_TXT_ALL_SECRETS_NEW_21}"
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_EXISTING_22="Either the entered --\${title1}-- is wrong or the token is locked. Error message:"

#-------------------------------------------------------------------------------
#  all_secrets_print
#-------------------------------------------------------------------------------
readonly L_SC_EN_DLG_TXT_ALL_SECRETS_PRINT_1="${L_SC_EN_DLG_TXT_ALL_FILE_PRINT_1}"

#===============================================================================
#  HELP
#===============================================================================
#-------------------------------------------------------------------------------
#  EXAMPLES
#-------------------------------------------------------------------------------
#  Example 1 | Initialize token
readonly L_SC_EN_HLP_TTL_EXAMPLES_1="Initialize token"
readonly L_SC_EN_HLP_TXT_EXAMPLES_1="${L_SC_HLP_TXT_EXAMPLES_1}"

#  Example 2 | Generate public-private key pair
readonly L_SC_EN_HLP_TTL_EXAMPLES_2="Generate public-private key pair"
readonly L_SC_EN_HLP_TXT_EXAMPLES_2="${L_SC_HLP_TXT_EXAMPLES_2}"

#  Example 3 | Import certificate / key / data object
readonly L_SC_EN_HLP_TTL_EXAMPLES_3="Import certificate / key / data object"
readonly L_SC_EN_HLP_TXT_EXAMPLES_3="${L_SC_HLP_TXT_EXAMPLES_3}"

#  Example 4 | Export certificate / data object
readonly L_SC_EN_HLP_TTL_EXAMPLES_4="Export certificate / data object"
readonly L_SC_EN_HLP_TXT_EXAMPLES_4="${L_SC_HLP_TXT_EXAMPLES_4}"

#  Example 5 | Delete certificate / key / data object
readonly L_SC_EN_HLP_TTL_EXAMPLES_5="Delete certificate / key / data object"
readonly L_SC_EN_HLP_TXT_EXAMPLES_5="${L_SC_HLP_TXT_EXAMPLES_5}"

#  Example 6 | PIN Management (Change/Reset/Unblock)
readonly L_SC_EN_HLP_TTL_EXAMPLES_6="PIN Management (Change/Reset/Unblock)"
readonly L_SC_EN_HLP_TXT_EXAMPLES_6="${L_SC_HLP_TXT_EXAMPLES_6}"

#  Example 7 | SmartCard-HSM / Nitrokey HSM 2 | Backup and restore private key
readonly L_SC_EN_HLP_TTL_EXAMPLES_7="Backup and restore private key (${L_SC_DLG_ITM_ARG_TOKEN_TYPE_SCHSM} only)"
readonly L_SC_EN_HLP_TXT_EXAMPLES_7="${L_SC_HLP_TXT_EXAMPLES_7}"

#-------------------------------------------------------------------------------
#  NOTES
#-------------------------------------------------------------------------------
#  Note 1
readonly L_SC_EN_HLP_TXT_NOTES_1="\
Minimum/Maximum length and allowed characters depend on the token type and model. For more information please also consult your token's data sheet or manual.

${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_OPENSC_P15}
PIN:    6 - 8 characters, digits (0-9) only
PUK:    Exactly 8 characters, digits only
SO-PIN: 6 - 8 characters, digits only


${L_SC_HLP_TXT_HEADER_OPENSC_P15}
PUK:    8 - 16 (*) characters, digits only
SO-PUK: 8 - 16 (*) characters, digits only

(*) To conform with 'FIPS-201 (PIV Card)' standard it must be exactly 8 characters long.


${L_SC_HLP_TXT_HEADER_SCHSM}
PIN:    6 - 15 bytes, ASCII characters only
PUK:    (not available)
SO-PIN: Exactly 16 hexadecimal (0-9 a-f) characters
Password (DKEK Share): >= 10 characters, any

Firmware versions before 1.0 have some restrictions, e.g.
  - Device has to be reinitialized to reset the user PIN,
    losing all certs/data/keys.
  - Security Officer PIN (SO-PIN) can only be set once(!)
    during first initialization.

See also:
${L_SC_HLP_TXT_NOTES_1_SCHSM}


${L_SC_HLP_TXT_HEADER_YUBICO}
PIN:    6 - 8 bytes, ASCII characters only
PUK:    6 - 8 bytes, any value (ASCII characters only recommended)
Management Key:
        Length depends on the key type ('${L_SC_HLP_PAR_ARG_ALL_KEY_TYPE}').
        Exactly 32 (AES128), 48 (AES192, TDES), 64 (AES256)
        characters, hexadecimal (0-9 a-f) only.

See also:
${L_SC_HLP_TXT_NOTES_1_YUBICO}


***** FIPS 201 (PIV Card) *****
PIN:    6 - 8 bytes, only ASCII numbers 0-9 ('0x30' - '0x39')
PUK:    8 bytes, any binary value ('0x00' - '0xFF')

See also:
  NIST SP 800-73-4 (Section \"2.4.3 Authentication of an Individual\")
${L_SC_HLP_TXT_NOTES_1_PIV}"

#  Note 2
readonly L_SC_EN_HLP_TXT_NOTES_2="${LIB_SHTPL_EN_TXT_HELP_TXT_NOTES_CREDENTIALS_ENV}"

#-------------------------------------------------------------------------------
#  REQUIREMENTS
#-------------------------------------------------------------------------------
#  Requirements 1 | All token types
readonly L_SC_EN_HLP_TTL_REQUIREMENTS_1="Miscellaneous Token Types (mandatory)"
readonly L_SC_EN_HLP_TXT_REQUIREMENTS_1="\
The following requirements are mandatory for all(!) token types. Additionally, there are token-specific requirements which you can find in the sections below.

Software:
${L_SC_HLP_TXT_REQUIREMENTS_11}

Hardware (Reader):
  Must be CCID compliant and have extended APDU support, see
${L_SC_HLP_TXT_REQUIREMENTS_12}"

#  Requirements 2 | Interactive Mode
readonly L_SC_EN_HLP_TTL_REQUIREMENTS_2="${LIB_SHTPL_EN_TXT_HELP_TTL_REQUIREMENTS_INTERACTIVE}"
readonly L_SC_EN_HLP_TXT_REQUIREMENTS_2="${LIB_SHTPL_EN_TXT_HELP_TXT_REQUIREMENTS_INTERACTIVE}"

#  Requirements 3 | PIN/PUK Letter
readonly L_SC_EN_HLP_TTL_REQUIREMENTS_3="PIN/PUK Letter (optional)"
readonly L_SC_EN_HLP_TXT_REQUIREMENTS_3="\
This project provides a customizable LaTeX letter template '${L_SC_HLP_TXT_REQUIREMENTS_31}' that can be used to print token-related secrets like PIN, PUK, etc. For further setup instructions please have a look at: ${L_SC_HLP_TXT_REQUIREMENTS_32}"

#  Requirements 4 | OpenSC (PKCS#11) and SmartCard-HSM / Nitrokey HSM 2
readonly L_SC_EN_HLP_TTL_REQUIREMENTS_4="${L_SC_EN_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P11} and ${L_SC_EN_DLG_ITM_ARG_TOKEN_TYPE_SCHSM}"
readonly L_SC_EN_HLP_TXT_REQUIREMENTS_4="\
Software:
${L_SC_HLP_TXT_REQUIREMENTS_41}

Hardware (Smartcard/Token):
  Must be supported by OpenSC, see
${L_SC_HLP_TXT_REQUIREMENTS_42}"

#  Requirements 5 | OpenSC (PKCS#15)
readonly L_SC_EN_HLP_TTL_REQUIREMENTS_5="${L_SC_EN_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15}"
readonly L_SC_EN_HLP_TXT_REQUIREMENTS_5="\
Software:
${L_SC_HLP_TXT_REQUIREMENTS_51}

Hardware (Smartcard/Token):
  Must be supported by OpenSC, see
${L_SC_HLP_TXT_REQUIREMENTS_52}"

#  Requirements 6 | SmartCard-HSM / Nitrokey HSM 2
readonly L_SC_EN_HLP_TTL_REQUIREMENTS_6="${L_SC_EN_DLG_ITM_ARG_TOKEN_TYPE_SCHSM}"
readonly L_SC_EN_HLP_TXT_REQUIREMENTS_6="\
Software:
${L_SC_HLP_TXT_REQUIREMENTS_61}"

#  Requirements 7 | Yubico YubiKey PIV
readonly L_SC_EN_HLP_TTL_REQUIREMENTS_7="${L_SC_EN_DLG_ITM_ARG_TOKEN_TYPE_YUBICO}"
readonly L_SC_EN_HLP_TXT_REQUIREMENTS_7="\
Software:
${L_SC_HLP_TXT_REQUIREMENTS_71}

Hardware (Smartcard/Token):
${L_SC_HLP_TXT_REQUIREMENTS_72}
    (Look for 'Smart card (PIV-compatible)' field)

'PIV PIN-only mode' is currently not supported, see '${L_SC_HLP_TXT_REQUIREMENTS_73}'."

#-------------------------------------------------------------------------------
#  SYNOPSIS
#-------------------------------------------------------------------------------
#  ACTION | All token types
readonly L_SC_EN_HLP_TTL_SYNOPSIS_ACTION_ALL="Miscellaneous Token Types"
readonly L_SC_EN_HLP_TXT_SYNOPSIS_ACTION_ALL="Some actions are only allowed with certain token types, see type-specific action lists above."

#  OPTION | All token types
readonly L_SC_EN_HLP_TTL_SYNOPSIS_OPTION_ALL="${L_SC_EN_HLP_TTL_SYNOPSIS_ACTION_ALL}"
readonly L_SC_EN_HLP_TXT_SYNOPSIS_OPTION_ALL="Some options are only allowed with certain token types, see type-specific option lists above."

#-------------------------------------------------------------------------------
#  TEXTS
#-------------------------------------------------------------------------------
#  Intro Description
readonly L_SC_EN_HLP_TXT_INTRO="Initialize and manage smartcards, USB tokens, and Hardware Security Modules (HSMs)."

#-------------------------------------------------------------------------------
#  TL;DR
#-------------------------------------------------------------------------------
readonly L_SC_EN_HLP_TTL_TLDR_1="Requirements"
readonly L_SC_EN_HLP_TXT_TLDR_1="\
To install the neccessary packages on your system, simply run:

${L_SC_HLP_TXT_TLDR_1_INSTALL}

Depending on your token type not all packages may be needed. For more information please have a look at <${LIB_SHTPL_EN_TXT_HELP_TTL_REQUIREMENTS}> section below.

${L_SC_EN_HLP_TXT_REQUIREMENTS_3}

The script has been developed and tested on the following system:

OS:         ${L_SC_HLP_TXT_TLDR_1_OS}
Kernel:     ${L_SC_HLP_TXT_TLDR_1_KERNEL}
Packages:   ${L_SC_HLP_TXT_TLDR_1_PACKAGES}"

#===============================================================================
#  CUSTOM STRINGS (used in terminal output <stdout>/<stderr>)
#===============================================================================
#  TODO: Here you can define custom language-specific strings.
#        Do not forget to "publish" them within the <init_lang()> function of
#        your destination script, e.g. 'run.sh'.
#===============================================================================