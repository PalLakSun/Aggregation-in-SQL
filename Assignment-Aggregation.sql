use world;
select * from country ;
select * from city_list;
#1.Count how many cities are there in each country?
select countrycode,count(city_name) as city_count
from city_list
group by countrycode
order by city_count desc;
# Using joins concept
select c.country_name,count(ci.city_name) as city_count
from country c
left join city_list ci
on c.countrycode=ci.countrycode
group by c.country_name
order by city_count  desc;

#2.Display all continents having more than 30 countries.
select continent,count(country_name) as country_count
from country
group by continent
having count(country_name)>30;

#3.List regions whose total population exceeds 200 million.
select region, sum(country_pop)/1000000 as total_pop from country
group by  region
having sum(country_pop)/1000000 > 200;

#using subquery
select region,total_pop
from(
select region ,sum(country_pop)/1000000 as total_pop
from country
group by region) t
where total_pop >200;

#4.Find the top 5 continents by average GNP per country.
select continent,avg(GNP)/1000000 as Avg_GNP
from country
group by continent
order by Avg_GNP desc
limit 5;

#5.Find the total number of official languages spoken in each continent.
select * from countrylanguage;
select * from country;
#using joins
select c.continent,count(distinct cl.language) as Official_lan_count
from country c 
left join countrylanguage cl
on c.countrycode=cl.countrycode
where cl.isofficial ='T'
group by c.continent
order by Official_lan_count;

#6.Find the maximum and minimum GNP for each continent.
select continent,max(GNP) max_GNP ,min(GNP) min_GNP
from country
group by continent;

#7.Find the country with the highest average city population

select country_name,highest_avg_city_pop
from(
select c.country_name,avg(ci.city_pop) highest_avg_city_pop
from country c
left join city_list ci
on c.countrycode=ci.countrycode
group by c.country_name
) t
order by highest_avg_city_pop desc
limit 1;

#8. List continents where the average city population is greater than 200,000.

select c.continent,avg(ci.city_pop) avg_city_pop
from country c
inner join city_list ci
on c.countrycode=ci.countrycode
group by c.continent 
having avg(ci.city_pop) > 200000 
order by avg_city_pop ;

#9.Find the total population and average life expectancy for each continent, ordered by average life expectancy descending
#using window function
select  distinct continent,
avg(lifeexpectancy) over (partition by continent) avg_LE,
sum(country_pop) over (partition by continent) total_pop
from country
order by avg_LE desc;

#using group by
select continent,avg(lifeexpectancy) avg_LE,sum(country_pop) total_pop
from country
group by continent
order by avg_LE desc;

#10.Find the top 3 continents with the highest average life expectancy, but only include those where the total population is over 200 million.
select continent,avg(lifeexpectancy) avg_LE,sum(country_pop)/1000000 total_pop
from country
group by continent
having sum(country_pop)/1000000>200
order by avg_LE desc
limit 3;







