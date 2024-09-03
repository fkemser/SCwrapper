#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the SCwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /src/lang/sc.de.lang.sh
#
#        USAGE:   ---
#                 (This is a constant file, so please do NOT run it.)
#
#  DESCRIPTION:   --German-- String Constants File for '/src/sc.sh'
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
readonly L_SC_DE_HLP_DES_ARG_ACTION_HELP="${LIB_SHTPL_DE_HLP_DES_ARG_ACTION_HELP}"

#  Log destination <ARG_LOGDEST_...>
readonly L_SC_DE_HLP_DES_ARG_LOGDEST="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST}"
readonly L_SC_DE_HLP_DES_ARG_LOGDEST_BOTH="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST_BOTH}"
readonly L_SC_DE_HLP_DES_ARG_LOGDEST_SYSLOG="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST_SYSLOG}"
readonly L_SC_DE_HLP_DES_ARG_LOGDEST_TERMINAL="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST_TERMINAL}"

#  Script operation modes <ARG_MODE_...>
readonly L_SC_DE_HLP_DES_ARG_MODE_DAEMON="${LIB_SHTPL_DE_HLP_DES_ARG_MODE_DAEMON}"
readonly L_SC_DE_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU="${LIB_SHTPL_DE_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (Token type)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_token_type
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_TOKEN_TYPE="Tokentyp"
readonly L_SC_DE_DLG_TXT_ARG_TOKEN_TYPE="Bitte wählen Sie Ihren Tokentyp aus. Für die erstmalige Einrichtung eines (nicht aufgeführten, aber) OpenSC-kompatiblen Tokens wählen Sie bitte 'opensc-p15'."

readonly L_SC_DE_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P11="${L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P11}"
readonly L_SC_DE_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15="${L_SC_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15}"
readonly L_SC_DE_DLG_ITM_ARG_TOKEN_TYPE_SCHSM="${L_SC_DLG_ITM_ARG_TOKEN_TYPE_SCHSM}"
readonly L_SC_DE_DLG_ITM_ARG_TOKEN_TYPE_YUBICO="${L_SC_DLG_ITM_ARG_TOKEN_TYPE_YUBICO}"

readonly L_SC_DE_HLP_DES_ARG_TOKEN_TYPE="Zu verwendenden Tokentyp auswählen"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (PKCS#11-related)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  p11_uri
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_P11_URI_1="PKCS#11 URI (Token)"
readonly L_SC_DE_DLG_TTL_P11_URI_2="PKCS#11 URI (Objekt)"
readonly L_SC_DE_DLG_TXT_P11_URI="Bitte wählen Sie eine der nachfolgenden URIs aus:"

#-------------------------------------------------------------------------------
#  p11_uri_filter
#-------------------------------------------------------------------------------
readonly L_SC_DE_HLP_DES_ARG_P11_URI_FILTER_ALL="Alle verfügbaren Objekte"
readonly L_SC_DE_HLP_DES_ARG_P11_URI_FILTER_CERTS="Nur Zertifikate, denen ein privater Schlüssel zugeordnet ist"
readonly L_SC_DE_HLP_DES_ARG_P11_URI_FILTER_CERTS_ALL="Alle verfügbaren Zertifikate"
readonly L_SC_DE_HLP_DES_ARG_P11_URI_FILTER_PRIVKEYS="Alle verfügbaren privaten Schlüssel"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (PKCS#15-related)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_p15_id_aid
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_P15_ID_AID_1="PKCS#15-Anwendung (AID)"

readonly L_SC_DE_DLG_TXT_ARG_P15_ID_AID_EXISTING_1="\
===============================
 Liste vorhandener Anwendungen
==============================="
readonly L_SC_DE_DLG_TXT_ARG_P15_ID_AID_EXISTING_2="Bitte wählen Sie aus der nachfolgenden Liste die Anwendungs-ID (AID) der zu verwendenden PKCS#15-Anwendung aus:"
readonly L_SC_DE_DLG_TXT_ARG_P15_ID_AID_EXISTING_3="Keine PKCS#15-Anwendung gefunden."

readonly L_SC_DE_DLG_TXT_ARG_P15_ID_AID_NEW_1="${L_SC_DE_DLG_TXT_ARG_P15_ID_AID_EXISTING_1}"
readonly L_SC_DE_DLG_TXT_ARG_P15_ID_AID_NEW_2="Bitte geben Sie eine gültige, noch nicht vergebene, (hexadezimale) Anwendungs-ID (AID) an."

readonly L_SC_DE_HLP_DES_ARG_P15_ID_AID="Legt die zu verwendende PKCS#15-Anwendung anhand ihrer hexadezimalen Anwendungs-ID (AID) fest. Führen Sie '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15} --list p15-application' aus, um alle verfügbaren PKCS#15-Anwendungen anzuzeigen."
readonly L_SC_DE_HLP_REF_ARG_P15_ID_AID="Verwenden Sie '${L_SC_HLP_PAR_ARG_P15_ID_AID}', um die Zielanwendung festzulegen, wenn auf dem Token mehrere PKCS#15-Anwendungen vorhanden sind."

#-------------------------------------------------------------------------------
#  arg_p15_id_auth
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_P15_ID_AUTH_1="PIN/PUK (Auth ID)"

readonly L_SC_DE_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_1="\
========================
 Liste vorhandener PINs
========================"
readonly L_SC_DE_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_2="Bitte wählen Sie aus der nachfolgenden Liste die Auth ID der zu verwendenden PIN/PUK aus:"
readonly L_SC_DE_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_3="Keine PIN/PUK vorhanden."

readonly L_SC_DE_DLG_TXT_ARG_P15_ID_AUTH_NEW_1="${L_SC_DE_DLG_TXT_ARG_P15_ID_AUTH_EXISTING_1}"
readonly L_SC_DE_DLG_TXT_ARG_P15_ID_AUTH_NEW_2="Bitte geben Sie eine gültige, noch nicht vergebene, (hexadezimale) Auth ID an."

readonly L_SC_DE_HLP_DES_ARG_P15_ID_AUTH="Legt das zu erstellende/verwendende PIN/PUK-Paar anhand seiner hexadezimalen Auth ID fest. Führen Sie '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15} --list p15-pin' aus, um alle verfügbaren PKCS#15 PINs anzuzeigen."
readonly L_SC_DE_HLP_REF_ARG_P15_ID_AUTH="Verwenden Sie '${L_SC_HLP_PAR_ARG_P15_ID_AUTH}', um das zu erstellende/verwendende PIN/PUK-Paar anhand seiner hexadezimalen Auth ID festzulegen."

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> ("FIPS 201 (PIV Card)"-related)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_piv_ber_tlv_tag
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_PIV_BER_TLV_TAG="PIV Card | Object ID (BER-TLV Tag)"
readonly L_SC_DE_DLG_TXT_ARG_PIV_BER_TLV_TAG="\
Bitte wählen Sie einen der nachfolgenden Tags aus.

${LIB_SHTPL_DE_DLG_TXT_SEEALSO}
${L_SC_DLG_TXT_ARG_PIV_BER_TLV_TAG}"

readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC107="Card Capability Container"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC102="Card Holder Unique Identifier"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC105="X.509 Certificate for PIV Authentication"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC103="Cardholder Fingerprints"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC106="Security Object"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC108="Cardholder Facial Image"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC101="X.509 Certificate for Card Authentication"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10A="X.509 Certificate for Digital Signature"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10B="X.509 Certificate for Key Management"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC109="Printed Information"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_7E="Discovery Object"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10C="Key History Object"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10D="Retired X.509 Certificate for Key Management 1"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10E="Retired X.509 Certificate for Key Management 2"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC10F="Retired X.509 Certificate for Key Management 3"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC110="Retired X.509 Certificate for Key Management 4"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC111="Retired X.509 Certificate for Key Management 5"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC112="Retired X.509 Certificate for Key Management 6"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC113="Retired X.509 Certificate for Key Management 7"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC114="Retired X.509 Certificate for Key Management 8"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC115="Retired X.509 Certificate for Key Management 9"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC116="Retired X.509 Certificate for Key Management 10"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC117="Retired X.509 Certificate for Key Management 11"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC118="Retired X.509 Certificate for Key Management 12"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC119="Retired X.509 Certificate for Key Management 13"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11A="Retired X.509 Certificate for Key Management 14"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11B="Retired X.509 Certificate for Key Management 15"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11C="Retired X.509 Certificate for Key Management 16"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11D="Retired X.509 Certificate for Key Management 17"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11E="Retired X.509 Certificate for Key Management 18"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC11F="Retired X.509 Certificate for Key Management 19"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC120="Retired X.509 Certificate for Key Management 20"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC121="Cardholder Iris Images"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_7F61="Biometric Information Templates Group Template"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC122="Secure Messaging Certificate Signer"
readonly L_SC_DE_DLG_ITM_ARG_PIV_BER_TLV_TAG_5FC123="Pairing Code Reference Data Container"

readonly L_SC_DE_HLP_DES_ARG_PIV_BER_TLV_TAG_1="PIV Objekt ID (BER-TLV Tag)"
readonly L_SC_DE_HLP_DES_ARG_PIV_BER_TLV_TAG_2="\
Siehe auch:
${L_SC_DLG_TXT_ARG_PIV_BER_TLV_TAG}"

readonly L_SC_DE_HLP_REF_ARG_PIV_BER_TLV_TAG="Verwenden Sie '${L_SC_HLP_PAR_ARG_PIV_BER_TLV_TAG}', um die zu verwendende PIV Objekt ID (BER-TLV tag) festzulegen"

#-------------------------------------------------------------------------------
#  arg_piv_keyref
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_PIV_KEYREF="PIV Card | Key Reference Value"

readonly L_SC_DE_DLG_TXT_ARG_PIV_KEYREF_SEEALSO="\
${LIB_SHTPL_DE_DLG_TXT_SEEALSO}
${L_SC_DLG_TXT_ARG_PIV_KEYREF_SEEALSO}"
readonly L_SC_DE_DLG_TXT_ARG_PIV_KEYREF_EXISTING="\
Bitte wählen Sie den Slot des Objekts, welches verwendet/bearbeitet werden soll.

${L_SC_DE_DLG_TXT_ARG_PIV_KEYREF_SEEALSO}"
readonly L_SC_DE_DLG_TXT_ARG_PIV_KEYREF_NEW="\
Bitte wählen Sie den Slot aus, in dem das zu erstellende/importierende Objekt
abgelegt werden soll.

${L_SC_DE_DLG_TXT_ARG_PIV_KEYREF_SEEALSO}"

readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_04="PIV Sicherer Nachrichtenversand"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_9A="PIV Authentifizierung"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_9B="PIV Card Application Administration Key"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_9C="Digitale Signatur"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_9D="Schlüsselverwaltung"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_9E="Authentifizierung"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_82="Abgelaufener Verwaltungsschlüssel 1"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_83="Abgelaufener Verwaltungsschlüssel 2"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_84="Abgelaufener Verwaltungsschlüssel 3"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_85="Abgelaufener Verwaltungsschlüssel 4"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_86="Abgelaufener Verwaltungsschlüssel 5"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_87="Abgelaufener Verwaltungsschlüssel 6"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_88="Abgelaufener Verwaltungsschlüssel 7"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_89="Abgelaufener Verwaltungsschlüssel 8"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_8A="Abgelaufener Verwaltungsschlüssel 9"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_8B="Abgelaufener Verwaltungsschlüssel 10"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_8C="Abgelaufener Verwaltungsschlüssel 11"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_8D="Abgelaufener Verwaltungsschlüssel 12"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_8E="Abgelaufener Verwaltungsschlüssel 13"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_8F="Abgelaufener Verwaltungsschlüssel 14"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_90="Abgelaufener Verwaltungsschlüssel 15"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_91="Abgelaufener Verwaltungsschlüssel 16"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_92="Abgelaufener Verwaltungsschlüssel 17"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_93="Abgelaufener Verwaltungsschlüssel 18"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_94="Abgelaufener Verwaltungsschlüssel 19"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_95="Abgelaufener Verwaltungsschlüssel 20"
readonly L_SC_DE_DLG_ITM_ARG_PIV_KEYREF_F9="Beglaubigung (siehe URL oben)"

readonly L_SC_DE_HLP_DES_ARG_PIV_KEYREF_1="PIV Slot (Key Reference Value)"
readonly L_SC_DE_HLP_DES_ARG_PIV_KEYREF_2="\
Siehe auch:
${L_SC_DLG_TXT_ARG_PIV_KEYREF_SEEALSO}"

readonly L_SC_DE_HLP_REF_ARG_PIV_KEYREF="Verwenden Sie '${L_SC_HLP_PAR_ARG_PIV_KEYREF}', um den PIV-Slot auszuwählen, der verwendet/bearbeitet/gelöscht werden soll"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (Used by two or more token types)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_all_data_application_name
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_DATA_APPLICATION_NAME_1="Anwendungsname (Datenobjekt)"

readonly L_SC_DE_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_1="\
================================
 Liste vorhandener Datenobjekte
================================"
readonly L_SC_DE_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_2="Bitte wählen Sie den Anwendungsnamen des zu bearbeitenden Datenobjekts aus:"
readonly L_SC_DE_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_3="Kein Datenobjekt gefunden."

readonly L_SC_DE_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_NEW_1="${L_SC_DE_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_1}"
readonly L_SC_DE_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_NEW_2="Bitte legen Sie den Anwendungsnamen des zu importierenden Datenobjekts fest:"

readonly L_SC_DE_HLP_DES_ARG_ALL_DATA_APPLICATION_NAME="Legt den Anwendungsnamen des zu importierenden Datenobjekts fest. Nur mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}' oder '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}'. Führen Sie '${L_SC_ABOUT_RUN} --list data' aus, um alle verfügbaren Datenobjekte anzuzeigen."
readonly L_SC_DE_HLP_REF_ARG_ALL_DATA_APPLICATION_NAME="Der Anwendungsname des Datenobjekts kann mit '${L_SC_HLP_PAR_ARG_ALL_DATA_APPLICATION_NAME}' festgelegt werden."

#-------------------------------------------------------------------------------
#  arg_all_data_oid
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_DATA_OID_1="Objektidentifikator (OID)"

readonly L_SC_DE_DLG_TXT_ARG_ALL_DATA_OID_EXISTING_1="${L_SC_DE_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_1}"
readonly L_SC_DE_DLG_TXT_ARG_ALL_DATA_OID_EXISTING_2="Bitte wählen Sie den Objektidentifikator (OID) des zu exportierenden/löschenden Datenobjekts aus:"
readonly L_SC_DE_DLG_TXT_ARG_ALL_DATA_OID_EXISTING_3="${L_SC_DE_DLG_TXT_ARG_ALL_DATA_APPLICATION_NAME_EXISTING_3}"

readonly L_SC_DE_DLG_TXT_ARG_ALL_DATA_OID_NEW_1="${L_SC_DE_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_1}"
readonly L_SC_DE_DLG_TXT_ARG_ALL_DATA_OID_NEW_2="Bitte geben Sie den Objektidentifikator (OID) des zu importierenden Datenobjekts an. ${LIB_SHTPL_DE_DLG_TXT_OPTIONAL}"

readonly L_SC_DE_HLP_DES_ARG_ALL_DATA_OID="Legt den Objektidentifikator (OID) des zu importierenden/exportierenden/löschenden Datenobjekts fest. Führen Sie '${L_SC_ABOUT_RUN} --list data' aus, um alle verfügbaren Datenobjekte anzuzeigen."
readonly L_SC_DE_HLP_REF_ARG_ALL_DATA_OID="Der Objektidentifikator (OID) des Datenobjekts kann mit '${L_SC_HLP_PAR_ARG_ALL_DATA_OID}' festgelegt werden."

#-------------------------------------------------------------------------------
#  arg_all_file
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_FILE="${LIB_SHTPL_DE_DLG_TTL_FILE_IN} / ${LIB_SHTPL_DE_DLG_TTL_FILE_OUT}"

readonly L_SC_DE_DLG_TTL_ARG_ALL_FILE_ALL_EXPORT="${LIB_SHTPL_DE_DLG_TTL_FILE_OUT} (.bin|.der|.pem)"
readonly L_SC_DE_DLG_TTL_ARG_ALL_FILE_ALL_IMPORT="${LIB_SHTPL_DE_DLG_TTL_FILE_IN} (.bin|.der|.pem)"
readonly L_SC_DE_DLG_TTL_ARG_ALL_FILE_ALL_KEYPAIRGEN="Öffentlicher Schlüssel (.der|.pem)"

readonly L_SC_DE_DLG_TTL_ARG_ALL_FILE_OPENSC_P11_IMPORT="${LIB_SHTPL_DE_DLG_TTL_FILE_IN} (.bin|.der)"

readonly L_SC_DE_DLG_TTL_ARG_ALL_FILE_SCHSM_IMPORT="${L_SC_DE_DLG_TTL_ARG_ALL_FILE_OPENSC_P11_IMPORT}"
readonly L_SC_DE_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_BACKUP="Privater Schlüssel (DKEK-verschlüsselt) (.bin)"
readonly L_SC_DE_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_DKEK_SHARE_CREATE="DKEK-Share-Datei (.pbe)"
readonly L_SC_DE_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_DKEK_SHARE_IMPORT="${L_SC_DE_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_DKEK_SHARE_CREATE}"
readonly L_SC_DE_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_RESTORE="${L_SC_DE_DLG_TTL_ARG_ALL_FILE_SCHSM_SCHSM_BACKUP}"

readonly L_SC_DE_DLG_TXT_ARG_ALL_FILE_IN="${LIB_SHTPL_DE_DLG_TXT_FILE_IN}"
readonly L_SC_DE_DLG_TXT_ARG_ALL_FILE_OUT="${LIB_SHTPL_DE_DLG_TXT_FILE_OUT_NOOVERRIDE}"

#-------------------------------------------------------------------------------
#  arg_all_force
#-------------------------------------------------------------------------------
readonly L_SC_DE_HLP_DES_ARG_ALL_FORCE="Führt die gewählte Aktion ohne jegliche Nachfrage durch. Nur mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_SCHSM} ${L_SC_HLP_PAR_ARG_ACTION_SCHSM_RESTORE}' oder '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO} (${L_SC_HLP_PAR_ARG_ACTION_ALL_INITIALIZE}|${L_SC_HLP_PAR_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY})'."

#-------------------------------------------------------------------------------
#  arg_all_format
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_FORMAT="Schlüsselformat"
readonly L_SC_DE_DLG_TXT_ARG_ALL_FORMAT="Bitte wählen Sie eines der nachfolgenden Dateiformate aus.

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"

readonly L_SC_DE_DLG_ITM_ARG_ALL_FORMAT_DER="${L_SC_DLG_ITM_ARG_ALL_FORMAT_DER}"
readonly L_SC_DE_DLG_ITM_ARG_ALL_FORMAT_PEM="${L_SC_DLG_ITM_ARG_ALL_FORMAT_PEM}"
readonly L_SC_DE_DLG_ITM_ARG_ALL_FORMAT_PKCS12="${L_SC_DLG_ITM_ARG_ALL_FORMAT_PKCS12}"

readonly L_SC_DE_HLP_DES_ARG_ALL_FORMAT="Zu verwendendes Zertifikat-/Schlüsselformat. 'pkcs12' ist ausschließlich in Verbindung mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15} ${L_SC_HLP_PAR_ARG_ACTION_ALL_IMPORT} --type privkey' möglich."
readonly L_SC_DE_HLP_REF_ARG_ALL_FORMAT="Verwenden Sie '${L_SC_HLP_PAR_ARG_ALL_FORMAT}', um das Zertifikat-/Schlüsselformat festzulegen."

#-------------------------------------------------------------------------------
#  arg_all_id_object
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_ID_OBJECT_1="Objekt ID"

readonly L_SC_DE_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_1="\
===========================
 Liste vorhandener Objekte
==========================="
readonly L_SC_DE_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_2="Bitte geben/wählen Sie die ID des zu verwendenden/bearbeitenden/löschenden Objekts an/aus."
readonly L_SC_DE_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_3="Kein Objekt gefunden."

readonly L_SC_DE_DLG_TXT_ARG_ALL_ID_OBJECT_NEW_1="${L_SC_DE_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_1}"
readonly L_SC_DE_DLG_TXT_ARG_ALL_ID_OBJECT_NEW_2="Bitte geben Sie eine gültige, noch nicht vergebene, ID an."

readonly L_SC_DE_HLP_DES_ARG_ALL_ID_OBJECT="ID des zu verwendenden/bearbeitenden/löschenden Objekts. Führen Sie '${L_SC_ABOUT_RUN} --list object' aus, um alle verfügbaren Objekte anzuzeigen."
readonly L_SC_DE_HLP_REF_ARG_ALL_ID_OBJECT="Objekt ID muss mit '${L_SC_HLP_PAR_ARG_ALL_ID_OBJECT}' festgelegt werden."

#-------------------------------------------------------------------------------
#  arg_all_id_reader
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_ID_READER_1="Leser/Slot ID"

readonly L_SC_DE_DLG_TXT_ARG_ALL_ID_READER_1="\
=========================
 Liste verfügbarer Slots
========================="
readonly L_SC_DE_DLG_TXT_ARG_ALL_ID_READER_2="Bitte wählen Sie den/das Slot/Lesegerät anhand seiner/-s dezimalen ID/Index aus. Sofern lediglich ein Gerät angeschlossen ist, ist dieser Wert normalerweise '0'."
readonly L_SC_DE_DLG_TXT_ARG_ALL_ID_READER_3="Kein Slot/Lesegerät gefunden."

readonly L_SC_DE_HLP_DES_ARG_ALL_ID_READER="Legt den zu verwendenden Slot/Lesegerät durch Angabe der/des dezimalen ID/Index <id> fest. Führen Sie '${L_SC_ABOUT_RUN} --list reader' aus, um alle verfügbaren Slots/Lesegeräte anzuzeigen."

#-------------------------------------------------------------------------------
#  arg_all_key_type
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_KEY_TYPE="Privater Schlüssel"
readonly L_SC_DE_DLG_TTL_ARG_ALL_KEY_TYPE_YUBICO_CHANGE_MANAGEMENT_KEY="Management Key"
readonly L_SC_DE_DLG_TTL_ARG_ALL_KEY_TYPE_YUBICO_INITIALIZE="${L_SC_DE_DLG_TTL_ARG_ALL_KEY_TYPE_YUBICO_CHANGE_MANAGEMENT_KEY}"

readonly L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_1="\
==========================
 Unterstützte Mechanismen
=========================="

readonly L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_2_ALL="Bitte geben Sie Typ und Länge in folgender Form (ohne '' <>) an:
"
readonly L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_2_OPENSC_P11="${L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_2_ALL}
  '<typ>:<laenge>', z.B. 'rsa:4096', 'EC:prime256v1'

${LIB_SHTPL_DE_DLG_TXT_SEEALSO} 'man pkcs11-tool', Parameter \"--key-type\".

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_2_OPENSC_P15="${L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_2_ALL}
  '<typ>/<laenge>', z.B. 'rsa/2048', 'ec/prime256v1'

${LIB_SHTPL_DE_DLG_TXT_SEEALSO} 'man pkcs15-init', Abschnitt \"Key generation\".

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_2_SCHSM="${L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_2_OPENSC_P11}"
readonly L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_2_YUBICO="${L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_2_ALL}
  '<TYP><LAENGE>', z.B. 'RSA2048', 'ECCP384'

${LIB_SHTPL_DE_DLG_TXT_SEEALSO}
${L_SC_DLG_TXT_ARG_ALL_KEY_TYPE_2_YUBICO}

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"

readonly L_SC_DE_DLG_TXT_ARG_ALL_KEY_TYPE_3="Bitte wählen Sie aus der nachfolgenden Liste einen Algorithmus aus.

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"

readonly L_SC_DE_HLP_DES_ARG_ALL_KEY_TYPE="Legt den Typ und die Länge des zu erstellenden Schlüssels fest. Führen Sie '${L_SC_ABOUT_RUN} --list algorithm' aus, um eine Liste von Algorithmen zu erhalten, die vom Token unterstützt werden. Abhängig vom Tokentyp muss <type> wie folgt aufgebaut sein (ohne ''):"
readonly L_SC_DE_HLP_DES_ARG_ALL_KEY_TYPE_OPENSC_P11="'<typ>:<laenge>', z.B. 'rsa:4096' oder 'EC:prime256v1'"
readonly L_SC_DE_HLP_DES_ARG_ALL_KEY_TYPE_OPENSC_P15="'<typ>/<laenge>', z.B. 'rsa/2048' oder 'ec/prime256v1'"
readonly L_SC_DE_HLP_DES_ARG_ALL_KEY_TYPE_SCHSM="${L_SC_DE_HLP_DES_ARG_ALL_KEY_TYPE_OPENSC_P11}"
readonly L_SC_DE_HLP_DES_ARG_ALL_KEY_TYPE_YUBICO="'<TYP><laenge>', z.B. 'RSA2048' oder 'ECCP384'. Nur die folgenden Formate sind erlaubt:"

readonly L_SC_DE_HLP_REF_ARG_ALL_KEY_TYPE="Schlüssellänge/-typ kann mit '${L_SC_HLP_PAR_ARG_ALL_KEY_TYPE}' festgelegt werden."

#-------------------------------------------------------------------------------
#  arg_all_label
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_LABEL_1="Objekt/Token Label"

readonly L_SC_DE_DLG_TXT_ARG_ALL_LABEL_EXISTING_1="\
===========================
 Liste vorhandener Objekte
==========================="
readonly L_SC_DE_DLG_TXT_ARG_ALL_LABEL_EXISTING_2="Bitte geben Sie das Label des zu bearbeitenden Objekts ein. ${LIB_SHTPL_DE_DLG_TXT_OPTIONAL}"
readonly L_SC_DE_DLG_TXT_ARG_ALL_LABEL_EXISTING_3="${L_SC_DE_DLG_TXT_ARG_ALL_ID_OBJECT_EXISTING_3}"

readonly L_SC_DE_DLG_TXT_ARG_ALL_LABEL_NEW_1="\
===========================
 Liste vorhandener Objekte
==========================="
readonly L_SC_DE_DLG_TXT_ARG_ALL_LABEL_NEW_2="Bitte geben Sie eine gültiges, noch nicht vergebenes, Label an. ${LIB_SHTPL_DE_DLG_TXT_OPTIONAL}"

readonly L_SC_DE_HLP_DES_ARG_ALL_LABEL="Label (Name) des zu bearbeitenden Objekts (oder des Tokens, wenn '${L_SC_HLP_PAR_ARG_ACTION_ALL_INITIALIZE}' benutzt wird). Führen Sie '${L_SC_ABOUT_RUN} --list object' aus, um alle verfügbaren Objekte anzuzeigen."

readonly L_SC_DE_HLP_REF_ARG_ALL_LABEL="Das zu erstellende/verwendende Objekt muss mit '${L_SC_HLP_PAR_ARG_ALL_LABEL}' festgelegt werden."
readonly L_SC_DE_HLP_REF_ARG_ALL_LABEL_OPTIONAL="Objektlabel kann mit '${L_SC_HLP_PAR_ARG_ALL_LABEL}' festgelegt werden."
readonly L_SC_DE_HLP_REF_ARG_ALL_LABEL_ID_OBJECT="Objekt muss mit '${L_SC_HLP_PAR_ARG_ALL_ID_OBJECT}' und/oder '${L_SC_HLP_PAR_ARG_ALL_LABEL}' festgelegt werden."
readonly L_SC_DE_HLP_REF_ARG_ALL_LABEL_ID_OBJECT_OPTIONAL="Objekt kann mit '${L_SC_HLP_PAR_ARG_ALL_ID_OBJECT}' und/oder '${L_SC_HLP_PAR_ARG_ALL_LABEL}' festgelegt werden."

#-------------------------------------------------------------------------------
#  arg_all_newpinpuk
#-------------------------------------------------------------------------------
readonly L_SC_DE_HLP_DES_ARG_ALL_NEWPINPUK="Neue Benutzer-PIN, Benutzer-PUK oder Security-Officer-PIN. Verwenden Sie diese Option nur dann, wenn ein bestehender Wert geändert werden soll. Im Fall von '${L_SC_HLP_PAR_ARG_ACTION_ALL_INITIALIZE}' or '${L_SC_HLP_PAR_ARG_ACTION_OPENSC_P15_STORE_PIN}' verwenden Sie bitte eine andere Option, z.B. '${L_SC_HLP_PAR_ARG_ALL_PIN}'. Siehe auch (1) und (2)."

#-------------------------------------------------------------------------------
#  arg_all_password
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_PASSWORD="Passwort Datei (optional)"
readonly L_SC_DE_HLP_DES_ARG_ALL_PASSWORD="Passwort zum Importieren oder Exportieren von passwortgeschützten Dateien. Siehe auch (1) und (2)."
readonly L_SC_DE_HLP_REF_ARG_ALL_PASSWORD="Für passwortgeschützte Dateien kann das Passwort mit '${L_SC_HLP_PAR_ARG_ALL_PASSWORD}' angegeben bzw. gesetzt werden"

#-------------------------------------------------------------------------------
#  arg_all_pin
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_PIN="Benutzer-PIN"
readonly L_SC_DE_HLP_DES_ARG_ALL_PIN="\
(Aktuelle oder initiale) Benutzer-PIN. Siehe auch (1) und (2).

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
${L_SC_DE_HLP_REF_ARG_P15_ID_AUTH}"
readonly L_SC_DE_HLP_REF_ARG_ALL_PIN="Die PIN kann mit '${L_SC_HLP_PAR_ARG_ALL_PIN}' angegeben werden"
readonly L_SC_DE_HLP_REF_ARG_ALL_PIN_SOPIN="Die PIN bzw. SO-PIN kann mit '${L_SC_HLP_PAR_ARG_ALL_PIN}' bzw. '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' angegeben werden"

#-------------------------------------------------------------------------------
#  arg_all_print
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_PRINT_FILE="Dateiinhalt ausdrucken?"
readonly L_SC_DE_DLG_TTL_ARG_ALL_PRINT_SECRETS="Geheimnummer(n) ausdrucken?"

readonly L_SC_DE_DLG_TXT_ARG_ALL_PRINT_FILE="\
Es wird empfohlen, den Dateiinhalt auszudrucken, für den Fall, dass die Datei beschädigt wird. Möchten Sie die Datei ausdrucken?

${LIB_SHTPL_DE_DLG_TXT_ATTENTION}
Sollte aktuell mehr als ein Token mit dem Rechner verbunden sein, so trennen Sie bitte die übrigen Token bevor(!) Sie fortfahren."
readonly L_SC_DE_DLG_TXT_ARG_ALL_PRINT_SECRETS="\
Möchten Sie Ihre (neue(n)) Geheimnummer(n) (PIN, PUK, Passwort, etc.) ausdrucken?

${LIB_SHTPL_DE_DLG_TXT_ATTENTION}
Sollte aktuell mehr als ein Token mit dem Rechner verbunden sein, so trennen Sie bitte die übrigen Token bevor(!) Sie fortfahren."

#-------------------------------------------------------------------------------
#  arg_all_print_separately
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_PRINT_SEPARATELY="Administrative Geheimnummer(n) separat ausdrucken?"
readonly L_SC_DE_DLG_TXT_ARG_ALL_PRINT_SEPARATELY="Möchten Sie SO-PIN/SO-PUK/Management Key auf einem separaten Dokument ausdrucken?"
readonly L_SC_DE_HLP_DES_ARG_ALL_PRINT_SEPARATELY="Wie '${L_SC_HLP_PAR_ARG_ALL_PRINT}', druckt aber SO-PIN/SO-PUK/Management Key auf ein separates Dokument"

#-------------------------------------------------------------------------------
#  arg_all_puk
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_PUK="Benutzer-PUK"
readonly L_SC_DE_HLP_DES_ARG_ALL_PUK="\
(Aktuelle oder initiale) Benutzer-PUK. Siehe auch (1) und (2).

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
${L_SC_DE_HLP_REF_ARG_P15_ID_AUTH}"

#-------------------------------------------------------------------------------
#  arg_all_random
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_RANDOM="Geheimnummer(n) (PIN, PUK, etc.) zufällig generieren?"
readonly L_SC_DE_DLG_TXT_ARG_ALL_RANDOM="Möchten Sie Ihre (neue(n)) Geheimnummer(n) (PIN, PUK, etc.) zufällig generieren?"
readonly L_SC_DE_HLP_DES_ARG_ALL_RANDOM="Generiert Zugangsdaten (PIN, PUK, etc.) zufällig"

#-------------------------------------------------------------------------------
#  arg_all_serial
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_SERIAL_1="Token-Seriennummer"

readonly L_SC_DE_DLG_TXT_ARG_ALL_SERIAL_1="Bitte wählen Sie Ihren Token anhand der zugehörigen Seriennummer aus."
readonly L_SC_DE_DLG_TXT_ARG_ALL_SERIAL_2="Kein Token gefunden."

readonly L_SC_DE_HLP_DES_ARG_ALL_SERIAL_YUBICO="Legt den zu verwenden Token anhand seiner Seriennummer fest. Führen Sie '${L_SC_ABOUT_RUN} --list reader' aus, um alle verfügbaren Token anzuzeigen."

#-------------------------------------------------------------------------------
#  arg_all_sopin
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_SOPIN="Security Officer PIN (SO-PIN)"
readonly L_SC_DE_HLP_DES_ARG_ALL_SOPIN="\
(Aktuelle oder initiale) Security Officer PIN (SO-PIN). Siehe auch (1) und (2).

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
${L_SC_DE_HLP_REF_ARG_P15_ID_AUTH}"
readonly L_SC_DE_HLP_REF_ARG_ALL_SOPIN="Die zu verwendende SO-PIN kann mit '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' festgelegt werden"

#-------------------------------------------------------------------------------
#  arg_all_sopuk
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_SOPUK="Security Officer PUK (SO-PUK)"
readonly L_SC_DE_HLP_DES_ARG_ALL_SOPUK="\
(Aktuelle oder initiale) Security Officer PUK (SO-PUK). Siehe auch (1) und (2).

${L_SC_HLP_TXT_HEADER_OPENSC_P15}
${L_SC_DE_HLP_REF_ARG_P15_ID_AUTH}"

#-------------------------------------------------------------------------------
#  arg_all_type
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_ALL_TYPE="Objekttyp"
readonly L_SC_DE_DLG_TXT_ARG_ALL_TYPE="Bitte wählen Sie einen der nachfolgenden Objekttypen aus."

readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_ALGORITHM="Unterstützte Mechanismen (Algorithmen, Schlüssellängen, ...)"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_CERT="Zertifikat"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_CHAIN="Zertifikatskette"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_DATA="Datenobjekt"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_INFO="Allgemeine Informationen"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_OBJECT="(Alle) Objekte"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_PRIVKEY="Privater Schlüssel"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_PUBKEY="Öffentlicher Schlüssel"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_READER="Verfügbare Leser/Slots"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_SECRKEY="Geheimer Schlüssel"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_SSHKEY="SSH Schlüssel"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_SSHKEY_RFC4716="SSH Schlüssel (RFC4716)"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_P15_APPLICATION="PKCS#15-Anwendung"
readonly L_SC_DE_DLG_ITM_ARG_ALL_TYPE_P15_PIN="PKCS#15-PIN"

readonly L_SC_DE_HLP_DES_ARG_ALL_TYPE="Legt den Typ des Objekts fest, welches importiert/exportiert/gelöscht/aufgelistet werden soll. Manche Objekttypen sind nur mit bestimmten Tokentypen verwendbar."
readonly L_SC_DE_HLP_REF_ARG_ALL_TYPE="Objekttyp muss mit '${L_SC_HLP_PAR_ARG_ALL_TYPE}' festgelegt werden"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (OpenSC (PKCS#11))
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (OpenSC (PKCS#15))
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_opensc_p15_profile
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_OPENSC_P15_PROFILE="OpenSC PKCS#15-Profil"
readonly L_SC_DE_DLG_TXT_ARG_OPENSC_P15_PROFILE="\
Bitte legen Sie das zu verwendende OpenSC PKCS#15-Profil in folgender Form fest:

  '<profile>[+<option>]...', z.B. 'pkcs15+onepin' (ohne '')

Machen Token unterstützen nur ein PIN/PUK-Paar, aber kein zusätzliches SO-PIN/SO-PUK-Paar. Hierfür verwenden Sie bitte die Profilvariante 'pkcs15+onepin'.

${LIB_SHTPL_DE_DLG_TXT_SEEALSO} 'man pkcs15-init', Parameter \"--profile\"

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"

readonly L_SC_DE_HLP_DES_ARG_OPENSC_P15_PROFILE="\
Zu verwendendes OpenSC PKCS#15-Profil, in der Form '<profile>[+<option>]...', z.B. 'pkcs15+onepin', wenn Ihr Token nur ein PIN/PUK-Paar aber kein zusätzliches SO-PIN/SO-PUK-Paar unterstützt.

Weitere Informationen finden Sie in der Manpage 'man pkcs15-init', Parameter \"--profile\"."

readonly L_SC_DE_HLP_REF_ARG_OPENSC_P15_PROFILE="Verwenden Sie '${L_SC_HLP_PAR_ARG_OPENSC_P15_PROFILE}', um das OpenSC PKCS#15 Profil festzulegen, welches während der Initialisierung geladen werden soll. Verwenden Sie beispielsweise 'pkcs15+onepin', wenn Ihr Token nur ein PIN/PUK-Paar aber kein zusätzliches SO-PIN/SO-PUK-Paar unterstützt."

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (SmartCard-HSM / Nitrokey HSM 2)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_schsm_dkek_shares
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_SCHSM_DKEK_SHARES="DKEK Shares"
readonly L_SC_DE_DLG_TXT_ARG_SCHSM_DKEK_SHARES_1="\
Um die Sicherung/Wiederherstellung von Schlüsseln zu ermöglichen, muss das HSM mit einem Device Key Encryption Key (DKEK) initialisiert werden. Möchten Sie das tun?

${LIB_SHTPL_DE_DLG_TXT_ATTENTION}
Wenn Sie \"Nein\" auswählen, wird kein DKEK erzeugt und eine Sicherung/Wiederherstellung von Schlüsseln ist nicht möglich."
readonly L_SC_DE_DLG_TXT_ARG_SCHSM_DKEK_SHARES_2="\
Bitte geben Sie die Anzahl an Dateien ein, auf die der Device Key Encryption Key (DKEK) \"aufgeteilt\" werden soll.

Wird dieser Wert auf '0' gesetzt, so wird ein zufälliger DKEK erzeugt. Schlüssel, die mit einem solchen DKEK gesichert wurden, können nur auf dasselbe HSM wiederhergestellt werden (nicht empfohlen).

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_SC_DE_HLP_DES_ARG_SCHSM_DKEK_SHARES="Legt die Anzahl an DKEK Shares (Dateien) fest, die notwendig sind, um den Device Key Encryption Key (DKEK) wiederherzustellen. Alle DKEK Shares werden für die Sicherung/Wiederherstellung der Schlüssel benötigt. Normalerweise wird dieser Wert auf '1' gesetzt. Falls dieser Parameter weggelassen oder auf '' gesetzt wird, wird kein DKEK erzeugt, folglich ist auch keine Sicherung/Wiederherstellung der Schlüssel möglich. Dieser Parameter ist nicht mit dem DKEK Passwort n-aus-m Schwellenwertsystem zu verwechseln. Verwenden Sie '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_ACTION_SCHSM_DKEK_SHARE_CREATE}', um die DKEK Shares zu erstellen."

#-------------------------------------------------------------------------------
#  arg_schsm_key_reference
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_SCHSM_KEY_REFERENCE="Key Identifier"

readonly L_SC_DE_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_BACKUP_1="Hinweis: Die ID des jeweiligen Objekts steht in der Zeile 'Key ref' (dezimaler Wert außerhalb der Klammern).

===========================
 Liste vorhandener Objekte
==========================="
readonly L_SC_DE_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_BACKUP_2="Bitte geben Sie die ID des zu sichernden Objekts ein."

readonly L_SC_DE_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_RESTORE_1="${L_SC_DE_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_BACKUP_1}"
readonly L_SC_DE_DLG_TXT_ARG_SCHSM_KEY_REFERENCE_RESTORE_2="Bitte geben Sie eine gültige, noch nicht vergebene, ID an."

readonly L_SC_DE_HLP_DES_ARG_SCHSM_KEY_REFERENCE="Legt den zu sichernden/wiederherstellenden Schlüssel mithilfe seiner ID <id> fest. Führen Sie 'pkcs15-tool --dump' aus, um alle für die Sicherung verfügbaren Schlüssel bzw. freie IDs für die Wiederherstellung anzuzeigen, das in der Befehlsausgabe relevante Feld lautet 'Key ref'."

#-------------------------------------------------------------------------------
#  arg_schsm_pwd_shares_threshold
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_SCHSM_PWD_SHARES_THRESHOLD="DKEK Password Shares (Minimum)"
readonly L_SC_DE_DLG_TXT_ARG_SCHSM_PWD_SHARES_THRESHOLD="Bitte geben Sie die Zahl an Password Shares ein, die für das Entschlüsseln des DKEK Shares mindestens notwendig sind."
readonly L_SC_DE_HLP_DES_ARG_SCHSM_PWD_SHARES_THRESHOLD="Minimum an Password Shares, die für das Entschlüsseln des DKEK Shares mindestens notwendig sind"

#-------------------------------------------------------------------------------
#  arg_schsm_pwd_shares_total
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_SCHSM_PWD_SHARES_TOTAL="DKEK Password Shares (Total)"
readonly L_SC_DE_DLG_TXT_ARG_SCHSM_PWD_SHARES_TOTAL="Bitte geben Sie die gesamte Anzahl an Password Shares an, die für das Verschlüsseln des DKEK Shares genutzt werden sollen."
readonly L_SC_DE_HLP_DES_ARG_SCHSM_PWD_SHARES_TOTAL="Anzahl an Password Shares, die für das Verschlüsseln des DKEK Shares insgesamt verwendet werden."

#-------------------------------------------------------------------------------
#  arg_schsm_pwd_use_threshold_scheme
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME="Ein n-aus-m Schwellenwertsystem verwenden?"
readonly L_SC_DE_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME_CREATE="\
Möchten Sie ein n-aus-m Schwellenwertsystem einrichten? Falls ja, wird das Passwort zufällig generiert und auf m Teile verteilt, wobei n Teile später notwendig sind, um das DKEK-Share für den Import zu entschlüsseln.

${LIB_SHTPL_DE_DLG_TXT_SEEALSO}
  ${L_SC_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME}"
readonly L_SC_DE_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME_IMPORT="\
Wurde das DKEK-Share mithilfe eines verteilten Passworts (n-aus-m Schwellenwertsystem) verschlüsselt (\"Ja\") oder eines einfachen Passworts (\"Nein\")?

${LIB_SHTPL_DE_DLG_TXT_SEEALSO}
  ${L_SC_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME}"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Other parameters <arg_...> (Yubico YubiKey PIV)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#-------------------------------------------------------------------------------
#  arg_yubico_management_key
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_YUBICO_MANAGEMENT_KEY="Management Key (hexadezimal (0-9 a-f) ohne '0x')"
readonly L_SC_DE_HLP_DES_ARG_YUBICO_MANAGEMENT_KEY="Legt den (aktuellen) Management-Key in hexadezimaler Form (ohne '0x') fest. Die Länge hängt von '${L_SC_HLP_PAR_ARG_ALL_KEY_TYPE}' ab, so sind es bei AES256 beispielsweise 32 Bytes. Siehe auch (1) und (2)."
readonly L_SC_DE_HLP_REF_ARG_YUBICO_MANAGEMENT_KEY="Der (aktuelle) Management-Key kann mit '${L_SC_HLP_PAR_ARG_YUBICO_MANAGEMENT_KEY}' angegeben werden."

#-------------------------------------------------------------------------------
#  arg_yubico_new_management_key
#-------------------------------------------------------------------------------
readonly L_SC_DE_HLP_DES_ARG_YUBICO_NEW_MANAGEMENT_KEY="Legt den (neuen) Management-Key in hexadezimaler Form (ohne '0x') fest. Die Länge hängt von '${L_SC_HLP_PAR_ARG_ALL_KEY_TYPE}' ab, so sind es bei AES256 beispielsweise 32 Bytes. Siehe auch (1) und (2)."
readonly L_SC_DE_HLP_REF_ARG_YUBICO_NEW_MANAGEMENT_KEY="Der (neue) Management-Key kann mit '${L_SC_HLP_PAR_ARG_YUBICO_NEW_MANAGEMENT_KEY}' festgelegt werden."

#-------------------------------------------------------------------------------
#  arg_yubico_pin_policy
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_YUBICO_PIN_POLICY="PIN-Richtlinie"
readonly L_SC_DE_DLG_TXT_ARG_YUBICO_PIN_POLICY="Bitte wählen Sie eine der nachfolgenden Richtlinie aus. Diese legt festlegt, ob bzw. wie oft bestimmte schlüsselbezogene Vorgänge mit Eingabe der PIN bestätigt werden müssen.

${LIB_SHTPL_DE_DLG_TXT_SEEALSO}
  ${L_SC_DLG_TXT_ARG_YUBICO_PIN_POLICY}"

readonly L_SC_DE_DLG_ITM_ARG_YUBICO_PIN_POLICY_ALWAYS="Immer"
readonly L_SC_DE_DLG_ITM_ARG_YUBICO_PIN_POLICY_DEFAULT="Standard"
readonly L_SC_DE_DLG_ITM_ARG_YUBICO_PIN_POLICY_NEVER="Niemals"
readonly L_SC_DE_DLG_ITM_ARG_YUBICO_PIN_POLICY_ONCE="Einmalig (je Sitzung)"

readonly L_SC_DE_HLP_DES_ARG_YUBICO_PIN_POLICY="PIN-Richtlinie, legt fest, ob und wie oft Schlüssel-bezogene Vorgänge mit Eingabe der Benutzer-PIN bestätigt werden müssen. Siehe auch: ${L_SC_DLG_TXT_ARG_YUBICO_PIN_POLICY}

Mögliche Werte sind:"

#-------------------------------------------------------------------------------
#  arg_yubico_touch_policy
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ARG_YUBICO_TOUCH_POLICY="Touch-Richtlinie"
readonly L_SC_DE_DLG_TXT_ARG_YUBICO_TOUCH_POLICY="Bitte wählen Sie eine der nachfolgenden Richtlinien aus. Diese legt festlegt, ob bzw. wie oft bestimmte schlüsselbezogene Vorgänge mit einem Fingerdruck bestätigt werden müssen.

${LIB_SHTPL_DE_DLG_TXT_SEEALSO}
  ${L_SC_DLG_TXT_ARG_YUBICO_TOUCH_POLICY}"

readonly L_SC_DE_DLG_ITM_ARG_YUBICO_TOUCH_POLICY_ALWAYS="Immer"
readonly L_SC_DE_DLG_ITM_ARG_YUBICO_TOUCH_POLICY_CACHED="Zwischengespeichert (erneutes Drücken innerhalb von 15 Sekunden nicht erforderlich)"
readonly L_SC_DE_DLG_ITM_ARG_YUBICO_TOUCH_POLICY_DEFAULT="Standard"
readonly L_SC_DE_DLG_ITM_ARG_YUBICO_TOUCH_POLICY_NEVER="Niemals"

readonly L_SC_DE_HLP_DES_ARG_YUBICO_TOUCH_POLICY="Touch-Richtlinie, legt fest, ob und wie oft Schlüssel-bezogene Vorgänge mit einem Fingerdruck bestätigt bestätigt werden müssen. Siehe auch: ${L_SC_DLG_TXT_ARG_YUBICO_TOUCH_POLICY}

Mögliche Werte sind:"

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Last argument (parameter), see also <args_read()> in '/src/run.sh'
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
readonly L_SC_DE_HLP_DES_LASTARG=""

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Script actions <ARG_ACTION_...>
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#  Main Menu Title/Text
readonly L_SC_DE_DLG_TTL_ARG_ACTION="${L_SC_ABOUT_PROJECT}"
readonly L_SC_DE_DLG_TXT_ARG_ACTION="Was möchten Sie tun?"

#-------------------------------------------------------------------------------
#  PKCS#11-related
#-------------------------------------------------------------------------------
#  ARG_ACTION_P11_GET_URI
readonly L_SC_DE_HLP_DES_ARG_ACTION_P11_GET_URI="Fordert den Nutzer zur Auswahl eines Token-Objekts auf und gibt anschließend dessen PKCS#11-URI wieder. Nur mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}', '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_SCHSM}' oder '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO}'. Die Liste der verfügbaren Objekte muss mit <type> gefiltert werden, mögliche Werte sind"

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
readonly L_SC_DE_DLG_ITM_ARG_ACTION_OPENSC_P15_ERASE_APPLICATION="PKCS#15-Anwendung löschen"
readonly L_SC_DE_HLP_DES_ARG_ACTION_OPENSC_P15_ERASE_APPLICATION="Löscht die PKCS#15-Anwendung mit der (hexadezimalen) Anwendungs-ID <aid>, siehe auch '${L_SC_HLP_PAR_ARG_P15_ID_AID}'. ${L_SC_DE_HLP_REF_ARG_ALL_PIN_SOPIN}."

#  ARG_ACTION_OPENSC_P15_ERASE_CARD
readonly L_SC_DE_DLG_ITM_ARG_ACTION_OPENSC_P15_ERASE_CARD="PKCS#15 Struktur löschen (nur für bestimmte Modelle)"
readonly L_SC_DE_HLP_DES_ARG_ACTION_OPENSC_P15_ERASE_CARD="${L_SC_DE_DLG_ITM_ARG_ACTION_OPENSC_P15_ERASE_CARD}. ${L_SC_DE_HLP_REF_ARG_ALL_PIN_SOPIN}."

#  ARG_ACTION_OPENSC_P15_FINALIZE
readonly L_SC_DE_DLG_ITM_ARG_ACTION_OPENSC_P15_FINALIZE="Initialisierung abschließen (nur für bestimmte Modelle)"
readonly L_SC_DE_HLP_DES_ARG_ACTION_OPENSC_P15_FINALIZE="${L_SC_DE_DLG_ITM_ARG_ACTION_OPENSC_P15_FINALIZE}. Abhängig vom Token kann dies dazu führen, dass keine weiteren privaten/geheimen Schlüssel und/oder PIN/PUK-Paare hinzugefügt werden können. Weitere Informationen finden Sie auf den modellspezifischen Wiki-Seiten von OpenSC:
  ${L_SC_HLP_TXT_REFERENCES_3}"
readonly L_SC_DE_TXT_ARG_ACTION_OPENSC_P15_FINALIZE_INFO="Initialisierung erfolgreich abgeschlossen."

#  ARG_ACTION_OPENSC_P15_STORE_PIN
readonly L_SC_DE_DLG_ITM_ARG_ACTION_OPENSC_P15_STORE_PIN="Zusätzliches PIN/PUK-Paar hinzufügen"
readonly L_SC_DE_HLP_DES_ARG_ACTION_OPENSC_P15_STORE_PIN="${L_SC_DE_DLG_ITM_ARG_ACTION_OPENSC_P15_STORE_PIN}. PIN/PUK können mit '${L_SC_HLP_PAR_ARG_ALL_PIN}' und '${L_SC_HLP_PAR_ARG_ALL_PUK}' festgelegt werden. ${L_SC_DE_HLP_REF_ARG_P15_ID_AUTH} ${L_SC_DE_HLP_REF_ARG_ALL_LABEL_OPTIONAL}"
readonly L_SC_DE_TXT_ARG_ACTION_OPENSC_P15_STORE_PIN_INFO="PIN/PUK erfolgreich hinzugefügt."

#-------------------------------------------------------------------------------
#  SmartCard-HSM / Nitrokey HSM 2
#-------------------------------------------------------------------------------
#  ARG_ACTION_SCHSM_BACKUP
readonly L_SC_DE_DLG_ITM_ARG_ACTION_SCHSM_BACKUP="Privaten Schlüssel sichern"
readonly L_SC_DE_HLP_DES_ARG_ACTION_SCHSM_BACKUP="Exportiert und speichert privaten Schlüssel in <file> (DKEK-verschlüsselt). Legen Sie mit '${L_SC_HLP_PAR_ARG_SCHSM_KEY_REFERENCE}' den zu verwendenden Schlüssel(-Identifizierer) fest. ${L_SC_DE_HLP_REF_ARG_ALL_PIN}."

#  ARG_ACTION_SCHSM_DKEK_SHARE_CREATE
readonly L_SC_DE_DLG_ITM_ARG_ACTION_SCHSM_DKEK_SHARE_CREATE="Device Key Encryption Key (DKEK) Share erzeugen"
readonly L_SC_DE_HLP_DES_ARG_ACTION_SCHSM_DKEK_SHARE_CREATE="\
Erzeugt ein verschlüsseltes DKEK-Share und speichert es in <file>. Bitte drucken Sie den Dateiinhalt aus für den Fall, dass die Datei beschädigt wird. Um eine druckbare Version zu erhalten, führen Sie 'openssl base64 -in <file>' aus.

Verwenden Sie '${L_SC_HLP_PAR_ARG_ALL_PASSWORD}', um das Passwort zum Verschlüsseln des DKEK-Shares festzulegen. Andernfalls werden Sie zur Eingabe aufgefordert.

Verwenden Sie '${L_SC_HLP_PAR_ARG_SCHSM_PWD_SHARES_THRESHOLD}' und '${L_SC_HLP_PAR_ARG_SCHSM_PWD_SHARES_TOTAL}', um ein n-aus-m Schwellenwertsystem einzurichten. Lassen Sie in diesem Fall '${L_SC_HLP_PAR_ARG_ALL_PASSWORD}' weg. Siehe auch: ${L_SC_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME}"

#  ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT
readonly L_SC_DE_DLG_ITM_ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT="Device Key Encryption Key (DKEK) Share importieren"
readonly L_SC_DE_HLP_DES_ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT="\
Entschlüsselt und schreibt die DKEK-Share-Datei <file> in das HSM.

Verwenden Sie '${L_SC_HLP_PAR_ARG_ALL_PASSWORD}', um das Passwort zum Entschlüsseln der DKEK-Share-Datei anzugeben. Andernfalls werden Sie zur Eingabe aufgefordert.

Verwenden Sie '${L_SC_HLP_PAR_ARG_SCHSM_PWD_SHARES_TOTAL}' für den Fall, dass Ihre DKEK-Share-Datei <int> Passwort-Shares verlangt, um es zu entschlüsseln. Lassen Sie in diesem Fall '${L_SC_HLP_PAR_ARG_ALL_PASSWORD}' weg, Sie werden zur Eingabe aufgefordert. Siehe auch: ${L_SC_DLG_TXT_ARG_SCHSM_PWD_USE_THRESHOLD_SCHEME}"

#  ARG_ACTION_SCHSM_RESTORE
readonly L_SC_DE_DLG_ITM_ARG_ACTION_SCHSM_RESTORE="Privaten Schlüssel wiederherstellen"
readonly L_SC_DE_HLP_DES_ARG_ACTION_SCHSM_RESTORE="Stellt privaten Schlüssel aus <file> (DKEK-verschlüsselt) wieder her. Legen Sie mit '${L_SC_HLP_PAR_ARG_SCHSM_KEY_REFERENCE}' den zu verwendenden Schlüssel(-Identifizierer) fest. Stellen Sie sicher, dass das HSM zuvor mit '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_ACTION_ALL_INITIALIZE} ${L_SC_HLP_PAR_ARG_SCHSM_DKEK_SHARES}' initialisiert wurde und die DKEK-Share-Datei mit '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_ACTION_SCHSM_DKEK_SHARE_IMPORT}' in das HSM geschrieben wurde. ${L_SC_DE_HLP_REF_ARG_ALL_PIN}."

#-------------------------------------------------------------------------------
#  Yubico YubiKey PIV
#-------------------------------------------------------------------------------
#  ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY
readonly L_SC_DE_DLG_ITM_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY="Management Key ändern"
readonly L_SC_DE_HLP_DES_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY="${L_SC_DE_DLG_ITM_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY}. ${L_SC_DE_HLP_REF_ARG_YUBICO_MANAGEMENT_KEY} ${L_SC_DE_HLP_REF_ARG_YUBICO_NEW_MANAGEMENT_KEY}"
readonly L_SC_DE_TXT_ARG_ACTION_YUBICO_CHANGE_MANAGEMENT_KEY_INFO="Management Key erfolgreich geändert."

#-------------------------------------------------------------------------------
#  Used by two or more token types
#-------------------------------------------------------------------------------
#  ARG_ACTION_ALL_CHANGE_PIN
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_CHANGE_PIN="Benutzer-PIN ändern (Benutzer-PIN erforderlich)"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_CHANGE_PIN="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_CHANGE_PIN}. Siehe auch '${L_SC_HLP_PAR_ARG_ALL_PIN}' und '${L_SC_HLP_PAR_ARG_ALL_NEWPINPUK}'."

#  ARG_ACTION_ALL_CHANGE_PUK
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_CHANGE_PUK="Benutzer-PUK ändern"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_CHANGE_PUK="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_CHANGE_PUK}. Nur mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}' oder '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO}'. Siehe auch '${L_SC_HLP_PAR_ARG_ALL_PUK}' und '${L_SC_HLP_PAR_ARG_ALL_NEWPINPUK}'."

#  ARG_ACTION_ALL_CHANGE_SO_PIN
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_CHANGE_SO_PIN="Security Officer PIN (SO-PIN) ändern"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_CHANGE_SO_PIN="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_CHANGE_SO_PIN}. Nur mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}', '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}' oder '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_SCHSM}'. Siehe auch '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' und '${L_SC_HLP_PAR_ARG_ALL_NEWPINPUK}'."

#  ARG_ACTION_ALL_CONNECT
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_CONNECT="Fordert den Nutzer interaktiv dazu auf, einen Token zu verbinden. Gibt entweder '0' (Token verbunden) oder '1' (kein Token erkannt) zurück."

#  ARG_ACTION_ALL_DELETE
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_DELETE="Zertifikat, Schlüssel oder Datenobjekt löschen"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_DELETE="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_DELETE}. ${L_SC_DE_HLP_REF_ARG_ALL_TYPE}."
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_DELETE_OPENSC_P11="\
${L_SC_DE_HLP_REF_ARG_ALL_PIN_SOPIN}.

  <type> = data
Objekt muss entweder mit '${L_SC_HLP_PAR_ARG_ALL_DATA_OID}' oder '${L_SC_HLP_PAR_ARG_ALL_DATA_APPLICATION_NAME}' und '${L_SC_HLP_PAR_ARG_ALL_LABEL}' festgelegt werden.

  <type> != data
Objekt muss mit '${L_SC_HLP_PAR_ARG_ALL_ID_OBJECT}' und/oder '${L_SC_HLP_PAR_ARG_ALL_LABEL}' (nicht mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}') festgelegt werden."
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_DELETE_OPENSC_P15="${L_SC_DE_HLP_REF_ARG_P15_ID_AID}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_DELETE_SCHSM="${L_SC_DE_HLP_DES_ARG_ACTION_ALL_DELETE_OPENSC_P11}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_DELETE_YUBICO="${L_SC_DE_HLP_REF_ARG_PIV_KEYREF}. ${L_SC_DE_HLP_REF_ARG_YUBICO_MANAGEMENT_KEY}"

#  ARG_ACTION_ALL_EXPORT
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_EXPORT="Zertifikat, (öffentlichen) Schlüssel oder Datenobjekt von Token nach Datei exportieren"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_EXPORT="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_EXPORT}. ${L_SC_DE_HLP_REF_ARG_ALL_TYPE}."
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_EXPORT_OPENSC_P11="\

  <type> = data
Objekt muss mit '${L_SC_HLP_PAR_ARG_ALL_LABEL}', '${L_SC_HLP_PAR_ARG_ALL_DATA_OID}' oder '${L_SC_HLP_PAR_ARG_ALL_DATA_APPLICATION_NAME}' festgelegt werden.

  <type> != data
Objekt muss mit '${L_SC_HLP_PAR_ARG_ALL_ID_OBJECT}' und/oder '${L_SC_HLP_PAR_ARG_ALL_LABEL}' (nicht mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}') festgelegt werden."
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_EXPORT_OPENSC_P15="${L_SC_DE_HLP_REF_ARG_ALL_PIN_SOPIN} (nur falls <type> = data). ${L_SC_DE_HLP_REF_ARG_P15_ID_AID}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_EXPORT_SCHSM="${L_SC_DE_HLP_DES_ARG_ACTION_ALL_EXPORT_OPENSC_P11}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_EXPORT_YUBICO="${L_SC_DE_HLP_REF_ARG_ALL_FORMAT} ${L_SC_DE_HLP_REF_ARG_PIV_KEYREF} (nur falls <type> = { cert | pubkey }). ${L_SC_DE_HLP_REF_ARG_PIV_BER_TLV_TAG} (nur falls <type> = data). ${L_SC_DE_HLP_REF_ARG_ALL_PIN} (nur falls <type> = { data | pubkey })."
readonly L_SC_DE_TXT_ARG_ACTION_ALL_EXPORT_YUBICO_INFO="Exportvorgang erfolgreich abgeschlossen."

#  ARG_ACTION_ALL_GET
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_GET="Gibt Informationen zur Smartcard oder zum Lesegerät wieder. Bei Ausführung des Befehls darf genau ein (1) Token verbunden sein."

#  ARG_ACTION_ALL_IMPORT
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_IMPORT="Zertifikat, Schlüssel oder Datenobjekt aus einer Datei importieren"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_IMPORT="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_IMPORT}. ${L_SC_DE_HLP_REF_ARG_ALL_TYPE}. ${L_SC_DE_HLP_REF_ARG_ALL_PASSWORD}."
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_IMPORT_OPENSC_P11="${L_SC_DE_HLP_REF_ARG_ALL_LABEL_ID_OBJECT} <file> muss DER-codiert sein. Um von PEM- nach DER-Format zu konvertieren, führen Sie 'openssl x509 -in <file_in>.pem -out <file_out>.der -outform der' aus. ${L_SC_DE_HLP_REF_ARG_ALL_PIN}.

  <type> = data
${L_SC_DE_HLP_REF_ARG_ALL_DATA_OID} ${L_SC_DE_HLP_REF_ARG_ALL_DATA_APPLICATION_NAME}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_IMPORT_OPENSC_P15="\
${L_SC_DE_HLP_REF_ARG_ALL_PIN_SOPIN}. ${L_SC_DE_HLP_REF_ARG_P15_ID_AID}

  <type> = data
${L_SC_DE_HLP_REF_ARG_ALL_LABEL_OPTIONAL} ${L_SC_DE_HLP_REF_ARG_ALL_DATA_OID} ${L_SC_DE_HLP_REF_ARG_ALL_DATA_APPLICATION_NAME}

  <type> != data
${L_SC_DE_HLP_REF_ARG_ALL_LABEL_ID_OBJECT_OPTIONAL} ${L_SC_DE_HLP_REF_ARG_ALL_FORMAT}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_IMPORT_SCHSM="${L_SC_DE_HLP_DES_ARG_ACTION_ALL_IMPORT_OPENSC_P11}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_IMPORT_YUBICO="${L_SC_DE_HLP_REF_ARG_ALL_FORMAT} ${L_SC_DE_HLP_REF_ARG_PIV_KEYREF} (nur falls <type> = { cert | privkey }). ${L_SC_DE_HLP_REF_ARG_PIV_BER_TLV_TAG} (nur falls <type> = data). ${L_SC_DE_HLP_REF_ARG_YUBICO_MANAGEMENT_KEY}"
readonly L_SC_DE_TXT_ARG_ACTION_ALL_IMPORT_OPENSC_P15_INFO="Importvorgang erfolgreich abgeschlossen."
readonly L_SC_DE_TXT_ARG_ACTION_ALL_IMPORT_YUBICO_INFO="${L_SC_DE_TXT_ARG_ACTION_ALL_IMPORT_OPENSC_P15_INFO}"

#  ARG_ACTION_ALL_INITIALIZE
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_INITIALIZE="Token initialisieren"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_INITIALIZE="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_INITIALIZE}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_INITIALIZE_OPENSC_P11="\
Legt Token-Label, PIN und SO-PIN fest. ${L_SC_DE_HLP_REF_ARG_ALL_LABEL}

PIN und SO-PIN können mit '${L_SC_HLP_PAR_ARG_ALL_PIN}' und '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' festgelegt werden."
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_INITIALIZE_OPENSC_P15="\
Initiale PKCS#15-Datenstruktur erstellen. ${L_SC_DE_HLP_REF_ARG_ALL_LABEL_OPTIONAL}

PIN, PUK, SO-PIN und SO-PUK können mit '${L_SC_HLP_PAR_ARG_ALL_PIN}', '${L_SC_HLP_PAR_ARG_ALL_PUK}', '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' und '${L_SC_HLP_PAR_ARG_ALL_SOPUK}' festgelegt werden. Manche Token unterstützen nur ein PIN/PUK-Paar aber kein zusätzliches SO-PIN/SO-PUK-Paar.

${L_SC_DE_HLP_REF_ARG_OPENSC_P15_PROFILE}

Mit bestimmten Token ist es notwendig, '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_ACTION_OPENSC_P15_ERASE_CARD}' vor und/oder '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_ACTION_OPENSC_P15_FINALIZE}' nach der Initialisierung auszuführen."
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_INITIALIZE_SCHSM="Löscht alle vorhandenen Schlüssel, Zertifikate und Dateien. Verwenden Sie zusätzlich '${L_SC_HLP_PAR_ARG_SCHSM_DKEK_SHARES}', um die Sicherung/Wiederherstellung von privaten Schlüsseln zu ermöglichen, dies kann nicht(!) nachträglich erfolgen.

PIN und SO-PIN können mit '${L_SC_HLP_PAR_ARG_ALL_PIN}' und '${L_SC_HLP_PAR_ARG_ALL_SOPIN}' festgelegt werden."
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_INITIALIZE_YUBICO="Löscht alle PIV-bezogenen Daten und setzt die PIV-Anwendung auf Werkseinstellungen zurück.

PIN, PUK und Management Key können mit '${L_SC_HLP_PAR_ARG_ALL_PIN}', '${L_SC_HLP_PAR_ARG_ALL_PUK}' und '${L_SC_HLP_PAR_ARG_YUBICO_MANAGEMENT_KEY}' festgelegt werden."
readonly L_SC_DE_TXT_ARG_ACTION_ALL_INITIALIZE_OPENSC_P15_INFO="Token erfolgreich initialisiert."

#  ARG_ACTION_ALL_KEYPAIRGEN
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_KEYPAIRGEN="Öffentlich-privates Schlüsselpaar erzeugen"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_KEYPAIRGEN="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_KEYPAIRGEN}. <file> ist nur erlaubt (und notwendig) mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO}'. ${L_SC_DE_HLP_REF_ARG_ALL_KEY_TYPE}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_KEYPAIRGEN_OPENSC_P11="${L_SC_DE_HLP_REF_ARG_ALL_LABEL_ID_OBJECT} ${L_SC_DE_HLP_REF_ARG_ALL_PIN}."
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_KEYPAIRGEN_OPENSC_P15="${L_SC_DE_HLP_REF_ARG_ALL_LABEL_ID_OBJECT_OPTIONAL} ${L_SC_DE_HLP_REF_ARG_ALL_PIN_SOPIN}. ${L_SC_DE_HLP_REF_ARG_P15_ID_AID}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_KEYPAIRGEN_YUBICO="Mit <file> muss die Datei festgelegt werden, in der der (generierte) öffentliche Schlüssel gespeichert werden soll. ${L_SC_DE_HLP_REF_ARG_ALL_FORMAT} ${L_SC_DE_HLP_REF_ARG_PIV_KEYREF}. ${L_SC_DE_HLP_REF_ARG_YUBICO_MANAGEMENT_KEY}"

#  ARG_ACTION_ALL_LIST
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_LIST="Vorhandene Objekte, unterstützte Mechanismen, etc. anzeigen"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_LIST="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_LIST}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_LIST_OPENSC_P15="${L_SC_DE_HLP_REF_ARG_P15_ID_AID}"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_LIST_OPENSC_P15_PINREQUIRED="${L_SC_DE_HLP_REF_ARG_ALL_PIN_SOPIN} (nur für bestimmte Modelle)."
readonly L_SC_DE_HLP_PAR_ARG_ACTION_ALL_LIST_ALGORITHM="Führen Sie '${L_SC_ABOUT_RUN} --list algorithm' aus, um eine Liste der Algorithmen anzuzeigen, die vom Token unterstützt werden."
readonly L_SC_DE_HLP_REF_ARG_ACTION_ALL_LIST_DATA="Führen Sie '${L_SC_ABOUT_RUN} --list data' aus, um alle verfügbaren Datenobjekte anzuzeigen."
readonly L_SC_DE_HLP_REF_ARG_ACTION_ALL_LIST_OBJECT="Führen Sie '${L_SC_ABOUT_RUN} --list object' aus, um alle verfügbaren Objekte anzuzeigen."
readonly L_SC_DE_HLP_REF_ARG_ACTION_ALL_LIST_P15_APPLICATION="Führen Sie '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15} --list p15-application' aus, um alle verfügbaren PKCS#15-Anwendungen anzuzeigen."
readonly L_SC_DE_HLP_REF_ARG_ACTION_ALL_LIST_P15_PIN="Führen Sie '${L_SC_ABOUT_RUN} ${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15} --list p15-pin' aus, um alle verfügbaren PKCS#15-PINs anzuzeigen."

#  ARG_ACTION_ALL_RESET_PIN
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_RESET_PIN="Benutzer-PIN zurücksetzen (SO-PIN erforderlich)"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_RESET_PIN="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_RESET_PIN}. Nur mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}' oder '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_SCHSM}'. Siehe auch '${L_SC_HLP_PAR_ARG_ALL_NEWPINPUK}' und '${L_SC_HLP_PAR_ARG_ALL_SOPIN}'."

#  ARG_ACTION_ALL_UNBLOCK_PIN
readonly L_SC_DE_DLG_ITM_ARG_ACTION_ALL_UNBLOCK_PIN="Benutzer-PIN zurücksetzen (Benutzer-PUK erforderlich)"
readonly L_SC_DE_HLP_DES_ARG_ACTION_ALL_UNBLOCK_PIN="${L_SC_DE_DLG_ITM_ARG_ACTION_ALL_UNBLOCK_PIN}. Nur mit '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P11}', '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_OPENSC_P15}' oder '${L_SC_HLP_PAR_ARG_TOKEN_TYPE_YUBICO}'. Siehe auch '${L_SC_HLP_PAR_ARG_ALL_NEWPINPUK}' und '${L_SC_HLP_PAR_ARG_ALL_PUK}'."

#===============================================================================
#  GLOBAL VARIABLES (CUSTOM)
#===============================================================================

#===============================================================================
#  FUNCTIONS (CUSTOM) (MENUS)
#===============================================================================
#-------------------------------------------------------------------------------
#  all_connect
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TTL_ALL_CONNECT="Token verbinden"
readonly L_SC_DE_DLG_TXT_ALL_CONNECT_1="\
Bitte verbinden Sie jetzt Ihre(n) Smartcard(s)/Token und drücken Sie die <Eingabetaste> um fortzufahren.

${LIB_SHTPL_DE_DLG_TXT_ATTENTION}
Sollten Sie diesen Hinweis in Zusammenhang mit einem Druckauftrag sehen, so stellen Sie bitte sicher, dass genau ein(e) Token/Smartcard verbunden ist."
readonly L_SC_DE_DLG_TXT_ALL_CONNECT_2="Smartcard/Token wurde nicht erkannt. Entweder ist diese(r) nicht verbunden oder nicht kompatibel. Weitere Informationen zu Geräteanforderungen finden Sie in der Hilfe.

Möchten Sie es nochmal versuchen?"

#-------------------------------------------------------------------------------
#  all_file_print
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TXT_ALL_FILE_PRINT_1="${LIB_SHTPL_DE_DLG_TXT_ERROR} Weitere Informationen finden Sie in der Hilfe im Abschnitt \"${LIB_SHTPL_DE_TXT_HELP_TTL_REQUIREMENTS} - PIN/PUK-Brief (optional)\"."

#-------------------------------------------------------------------------------
#  all_secrets
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_11="Bitte geben Sie die (neue) --\${title1}-- ein. Bitte beachten Sie dabei die folgenden Anforderungen:"

#  OpenSC (PKCS#11)
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_11_OPENSC_P11="\
${L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_11}

PIN:    6 - 8 Zeichen, nur Ziffern (0-9)
PUK:    Genau 8 Zeichen, nur Ziffern
SO-PIN: 6 - 8 Zeichen, nur Ziffern

${LIB_SHTPL_DE_DLG_TXT_STDIN_HIDDEN}"

#  OpenSC (PKCS#15)
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_11_OPENSC_P15="\
${L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_11}

PIN:    6 - 8 Zeichen, nur Ziffern (0-9)
PUK:    8 - 16 (*) Zeichen, nur Ziffern
SO-PIN: 6 - 8 Zeichen, nur Ziffern
SO-PUK: 8 - 16 (*) Zeichen, nur Ziffern

(*) Für die Konformität mit dem Standard 'FIPS-201 (PIV Card)' ist eine Länge von genau 8 Zeichen erlaubt.

${LIB_SHTPL_DE_DLG_TXT_STDIN_HIDDEN}"

#  SmartCard-HSM / Nitrokey HSM 2
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_11_SCHSM="\
${L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_11}

PIN:    6 - 15 Zeichen, nur ASCII
SO-PIN: Genau 16 Zeichen, nur hexadezimal (0-9 a-f)
Passwort (DKEK Share): >= 10 Zeichen, beliebig

Bei Firmware-Versionen unter 1.0 bestehen einige Einschränkungen:
  - Um die Benutzer-PIN zurückzusetzen muss der gesamte Token reinitialisiert
    werden, wobei alle Zertifikate/Daten/Schlüssel verloren gehen.
  - Die Security Officer PIN (SO-PIN) kann nur einmalig(!)
    gesetzt werden, während der Initialisierung.

${LIB_SHTPL_DE_DLG_TXT_SEEALSO}
${L_SC_DLG_TXT_ALL_SECRETS_NEW_11_SCHSM}

${LIB_SHTPL_DE_DLG_TXT_STDIN_HIDDEN}"

#  Yubico YubiKey PIV
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_11_YUBICO="\
${L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_11}

PIN:            6 - 8 Zeichen, nur ASCII
PUK:            6 - 8 Zeichen, beliebig (nur ASCII empfohlen)
Management Key: Genau 32 (AES128), 48 (AES192, TDES), 64 (AES256)
                Zeichen, nur hexadezimal (0-9 a-f)

${LIB_SHTPL_DE_DLG_TXT_SEEALSO}
${L_SC_DLG_TXT_ALL_SECRETS_NEW_11_YUBICO}

${LIB_SHTPL_DE_DLG_TXT_STDIN_HIDDEN}"

readonly L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_12="Bitte notieren Sie sich Ihre(n) neue(n) --\${title1}-- :"
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_13="Bitte geben Sie Ihre(n) neue(n) --\${title1}-- zur Bestätigung (erneut) ein. ${LIB_SHTPL_DE_TXT_STDIN_HIDDEN}"
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_21="Die eingegebene --\${title1}-- enthält entweder ungültige Zeichen oder ist zu kurz bzw. zu lang."
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_22="Die eingegebenen Werte stimmen nicht überein."

readonly L_SC_DE_DLG_TXT_ALL_SECRETS_EXISTING_1="Bitte geben Sie Ihre(n) aktuelle(n) --\${title1}-- ein. ${LIB_SHTPL_DE_TXT_STDIN_HIDDEN}"
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_EXISTING_21="${L_SC_DE_DLG_TXT_ALL_SECRETS_NEW_21}"
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_EXISTING_22="Entweder ist die eingegebene --\${title1}-- falsch oder der Token ist gesperrt. Fehlermeldung:"

#-------------------------------------------------------------------------------
#  all_secrets_print
#-------------------------------------------------------------------------------
readonly L_SC_DE_DLG_TXT_ALL_SECRETS_PRINT_1="${L_SC_DE_DLG_TXT_ALL_FILE_PRINT_1}"

#===============================================================================
#  HELP
#===============================================================================
#-------------------------------------------------------------------------------
#  EXAMPLES
#-------------------------------------------------------------------------------
#  Example 1 | Initialize token
readonly L_SC_DE_HLP_TTL_EXAMPLES_1="Initialize token"
readonly L_SC_DE_HLP_TXT_EXAMPLES_1="${L_SC_HLP_TXT_EXAMPLES_1}"

#  Example 2 | Generate public-private key pair
readonly L_SC_DE_HLP_TTL_EXAMPLES_2="Generate public-private key pair"
readonly L_SC_DE_HLP_TXT_EXAMPLES_2="${L_SC_HLP_TXT_EXAMPLES_2}"

#  Example 3 | Import certificate / key / data object
readonly L_SC_DE_HLP_TTL_EXAMPLES_3="Import certificate / key / data object"
readonly L_SC_DE_HLP_TXT_EXAMPLES_3="${L_SC_HLP_TXT_EXAMPLES_3}"

#  Example 4 | Export certificate / data object
readonly L_SC_DE_HLP_TTL_EXAMPLES_4="Export certificate / data object"
readonly L_SC_DE_HLP_TXT_EXAMPLES_4="${L_SC_HLP_TXT_EXAMPLES_4}"

#  Example 5 | Delete certificate / key / data object
readonly L_SC_DE_HLP_TTL_EXAMPLES_5="Delete certificate / key / data object"
readonly L_SC_DE_HLP_TXT_EXAMPLES_5="${L_SC_HLP_TXT_EXAMPLES_5}"

#  Example 6 | PIN Management (Change/Reset/Unblock)
readonly L_SC_DE_HLP_TTL_EXAMPLES_6="PIN Management (Change/Reset/Unblock)"
readonly L_SC_DE_HLP_TXT_EXAMPLES_6="${L_SC_HLP_TXT_EXAMPLES_6}"

#  Example 7 | SmartCard-HSM / Nitrokey HSM 2 | Backup and restore private key
readonly L_SC_DE_HLP_TTL_EXAMPLES_7="Backup and restore private key (${L_SC_DLG_ITM_ARG_TOKEN_TYPE_SCHSM} only)"
readonly L_SC_DE_HLP_TXT_EXAMPLES_7="${L_SC_HLP_TXT_EXAMPLES_7}"

#-------------------------------------------------------------------------------
#  NOTES
#-------------------------------------------------------------------------------
#  Note 1
readonly L_SC_DE_HLP_TXT_NOTES_1="\
Die minimale/maximale Länge und die erlaubten Zeichen hängen vom verwendeten Tokentyp und -modell ab. Weitere Informationen finden Sie unter Umständen auch im Datenblatt oder Handbuch Ihres Tokens.

${L_SC_HLP_TXT_HEADER_OPENSC_P11}
${L_SC_HLP_TXT_HEADER_OPENSC_P15}
PIN:    6 - 8 Zeichen, nur Ziffern (0-9)
PUK:    Genau 8 Zeichen, nur Ziffern
SO-PIN: 6 - 8 Zeichen, nur Ziffern


${L_SC_HLP_TXT_HEADER_OPENSC_P15}
PUK:    8 - 16 (*) Zeichen, nur Ziffern
SO-PUK: 8 - 16 (*) Zeichen, nur Ziffern

(*) Für die Konformität mit dem Standard 'FIPS-201 (PIV Card)' ist eine Länge von genau 8 Zeichen vorgeschrieben.


${L_SC_HLP_TXT_HEADER_SCHSM}
PIN:    6 - 15 bytes, nur ASCII Zeichen
SO-PIN: Genau 16 hexadezimale (0-9 a-f) Zeichen
Passwort (DKEK Share): >= 10 Zeichen, beliebig

Bei Firmware-Versionen unter 1.0 bestehen einige Einschränkungen:
  - Um die Benutzer-PIN zurückzusetzen muss der gesamte Token reinitialisiert
    werden, wobei alle Zertifikate/Daten/Schlüssel verloren gehen.
  - Die Security Officer PIN (SO-PIN) kann nur einmalig(!)
    gesetzt werden, während der Initialisierung.

Siehe auch:
${L_SC_HLP_TXT_NOTES_1_SCHSM}


${L_SC_HLP_TXT_HEADER_YUBICO}
PIN:    6 - 8 Bytes, nur ASCII Zeichen
PUK:    6 - 8 Bytes, beliebiger Wert (ASCII Zeichen empfohlen)
Management Key:
        Länge hängt vom verwendeten Schlüsseltyp ('${L_SC_HLP_PAR_ARG_ALL_KEY_TYPE}') ab.
        Genau 32 (AES128), 48 (AES192, TDES), 64 (AES256)
        Zeichen, nur hexadezimal (0-9 a-f).

Siehe auch:
${L_SC_HLP_TXT_NOTES_1_YUBICO}"

#  Note 2
readonly L_SC_DE_HLP_TXT_NOTES_2="${LIB_SHTPL_DE_TXT_HELP_TXT_NOTES_CREDENTIALS_ENV}"

#-------------------------------------------------------------------------------
#  REQUIREMENTS
#-------------------------------------------------------------------------------
#  Requirements 1 | All token types
readonly L_SC_DE_HLP_TTL_REQUIREMENTS_1="Diverse Tokentypen (obligatorisch)"
readonly L_SC_DE_HLP_TXT_REQUIREMENTS_1="\
Die folgenden Anforderungen gelten für alle(!) Tokentypen. Weitere (typspezifische) Anforderungen entnehmen Sie bitte den Abschnitten weiter unten.

Software:
${L_SC_HLP_TXT_REQUIREMENTS_11}

Hardware (Lesegerät):
  Muss CCID-konform sein und 'extended APDU'-Unterstützung besitzen, siehe
${L_SC_HLP_TXT_REQUIREMENTS_12}"

#  Requirements 2 | Interactive Mode
readonly L_SC_DE_HLP_TTL_REQUIREMENTS_2="${LIB_SHTPL_DE_TXT_HELP_TTL_REQUIREMENTS_INTERACTIVE}"
readonly L_SC_DE_HLP_TXT_REQUIREMENTS_2="${LIB_SHTPL_DE_TXT_HELP_TXT_REQUIREMENTS_INTERACTIVE}"

#  Requirements 3 | PIN/PUK Letter
readonly L_SC_DE_HLP_TTL_REQUIREMENTS_3="PIN/PUK-Brief (optional)"
readonly L_SC_DE_HLP_TXT_REQUIREMENTS_3="\
Dieses Repository beinhaltet eine LaTeX-Briefvorlage '${L_SC_HLP_TXT_REQUIREMENTS_31}', die Sie für die Herausgabe der PIN, PUK, etc. nutzen können. Für die Einrichtung folgen Sie bitte den Anweisungen unter '${L_SC_HLP_TXT_REQUIREMENTS_32}'."

#  Requirements 4 | OpenSC (PKCS#11) and SmartCard-HSM / Nitrokey HSM 2
readonly L_SC_DE_HLP_TTL_REQUIREMENTS_4="${L_SC_DE_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P11} und ${L_SC_DE_DLG_ITM_ARG_TOKEN_TYPE_SCHSM}"
readonly L_SC_DE_HLP_TXT_REQUIREMENTS_4="\
Software:
${L_SC_HLP_TXT_REQUIREMENTS_41}

Hardware (Smartcard/Token):
  Muss von OpenSC unterstützt werden, siehe
${L_SC_HLP_TXT_REQUIREMENTS_42}"

#  Requirements 5 | OpenSC (PKCS#15)
readonly L_SC_DE_HLP_TTL_REQUIREMENTS_5="${L_SC_DE_DLG_ITM_ARG_TOKEN_TYPE_OPENSC_P15}"
readonly L_SC_DE_HLP_TXT_REQUIREMENTS_5="\
Software:
${L_SC_HLP_TXT_REQUIREMENTS_51}

Hardware (Smartcard/Token):
  Muss von OpenSC unterstützt werden, siehe
${L_SC_HLP_TXT_REQUIREMENTS_52}"

#  Requirements 6 | SmartCard-HSM / Nitrokey HSM 2
readonly L_SC_DE_HLP_TTL_REQUIREMENTS_6="${L_SC_DE_DLG_ITM_ARG_TOKEN_TYPE_SCHSM}"
readonly L_SC_DE_HLP_TXT_REQUIREMENTS_6="\
Software:
${L_SC_HLP_TXT_REQUIREMENTS_61}"

#  Requirements 7 | Yubico YubiKey PIV
readonly L_SC_DE_HLP_TTL_REQUIREMENTS_7="${L_SC_DE_DLG_ITM_ARG_TOKEN_TYPE_YUBICO}"
readonly L_SC_DE_HLP_TXT_REQUIREMENTS_7="\
Software:
${L_SC_HLP_TXT_REQUIREMENTS_71}

Hardware (Smartcard/Token):
${L_SC_HLP_TXT_REQUIREMENTS_72}
    (Siehe Eigenschaft 'Smart card (PIV-compatible)')

Der 'PIV PIN-only'-Modus wird derzeit nicht unterstützt, siehe '${L_SC_HLP_TXT_REQUIREMENTS_73}'."

#-------------------------------------------------------------------------------
#  SYNOPSIS
#-------------------------------------------------------------------------------
#  ACTION | All token types
readonly L_SC_DE_HLP_TTL_SYNOPSIS_ACTION_ALL="Diverse Tokentypen"
readonly L_SC_DE_HLP_TXT_SYNOPSIS_ACTION_ALL="Manche Aktionen sind nur für bestimmte Tokentypen zulässig. Welche das jeweils sind, können Sie den typspezifischen Aktionslisten weiter oben entnehmen."

#  OPTION | All token types
readonly L_SC_DE_HLP_TTL_SYNOPSIS_OPTION_ALL="${L_SC_DE_HLP_TTL_SYNOPSIS_ACTION_ALL}"
readonly L_SC_DE_HLP_TXT_SYNOPSIS_OPTION_ALL="Manche Optionen sind nur für bestimmte Tokentypen zulässig. Welche das jeweils sind, können Sie den typspezifischen Optionslisten weiter oben entnehmen."

#-------------------------------------------------------------------------------
#  TEXTS
#-------------------------------------------------------------------------------
# Intro Description
readonly L_SC_DE_HLP_TXT_INTRO="Initialisieren und Verwalten von Smartcards, USB-Token und Hardware Security Modules (HSMs)."

#-------------------------------------------------------------------------------
#  TL;DR
#-------------------------------------------------------------------------------
readonly L_SC_DE_HLP_TTL_TLDR_1="Anforderungen"
readonly L_SC_DE_HLP_TXT_TLDR_1="\
Um die benötigten Pakete zu installieren, führen Sie bitte folgenden Befehl aus:

${L_SC_HLP_TXT_TLDR_1_INSTALL}

Unter Umständen werden, abhängig vom Tokentyp, nicht alle Pakete benötigt. Informationen hierzu finden Sie im Abschnitt <${LIB_SHTPL_DE_TXT_HELP_TTL_REQUIREMENTS}> weiter unten.

${L_SC_DE_HLP_TXT_REQUIREMENTS_3}

Das Skript wurde in folgender Umgebung entwickelt und getestet:

OS:         ${L_SC_HLP_TXT_TLDR_1_OS}
Kernel:     ${L_SC_HLP_TXT_TLDR_1_KERNEL}
Pakete:     ${L_SC_HLP_TXT_TLDR_1_PACKAGES}"

#===============================================================================
#  CUSTOM STRINGS (used in terminal output <stdout>/<stderr>)
#===============================================================================
#  TODO: Here you can define custom language-specific strings.
#        Do not forget to "publish" them within the <init_lang()> function of
#        your destination script, e.g. 'run.sh'.
#===============================================================================