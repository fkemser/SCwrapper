<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GNU GPL v3.0 License][license-shield]][license-url]
<!-- [![LinkedIn][linkedin-shield]][linkedin-url] -->



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <!-- <a href="https://github.com/fkemser/SCwrapper">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->

<h3 align="center">SCwrapper</h3>

  <p align="center">
    A collection of shell scripts to initialize and manage certain smartcards, USB tokens, and hardware security modules (HSMs), either interactively or via command line.
    <br />
    <a href="https://github.com/fkemser/SCwrapper"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/fkemser/SCwrapper">View Demo</a>
    ·
    <a href="https://github.com/fkemser/SCwrapper/issues">Report Bug</a>
    ·
    <a href="https://github.com/fkemser/SCwrapper/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#related-projects">Related Projects</a></li>
        <li><a href="#testing-environment">Testing Environment</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#mandatory">Mandatory</a></li>
        <li><a href="#interactive-mode-optional">Interactive Mode (optional)</a></li>
        <li><a href="#pinpuk-letter-optional">PIN/PUK Letter (optional)</a></li>
        <li><a href="#opensc-pkcs11-and-smartcard-hsm--nitrokey-hsm-2">OpenSC PKCS#11 and SmartCard-HSM / Nitrokey HSM 2</a></li>
        <li><a href="#opensc-pkcs15">OpenSC PKCS#15</a></li>
        <li><a href="#yubico-yubikey-piv">Yubico YubiKey PIV</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage-srcscsh">Usage (/src/sc.sh)</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This project provides a shell script to

- initialize a security token including setting secrets (PIN, PUK, etc.),
- print initial secrets by using a customizable letter template,
- import/export/delete certificates, keys, data objects from/to the token,
- generate public-private key pairs,
- change/reset/unblock PIN,
- and much more.

The script can be controlled either via command-line switches or via an interactive, `dialog`-based interface.

So far, this project supports the following security token:

- Smartcards and token that that are supported by [OpenSC (PKCS#11/PKCS#15)](https://github.com/OpenSC/OpenSC/wiki/Supported-hardware-%28smart-cards-and-USB-tokens%29)
- [SmartCard-HSM / Nitrokey HSM 2](https://github.com/OpenSC/OpenSC/wiki/SmartCardHSM)
- [Yubico YubiKey PIV](https://developers.yubico.com/PIV/Introduction/)

> :information_source: Please note that this project cannot cover all token-specific actions and options. For very specific use cases you should use the tools provided by your token manufacturer.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

[![Shell Script][Shell Script-shield]][Shell Script-url]
[![LaTeX][LaTeX-shield]][LaTeX-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Related Projects

This work includes or is based on other projects:

* [SHtemplate](https://github.com/fkemser/SHtemplate), a template for POSIX-/Bourne-Shell(sh) projects.
* [CUPSwrapper](https://github.com/fkemser/CUPSwrapper), a collection of shell scripts to interactively print and manage printers for local usage.
* [GerLaTeXLetter](https://github.com/fkemser/GerLaTeXLetter), a LaTeX template for business letters (mostly) following German DIN 5008 standard, based on KOMA-Script class `scrlttr2`.
* [TeXLetterCreator](https://github.com/fkemser/TeXLetterCreator), a collection of shell scripts to interactively create and print TeX-based form letters.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Testing Environment

The project has been developed and tested on the following system:

| Info | Description
---: | ---
OS | Debian GNU/Linux 12 (bookworm)
Kernel | 5.15.133.1-microsoft-standard-WSL2
Packages | [coreutils (9.1-1)](https://packages.debian.org/bookworm/coreutils)
|| [dash (0.5.12-2)](https://packages.debian.org/bookworm/dash)
|| [dialog (1.3-20230209-1)](https://packages.debian.org/bookworm/dialog)
|| [libc-bin (2.36-9+deb12u3)](https://packages.debian.org/bookworm/libc-bin)
|| [gnutls-bin (3.7.9-2+deb12u2)](https://packages.debian.org/bookworm/gnutls-bin)
|| [libccid (1.5.2-1)](https://packages.debian.org/bookworm/libccid)
|| [opensc (0.23.0-0.3+deb12u1)](https://packages.debian.org/bookworm/opensc)
|| [opensc-pkcs11 (0.23.0-0.3+deb12u1)](https://packages.debian.org/bookworm/opensc-pkcs11)
|| [openssl (3.0.11-1~deb12u2)](https://packages.debian.org/bookworm/openssl)
|| [pcscd (1.9.9-2)](https://packages.debian.org/bookworm/pcscd)
|| [ykcs11 (2.2.0-1.1)](https://packages.debian.org/bookworm/ykcs11)
|| [yubikey-manager (4.0.9-1)](https://packages.debian.org/bookworm/yubikey-manager)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started
### Prerequisites
Please make sure that the following dependencies are installed:

* [PCSClite](https://pcsclite.apdu.fr/)
* [USB PC/SC CCID driver](https://ccid.apdu.fr/)

Additionally, there are some use-case specific dependencies (see sections below):

* [Dialog](https://invisible-island.net/dialog/dialog.html)
* [GnuTLS](https://www.gnutls.org/)
* [OpenSC](https://github.com/OpenSC/OpenSC)
* [OpenSC (PKCS#11 module)](https://github.com/OpenSC/libp11)
* [OpenSSL](https://www.openssl.org/)
* [Yubico PIV tool (PKCS#11 module)](https://developers.yubico.com/yubico-piv-tool/)
* [YubiKey Manager](https://developers.yubico.com/yubikey-manager/)

### Mandatory
```
  Packages: PCSClite, USB PC/SC CCID driver
    Debian: > sudo apt install pcscd libccid
```

### Interactive Mode (optional)
In case you run this script interactively your terminal window must have a size of <100x30> or bigger.

````
  Packages: Dialog
    Debian: > sudo apt install dialog
````

### PIN/PUK Letter (optional)
This project provides a **LaTeX letter template** (`/tex/sc.tex`), a modified version of [GerLaTeXLetter](https://github.com/fkemser/GerLaTeXLetter).
You can use this template for **priting token-related secrets like PIN, PUK, etc.**.

:warning: To use this feature **please follow all of the following setup instructions before continuing** :warning:
  * [CUPSwrapper](https://github.com/fkemser/CUPSwrapper#prerequisites)
  * [GerLaTeXLetter](https://github.com/fkemser/GerLaTeXLetter#prerequisites)
  * [TeXLetterCreator](https://github.com/fkemser/TeXLetterCreator#prerequisites)

Afterwards, please install some **additional but required CTAN packages**

```sh
tlmgr install environ microtype pgf tcolorbox tikzfill trimspaces
```

**To customize the template** please edit the files within the `/tex` folder. For more information please have a look at [GerLaTeXLetter](https://github.com/fkemser/GerLaTeXLetter#customization). The instructions for `letter.tex` also apply to `sc.tex`.

### OpenSC PKCS#11 and SmartCard-HSM / Nitrokey HSM 2
````
  Packages: GnuTLS, OpenSC, OpenSC (PKCS#11 module)
    Debian: > sudo apt install gnutls-bin opensc opensc-pkcs11
````

### OpenSC PKCS#15
````
  Packages: OpenSC
    Debian: > sudo apt install opensc
````

### SmartCard-HSM / Nitrokey HSM 2
````
  Packages: OpenSSL
    Debian: > sudo apt install openssl
````

### Yubico YubiKey PIV
[PIV PIN-only mode](https://docs.yubico.com/yesdk/users-manual/application-piv/pin-only.html) is currently not supported.

````
  Packages: GnuTLS, Yubico PIV tool (PKCS#11 module), YubiKey Manager
    Debian: > sudo apt install gnutls-bin ykcs11 yubikey-manager
````

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Installation
1. Make sure that your environment meets the [requirements](#prerequisites).

2. Clone the repo
	```sh
   git clone --recurse-submodules https://github.com/fkemser/SCwrapper.git
   ```

2. Edit the repository configuration file. In case it is empty just keep it as it is, **do not delete it**.
	```sh
   nano ./SCwrapper/etc/sc.cfg.sh
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE -->
## Usage (/src/sc.sh)

To call the script interactively, run `/src/sc.sh` (without further arguments) from your terminal. To get help, run `/src/sc.sh -h`.  

```sh
================================================================================
===============================     SYNOPSIS     ===============================
================================================================================

There are multiple ways to run this script:

Interactive mode (without any args):
> ./sc.sh

Classic (script) mode:
> ./sc.sh [ OPTION ]... ACTION

OpenSC PKCS#11         ./sc.sh [ -T opensc-p11 ] [ OPTION ]... ACTION           
(default)                                                                       
                                                                                
                       ACTION := { -h|--help | --change-pin | --change-so-pin | 
                       --connect | --delete | --export <file> | --get <type> |  
                       --import <file> | --initialize | --keypairgen [<file>] | 
                       --list <type> | --p11-get-uri <type> | --reset-pin }     
                                                                                
                       OPTION := { [--data-application-name <name>] |           
                       [--data-oid <oid>] | [-f|--format <format>] | [-i|--id   
                       <id>] | [--key-type <type>] | [-l|--label <label>] |     
                       [-n|--new-pin|--new-puk| --new-so-pin <val>] |           
                       [--password <pwd>] | [-p|--pin <pin>] | [-P|--puk <puk>] 
                       | [-r|--reader <id>] | [-s|--so-pin <so pin>] |          
                       [-S|--so-puk <so puk>] | [-t|--type <type>] }            

OpenSC PKCS#15         ./sc.sh -T opensc-p15 [ OPTION ]... ACTION               
                                                                                
                       ACTION := { -h|--help | --change-pin | --change-puk |    
                       --change-so-pin | --connect | --delete |                 
                       --erase-application <aid> | --erase-card | --export      
                       <file> | --finalize | --get <type> | --import <file> |   
                       --initialize | --keypairgen [<file>] | --list <type> |   
                       --store-pin | --unblock-pin }                            
                                                                                
                       OPTION := { [--data-application-name <name>] |           
                       [--data-oid <oid>] | [-f|--format <format>] | [-i|--id   
                       <id>] | [--key-type <type>] | [-l|--label <label>] |     
                       [-n|--new-pin|--new-puk| --new-so-pin <val>] |           
                       [--opensc-p15-profile <profile>] | [--p15-aid <id>] |    
                       [--p15-auth-id <id>] | [--password <pwd>] | [-p|--pin    
                       <pin>] | [-P|--puk <puk>] | [-r|--reader <id>] |         
                       [-s|--so-pin <so pin>] | [-S|--so-puk <so puk>] |        
                       [-t|--type <type>] }                                     

SmartCard-HSM /        ./sc.sh -T schsm [ OPTION ]... ACTION                    
Nitrokey HSM 2                                                                  
                                                                                
                       ACTION := { -h|--help | --change-pin | --change-so-pin | 
                       --connect | --delete | --export <file> | --get <type> |  
                       --import <file> | --initialize | --keypairgen [<file>] | 
                       --list <type> | --p11-get-uri <type> | --reset-pin |     
                       --schsm-backup <file> | --schsm-dkek-share-create <file> 
                       | --schsm-dkek-share-import <file> | --schsm-restore     
                       <file> }                                                 
                                                                                
                       OPTION := { [-F|--force] | [-f|--format <format>] |      
                       [-i|--id <id>] | [--key-type <type>] | [-l|--label       
                       <label>] | [-n|--new-pin|--new-puk| --new-so-pin <val>]  
                       | [--password <pwd>] | [-p|--pin <pin>] | [-P|--puk      
                       <puk>] | [-r|--reader <id>] | [--schsm-dkek-shares       
                       <int>] | [--schsm-key-reference <id>] |                  
                       [--schsm-pwd-shares-threshold <int>] |                   
                       [--schsm-pwd-shares-total <int>] | [-s|--so-pin <so      
                       pin>] | [-S|--so-puk <so puk>] | [-t|--type <type>] }    

Yubico YubiKey PIV     ./sc.sh -T yubico [ OPTION ]... ACTION                   
                                                                                
                       ACTION := { -h|--help | --change-management-key |        
                       --change-pin | --change-puk | --connect | --delete |     
                       --export <file> | --get <type> | --import <file> |       
                       --initialize | --keypairgen [<file>] | --list <type> |   
                       --p11-get-uri <type> | --unblock-pin }                   
                                                                                
                       OPTION := { [-F|--force] | [-f|--format <format>] |      
                       [--key-type <type>] | [-n|--new-pin|--new-puk|           
                       --new-so-pin <val>] | [--password <pwd>] | [-p|--pin     
                       <pin>] | [--piv-id <id>] | [--piv-slot <id>] | [-P|--puk 
                       <puk>] | [--serial <serial no>] | [-s|--so-pin <so pin>] 
                       | [-S|--so-puk <so puk>] | [-t|--type <type>] |          
                       [--yubico-management-key <key>] |                        
                       [--yubico-new-management-key <key>] |                    
                       [--yubico-pin-policy <pol>] | [--yubico-touch-policy     
                       <pol>] }                                                 

--------------------------------------------------------------------------------
--------------------------------     ACTION     --------------------------------
--------------------------------------------------------------------------------

__________________________ Miscellaneous Token Types ___________________________

Some actions are only allowed with certain token types, see type-specific action lists above.

--change-pin              Change user PIN (requires user PIN). See also         
                          '-p|--pin <pin>' and '-n|--new-pin|--new-puk|         
                          --new-so-pin <val>'.                                  

--change-puk              Change user PUK. Only with '-T opensc-p15' or '-T     
                          yubico'. See also '-P|--puk <puk>' and                
                          '-n|--new-pin|--new-puk|                              
                          --new-so-pin <val>'.                                  

--change-so-pin           Change security officer PIN (SO-PIN). Only with '-T   
                          opensc-p11', '-T opensc-p15', or '-T schsm'. See also 
                          '-s|--so-pin <so pin>' and '-n|--new-pin|--new-puk|   
                          --new-so-pin <val>'.                                  

--connect                 Prompt the user interactively to connect a token.     
                          Returns '0' (token connected) or '1' (no token found).

--delete                  Delete a certificate, key, or data object on the      
                          token. Object type must be specified using '-t|--type 
                          <type>'.                                              
                                                                                
                          ***** OpenSC PKCS#11 ('-T opensc-p11') *****          
                          ***** OpenSC PKCS#15 ('-T opensc-p15') *****          
                          ***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm')     
                          *****                                                 
                          Use '-p|--pin <pin>' or '-s|--so-pin <so pin>' to     
                          specify the PIN or SO-PIN to use.                     
                                                                                
                            <type> = data                                       
                          Use '--data-oid <oid>' or '--data-application-name    
                          <name>' and '-l|--label <label>' to specify the data  
                          object to delete.                                     
                                                                                
                            <type> != data                                      
                          Use '-i|--id <id>' and/or '-l|--label <label>' (not   
                          with '-T opensc-p15') to specify the object to delete.
                                                                                
                          <type> = { cert | data | privkey | pubkey | secrkey } 
                                                                                
                          ***** OpenSC PKCS#15 ('-T opensc-p15') *****          
                          Use '--p15-aid <id>' to specify the target            
                          application when using multi-application cards.       
                                                                                
                          <type> = { cert | chain | data | privkey | pubkey |   
                          secrkey }                                             
                                                                                
                          ***** Yubico YubiKey PIV ('-T yubico') *****          
                          Use '--piv-slot <id>' to specify the PIV slot to      
                          operate on. Use '--yubico-management-key <key>' to    
                          specify the current management key.                   
                                                                                
                          <type> = { cert }                                     

--export <file>           Export a certificate, public key, or data object from 
                          the token to a <file>. Object type must be specified  
                          using '-t|--type <type>'.                             
                                                                                
                          ***** OpenSC PKCS#11 ('-T opensc-p11') *****          
                          ***** OpenSC PKCS#15 ('-T opensc-p15') *****          
                          ***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm')     
                          *****                                                 
                                                                                
                            <type> = data                                       
                          Use '-l|--label <label>', '--data-oid <oid>' or       
                          '--data-application-name <name>' to specify the data  
                          object to export.                                     
                                                                                
                            <type> != data                                      
                          Use '-i|--id <id>' and/or '-l|--label <label>' (not   
                          with '-T opensc-p15') to specify the object to export.
                                                                                
                          <type> = { cert | data | pubkey }                     
                                                                                
                          ***** OpenSC PKCS#15 ('-T opensc-p15') *****          
                          Use '-p|--pin <pin>' or '-s|--so-pin <so pin>' to     
                          specify the PIN or SO-PIN to use (only if <type> =    
                          data). Use '--p15-aid <id>' to specify the target     
                          application when using multi-application cards.       
                                                                                
                          <type> = { cert | data | pubkey | sshkey |            
                          sshkey-rfc4716 }                                      
                                                                                
                          ***** Yubico YubiKey PIV ('-T yubico') *****          
                          Use '-f|--format <format>' to specify the             
                          certificate/key format. Use '--piv-slot <id>' to      
                          specify the PIV slot to operate on (only if <type> =  
                          { cert | pubkey }). Use '--piv-id <id>' to specify    
                          the PIV object id (BER-TLV tag) to use (only if       
                          <type> = data). Use '-p|--pin <pin>' to specify the   
                          PIN to use (only if <type> = { data | pubkey }).      
                                                                                
                          <type> = { cert | data | pubkey }                     

--get <type>              Get information about the smartcard or its reader.    
                          Exactly one (1) token must be connected at that time. 
                                                                                
                          ***** OpenSC PKCS#11 ('-T opensc-p11') *****          
                          ***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm')     
                          *****                                                 
                          ***** Yubico YubiKey PIV ('-T yubico') *****          
                                                                                
                          <type> = { reader | smartcard |                       
                          smartcard-manufacturer | smartcard-model |            
                          smartcard-serial }                                    
                                                                                
                          ***** OpenSC PKCS#15 ('-T opensc-p15') *****          
                                                                                
                          <type> = { reader | smartcard | smartcard-model |     
                          smartcard-serial }                                    

--import <file>           Import a certificate, key, or data object from a      
                          <file> to the token. Object type must be specified    
                          using '-t|--type <type>'. For password-protected      
                          files use '--password <pwd>' to specify/set the       
                          password.                                             
                                                                                
                          ***** OpenSC PKCS#11 ('-T opensc-p11') *****          
                          ***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm')     
                          *****                                                 
                          Object must be specified via '-i|--id <id>' and/or    
                          '-l|--label <label>'. <file> must be DER-encoded. To  
                          convert from PEM to DER format, just run 'openssl     
                          x509 -in <file_in>.pem -out <file_out>.der -outform   
                          der'. Use '-p|--pin <pin>' to specify the PIN to use. 
                                                                                
                            <type> = data                                       
                          Optionally use '--data-oid <oid>' to specify the data 
                          object's identifier (OID). Optionally use             
                          '--data-application-name <name>' to specify the data  
                          object's application name.                            
                                                                                
                          <type> = { cert | data | privkey | pubkey | secrkey } 
                                                                                
                          ***** OpenSC PKCS#15 ('-T opensc-p15') *****          
                          Use '-p|--pin <pin>' or '-s|--so-pin <so pin>' to     
                          specify the PIN or SO-PIN to use. Use '--p15-aid      
                          <id>' to specify the target application when using    
                          multi-application cards.                              
                                                                                
                            <type> = data                                       
                          Optionally use '-l|--label <label>' to specify object 
                          label (name). Optionally use '--data-oid <oid>' to    
                          specify the data object's identifier (OID).           
                          Optionally use '--data-application-name <name>' to    
                          specify the data object's application name.           
                                                                                
                            <type> != data                                      
                          Optionally use '-i|--id <id>' and/or '-l|--label      
                          <label>' to specify an object. Use '-f|--format       
                          <format>' to specify the certificate/key format.      
                                                                                
                          <type> = { cert | data | privkey | pubkey | secrkey } 
                                                                                
                          ***** Yubico YubiKey PIV ('-T yubico') *****          
                          Use '-f|--format <format>' to specify the             
                          certificate/key format. Use '--piv-slot <id>' to      
                          specify the PIV slot to operate on (only if <type> =  
                          { cert | privkey }). Use '--piv-id <id>' to specify   
                          the PIV object id (BER-TLV tag) to use (only if       
                          <type> = data). Use '--yubico-management-key <key>'   
                          to specify the current management key.                
                                                                                
                          <type> = { cert | data | privkey }                    

--initialize              Initialize token                                      
                                                                                
                          ***** OpenSC PKCS#11 ('-T opensc-p11') *****          
                          Set token label, SO-PIN, and PIN. Object to create or 
                          operate on must be specified via '-l|--label <label>'.
                                                                                
                          Use '-p|--pin <pin>' and '-s|--so-pin <so pin>' to    
                          set PIN and SO-PIN.                                   
                                                                                
                          ***** OpenSC PKCS#15 ('-T opensc-p15') *****          
                          Create initial PKCS#15 data structure. Optionally use 
                          '-l|--label <label>' to specify object label (name).  
                                                                                
                          Use '-p|--pin <pin>', '-P|--puk <puk>', '-s|--so-pin  
                          <so pin>', and '-S|--so-puk <so puk>' to set PIN,     
                          PUK, SO-PIN, and SO-PUK. Please note that certain     
                          models only support one PIN/PUK pair but no           
                          additional SO-PIN/SO-PUK.                             
                                                                                
                          Use '--opensc-p15-profile <profile>' to specify the   
                          OpenSC PKCS#15 profile to load during initialization, 
                          e.g. 'pkcs15+onepin' in case your token only supports 
                          one user PIN/PUK pair but no additional SO-PIN/SO-PUK.
                                                                                
                          With certain models it is necessary to run './sc.sh   
                          --erase-card' before and/or './sc.sh --finalize'      
                          after initialization.                                 
                                                                                
                          ***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm')     
                          *****                                                 
                          Remove all existing keys, certificates and files. Use 
                          it with '--schsm-dkek-shares <int>' to enable private 
                          key backup/restore, this can not(!) be done at a      
                          later stage.                                          
                                                                                
                          Use '-p|--pin <pin>' and '-s|--so-pin <so pin>' to    
                          set PIN and SO-PIN.                                   
                                                                                
                          ***** Yubico YubiKey PIV ('-T yubico') *****          
                          Wipe all PIV-related data and restore PIV application 
                          to factory settings.                                  
                                                                                
                          Use '-p|--pin <pin>', '-P|--puk <puk>', and           
                          '--yubico-management-key <key>' to set PIN, PUK, and  
                          management key.                                       

--keypairgen [<file>]     Generate a public-private key pair. <file> is only    
                          possible (and mandatory) with '-T yubico'. Optionally 
                          use '--key-type <type>' to specify key type/length.   
                                                                                
                          ***** OpenSC PKCS#11 ('-T opensc-p11') *****          
                          ***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm')     
                          *****                                                 
                          Object must be specified via '-i|--id <id>' and/or    
                          '-l|--label <label>'. Use '-p|--pin <pin>' to specify 
                          the PIN to use.                                       
                                                                                
                          ***** OpenSC PKCS#15 ('-T opensc-p15') *****          
                          Optionally use '-i|--id <id>' and/or '-l|--label      
                          <label>' to specify an object. Use '-p|--pin <pin>'   
                          or '-s|--so-pin <so pin>' to specify the PIN or       
                          SO-PIN to use. Use '--p15-aid <id>' to specify the    
                          target application when using multi-application cards.
                                                                                
                          ***** Yubico YubiKey PIV ('-T yubico') *****          
                          It is mandatory to set <file> to specify where the    
                          (generated) public key should be saved to. Use        
                          '-f|--format <format>' to specify the certificate/key 
                          format. Use '--piv-slot <id>' to specify the PIV slot 
                          to operate on. Use '--yubico-management-key <key>' to 
                          specify the current management key.                   

--list <type>             List available objects, supported mechanisms, etc.    
                                                                                
                          ***** OpenSC PKCS#11 ('-T opensc-p11') *****          
                          <type> = { algorithm | object | reader }              
                                                                                
                          ***** OpenSC PKCS#15 ('-T opensc-p15') *****          
                          Use '--p15-aid <id>' to specify the target            
                          application when using multi-application cards.       
                                                                                
                          <type> = { algorithm | cert | data | info | object |  
                          privkey | pubkey | reader | secrkey | p15-application 
                          | p15-pin }                                           
                                                                                
                          <type> = { data | privkey | secrkey }                 
                          Use '-p|--pin <pin>' or '-s|--so-pin <so pin>' to     
                          specify the PIN or SO-PIN to use (certain models      
                          only).                                                
                                                                                
                          ***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm')     
                          *****                                                 
                          <type> = { algorithm | object | reader }              
                                                                                
                          ***** Yubico YubiKey PIV ('-T yubico') *****          
                          <type> = { algorithm | data | info | reader }         

--p11-get-uri <type>      Interactively select a token object and get its       
                          PKCS#11 URI. Only with '-T opensc-p11', '-T schsm',   
                          or '-T yubico'. <type> acts as an object filter,      
                          possible values are:                                  
                                                                                
                                all  :  All available objects                   
                          all-certs  :  All available certificates              
                              certs  :  Only certificates that                  
                                        have an associated                      
                                        private key                             
                           privkeys  :  All available private keys              
                                                                                
                          (default: 'all')                                      

--reset-pin               Reset user PIN (requires SO-PIN). Only with '-T       
                          opensc-p11' or '-T schsm'. See also                   
                          '-n|--new-pin|--new-puk|                              
                          --new-so-pin <val>' and '-s|--so-pin <so pin>'.       

--unblock-pin             Reset user PIN (requires user PUK). Only with '-T     
                          opensc-p11', '-T opensc-p15', or '-T yubico'. See     
                          also '-n|--new-pin|--new-puk|                         
                          --new-so-pin <val>' and '-P|--puk <puk>'.             

________________________________ OpenSC PKCS#15 ________________________________

--erase-application <aid>     Erase PKCS#15 application with the (hexadecimal)  
                              application identifier <aid>, see also '--p15-aid 
                              <id>'. Use '-p|--pin <pin>' or '-s|--so-pin <so   
                              pin>' to specify the PIN or SO-PIN to use.        

--erase-card                  Erase PKCS#15 structure (certain models only).    
                              Use '-p|--pin <pin>' or '-s|--so-pin <so pin>' to 
                              specify the PIN or SO-PIN to use.                 

--finalize                    Finish initialization (certain models only).      
                              Depending on the model this may prevent you from  
                              adding new private/secret keys and/or PIN/PUK     
                              pairs. For further information please have a look 
                              at OpenSC's model-specific wiki pages:            
                                https://github.com/OpenSC/OpenSC/wiki           

--store-pin                   Add another user PIN/PUK pair. Use '-p|--pin      
                              <pin>' and '-P|--puk <puk>' to set PIN and PUK.   
                              Use '--p15-auth-id <id>' to specify the           
                              hexadecimal auth id of PIN/PUK pair to            
                              use/create. Optionally use '-l|--label <label>'   
                              to specify object label (name).                   

________________________ SmartCard-HSM / Nitrokey HSM 2 ________________________

--schsm-backup <file>                Export private key and store it in <file>  
                                     (DKEK-encrypted). Use it with              
                                     '--schsm-key-reference <id>' to specify    
                                     the key (identifier) to use. Use '-p|--pin 
                                     <pin>' to specify the PIN to use.          

--schsm-dkek-share-create <file>     Create an encrypted DKEK share and save it 
                                     into <file>. Please print the file's       
                                     content on paper in case the file gets     
                                     corrupted. To get a printable version, run 
                                     'openssl base64 -in <file>'.               
                                                                                
                                     Use '--password <pwd>' to specify an       
                                     encryption password, otherwise you will be 
                                     prompted for one.                          
                                                                                
                                     Use '--schsm-pwd-shares-threshold <int>'   
                                     and '--schsm-pwd-shares-total <int>' to    
                                     establish an n-of-m threshold scheme. Do   
                                     not(!) use '--password <pwd>' in this      
                                     case, you will be prompted for the         
                                     password shares. See also:                 
                                     https://github.com/OpenSC/OpenSC/wiki/Smart
                                     CardHSM#using-a-n-of-m-threshold-scheme    

--schsm-dkek-share-import <file>     Decrypt and write DKEK share from <file>   
                                     to the HSM.                                
                                                                                
                                     Use '--password <pwd>' to specify the      
                                     decryption password, otherwise you will be 
                                     prompted for one.                          
                                                                                
                                     Use it with '--schsm-pwd-shares-total      
                                     <int>' in case your DKEK share requires    
                                     <int> password shares to restore it. Do    
                                     not(!) use '--password <pwd>' in this      
                                     case, you will be prompted for the         
                                     password shares. See also:                 
                                     https://github.com/OpenSC/OpenSC/wiki/Smart
                                     CardHSM#using-a-n-of-m-threshold-scheme    

--schsm-restore <file>               Restore private key from <file>            
                                     (DKEK-encrypted). Use it with              
                                     '--schsm-key-reference <id>' to specify    
                                     the key reference to use. This mode        
                                     requires running './sc.sh --initialize     
                                     --schsm-dkek-shares <int>' and './sc.sh    
                                     --schsm-dkek-share-import <file>'          
                                     beforehand. Use '-p|--pin <pin>' to        
                                     specify the PIN to use.                    

______________________________ Yubico YubiKey PIV ______________________________

--change-management-key     Change management key. Use '--yubico-management-key 
                            <key>' to specify the current management key. Use   
                            '--yubico-new-management-key <key>' to specify the  
                            new management key.                                 

--------------------------------------------------------------------------------
--------------------------------     OPTION     --------------------------------
--------------------------------------------------------------------------------

__________________________ Miscellaneous Token Types ___________________________

Some options are only allowed with certain token types, see type-specific option lists above.

-T|--token-type <type>             Select the token type to use                 
                                                                                
                                   <type> = { opensc-p11 | opensc-p15 | schsm | 
                                   yubico }                                     
                                                                                
                                   (default: 'opensc-p11')                      

--data-application-name <name>     Specify the application name of the data     
                                   object to import. Only with '-T opensc-p11'  
                                   or '-T opensc-p15'. Run './sc.sh --list      
                                   data' to list all available data objects.    

--data-oid <oid>                   Specify the data object's identifier (OID).  
                                   Run './sc.sh --list data' to list all        
                                   available data objects.                      

-F|--force                         Perform action without any further user      
                                   interaction. Only with '-T schsm             
                                   --schsm-restore <file>' or '-T yubico        
                                   (--initialize|--change-management-key)'.     

-f|--format <format>               Certificate or key format to use. 'pkcs12'   
                                   is only possible with '-T opensc-p15         
                                   --import <file> --type privkey'.             
                                                                                
                                   <format> = { pem | der | pkcs12 }            
                                                                                
                                   (default: 'pem')                             

-i|--id <id>                       ID of the object to create or operate on.    
                                   Run './sc.sh --list object' to list all      
                                   available objects.                           

--key-type <type>                  Type and length of the key to create. Run    
                                   './sc.sh --list algorithm' to get a list of  
                                   algorithms supported by the token. Depending 
                                   on the token type this value must follow one 
                                   of the following forms (without ''):         
                                                                                
                                   ***** OpenSC PKCS#11 ('-T opensc-p11') ***** 
                                   ***** SmartCard-HSM / Nitrokey HSM 2 ('-T    
                                   schsm') *****                                
                                   '<type>:<length>', e.g. 'rsa:4096' or        
                                   'EC:prime256v1'                              
                                                                                
                                   ***** OpenSC PKCS#15 ('-T opensc-p15') ***** 
                                   '<type>/<length>', e.g. 'rsa/2048' or        
                                   'ec/prime256v1'                              
                                                                                
                                   ***** Yubico YubiKey PIV ('-T yubico') ***** 
                                   '<TYPE><length>', e.g. 'RSA2048' or          
                                   'ECCP384'. Only the following values are     
                                   allowed:                                     
                                                                                
                                   Private Key                                  
                                   <type> = { RSA2048 | RSA1024 | ECCP256 |     
                                   ECCP384 }                                    
                                                                                
                                   Management Key                               
                                   <type> = { AES256 | AES192 | AES128 | TDES } 
                                                                                
                                   (default: 'rsa:2048')                        

-l|--label <label>                 Label (name) of the object to operate on (or 
                                   the token label when '--initialize' is       
                                   used). Run './sc.sh --list object' to list   
                                   all available objects.                       

-n|--new-pin|--new-puk|            New user PIN, PUK, or security officer PIN.  
--new-so-pin <val>                 Use this option only in case you change an   
                                   Use this option only in case you change an   
                                   existing value. With '--initialize' or       
                                   '--store-pin' please use other options, e.g. 
                                   '-p|--pin <pin>'. See also (1) and (2).      

--p15-aid <id>                     Set the hexadecimal application id (AID) of  
                                   the PKCS#15 application to bind to. Run      
                                   './sc.sh -T opensc-p15 --list                
                                   p15-application' to list all available       
                                   PKCS#15 applications.                        

--p15-auth-id <id>                 Specify the hexadecimal auth id of the       
                                   PIN/PUK pair to use/create. Run './sc.sh -T  
                                   opensc-p15 --list p15-pin' to list all       
                                   available PKCS#15 PINs.                      

--piv-id <id>                      PIV object identifier (BER-TLV Tag)          
                                                                                
                                   <id> = { 5FC107 | 5FC102 | 5FC105 | 5FC103 | 
                                   5FC106 | 5FC108 | 5FC101 | 5FC10A | 5FC10B | 
                                   5FC109 | 7E | 5FC10C | 5FC10D | 5FC10E |     
                                   5FC10F | 5FC110 | 5FC111 | 5FC112 | 5FC113 | 
                                   5FC114 | 5FC115 | 5FC116 | 5FC117 | 5FC118 | 
                                   5FC119 | 5FC11A | 5FC11B | 5FC11C | 5FC11D | 
                                   5FC11E | 5FC11F | 5FC120 | 5FC121 | 7F61 |   
                                   5FC122 | 5FC123 }                            
                                                                                
                                   See also:                                    
                                     NIST SP 800-73-4 (Section 4.3 "Object      
                                   Identifiers")                                
                                       https://doi.org/10.6028/NIST.SP.800-73-4 
                                     Yubico                                     
                                                                                
                                   https://developers.yubico.com/yubico-piv-tool
                                   /Actions/read_write_objects.html             

--piv-slot <id>                    PIV slot (key reference value)               
                                                                                
                                   <id> = { 04 | 9A | 9C | 9D | 9E | 82 | 83 |  
                                   84 | 85 | 86 | 87 | 88 | 89 | 8A | 8B | 8C | 
                                   8D | 8E | 8F | 90 | 91 | 92 | 93 | 94 | 95 | 
                                   F9 }                                         
                                                                                
                                   See also:                                    
                                     NIST SP 800-73-4 (Section 5.1 "Key         
                                   References")                                 
                                       https://doi.org/10.6028/NIST.SP.800-73-4 
                                     Yubico                                     
                                                                                
                                   https://developers.yubico.com/PIV/Introductio
                                   n/Certificate_slots.html                     

--password <pwd>                   Password for exporting/importing             
                                   password-protected files. See also (1) and   
                                   (2).                                         

-p|--pin <pin>                     (Current or initial) user PIN. See also (1)  
                                   and (2).                                     
                                                                                
                                   ***** OpenSC PKCS#15 ('-T opensc-p15') ***** 
                                   Use '--p15-auth-id <id>' to specify the      
                                   hexadecimal auth id of PIN/PUK pair to       
                                   use/create.                                  

-P|--puk <puk>                     (Current or initial) user PUK. See also (1)  
                                   and (2).                                     
                                                                                
                                   ***** OpenSC PKCS#15 ('-T opensc-p15') ***** 
                                   Use '--p15-auth-id <id>' to specify the      
                                   hexadecimal auth id of PIN/PUK pair to       
                                   use/create.                                  

-r|--reader <id>                   Specify slot/reader to use by its decimal    
                                   ID/index <id>. Run './sc.sh --list reader'   
                                   to list all available slots/readers.         

--serial <serial no>               ***** Yubico YubiKey PIV ('-T yubico') ***** 
                                   Specify token to use by its serial number.   
                                   Run './sc.sh --list reader' to list all      
                                   available tokens.                            

-s|--so-pin <so pin>               (Current or initial) security officer PIN    
                                   (SO-PIN). See also (1) and (2).              
                                                                                
                                   ***** OpenSC PKCS#15 ('-T opensc-p15') ***** 
                                   Use '--p15-auth-id <id>' to specify the      
                                   hexadecimal auth id of PIN/PUK pair to       
                                   use/create.                                  

-S|--so-puk <so puk>               (Current or initial) security officer PUK    
                                   (SO-PUK). See also (1) and (2).              
                                                                                
                                   ***** OpenSC PKCS#15 ('-T opensc-p15') ***** 
                                   Use '--p15-auth-id <id>' to specify the      
                                   hexadecimal auth id of PIN/PUK pair to       
                                   use/create.                                  

-t|--type <type>                   Specify object type. Some types are only     
                                   available with certain token types.          
                                                                                
                                              cert  :  Certificate              
                                              data  :  Data Object              
                                            object  :  (All) Objects            
                                           privkey  :  Private Key              
                                            pubkey  :  Public Key               
                                           secrkey  :  Secret Key               
                                             chain  :  Certificate Chain        
                                            sshkey  :  SSH Key                  
                                    sshkey-rfc4716  :  SSH Key (RFC4716)        
                                         algorithm  :  Supported                
                                                       Mechanisms               
                                                       (algorithms, key         
                                                       lengths, ...)            
                                              info  :  General Information      
                                            reader  :  Available                
                                                       Reader/Slots             
                                   p15-application  :  PKCS#15 Application      
                                           p15-pin  :  PKCS#15 PIN              

________________________________ OpenSC PKCS#15 ________________________________

--opensc-p15-profile <profile>     Specify OpenSC PKCS#15 profile to load       
                                   during initialization in the form of         
                                   '<profile>[+<option>]...', e.g.              
                                   'pkcs15+onepin' in case your token only      
                                   supports one user PIN/PUK pair but no        
                                   separate SO-PIN/SO-PUK.                      
                                                                                
                                   For more information please have a look at   
                                   the manpage by running 'man pkcs15-init',    
                                   parameter "--profile".                       
                                                                                
                                   (default: 'pkcs15')                          

________________________ SmartCard-HSM / Nitrokey HSM 2 ________________________

--schsm-dkek-shares <int>              Specify number of DKEK shares (files)    
                                       that are necessary to recreate the       
                                       Device Key Encryption Key (DKEK). All    
                                       DKEK shares are needed to backup/restore 
                                       the keys. Usually you set <int> to '1'.  
                                       Leave this parameter out or set <int> to 
                                       '' to disable DKEK creation and the key  
                                       backup/restore feature. Set <int> to '0' 
                                       to create a random DKEK meaning that     
                                       keys backed up with this DKEK can only   
                                       be restored in the same HSM. Please do   
                                       not confuse this with DKEK password      
                                       n-of-m threshold scheme. Use './sc.sh    
                                       --schsm-dkek-share-create <file>' to     
                                       create the DKEK share(s).                
                                                                                
                                       (default: '')                            

--schsm-key-reference <id>             Specify key (identifier) to              
                                       backup/restore. Run 'pkcs15-tool --dump' 
                                       to show available keys to backup or free 
                                       reference ids to use for restore (in the 
                                       command's output the relevant value is   
                                       the 'Key ref' field).                    
                                                                                
                                       (default: '1')                           

--schsm-pwd-shares-threshold <int>     Threshold (minimum) number of password   
                                       shares required for deciphering the DKEK 
                                       share                                    
                                                                                
                                       (default: '')                            

--schsm-pwd-shares-total <int>         Total number of password shares used to  
                                       encipher the DKEK share                  
                                                                                
                                       (default: '')                            

______________________________ Yubico YubiKey PIV ______________________________

--yubico-management-key <key>         Specify current management key in hex     
                                      form (without '0x'). Length depends on    
                                      '--key-type <type>', e.g. 32 bytes for    
                                      AES256. See also (1) and (2).             

--yubico-new-management-key <key>     Specify new management key in hex form    
                                      (without '0x'). Length depends on         
                                      '--key-type <type>', e.g. 32 bytes for    
                                      AES256. See also (1) and (2).             

--yubico-pin-policy <pol>             PIN policy, defines if or how often a     
                                      user must confirm key-related operations  
                                      by entering the user PIN. See also:       
                                      https://docs.yubico.com/yesdk/users-manual
                                      /application-piv/pin-touch-policies.html  
                                                                                
                                      Possible values are:                      
                                                                                
                                      default  :  Default                       
                                       always  :  Always                        
                                         once  :  Once (per session)            
                                        never  :  Never                         
                                                                                
                                      (default: 'default')                      

--yubico-touch-policy <pol>           Touch policy, defines if or how often a   
                                      user must confirm key-related operations  
                                      by pushing YubiKey's button. See also:    
                                      https://docs.yubico.com/yesdk/users-manual
                                      /application-piv/pin-touch-policies.html  
                                                                                
                                      Possible values are:                      
                                                                                
                                      default  :  Default                       
                                       always  :  Always                        
                                       cached  :  Cached (A touch is not        
                                                  needed if the YubiKey had     
                                                  been touched within the       
                                                  last 15 seconds.)             
                                        never  :  Never                         
                                                                                
                                      (default: 'default')                      

================================================================================
===============================     EXAMPLES     ===============================
================================================================================

_______________________________ Initialize token _______________________________

export pin="1111"
export puk="123456"
export sopin="123456"
export sopuk="123456"
export password="secret"
export mgmtkey="010203040506070801020304050607080102030405060708"


***** OpenSC PKCS#11 ('-T opensc-p11') *****
./sc.sh -T opensc-p11 --initialize --label mytoken --pin env:pin --so-pin env:sopin


***** OpenSC PKCS#15 ('-T opensc-p15') *****
# Step 1 - Erase PKCS#15 structure (certain models only)
  ./sc.sh -T opensc-p15 --erase-card

# Step 2 - Initialize token (all models)
# Token supports a separate SO-PIN/SO-PUK pair
  ./sc.sh -T opensc-p15 --initialize --pin env:pin --puk env:puk --so-pin env:sopin --so-puk env:sopuk
# Token only supports one PIN/PUK pair
  ./sc.sh -T opensc-p15 --initialize --opensc-p15-profile pkcs15+onepin --pin env:pin --puk env:puk

# Step 3 - Finish initialization (certain models only)
  ./sc.sh -T opensc-p15 --finalize


***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm') *****
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


***** Yubico YubiKey PIV ('-T yubico') *****
./sc.sh -T yubico --initialize --pin env:pin --puk env:puk --yubico-management-key env:mgmtkey

_______________________ Generate public-private key pair _______________________

***** OpenSC PKCS#11 ('-T opensc-p11') *****
***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm') *****
./sc.sh -T <...> --keypairgen --id 10 --key-type rsa:2048
./sc.sh -T <...> --keypairgen --label mykey --key-type rsa:2048

***** OpenSC PKCS#15 ('-T opensc-p15') *****
./sc.sh -T opensc-p15 --keypairgen --id 10 --key-type rsa/2048
./sc.sh -T opensc-p15 --keypairgen --label mykey --key-type rsa/2048

***** Yubico YubiKey PIV ('-T yubico') *****
./sc.sh -T yubico --keypairgen "pubkey.pem" --format pem --piv-slot 9A --key-type RSA2048

____________________ Import certificate / key / data object ____________________

***** OpenSC PKCS#11 ('-T opensc-p11') *****
***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm') *****
./sc.sh -T <...>  --import cert.der   --type cert     --id 10   --label mycert
./sc.sh -T <...>  --import key.der    --type privkey  --id 20   --label mykey
./sc.sh -T <...>  --import data.file  --type data     --id 30   --label mydata

***** OpenSC PKCS#15 ('-T opensc-p15') *****
./sc.sh -T opensc-p15   --import cert.pem   --type cert     --id 10   --label mycert
./sc.sh -T opensc-p15   --import cert.der   --type cert     --id 10   --label mycert  --format der
./sc.sh -T opensc-p15   --import key.pem    --type privkey  --id 20   --label mykey
./sc.sh -T opensc-p15   --import key.p12    --type privkey  --id 20   --label mykey   --format pkcs12
./sc.sh -T opensc-p15   --import data.file  --type data               --label mydata

***** Yubico YubiKey PIV ('-T yubico') *****
./sc.sh -T yubico   --import cert.pem   --type cert     --piv-slot 9A   --format pem
./sc.sh -T yubico   --import key.der    --type privkey  --piv-slot 9A   --format der
./sc.sh -T yubico   --import data.file  --type data     --piv-id

_______________________ Export certificate / data object _______________________

***** OpenSC PKCS#11 ('-T opensc-p11') *****
***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm') *****
./sc.sh -T <...>    --export cert.der   --type cert   ( --id 10 | --label mycert )
./sc.sh -T <...>    --export data.file  --type data   --label mydata

***** OpenSC PKCS#15 ('-T opensc-p15') *****
./sc.sh -T opensc-p15   --export cert.der   --type cert   --id 10
./sc.sh -T opensc-p15   --export data.file  --type data   --label mydata

***** Yubico YubiKey PIV ('-T yubico') *****
./sc.sh -T yubico   --export cert.der   --type cert   --piv-slot 9A   --format der
./sc.sh -T yubico   --export cert.pem   --type cert   --piv-slot 9A   --format pem
./sc.sh -T yubico   --export data.file  --type data   --piv-id 5FC108

____________________ Delete certificate / key / data object ____________________

***** OpenSC PKCS#11 ('-T opensc-p11') *****
***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm') *****
./sc.sh -T <...>  --delete  --type cert     ( --id 10 | --label mycert )
./sc.sh -T <...>  --delete  --type privkey  ( --id 20 | --label mykey )
./sc.sh -T <...>  --delete  --type data     --label mydata  --data-application-name <name>
./sc.sh -T <...>  --delete  --type data     --data-oid <oid>

***** OpenSC PKCS#15 ('-T opensc-p15') *****
./sc.sh -T opensc-p15   --delete  --type cert     --id 10
./sc.sh -T opensc-p15   --delete  --type privkey  --id 20
./sc.sh -T opensc-p15   --delete  --type data     --label mydata  --data-application-name <name>
./sc.sh -T opensc-p15   --delete  --type data     --data-oid <oid>

***** Yubico YubiKey PIV ('-T yubico') *****
./sc.sh -T yubico --delete --type cert --piv-slot 9A

____________________ PIN Management (Change/Reset/Unblock) _____________________

export oldpin="1111"
export newpin="2222"
export puk="123456"
export sopin="123456"

./sc.sh -T <...> --change-pin  --pin env:oldpin    --new-pin env:newpin
./sc.sh -T <...> --reset-pin   --so-pin env:sopin  --new-pin env:newpin
./sc.sh -T <...> --unblock-pin --puk env:puk       --new-pin env:newpin

_____ Backup and restore private key (SmartCard-HSM / Nitrokey HSM 2 only) _____

./sc.sh -T schsm  --schsm-backup  wrap-key.bin  --schsm-key-reference 1
./sc.sh -T schsm  --schsm-restore wrap-key.bin  --schsm-key-reference 10

================================================================================
================================     NOTES     =================================
================================================================================

_____________________________________ (1) ______________________________________

Minimum/Maximum length and allowed characters depend on the token type and model. For more information please also consult your token's data sheet or manual.

***** OpenSC PKCS#11 ('-T opensc-p11') *****
***** OpenSC PKCS#15 ('-T opensc-p15') *****
PIN:    6 - 8 characters, digits (0-9) only
PUK:    Exactly 8 characters, digits only
SO-PIN: 6 - 8 characters, digits only


***** OpenSC PKCS#15 ('-T opensc-p15') *****
PUK:    8 - 16 (*) characters, digits only
SO-PUK: 8 - 16 (*) characters, digits only

(*) To conform with 'FIPS-201 (PIV Card)' standard it must be exactly 8 characters long.


***** SmartCard-HSM / Nitrokey HSM 2 ('-T schsm') *****
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
  https://github.com/OpenSC/OpenSC/wiki/SmartCardHSM#using-pkcs11-tool
  https://raymii.org/s/articles/Get_Started_With_The_Nitrokey_HSM.html


***** Yubico YubiKey PIV ('-T yubico') *****
PIN:    6 - 8 bytes, ASCII characters only
PUK:    6 - 8 bytes, any value (ASCII characters only recommended)
Management Key:
        Length depends on the key type ('--key-type <type>').
        Exactly 32 (AES128), 48 (AES192, TDES), 64 (AES256)
        characters, hexadecimal (0-9 a-f) only.

See also:
  https://docs.yubico.com/yesdk/users-manual/application-piv/pin-puk-mgmt-key.html


***** FIPS 201 (PIV Card) *****
PIN:    6 - 8 bytes, only ASCII numbers 0-9 ('0x30' - '0x39')
PUK:    8 bytes, any binary value ('0x00' - '0xFF')

See also:
  NIST SP 800-73-4 (Section "2.4.3 Authentication of an Individual")
  https://doi.org/10.6028/NIST.SP.800-73-4

_____________________________________ (2) ______________________________________

It is highly recommended to pass credentials only via environment variables. To do so, just set this value to 'env:<VAR>' (without '' <>) where <VAR> is your environment variable's name.

Please note that passing credentials in clear-text form can be highly insecure as any other user/process could display the command line of this application by using system utilities like 'ps'.

Example: You would like to pass the password '123456'.

  Via an environment variable (preferred)
    > export mypwd="123456"
    > ... "env:mypwd"

  Directly, in clear-text form (NOT recommended)
    > ... "123456"
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/fkemser/SCwrapper/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the **GNU General Public License v3.0 (or later)**. See [`LICENSE`][license-url] for more information.  

> :warning: The license above does not apply to the files and folders within the library directory `/lib`. Please have a look at the `LICENSE` file located in the root directory of each library to get more information.

> :warning: The license above may not apply to some files within the TeX letter directory `/tex`. Please have a look at the `SPDX-FileCopyrightText` and `SPDX-License-Identifier` headers in each file to get more information.

> :warning: The license above does not apply to the sample logo file `/tex/logo.png`. For more information please have a look at [Logoipsum's terms of license](https://logoipsum.com/license).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/fkemser/SCwrapper](https://github.com/fkemser/SCwrapper)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

###
* [Dialog](https://invisible-island.net/dialog/dialog.html)
* [GnuTLS](https://www.gnutls.org/)
* [OpenSC](https://github.com/OpenSC/OpenSC)
* [OpenSC (PKCS#11 module)](https://github.com/OpenSC/libp11)
* [OpenSSL](https://www.openssl.org/)
* [PCSClite](https://pcsclite.apdu.fr/)
* [USB PC/SC CCID driver](https://ccid.apdu.fr/)
* [Yubico PIV tool (PKCS#11 module)](https://developers.yubico.com/yubico-piv-tool/)
* [YubiKey Manager](https://developers.yubico.com/yubikey-manager/)

###
* [The LaTeX Project](https://www.latex-project.org/)
* [TeX Live - TeX Users Group (tug.org)](https://www.tug.org/texlive/)
* [LuaTeX](https://www.luatex.org/)

###
* [environ (CTAN)](https://www.ctan.org/pkg/environ)
* [microtype (CTAN)](https://www.ctan.org/pkg/microtype)
* [pgf (CTAN)](https://www.ctan.org/pkg/pgf)
* [tcolorbox (CTAN)](https://www.ctan.org/pkg/tcolorbox)
* [tikzfill (CTAN)](https://www.ctan.org/pkg/tikzfill)
* [trimspaces (CTAN)](https://www.ctan.org/pkg/trimspaces)

###
* [othneildrew/Best-README-Template](https://github.com/othneildrew/Best-README-Template)
* [Ileriayo/markdown-badges](https://github.com/Ileriayo/markdown-badges)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/fkemser/SCwrapper.svg?style=for-the-badge
[contributors-url]: https://github.com/fkemser/SCwrapper/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/fkemser/SCwrapper.svg?style=for-the-badge
[forks-url]: https://github.com/fkemser/SCwrapper/network/members
[stars-shield]: https://img.shields.io/github/stars/fkemser/SCwrapper.svg?style=for-the-badge
[stars-url]: https://github.com/fkemser/SCwrapper/stargazers
[issues-shield]: https://img.shields.io/github/issues/fkemser/SCwrapper.svg?style=for-the-badge
[issues-url]: https://github.com/fkemser/SCwrapper/issues
[license-shield]: https://img.shields.io/github/license/fkemser/SCwrapper.svg?style=for-the-badge
[license-url]: https://github.com/fkemser/SCwrapper/blob/main/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username

[SHlib-url]: https://github.com/fkemser/SHlib
[SHtemplateLIB-url]: https://github.com/fkemser/SHtemplateLIB

[iso639-1-url]: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

[LaTeX-shield]: https://img.shields.io/badge/latex-%23008080.svg?style=for-the-badge&logo=latex&logoColor=white
[LaTeX-url]: https://www.latex-project.org/
[Shell Script-shield]: https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white
[Shell Script-url]: https://pubs.opengroup.org/onlinepubs/9699919799/