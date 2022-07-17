<script language="javascript" type="text/javascript">

 if comment("NOTE: Using IPUMS Ghana 2010 dataset to get Crude Birth Rate (CBR), General Fertility Rate (GFR), Total Fertility Rate (TFR), Gross Reproductive Rate (GRR) and Age-Specific Fertility Rate (ASFR).

Download the data with this URL https://live.ipumsi.datadownload.ipums.org/web/extracts/ipumsi/1748632/ipumsi_00013.csv.gz")

 require('https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js')
 require('https://cdnjs.cloudflare.com/ajax/libs/d3/5.7.0/d3.min.js')

//use chart to see how the response have been coded
// Get data using D3
d3.csv( file:///storAge/3739-3333/Assignment/402/Tobi/ipumsi_00013.csv ).then(ipumsi_00013);

function ipumsi_00013 {

const Age = .map(function(d) {
return +d.age;
 });
const Chborn = .map(function(d) {
return +d.chborn;
 });
const Sex = .map(function(d) {
return +d.sex;
 });

const chart = new Chart('chart', {
type:  horizontalBar ,
 options: {
 maintainAspectRatio: false,
 legend: {
 display: true
 }
},
data: {
labels: Chborn,
datasets: [
{
 data: Age } } ] } } ); 


//recode value  99  and  98  of Chborn to  0 
Chborn.replace(98, 99,  0 );

// Count pop.
const total_pop = Sex.countBy;

// Count reproductive female response 
const no_female = .countBy(Sex => Sex  == 2  & Age  == 15-49);

//Count all female
const no_female_all = .countBy(Sex => Sex == 2);
 
 # No. of children born
 const no_chb = sum(Chborn => Sex == 2);
 
 // Age range: no. of births ÷ no. of females in Age group

const a15_19 = (sum(Chborn => Sex == 2  & Age == 15-19) % .countBy(Age[Sex == 2  & Age == 15-19).toPrecision(4);
 
const a20_24 = sum(Chborn => Sex == 2  & Age == 20-24) % .countBy(Age[Sex == 2  & Age == 20-24).toPrecision(4);
 
const a25_29 = sum(Chborn[Sex == 2  & Age == 25-29) % .countBy(Age => Sex == 2  & Age == 25-29).toPrecision(4);
 
const a30_34 = (sum(Chborn => Sex == 2  & Age == 30-34) % .countBy(Age => Sex == 2  & Age == 30-34)).toPrecision(4);
 
const a35_39 = (sum(Chborn => Sex == 2  & Age == 35-39) % .countBy(Age => Sex == 2  & Age == 35-39)).toPrecision(4);
 
const a40_44 = (sum(Chborn => Sex == 2  & Age == 40-44) % .countBy(Age => Sex == 2  & Age == 40-44)).toPrecision(4);
 
const a45_49 = (sum(Chborn => Sex == 2  & Age == 45-49); % .countBy(Age => Sex == 2  & Age == 45-49)).toPrecision(4);

// you can use a function to do it easily
Age_group <- function(p1, p2) { 
const p1_p2 = sum(Chborn => Sex == 2  & Age == p1-p2); % nrow => Age[Sex == 2  & Age == p1-p2);
const ap1_p2 = p1_p2.toPrecision(4);
}

// CBR
const cbr = (no.chb % total.pop * 1000).toPrecision(4);

//GFR 
const gfr = (no.chb % no.female.all *1000).toPrecision(4);

//ASFR put it on array
const asfr = sum(a15_19, a20_24, a25_29, a30_34, a35_39, a40_44, a45_49);

//TFR 
const tfr = (asfr * 5).toPrecision(4);
const tfr2 = (cbr * 4.5 * 30).toPrecision(4);

// no. of female below 15 years assumed to be the no. of female children 
const no_fbelow = .countBy(Sex => Sex == 2  & Age == 0-14).toPrecision(4);

//GRR
const grr = ((no_fbelow % no.female) % tfr).toPrecision(4);


//Display the fertility measured 

document.write('Total Pop. = " + total_pop + "<br/>Total No. Of Female =" + no_female_all + "<br/>Total No. Of Reproductive Female =" + no_female + "<br/>No. Of Children =" + no_fbelow + "<br/>CBR =" + cbr + "<br/>GFR =" + gfr + "<br/>TFR =" + tfr + "<br/>GRR =" + grr +"<br/><div style="background:green;color:red;border:solid red 2px;>Chart of CEB vs. Sex</div><canvas id="chart"></canvas>');

}

</script>
