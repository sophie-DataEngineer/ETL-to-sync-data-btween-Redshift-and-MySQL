import boto3, json
from pg import DB 

#set up secretsmanager to get credentials for redshift
secret_name = 'ecommerce4redshift'
region_name = 'ap-southeast-2'

session = boto3.session.Session()
client = session.client(service_name = 'secretsmanger', region_name= region_name)

get_secret_response = client.get_secret_value(SecretId=secret_name)

#turn string to dictionary via json.load
creds = json.loads(get_secret_response['SecretString'])

username = creds['username']
pwd = creds['password']
host = creds['host']

#connection
db = DB(dbname='dev', host=host, port=5439, user= username, passwd=pwd)

#upsert data from RDS transaction data to Redshift DWH dimension tables
merge_query = """
			begin;
			copy mysql_dwh_staging.orders from 's3://ecommerce-rds-dwh/orders/current/orders.csv'
			iam_role 'arn:aws:iam::318140223133:role/redshiftRole'
			CSV QUOTE '\"' DELIMITER ','
			acceptinvchars;

			delete from mysql_dwh.orders 
			using mysql_dwh_staging.orders
			where mysql_dwh_staging.orders.order_id = mysql_dwh.orders.order_id;

			insert into mysql_dwh.orders select * from mysql_dwh_staging.orders;

			truncate table mysql_dwh_staging.orders;

			end;
			"""
db.query(merge_qry)