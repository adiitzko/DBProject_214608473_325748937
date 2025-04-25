//  רשימה של לקוחות והמדינות אליהן הם טסו לפחות פעמיים
WITH
  CustomerCountries AS (
    SELECT
      i.customerID,
      c.fullName AS customerName,
      d.country
    FROM invite i
    JOIN customer c ON i.customerID = c.ID
    JOIN trip t ON i.tripID = t.tripID
    JOIN destination d ON t.destinationZip = d.zipCode
  ),
  CustomerCountryCounts AS (
    SELECT
      customerID,
      customerName,
      country,
      COUNT(*) AS tripCount
    FROM CustomerCountries
    GROUP BY
      customerID,
      customerName,
      country
    HAVING
      COUNT(*) >= 2
  )
SELECT DISTINCT
  ccc.customerName,
  ccc.country
FROM CustomerCountryCounts ccc
ORDER BY
  ccc.customerName,
  ccc.country;
