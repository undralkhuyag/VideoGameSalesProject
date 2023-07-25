--Subquery in select:
Select Publisher, Genre, name
From ..saledata$
Where 10<
	(Select count(rank) 
	From ..saledata$
	Where year between 1997 and 2019)

--Subquery in having--
Select name, avg(rank), Publisher
From ..saledata$
Group By name
Having avg(rank)<
	(Select avg(rank)
	From ..saledata$
	where year=2019)
--partition by publisher avg, min, max sales--
Select publisher
, AVG(NA_Sales) OVER (Partition By Publisher) as avg_NA_Sales
, Min(NA_Sales) OVER (Partition By Publisher) as min_NA_Sales
, Max(NA_Sales) OVER (Partition By Publisher) as max_NA_Sales
From ..saledata$

--Rank() with partition by publisher and order by NA_sales--
Select publisher, name, RANK() OVER (Partition by publisher Order by name DESC) as rank_pub
FROM ..saledata$