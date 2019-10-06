# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import pandas as pd
import mysql.connector



mydb       = mysql.connector.connect(
  host     = "localhost",
  user     = "root",
  passwd   = "Esther99!",
  database = "HW3"
)

print(mydb)
mycursor = mydb.cursor()
mycursor.execute("show tables;")
mycursor.close()

for x in mycursor:   print(x)

sql_query = "SELECT * FROM intl_football;"
mycursor = mydb.cursor()
mycursor.execute(sql_query)
myresult = mycursor.fetchall()
mycursor.close()


dta_at_country_date = pd.DataFrame(myresult)



# In[]
#data_url           = 'http://bit.ly/2cLzoxH'
#dta_at_country_year = pd.read_csv(data_url)
#dta_at_country_year.to_excel('D:\data_country_db_at_country_year.xlsx')
