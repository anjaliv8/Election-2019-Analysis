-------- Showing data of table Results of Election 2019 (lossing candidate)
SELECT * 
FROM Election_2019.dbo.Results;

-------- Showing data of table Winning_candidate of Election 2019 (winning candidate)
SELECT * 
FROM Election_2019.dbo.Winning_candidate;

--------Independent candidates who won election
SELECT * 
FROM Election_2019.dbo.Winning_candidate
WHERE Party = 'Independent';

--------BJP candidates who won election by votes more than 70 %
SELECT Candidate, Constituency, Percentage
FROM Election_2019.dbo.Winning_candidate
WHERE Party = 'Bharatiya Janata Party' And Percentage >  70
ORDER BY Candidate ASC;

--------INC candidates who won election by votes more than 50 %
SELECT Candidate, Constituency, Percentage
FROM Election_2019.dbo.Winning_candidate
WHERE Party = 'Indian National Congress' And Percentage >  50
ORDER BY Candidate ASC;

-------- Showing particular columns in a table
SELECT Constituency, Candidate, Party AS Party_name
FROM Election_2019.dbo.Results;

SELECT State, Constituency, Party, Candidate AS Winner
FROM Election_2019.dbo.Winning_candidate;

-------- Selecting data using ORDER BY Clause
SELECT Constituency, Candidate, Party AS Party_name
FROM Election_2019.dbo.Results
ORDER BY Constituency ASC;

SELECT State, Constituency, Party, Candidate AS Winner
FROM Election_2019.dbo.Winning_candidate
ORDER BY State DESC;

SELECT Constituency, Candidate, Party AS Party_name
FROM Election_2019.dbo.Results
ORDER BY 1,2;

-------- Looking at EVM Votes VS Postal Votes
SELECT Constituency, Candidate, Party AS Party_name, EVM_Votes, Total_Votes, (EVM_Votes / Total_Votes)*100 AS EVMvote_percentage
FROM Election_2019.dbo.Results;

SELECT Constituency, Candidate, Party AS Party_name, Postal_Votes, Total_Votes, (Postal_Votes / Total_Votes)*100 AS Postalvote_percentage
FROM Election_2019.dbo.Results
WHERE Constituency LIKE '%pur%' or Postal_Votes = '0'
ORDER BY 1,2,3;

--------Showing data of Independently winning Candidate
SELECT Constituency, Total_Votes, Party, (Total_Votes/Percentage)*100 AS Total_votes
FROM Election_2019.dbo.Winning_candidate
WHERE Party = 'Independent'
ORDER BY 4;

--------Looking at State with higher voting count
SELECT State, MAX(Total_Votes) AS HighestVotingCount
FROM Election_2019.dbo.Results
group by State
ORDER BY HighestVotingCount ASC;

--------LET'S BREAK THINGS BY STATE
SELECT State, MAX(cast(Total_Votes as int)) as Totalvotecount
FROM Election_2019.dbo.Winning_candidate
WHERE State IS NOT NULL
GROUP BY State
ORDER BY Totalvotecount desc;

--------Showing total vote count in particular state
SELECT State, MAX(cast(Total_Votes as int)) as Totalvotecount
FROM Election_2019.dbo.Winning_candidate

--------Where state like '%pradesh%'
WHERE State like 'M%'
GROUP BY State
ORDER BY Totalvotecount desc;

--------Looking at the candidates who won election in Uttar Pradesh
Select res.State, res.Candidate, res.Constituency, win.Total_Votes
FROM Election_2019.dbo.Results res
JOIN Election_2019.dbo.Winning_candidate win
	ON res.Candidate = win.Candidate
	and res.Constituency = win.Constituency
	WHERE res.State = 'Uttar Pradesh'
	ORDER BY 4;

--------BJP Candidates in Delhi 
Select State, Candidate, Party, Constituency, Total_Votes, Percent_votes
from Election_2019.dbo.Results
where
  (
    Percent_votes BETWEEN 40 and 100
    and Party = 'Bharatiya Janata Party'
    and State like '%Delhi%'
  )
and Total_Votes NOT in (50000, 100000);

--------Statewise Total vote count having percentage more than 45%
SELECT State, Count(Total_Votes) as Totalvotecount
FROM Election_2019.dbo.Winning_candidate
WHERE Percentage > 45
GROUP BY State
ORDER BY Totalvotecount desc;





