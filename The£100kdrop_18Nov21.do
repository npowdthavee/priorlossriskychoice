clear all
import delimited "/Users/nattavudhpowdthavee/Dropbox/The £100k drop/the100kdrop_updated_Oct2019.txt", encoding(ISO-8859-1)clear

global out_dir "/Users/nattavudhpowdthavee/Dropbox/The £100k drop/Results"

**The £100k drop project


**Generate the dispersion index (variance over mean) for choices that are available 


sort id question
by id: gen remaining_t_1 = remaining[_n-1]
by id: gen remaining_t_2 = remaining[_n-2]
by id: gen remaining_t1 = remaining[_n+1]
 
replace remaining_t_1 = 100 if question==1
replace remaining_t_2 = 100 if question==2
 
gen d_index = 4*(100^2 - (c1^2+c2^2+c3^2+c4^2))/(100^2*(4-1)) if question==1
replace d_index = 4*(remaining_t_1^2 - (c1^2+c2^2+c3^2+c4^2))/(remaining_t_1^2*(4-1)) if question>=2 & question<=3
replace d_index = 3*(remaining_t_1^2 - (c1^2+c2^2+c3^2))/(remaining_t_1^2*(3-1)) if question>=4 & question<=6
replace d_index = 2*(remaining_t_1^2 - (c1^2+c2^2))/(remaining_t_1^2*(2-1)) if question==7

gen low_money = 0
replace low_money = 1 if question>=1 & question<=3 & remaining_t_1<=7.5
replace low_money = 2 if question>=4 & question<=7 & remaining_t_1<=5

**Generate gender mixed

gen mgender = (gender_1 + gender_2)/2 

**gen future diversification

sort id question
by id: gen d_index_t1 = d_index[_n+1]
by id: gen d_index_t_1 = d_index[_n-1]

**gen loss from previous round
gen loss = remaining_t_1-remaining_t_2 
replace loss = loss*-1 
gen loss_prop = (remaining_t_1-remaining_t_2)/remaining_t_2 
replace loss_prop = loss_prop*-1 
gen loss_prop_sq = loss_prop^2
gen  delta = (remaining_t_1-remaining_t_2) 
gen loss_d = 0 if delta==0
replace loss_d = 1 if delta<0
replace loss_d = 2 if delta>0 & delta~=.
 
gen lg_loss_prop = log(loss_prop)

sort id question
by id: gen loss_t1 = loss[_n+1]
by id: gen loss_t_1 = loss[_n-1]

gen lg_loss = log(loss)
gen lg_remaining = log(remaining)
gen lg_remaining_t_1 = log(remaining_t_1)
gen lg_remaining_t_2 = log(remaining_t_2)

gen lg_remaining_t_1_sq = lg_remaining_t_1^2
gen lg_remaining_t_2_sq = lg_remaining_t_2^2

**Max bet
 egen max_bet = rowmax(c1 c2 c3 c4) 
sort id question
by id: gen max_bet_t1 = max_bet[_n+1]

**drop out in t_1
gen diff_question = max_question - question

gen drop_out_t1 = 0 
replace drop_out_t1 = 1 if diff_question ==1
replace drop_out_t1 = . if diff_question==0

gen all_out = 0
replace all_out = 1 if d_index==0

by id: gen all_out_t1 = all_out[_n+1]

gen diff_d_index = d_index_t1-d_index

gen couple = 0
replace couple = 1 if relationship=="couple"

gen white = 0
replace white = 1 if ethnic_1 =="white" 
replace white = 1 if ethnic_1 == "white "
replace white = 1 if ethnic_2 == "white"

gen nonwhite = 0 if white==1
replace nonwhite = 1 if white==0


global control0 " i.low   i.question "
global control1 "d_index_t_1  i.low  i.question"

gen remaining_sq = remaining^2/100
gen remaining_t_1_sq = remaining_t_1^2/100
gen remaining_t_2_sq = remaining_t_2^2/100
gen loss_sq = loss^2/100

 

**gen categorical remaining
gen remain_cat = 10 if remaining >=0 & remaining<=10
replace remain_cat = 20 if remaining >10 & remaining<=20
replace remain_cat = 30 if remaining >20 & remaining<=30
replace remain_cat = 40 if remaining >30 & remaining<=40
replace remain_cat = 50 if remaining >40 & remaining<=50
replace remain_cat = 60 if remaining >50 & remaining<=60
replace remain_cat = 70 if remaining >60 & remaining<=70
replace remain_cat = 80 if remaining >70 & remaining<=80
replace remain_cat = 90 if remaining >80 & remaining<=90
replace remain_cat = 100 if remaining >90 & remaining<=100


gen remain_t_1_cat = 10 if remaining_t_1 >=0 & remaining_t_1<=10
replace remain_t_1_cat = 20 if remaining_t_1 >10 & remaining_t_1<=20
replace remain_t_1_cat = 30 if remaining_t_1 >20 & remaining_t_1<=30
replace remain_t_1_cat = 40 if remaining_t_1 >30 & remaining_t_1<=40
replace remain_t_1_cat = 50 if remaining_t_1 >40 & remaining_t_1<=50
replace remain_t_1_cat = 60 if remaining_t_1 >50 & remaining_t_1<=60
replace remain_t_1_cat = 70 if remaining_t_1 >60 & remaining_t_1<=70
replace remain_t_1_cat = 80 if remaining_t_1 >70 & remaining_t_1<=80
replace remain_t_1_cat = 90 if remaining_t_1 >80 & remaining_t_1<=90
replace remain_t_1_cat = 100 if remaining_t_1 >90 & remaining_t_1<=100

gen remain_t_2_cat = 10 if remaining_t_2 >=0 & remaining_t_2<=10
replace remain_t_2_cat = 20 if remaining_t_2 >10 & remaining_t_2<=20
replace remain_t_2_cat = 30 if remaining_t_2 >20 & remaining_t_2<=30
replace remain_t_2_cat = 40 if remaining_t_2 >30 & remaining_t_2<=40
replace remain_t_2_cat = 50 if remaining_t_2 >40 & remaining_t_2<=50
replace remain_t_2_cat = 60 if remaining_t_2 >50 & remaining_t_2<=60
replace remain_t_2_cat = 70 if remaining_t_2 >60 & remaining_t_2<=70
replace remain_t_2_cat = 80 if remaining_t_2 >70 & remaining_t_2<=80
replace remain_t_2_cat = 90 if remaining_t_2 >80 & remaining_t_2<=90
replace remain_t_2_cat = 100 if remaining_t_2 >90 & remaining_t_2<=100

gen loss_cat = 10 if loss >=0 & loss<=10
replace loss_cat = 20 if loss >10 & loss<=20
replace loss_cat = 30 if loss >20 & loss<=30
replace loss_cat = 40 if loss >30 & loss<=40
replace loss_cat = 50 if loss >40 & loss<=50
replace loss_cat = 60 if loss >50 & loss<=60
replace loss_cat = 70 if loss >60 & loss<=70
replace loss_cat = 80 if loss >70 & loss<=80
replace loss_cat = 90 if loss >80 & loss<=90
replace loss_cat = 100 if loss >90 & loss<=100

gen loss_cat2 = 0 if loss >=0 & loss<=25
replace loss_cat2 = 1 if loss >25 & loss<=50
replace loss_cat2 = 2 if loss >50 & loss<=75
replace loss_cat2 = 3 if loss >75 & loss <=100

gen loss_cat3 = 0 if loss_prop >=0 & loss_prop<=.25
replace loss_cat3 = 1 if loss_prop >.25 & loss_prop<=.50
replace loss_cat3 = 2 if loss_prop >.50 & loss_prop<=.75
replace loss_cat3 = 3 if loss_prop >.75 & loss_prop <=.100

replace d_index = . if d_index>1 & d_index~=.

save "/Users/nattavudhpowdthavee/Dropbox/The £100k drop/The£100kdrop.dta", replace

 
**Fig.2: Relationship between dispersion and loss

**Figures

**Fig.1: Dispersion index by question 
tab question, su(d_index)

tab question, su(loss)

collapse d_index loss loss_prop, by(id)

lowess d_index loss

lowess d_index loss_prop
 
 
use "/Users/nattavudhpowdthavee/Dropbox/The £100k drop/The£100kdrop.dta", clear


**Regression
*Table 1: Absolute loss 
xi:xtreg d_index loss remaining_t_1  $control1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table1_.xls", replace stat(coef se) 2aster  label dec(3)
xi:xtreg d_index loss loss_sq remaining_t_1  $control1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table1_.xls", append stat(coef se) 2aster  label dec(3)
xi:xtreg d_index i.loss_cat2 remaining_t_1  $control1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table1_.xls", append stat(coef se) 2aster  label dec(3)
xi:xtreg d_index lg_loss remaining_t_1  $control1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table1_.xls", append stat(coef se) 2aster  label dec(3)
   
*Table 2: Loss proportion 
xi:xtreg d_index loss_prop remaining_t_1  $control1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table2_.xls", replace stat(coef se) 2aster  label dec(3)
xi:xtreg d_index loss_prop loss_prop_sq remaining_t_1  $control1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table2_.xls", append stat(coef se) 2aster  label dec(3)
xi:xtreg d_index i.loss_cat3 remaining_t_1  $control1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table2_.xls", append stat(coef se) 2aster  label dec(3)
xi:xtreg d_index lg_loss_prop remaining_t_1  $control1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table2_.xls", append stat(coef se) 2aster  label dec(3)

xtset id question
 
**Table 3: Testing the lagged effect
xi:xtreg d_index loss l.loss l2.loss remaining_t_1  $control1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table3_.xls", replace stat(coef se) 2aster  label dec(3)
xi:xtreg d_index loss_prop l.loss_prop l2.loss_prop remaining_t_1  $control1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table3_.xls", append stat(coef se) 2aster  label dec(3)
 
 
*Table 4:  By gender grouping and couple status
xi:xtreg d_index loss remaining_t_1 d_index_t_1 $control0 if mgender==0,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table4_.xls", replace stat(coef se) 2aster  label dec(3)
xi:xtreg d_index loss remaining_t_1 d_index_t_1 $control0 if mgender==0.5,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table4_.xls", append stat(coef se) 2aster  label dec(3)
xi:xtreg d_index loss remaining_t_1 d_index_t_1 $control0 if mgender==1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table4_.xls", append stat(coef se) 2aster  label dec(3)
xi:xtreg d_index loss remaining_t_1 d_index_t_1 $control0 if couple==1,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table4_.xls", append stat(coef se) 2aster  label dec(3)
xi:xtreg d_index loss remaining_t_1 d_index_t_1 $control0 if couple==0,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table4_.xls", append stat(coef se) 2aster  label dec(3)
 
 
**Table 5: By loss level & round
xi:xtreg d_index loss remaining_t_1 d_index_t_1 $control0 if question<=3,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table5_.xls", replace stat(coef se) 2aster  label dec(3)
xi:xtreg d_index loss remaining_t_1 d_index_t_1 $control0 if question>3 & question<=6,   fe i(id) cluster(id)
outreg2 using "${out_dir}/table5_.xls", append stat(coef se) 2aster  label dec(3)
 
 
*Table 6: All out 
xi:xtlogit all_out loss remaining_t_1 d_index_t_1 $control0,   fe i(id)  
outreg2 using "${out_dir}/table6_.xls", replace stat(coef se) 2aster  label dec(3)
xi:xtreg max_bet  loss remaining_t_1 d_index_t_1 $control0,   fe i(id)  
outreg2 using "${out_dir}/table6_.xls", append stat(coef se) 2aster  label dec(3)
 

