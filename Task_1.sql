-- 1. Сколько человек в одном бронировании?

select passengers_in_booking, bookings_totaly from (
	select count(book_ref) as bookings_totaly, passengers_in_booking from (
		select book_ref, count(ticket_no) as passengers_in_booking from tickets  
		where book_ref in (select  book_ref from bookings  as q) 
			group by tickets.book_ref) as w group by passengers_in_booking
			) 
			as e
order by passengers_in_booking;

