use pl;

delete from epl
where HTHG is null
or Referee is null;

-- max goals scored by the home team in a match
select MatchDate, Season, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee
from epl
order by FTHG desc
limit 10; 

-- max goals scored by the away team in a match
select* 
from epl
order by FTAG desc
limit 10;

alter table epl
drop column PSH,
drop column PSD,
drop column PSA, 
drop column BbAvd;

-- max goal difference
select*
from epl 
order by abs(cast(FTAG as signed) - cast(FTHG as signed)) desc
limit 10;

-- max goals score by a team at half time
select MatchDate, Season, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR, Referee
from epl 
order by greatest(HTHG, HTAG) desc
limit 10;

-- team with the most goals 
select Team, sum(goals) as totalgoals
from ( select HomeTeam as Team, FTHG as goals
		from epl 
        union all 
        select AwayTeam as Team, FTAG as goals
        from epl) as combined
group by team
order by totalgoals desc
limit 10;

-- highest goals scored by a team in every season
select Team, sum(goals) as total_goals, Season
from (select HomeTeam as Team,FTHG as goals, Season
	  from epl
      union all
      select AwayTeam as Team, FTAG as goals, Season
      from epl
      ) as combined 
group by team, Season
order by Season desc, total_goals desc;

-- referee wise goals 
select Team, sum(goals) as total_goals, Referee
from (select HomeTeam as Team,FTHG as goals, Referee
	  from epl
      union all
      select AwayTeam as Team, FTAG as goals, Referee
      from epl
      ) as combined 
group by team, Referee
order by total_goals desc;

-- referee who officiated the most games
SELECT Referee, COUNT(*) AS games_officiated
FROM epl
GROUP BY Referee
ORDER BY games_officiated DESC
limit 10;

-- referee who officiated the most games season wise
SELECT Referee,Season,  COUNT(*) AS games_officiated
FROM epl
GROUP BY Referee, Season
ORDER BY games_officiated DESC
limit 10;
