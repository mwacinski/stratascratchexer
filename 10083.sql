SELECT index, start_date, yearly_salary
FROM lyft_drivers
WHERE end_date IS NULL
ORDER BY yearly_salary DESC
LIMIT 5