create table vguo.g20140612 as
  select 
    count(a.customers_id) num_reg_users, 
    count(b.customers_id) num_paying_users,
    b.num_day_diff num_day_diff
  from
    
     (
      select
        customers_id,
        reg_date
      from
        customers360
      where 
        year(reg_date)=2014
        and 
        month(reg_date)=3
     ) a
    left outer join
     (
      select 
        customers_id,
        min(num_day_diff) num_day_diff,
        min(reg_date) reg_date
      from 
        cubes_rev_dim
      where
        year(reg_date)=2014
        and
        month(reg_date)=3
      group by 
        customers_id
     ) b
    on a.customers_id=b.customers_id
    
    group by
      b.num_day_diff;
      
create table vguo.g20140612_1 as
  select 
    sum(num_reg_users) reg_users,
    sum(num_paying_users) paying_users
  from
    vguo.g20140612
  group by
    case when
      num_day_diff <= 30 then 1 else 0 end;
    

 
      
      
      
            
    
            
    
