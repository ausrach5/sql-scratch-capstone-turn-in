/*** Rachel Thorpe ***/
/*** Capstone Project 3 ***/

/* Task1 */

SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;

SELECT COUNT(DISTINCT utm_source)
FROM page_visits;

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;

SELECT DISTINCT page_name
FROM page_visits;

/* Task2 */

WITH first_touch AS (
 SELECT user_id,
   MIN(timestamp) AS first_touch_at
 FROM page_visits
 GROUP BY user_id),
ft_attr AS
 (SELECT ft.user_id,
  ft.first_touch_at,
  pv.utm_source,
  pv.utm_campaign
FROM first_touch AS 'ft'
JOIN page_visits AS 'pv'
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp)
SELECT ft_attr.utm_source AS 'Source',
  ft_attr.utm_campaign AS 'Campaign',
  COUNT(*) AS 'First Touches'
FROM ft_attr
GROUP BY 1,2
ORDER BY 3 DESC;

WITH last_touch AS (
 SELECT user_id,
  MAX(timestamp) AS last_touch_at
 FROM page_visits
 GROUP BY user_id),
lt_attr AS
 (SELECT lt.user_id,
  lt.last_touch_at,
  pv.utm_source,
  pv.utm_campaign
FROM last_touch AS 'lt'
JOIN page_visits AS 'pv'
  ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp)
SELECT lt_attr.utm_source AS 'Source',
  lt_attr.utm_campaign AS 'Campaign',
  COUNT(*) AS 'Last Touches'
FROM lt_attr
GROUP BY 1,2
ORDER BY 3 DESC;

SELECT COUNT(DISTINCT user_id) AS 'Purchase Page Visits'
FROM page_visits
WHERE page_name = '4 - purchase';

WITH last_touch AS (
 SELECT user_id,
  MAX(timestamp) AS last_touch_at
 FROM page_visits
   WHERE page_name = '4 - purchase'
   GROUP BY user_id),
lt_attr AS
 (SELECT lt.user_id,
  lt.last_touch_at,
  pv.utm_source,
  pv.utm_campaign
 FROM last_touch AS 'lt'
 JOIN page_visits AS 'pv'
  ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp)
 SELECT lt_attr.utm_source AS 'Source',
  lt_attr.utm_campaign AS 'Campaign',
  COUNT(*) AS 'Last Touches on Purchase'
FROM lt_attr
GROUP BY 1,2
ORDER BY 3 DESC;