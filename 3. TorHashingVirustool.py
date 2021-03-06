#PROJECT
""" malware analytic tools in python
    By Hud Seidu Daannaa, CEH, GCHQ, MSc Information security.
    This script comprizes of TOR, HASH (MD5, SHA1), SSDEEP, VIRUSTOOL
    
    STEPS
    +. The main aim of thisis to broaden the understanding by using code (python) and limiting the
       the use of automated tools which tend to skip certain vital information
"""
#LIBRARIES USED
from __future__ import print_function
from virus_total_apis import PublicApi as VirusTotalPublicApi
import json

#USEFUL FUNCTIONS      
def anonymity_TOR():
    """
    To help conceal one’s identity whiles performing research through a given browser. 
    Tor, The Onion Router, is a network system which helps to provide anonymity while 
    surfing or researching online, by routing traffic through the systems of volunteers 
    worldwide, in a way that will hide a client’s IP, location or usage from anybody who 
    might be performing network analysis or monitoring on you
    """
    import socket, socks
    try:
        print ' '
        print ' '
        print '[-] establishing TOR routing ...'
        socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, "127.0.0.1", 9050, True)
        print '[-] Done!'
        print ' '
    except:
        print '[-] unable to establish TOR routing ...'
        sys.close()
    print '____'
    try:
        print '[-] Passing normal traffic through TOR network '
        socket.socket = socks.socksocket
        print '[-] Done!'
    except:
        print '[-] unable to pass trafic ...'
        sys.close()
    print '____'
    print '[-] Tor connection established'
    
def hash_SHA256(input_=''):
    from Crypto.Hash import SHA256
    h = SHA256.new()
    h.update(input_)
    h2 = h.digest()
    print 'original: ', input_
    print 'digest  : ', h2
    return h

def hash_MD5(input_=''):
    import hashlib
    return hashlib.md5(input_).hexdigest()

def ssdeep_(input_=''):
    """
    SSDEEP generates a hash value that tries to detect the level of similarity 
    between two given files at the binary level.This is different from a cryptographic 
    hash  because a cryptographic hash can check exact matches (or non-matches).
    """
    #pip install ssdeep
    import ssdeep
    return ssdeep.hash(input_)

#PARAMETERS
#Api key is concealed for privacy reasons
api_key = '********************************************************************'
input_  = "X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*"

#HASHING THE INPUT
input_hashed  = hash_MD5(input_)
input_hashed_fuzzy = ssdeep_(input_)

#USING API_KEY & HASH INPUT IN VIRUS-TOTAL FUNCTION
"""
VirusTotal sums many antivirus products and online scan engines which helps to check 
for malware or viruses to verify against any false positives. It also allows the automation 
of some of its online features such as uploading urls and samples
"""
total_v = VirusTotalPublicApi(api_key).get_file_report(input_hashed)

#PRINT INFORMATION IN JSON FORMAT
print(json.dumps(response, sort_keys=False, indent=4))
