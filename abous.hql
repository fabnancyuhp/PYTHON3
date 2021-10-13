-- 1er dataset à créér 
create temporary table dataiku.Etape1_tmp as 
select 
      rce
     ,kn_individuprofessionel
     ,raisonsocialeentreprise
     ,naf,date_decreation
     ,heure_de_creation
     ,cast(date_decreation as date) as date_creat
  from dataiku.verfif_schem_fab_er_certifier_
  where cast(date_decreation as date)>='2021-03-09';
  
 -- 2ème dataset à créér 
create temporary table dataiku.Etape2_tmp as
select kn_individuprofessionel
      ,operateur_tel
      ,territoire_tel
      ,date_attribution_tel
  from dataiku.verfif_schem_fab_er_certifier_
  where cast(date_decreation as date)<'2021-03-09';
  
-- fusion des 2 datasets
insert overwrite table dataiku.${projectKey}_${Instance}_Etape_final
select a.*,b.*
       from dataiku.Etape1_tmp a
  left join dataiku.Etape2_tmp b
  on a.kn_individuprofessionel=b.kn_individuprofessionel
