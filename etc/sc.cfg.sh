#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the SCwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /etc/sc.cfg.sh
#
#        USAGE:   ---
#                 (This is a configuration file, so please do NOT run it.)
#
#  DESCRIPTION:   Configuration File for </src/sc.sh>
#
#         BUGS:   ---
#
#        NOTES:   Please DO NOT DELETE this file, even when it is empty.
#
#         TODO:   See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#                  DONE: DEFINE YOUR VARIABLES/CONSTANTS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
# Default key type (algorithm, length)
# Run '/src/sc.sh --help', parameter '-T|--key-type <type>',
# for more information.
readonly CFG_SC_ARG_KEY_TYPE="rsa:2048"
readonly CFG_SC_ARG_ALL_KEY_TYPE_OPENSC_P11="rsa:2048"
readonly CFG_SC_ARG_ALL_KEY_TYPE_OPENSC_P15="rsa/2048"
readonly CFG_SC_ARG_ALL_KEY_TYPE_SCHSM="rsa:4096"
readonly CFG_SC_ARG_ALL_KEY_TYPE_YUBICO="RSA2048"
readonly CFG_SC_ARG_ALL_KEY_TYPE_YUBICO_CHANGE_MANAGEMENT_KEY="AES256"
readonly CFG_SC_ARG_ALL_KEY_TYPE_YUBICO_INITIALIZE="${CFG_SC_ARG_ALL_KEY_TYPE_YUBICO_CHANGE_MANAGEMENT_KEY}"
#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#                  DONE: DEFINE YOUR VARIABLES/CONSTANTS HERE
#===============================================================================