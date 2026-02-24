---
layout: post
title: Wanted to know the differences between order by and  group by clauses in
date: 2022-12-04
categories: ['Database', 'MySQL']
---

In this, we are going to look into "**order by**" and "**group by**"clauses in SQL.

## 

**Group By**

The "**GROUP BY**" clause is utilized to aggregate data based on one or more columns, employing aggregate functions such as **COUNT()**, **SUM()**, **MIN()**, **MAX()**, and **AVG()**.

Let's consider an example with the following table related to "pets."

![]({{site.baseurl}}/assets/img/2022/12/image.png)

To determine the total number of a specific species (e.g., the total number of cats or dogs), you would need to execute the following query:
**`mysql> select species, count(*) from pet group by species;`**

**Executing the above query involves three crucial steps:**

1) Collecting all records from the "pet" table - (**FROM** Clause)

2) Grouping unique values in the "species" column  - (**GROUP BY** Clause)

3) Applying the aggregate function (**COUNT(*)**) to each group obtained in the second step - (**SELECT** Clause)

In the execution order of the above SQL query, the sequence is `"**FROM Clause** → **GROUP BY Clause** → **SELECT Clause**."`

![]({{site.baseurl}}/assets/img/2022/12/image-3.png)

## **Order By**

The "**ORDER BY**" clause is employed to arrange the results of a SQL query based on one or more columns. Let's use the same example with the "pets" table to illustrate how the "ORDER BY" clause can be integrated into our query.

Suppose we wish to sort the results obtained from the SQL query (`select species, count(*) from pet group by species`), which we executed in the preceding section to explore the "**`GROUP BY`**" clause.

![This image has an empty alt attribute; its file name is image-3.png]({{site.baseurl}}/assets/img/2022/12/image-3.png)

To sort the result using the "**`ORDER BY`**" clause, execute the following SQL query:
`**mysql> select species, count(*) from pet group by species order by count(*);**`

By default, the sorting is in ascending order. For descending order, append the `DESC` keyword at the end of the query:
`**mysql> select species, count(*) from pet group by species order by count(*) DESC;**`

![]({{site.baseurl}}/assets/img/2022/12/image-4.png)
