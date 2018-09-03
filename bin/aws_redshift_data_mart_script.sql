select * from pg_namespace;

select distinct(tablename) from pg_table_def
where schemaname = 'public';

select * from STL_LOAD_ERRORS

drop table public.dim_time;

create table public.dim_time(
	TIME_ID integer not null distkey sortkey,
	DATE char(10) not null,
	DAY smallint not null,
	WEEK smallint not null,
	MONTH_NUMBER smallint not null,
	MONTH char(9) not null,
	YEAR smallint not null);

	copy public.dim_time from 's3://skip20180624/DIM_TIME.csv' 
		credentials 'aws_iam_role=arn:aws:iam::848967360618:role/myRedshiftRole'
		delimiter ',' region 'sa-east-1';


drop table public.dim_customer;

create table public.dim_customer(
	CUST_ID integer not null distkey sortkey,
	CUST_NM char(150) not null,
	CUST_GENDER char(6) not null,
	CITY char(100) not null,
	PROVINCE char(100) not null,
	COUNTRY char(100) not null);

	copy public.dim_customer from 's3://skip20180624/DIM_CUSTOMER.csv' 
		credentials 'aws_iam_role=arn:aws:iam::848967360618:role/myRedshiftRole'
		delimiter ',' region 'sa-east-1';			



drop table public.dim_product;

create table public.dim_product(
	PROD_ID integer not null distkey sortkey,
	PROD_NM char(150) not null,
	PROD_BRAND char(150) not null,
	PROD_CAT_NM char(100) not null,
	PROD_PRICE decimal(8,2) not null,
	PROD_CURRENCY char(3) not null
	);

	copy public.dim_product from 's3://skip20180624/DIM_PRODUCT.csv' 
		credentials 'aws_iam_role=arn:aws:iam::848967360618:role/myRedshiftRole'
		delimiter ',' region 'sa-east-1';		


drop table public.fact_sales;

create table public.fact_sales(
	FACT_SALE_ID integer not null distkey sortkey,
	TIME_ID integer not null,
	CUST_ID integer not null,
	PROD_ID char(100) not null,
	QTY_SOLD decimal(8,2) not null,
	TOT_AMOUNT_SOLD decimal(8,2) not null,
	CURRENCY_TYPE char(3) not null
	);

	copy public.fact_sales from 's3://skip20180624/FACT_SALES.csv' 
		credentials 'aws_iam_role=arn:aws:iam::848967360618:role/myRedshiftRole'
		delimiter ',' region 'sa-east-1';			