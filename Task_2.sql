-- 2. До каких городов нельзя добраться без пересадок из Москвы?

select distinct city::json->>'ru' as no_flights_from_moscow from airports_data where airport_code not in (
select distinct arrival_airport  from flights where departure_airport  in
(select  airport_code as moscow_codes from airports_data where (city::json->>'ru') = 'Москва'))
order by city::json->>'ru'; 