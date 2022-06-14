from dataclasses import replace
from getpass import getpass
from mysql.connector import connect, Error
import re

import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="root",
  database="translator"
)

mycursor = mydb.cursor()
f = open('24.txt', 'r')
l = [line.strip() for line in f]
for val,i in enumerate(l):
    temp = re.split('/', i)
    osetian = temp[0].replace('"', "")
    trans = temp[1].replace('"', "")
    print(osetian,trans)
    mycursor.execute(f'INSERT INTO osetian_words (osetian_word, transcripiton ) VALUES ("{osetian}","{trans}")')
    mydb.commit()
    id = mycursor.lastrowid
    if temp[2].__contains__(';'):
        russia_temp = re.split(';', temp[2])
    else:
        russia_temp = re.split(',', temp[2])
        

    for j in russia_temp:
        j = j.strip()
        mycursor.execute(f'INSERT INTO russian_words (osetian_words_id , russian_word ) VALUES ({id},"{j}")')
    mydb.commit()

mydb.commit()