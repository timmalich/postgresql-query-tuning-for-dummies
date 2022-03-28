-- GOOD 80ms
select distinct on (sales.id) sales.id, sales.id, sales.selling_price, sales.payed, sales.last_payment
from sales limit 500;
