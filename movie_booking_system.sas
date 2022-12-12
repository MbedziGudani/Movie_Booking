/*Creayting index*/
data movie_booking;
     set movie_booking;
     index = _N_;
run;

/*Statistics*/
PROC means data = movie_booking;
run;

/*data imputation using mean*/
data tickets_booking;
   set WORK.movie_booking;
   
   capacity = coalesce(capacity,855);
   occu_perc =coalesce(occu_perc,20);
run;

/*macro DELETE*/
%macro deleting(index);
       %put index = &index;
       
       data tickets_booking;
       set tickets_booking;
       if index = &index then delete;
run;
%mend deleting;

%deleting(3);

/*macro MODIFY*/
%macro modify(index=,film_code=,cinema_code=,total_sale=,tickets_sold=,tickets_out=,show_time=,occu_perc=,ticket_price=,ticket_use=,capacity=,date=,month=,quarter=,day=);

   data movie_booking;
     modify movie_booking;
         film_code =&film_code;
         cinema_code =&cinema_code;
         total_sales =&total_sale;
         tickets_sold =&tickets_sold;
         tickets_out =&tickets_out;
         show_time =&show_time;
         occu_perc =&occu_perc;
         ticket_price =&ticket_price;
         ticket_use =&ticket_use;
         capacity =&capacity;
         date =&date;
         month =&month;
         quarter =&quarter;
         day =&day;
         format data yymmdd10.;
         where index =&index;
run;
%mend modify;

%modify(index=3,film_code=1403,cinema_code=304,total_sale=30909500,tickets_sold=26,tickets_out=0,show_time=4,occu_perc=4.26,ticket_price=150000,ticket_use=26,capacity=610.55,date=2018-06-06,month=6,quarter=2,day=6);
  
/*macro INSERT*/
%macro generate(index=,film_code=,cinema_code=,total_sale=,tickets_sold=,tickets_out=,show_time=,occu_perc=,ticket_price=,ticket_use=,capacity=,date=,month=,quarter=,day=);
%put film_code =&film_code;
%put cinema_code =&cinema_code;
%put total_sales =&total_sale;
%put tickets_sold =&tickets_sold;
%put tickets_out =&tickets_out;
%put show_time =&show_time;
%put occu_perc =&occu_perc;
%put ticket_price =&ticket_price;
%put ticket_use =&ticket_use;
%put capacity =&capacity;
%put date =&date;
%put month =&month;
%put quarter =&quarter;
%put day =&day;
%put index =&index;
data temp;
    film_code =&film_code;
    cinema_code =&cinema_code;
    total_sales =&total_sale;
    tickets_sold =&tickets_sold;
    tickets_out =&tickets_out;
    show_time =&show_time;
    occu_perc =&occu_perc;
    ticket_price =&ticket_price;
    ticket_use =&ticket_use;
    capacity =&capacity;
    date =&date;
    month =&month;
    quarter =&quarter;
    day =&day;
    index =&index;
PROC APPEND base = Work.movie_booking;
data = Work.temp;
run;
%mend generate;

%generate(index=5,film_code=1403,cinema_code=304,total_sale=30909500,tickets_sold=26,tickets_out=0,show_time=4,occu_perc=4.26,ticket_price=150000,ticket_use=26,capacity=610.55,date=2018-06-06,month=6,quarter=2,day=6);

/*macro search*/
%macro search(filter,x);
/* 	%put x = &x; */
/* 	%put filter = &filter; */
	
	%if film_code = &filter or cinema_code =&filter or index = &filter %then 
	 		%do;
	    		
	    		data result;
	    		     set movie_booking;
	    		     where film_code = &x or cinema_code = &x or index = &x;
	    		run;    
	    		proc print data = result;
	    		run;
	    		
	    	%end;
	    	
%mend search;

%search(index, 20);
	    		
	    		
  