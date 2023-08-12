select * from [dbo].[CovidDeaths];
select * from [dbo].[CovidVaccinations];

select location,date,population,total_cases,new_cases,total_deaths
from [dbo].[CovidDeaths]
order by 1,2;

select location, date, total_tests,new_tests,new_vaccinations
from CovidVaccinations
where location = 'India'
order by location,date;

--Looking at total test vs total cases

select cd.location,cd.date,cd.total_cases,cv.total_tests 
from CovidDeaths cd
join CovidVaccinations cv
on cd.date = cv.date
where cd.location = 'india';


-- Looking at total test done in India

select sum( cast( total_tests AS BIGINT))
from CovidVaccinations
where location = 'india';


---Looking at total cases vs total deaths

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_percentage
from CovidDeaths
where location = 'India'
order by 2;


--Looking at total cases vs total population
--shows what percentage of population got covid

select location,date,total_cases,population,(total_cases/population)*100 as percentage_PopulationInfected
from CovidDeaths
where location = 'India'
order by 2;


--Looking at countries with highest infected rate compared with population

select location,population,max(total_cases)as HighestInfectedCount,max(total_cases/population)*100 as countriesWithInfectedRate
from CovidDeaths
group by location,population
order by countriesWithInfectedRate desc;


--Looking at countries with highest DEATH count compared with population

select location,population,max(total_deaths)as HighestDeathCount,max(total_deaths/population)*100 as countriesWithDeathRate
from CovidDeaths
--where location = 'india'
group by location,population
order by countriesWithDeathRate; 


--Breaking thing continent wise
----continent with highest death count per population

select continent,max(total_deaths)as Totaldeathcount
from CovidDeaths
where continent is not null
group by continent
order by Totaldeathcount desc; 


--GLOBAL NUMBERS
--Looking at worldwide total new cases and total new deaths as per DATES

select date,SUM(new_cases) as TotalCases, SUM(new_deaths) as TotalDeaths, (SUM(new_deaths)/SUM(new_cases))*100 as DeathPercentage
from CovidDeaths
group by date
order by date;


--Looking at total population vs vaccination

select dea.location,dea.continent,dea.date, dea.population, vac.new_vaccinations
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
order by 1,2;






