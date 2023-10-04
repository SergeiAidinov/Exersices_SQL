-- 4. Какая модель перевозит больше всего пассажиров?

drop  table if exists t1;
drop  table if exists t2;

create temp table t1 (
	fl_id int, 
	qty_passes int
);

create temp table t2 (
	fl_id int,
	aircraft_code varchar(3),
	qty_passes int
);

insert into t1 (fl_id, qty_passes) select flight_id, count(ticket_no) from boarding_passes group by flight_id;

insert into t2(fl_id, aircraft_code, qty_passes) select flight_id, aircraft_code, qty_passes from t1 
join flights  on flights.flight_id  = t1.fl_id order by qty_passes desc;

select model::json->>'ru', w.aircraft_code, w.qty from 
	(select aircraft_code, q.qty from
		(select aircraft_code, sum(qty_passes) as qty from t2 group by aircraft_code)   as q) as w
join aircrafts_data on aircrafts_data.aircraft_code  = w.aircraft_code
order by w.qty desc;

drop  table if exists t1;
drop  table if exists t2;
