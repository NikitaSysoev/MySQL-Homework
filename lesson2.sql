use geodata;

alter table _cities change city_id id int not null primary key auto_increment;

alter table _countries change country_id id int not null primary key auto_increment;

alter table _regions change region_id id int not null primary key auto_increment;

alter table _cities add constraint fk_CountriesCities foreign key (country_id) references _countries(id);

alter table _cities change region_id region_id int not null;

SET foreign_key_checks = 0;

alter table _cities add constraint fk_RegionCities foreign key (region_id) references _regions(id);

SET foreign_key_checks = 1;

alter table _regions add constraint fk_CountriesRegions foreign key (country_id) references _countries(id);

alter table _regions change title_ru title varchar(150) not null;

create index idx_title on _regions(title);

alter table _regions 
	drop column title_ua,  
	drop column title_be, 
    drop column title_en, 
    drop column title_es, 
    drop column title_pt, 
    drop column title_de, 
    drop column title_fr, 
    drop column title_it, 
    drop column title_pl, 
    drop column title_ja, 
    drop column title_lt, 
    drop column title_lv, 
    drop column title_cz;

alter table _cities change title_ru title varchar(150) not null;

create index idx_title on _cities(title);

alter table _cities change area_ru area varchar(150) null;

alter table _cities change region_ru region varchar(150) null;

alter table _cities
	drop column title_ua,  
	drop column title_be, 
    drop column title_en, 
    drop column title_es, 
    drop column title_pt, 
    drop column title_de, 
    drop column title_fr, 
    drop column title_it, 
    drop column title_pl, 
    drop column title_ja, 
    drop column title_lt, 
    drop column title_lv, 
    drop column title_cz,
    drop column area_ua,  
	drop column area_be, 
    drop column area_en, 
    drop column area_es, 
    drop column area_pt, 
    drop column area_de, 
    drop column area_fr, 
    drop column area_it, 
    drop column area_pl, 
    drop column area_ja, 
    drop column area_lt, 
    drop column area_lv, 
    drop column area_cz,
    drop column region_ua,  
	drop column region_be, 
    drop column region_en, 
    drop column region_es, 
    drop column region_pt, 
    drop column region_de, 
    drop column region_fr, 
    drop column region_it, 
    drop column region_pl, 
    drop column region_ja, 
    drop column region_lt, 
    drop column region_lv, 
    drop column region_cz;
 
    
alter table _countries change title_en title varchar(150) not null;

create index idx_title on _countries(title);

alter table _countries 
	drop column title_ua,  
	drop column title_be, 
    drop column title_ru, 
    drop column title_es, 
    drop column title_pt, 
    drop column title_de, 
    drop column title_fr, 
    drop column title_it, 
    drop column title_pl, 
    drop column title_ja, 
    drop column title_lt, 
    drop column title_lv, 
    drop column title_cz;