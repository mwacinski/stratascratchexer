select (count(t2.phone_number) / count(t1.phone_number)::FLOAT) * 100
from fb_sms_sends t1
left join fb_confirmers t2
on t1.phone_number = t2.phone_number and t1.ds = t2.date
where t1.ds = '2020-08-04' and t1.type = 'message'
