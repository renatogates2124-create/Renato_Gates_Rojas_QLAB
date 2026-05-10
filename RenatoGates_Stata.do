clear all
set more off
cls 
/*==============================================================================
                     Evaluación de conocimientos Stata
                              Renato Gates
==============================================================================*/
*Directorio de trabajo
gl main "C:\Users\RENATO\Desktop\IPA\Stata_interns"
gl bases "$main/Bases"
gl resultados "$main/resultados"

log using "$main/resultados"
import delimited "$bases\student_test_data_final.csv"
*Limpieza
mdesc
drop if girl ==.
drop if spelling_correct ==.
/*==============================================================================
En relación al puntaje de lectura de palabras, dado que se trata de 24 preguntas
,considero que "-98" es igual a "-99" en que son valores atípicos. Sería algo
que confirmaría con respecto a "-98", pero en esta ocasión procederé de 
esta manera.          
==============================================================================*/
drop if w_correct ==-98
drop if w_correct ==-99
drop if s_correct ==-99
forvalues x = 1/8{
drop if a`x'_correct=="."
}
forvalues x = 1/8{
generate a`x'_correct_num = .
replace a`x'_correct_num = 1 if a`x'_correct == "1"
replace a`x'_correct_num = 2 if a`x'_correct == "2"
replace a`x'_correct_num = 3 if a`x'_correct == "3"
replace a`x'_correct_num = 0 if a`x'_correct == "NONE"
drop a`x'_correct
rename a`x'_correct_num a`x'_correct
}
egen puntaje_total = rsum(w_correct s_correct a1_correct a2_correct a3_correct a4_correct a5_correct a6_correct a7_correct a8_correct spelling_correct)

recode puntaje_total (80/98=1 "A") (60/79=2 "B") (40/59=3 "C") (20/39=4 "D") (0/19=5 "F"), gen(puntaje_letters)
lab var puntaje_letters "Puntaje en letra"
*Mencionan los puntajes estandarizados de los del grupo de control*
/*==============================================================================
Tuve muchos problemas  al usar el puntaje z 
solo del control a la hora delanálisis de datos. Por lo que lo dejaré como 
comentario y utilizare el puntaje total, porque con eso si se encuentra 
corriendo las regresiones.        
==============================================================================*/
*sum puntaje_total if tracking==0, detail
*gen puntaje_control = puntaje_total if tracking==0
egen Z = std(puntaje_total)
save "$bases/base_student_limpia.dta",replace 
/*==============================================================================
Analizamos ahora la base de los profesores        
==============================================================================*/
clear all
use "$bases/teacher_data_final"
*limpiamos
mdesc
/*==============================================================================
No considero que se deba eliminar los números que no son entero, pero en este
caso también preguntaría si es o no necesario realizarlo.        
==============================================================================*/
drop if yrstaught==.
bysort schoolid: egen avg_yrstaught = mean(yrstaught)
*reshape wide schoolid, i(yrstaught) j(teacherid)
/*==============================================================================
Con un poco más de tiempo, hubiese intentado pausadamente realizar correctamente
el reshape wide, por lo que de no haber regresado a intentar modificarlo fue
por el tiempo.    
==============================================================================*/
save "$bases/base_teachers_limpia.dta",replace 
/*==============================================================================
Merge      
==============================================================================*/
clear all
use "$bases/base_student_limpia.dta"
merge m:m schoolid using "$bases/base_teachers_limpia.dta", nogen
save "$bases/base_final_limpia.dta",replace 
/*==============================================================================
Análisis de los datos       
==============================================================================*/
clear all
use "$bases/base_final_limpia.dta"
encode zone, gen(zoneid)
/*==============================================================================
Pensé en intentar xtset para hacer un modelo de efectos fijos, pero creo que
no sería oportuno un panel de 2015-2017 así que creo que se refieren solo a 
la variable zone.     
==============================================================================*/
reg Z tracking i.zoneid, robust
eststo Modelo1
reg Z tracking i.zoneid girl hh_income, robust
eststo Modelo2
outreg2 [Modelo1 Modelo2] using IPA.doc, replace title("Interpretación de los Resultados")
log close















