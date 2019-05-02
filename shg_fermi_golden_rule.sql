--create database fermi_golden_rule;

use fermi_golden_rule


--MAKING TABLES
create table matrix_elements (
calc_id int identity(1,1) primary key,
structure_id int not null,
amp_x float not null,
amp_y float not null,
amp_z float not null,
k_ind int not null,
band1 int not null,
band2 int not null,
descriptor varchar(100) null
);

create table structures (
structure_id int  identity(1,1) primary key,
stoichiometry varchar(30) not null,
strain float,
strain_direction varchar(10) not null check (strain_direction in('x','y','bi','none')));


--INSERTING INITIAL DATA
insert into structures values ('MoS2',0.0, 'y'), ('MoS2',3.0, 'y');
insert into matrix_elements values (1,3.91E-06, 2.92E-06, 1.66E-12, 155, 13, 15, 'MoS2 0 strain at K with H/L+1'),
(2,5.64E-06, 1.12E-07, 4.81E-16, 155, 13, 15, 'MoS2 3 ystrain at K with H/L+1'),
(1,1.58E-11, 6.95E-11, 1.67E-22, 1, 13, 14, 'MoS2 0 strain at G with H/L'),
(2,9.71E-24, 1.11E-13, 5.05E-08, 1, 13, 14, 'MoS2 3 ystrain at G with H/L')


--CREATE SHG DATA TABLE FROM CSV
create table shg_data (
shg_calc_ind int primary key,
stoichiometry varchar(30) not null,
strain float,
strain_direction varchar(10) not null check (strain_direction in('x','y','bi','none')),
range1 float,
range2 float,
range3 float);
BULK INSERT shg_data
    FROM 'C:\Users\Kory\Google Drive\Jupyter_Notebook\TMD_Strain_Paper\BSE_SHG_values.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    ERRORFILE = 'C:\Users\Kory\Google Drive\Jupyter_Notebook\TMD_Strain_Paper\ErrorRows.csv',
    TABLOCK
    )


--ADD NEW DATA
use fermi_golden_rule

insert into matrix_elements values (2,
 4.564762147984951E-014,
  9.437910798287227E-024,
  3.198553279184626E-022,
1, 13, 15, 
'MoS2 3 strain at G with H/L+1');

select * from matrix_elements