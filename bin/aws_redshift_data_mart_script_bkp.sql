--##############################################################################################
--### Skip the Dishes - Hackaton VanHack Recruiting Fair 2.0 Sao Paulo 2018
--### Candidate: Leonardo Mairene Muniz - Data Engineer (253)
--### Date: 2018-06-24
--### Content History:
--### 	v1.0: Skip the Dishes - Data Warehouse Script Generation (AWS Redshift Spectrum)
--##############################################################################################

-- Drop table PUBLIC.DIM_TIME
drop table public.dim_time;

-- Create table PUBLIC.DIM_TIME
create table public.dim_time(
	TIME_ID integer not null distkey sortkey,
	DATE char(10) not null,
	DAY smallint not null,
	WEEK smallint not null,
	MONTH_NUMBER smallint not null,
	MONTH char(9) not null,
	YEAR smallint not null);

-- Load data from AWS S3 - Skip the Dishes bucket, file DIM_TIME.csv into table PUBLIC.DIM_TIME
	copy public.dim_time from 's3://skip20180624/DIM_TIME.csv' 
		credentials 'aws_iam_role=arn:aws:iam::848967360618:role/myRedshiftRole'
		delimiter ',' region 'sa-east-1';

-- Drop table PUBLIC.DIM_CUSTOMER
drop table public.dim_customer;

-- Create table PUBLIC.DIM_CUSTOMER
create table public.dim_customer(
	CUST_ID integer not null distkey sortkey,
	CUST_NM char(150) not null,
	CUST_GENDER char(6) not null,
	CITY char(100) not null,
	PROVINCE char(100) not null,
	COUNTRY char(100) not null);

-- Load data from AWS S3 - Skip the Dishes bucket, file DIM_CUSTOMER.csv into table PUBLIC.DIM_CUSTOMER
	copy public.dim_customer from 's3://skip20180624/DIM_CUSTOMER.csv' 
		credentials 'aws_iam_role=arn:aws:iam::848967360618:role/myRedshiftRole'
		delimiter ',' region 'sa-east-1';			

-- Drop table PUBLIC.DIM_PRODUCT
drop table public.dim_product;

-- Create table PUBLIC.DIM_PRODUCT
create table public.dim_product(
	PROD_ID integer not null distkey sortkey,
	PROD_NM char(150) not null,
	PROD_BRAND char(150) not null,
	PROD_CAT_NM char(100) not null,
	PROD_PRICE decimal(8,2) not null,
	PROD_CURRENCY char(3) not null
	);

-- Load data from AWS S3 - Skip the Dishes bucket, file DIM_PRODUCT.csv into table PUBLIC.DIM_PRODUCT
	copy public.dim_product from 's3://skip20180624/DIM_PRODUCT.csv' 
		credentials 'aws_iam_role=arn:aws:iam::848967360618:role/myRedshiftRole'
		delimiter ',' region 'sa-east-1';		

-- Drop table PUBLIC.FACT_SALES
drop table public.fact_sales;

-- Create table PUBLIC.FACT_SALES
create table public.fact_sales(
	FACT_SALE_ID integer not null distkey sortkey,
	TIME_ID integer not null,
	CUST_ID integer not null,
	PROD_ID char(100) not null,
	QTY_SOLD decimal(8,2) not null,
	TOT_AMOUNT_SOLD decimal(8,2) not null,
	CURRENCY_TYPE char(3) not null
	);

-- Load data from AWS S3 - Skip the Dishes bucket, file FACT_SALES.csv into table PUBLIC.FACT_SALES
	copy public.fact_sales from 's3://skip20180624/FACT_SALES.csv' 
		credentials 'aws_iam_role=arn:aws:iam::848967360618:role/myRedshiftRole'
		delimiter ',' region 'sa-east-1';			