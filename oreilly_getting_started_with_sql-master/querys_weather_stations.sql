select * from station_data;

-- selecionando os registros da tabela apenas do ano 2010
select * from station_data
where year = 2010;

-- selecionando os registros de todos so anos da tabela, exceto 2010
select * from station_data
where year != 2010;

-- ou

select * from station_data
where year <> 2010;

-- declarando intervalos inclusivos
select *from station_data
where year between 2005 and 2010;

-- todos os registros entre os anos 2005 e 2010, inclusive
select * from station_data
where year >= 2005 and year <= 2010; 

-- todos os registros entre os anos 2005 e 2010, exclusivamente
select * from station_data
where year > 2005 and year < 2010; 

-- selecionando registros dos meses 3, ou 6, ou 9, ou 12
select * from station_data
where month = 3
or month = 6
or month = 9
or month = 12;

-- mesma consulta anterior utilizando IN
select * from station_data
where month in (3, 6, 9, 12);

-- selecionando registros exceto dos meses 3, ou 6, ou 9, ou 12 utilizando IN
select * from station_data
where month not in (3, 6, 9, 12);

-- selecionando os meses divisivéis por 3
select * from station_data
where month % 3 = 0;

-- manipulando texto com where
-- filtar um REPORTE_CODE específico
select * from station_data
where report_code = '513A63';

select * from station_data
where report_code in ('513A63', '1F8A7B', 'EF616A');

-- verificando que todos os registros da coluna REPORT_CODE têm 6 digitos
select * from station_data
where length(report_code) != 6;

-- selecionando todos ao código que começam com a letra 'A' usando LIKE
select * from station_data
where report_code like 'A%';

-- selecionando todos ao código que começam com a letra 'B' e a segunda letra 'C' usando LIKE
select * from station_data
where report_code like 'B_C%';

-- usando where com booleanos
select * from station_data
where tornado = true and hail = true;

select * from station_data
where tornado = 1 and hail = 1;

select * from station_data
where tornado and hail;

select * from station_data
where not tornado and hail;

-- manipulando null
-- todos os registros null SNOW_DEPTH
select * from station_data
where snow_depth is null;

-- todos os registros não nullo SNOW_DEPTH
select * from station_data
where snow_depth is not null;

-- consultando todos os registros em que PRECIPITATION for menor que 0,5
select * from station_data
where precipitation <= 0.5;

-- consultando todos os registros em que PRECIPITATION for menor que 0,5 ou nulos
select * from station_data
where precipitation is null or precipitation <= 0.5;