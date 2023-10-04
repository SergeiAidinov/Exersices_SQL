-- 3. Какие модели выполняют больше всего и меньше всего рейсов?

select model, count(flights.aircraft_code) as total_flights from flights 
join aircrafts on flights.aircraft_code = aircrafts.aircraft_code 
where flights.aircraft_code in
(select aircraft_code from aircrafts_data) 
group by aircrafts.model order by total_flights desc;