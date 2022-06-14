from flask import Flask, jsonify
import sqlite3
from mysql.connector import connect, Error
import mysql.connector
import json
from flask import request as req

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="root",
  database="translator"
)

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = True

data = {

}
@app.route('/get_osetian_word', methods=['POST'])
def get_os_word():
    if req.method=='POST':
        request_data = req.data
        request_data = json.loads(request_data.decode('utf-8'))
        rus_word = request_data['russian_word']
        mycursor = mydb.cursor()
        print(rus_word)
        mycursor.execute(f"select * from russian_words where russian_word = '{rus_word}'")
        myres = mycursor.fetchall()
        mydb.commit()
        print(myres)
        mycursor.execute(f'select osetian_word from osetian_words where id = {myres[0][2]}')
        myword = mycursor.fetchall()
        return jsonify(myword)

@app.route('/get_russian_word', methods=['POST'])
def get_ru_word():
    if req.method=='POST':
        request_data = req.data
        request_data = json.loads(request_data.decode('utf-8'))
        os_word = request_data['osetian_word']
        mycursor = mydb.cursor()
        mycursor.execute(f'select * from osetian_words where osetian_word = "{os_word}"')
        myres = mycursor.fetchall()
        print(myres)
        mydb.commit()
        mycursor.execute(f'select russian_word from russian_words where osetian_words_id = {myres[0][0]}')
        myword = mycursor.fetchall()
        return jsonify(myword)
    
@app.route('/words', methods=['POST'])
def get_list():
    mycursor = mydb.cursor()
    request_data = req.data
    request_data = json.loads(request_data.decode('utf-8'))
    offset = request_data['offset']
    mycursor.execute(f'select * from osetian_words limit 50 offset {offset}')
    myresult = mycursor.fetchall()
    mydb.commit()
    word = []
    for i in myresult:
        rus_words = []
        mycursor.execute(f'select * from russian_words where osetian_words_id = {i[0]}')
        myrus = mycursor.fetchall()
        mydb.commit()
        for j in myrus:
            rus_words.append(j[1])
        data = {
            
                'id':i[0], 
                'osetian_word':i[1],
                'transcription':i[2],
                'russian_words':rus_words
                
        }
        word.append(data)
    return jsonify(word)


if __name__ =='__main__':
    app.run()

