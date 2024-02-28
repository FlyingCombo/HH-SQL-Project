#️импортируем нужные библиотеки
import sqlite3
import pandas as pd
#from pandas_profiling import ProfileReport

#️подключение к бд
con = sqlite3.connect('hh_project.db', timeout=10)
cur = con.cursor()

#️загрузка необходимых столбцов в dataframe
df = pd.read_excel('vacancies_data_for_analysis.xlsx', usecols=['id', 'name', 'area.id', 'address.metro.station_name', 'salary.from', 'salary.to',
'address.raw', 'experience.name', 'schedule.name', 'employment.name', 'employer.id', 'alternate_url', 'created_at'])

#типы данных в прочитанном dataframe
df.dtypes

#типы данных в прочитанном dataframe
df.dtypes

#первые 10 строк 
df.head(10)

#индекс строк
df.index

#столбцы
df.columns

#Преданализ данных
df.describe()

#количество NULL записей
df.isnull().sum()

#проверка дубликатов
df.duplicated()

#️загрузка таблицы в БД, указав название таблицы. 
df.to_sql(con=con, name='vacancies_data_for_analysis', index=False, if_exists = 'replace')

#️считывание данных из таблицы (проверка)
data_test = cur.execute('select * from vacancies_data_for_analysis')
con.commit()
cur.fetchall()

#загрузка справочников
df_area = pd.read_excel('area.xlsx')
df_employer = pd.read_excel('employer.xlsx')

#проверки
df_area.dtypes
df_area.head(10)
df_area.index
df_area.columns
df_area.describe()
df_area.isnull().sum()
df_area.duplicated()

df_employer.dtypes
df_employer.head(10)
df_employer.index
df_employer.columns
df_employer.describe()
df_employer.isnull().sum()
df_employer.duplicated()

#запись в БД
df_area.to_sql(con=con, name='area', index=False, if_exists = 'replace')
df_employer.to_sql(con=con, name='employer', index=False, if_exists = 'replace')

#чтение из area
data_test = cur.execute('select * from area')
con.commit()
cur.fetchall()

#чтение из employer
data_test = cur.execute('select * from employer')
con.commit()
cur.fetchall()