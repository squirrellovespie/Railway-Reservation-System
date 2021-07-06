import mysql.connector
from tabulate import tabulate
import datetime

'''
Change the database details to reflect the local environment
TABLES:
1. train_details
2. passengers
3. train_timings
4. availability
''' 

mydb=mysql.connector.connect(host="localhost",\
                             user="root",\
                             passwd="TIGER",\
                             database="python_mysql");
mycursor = mydb.cursor()

def railresmenu():
    print("Railway Reservation Menu")
    print()
    print("1. Ticket Booking")
    print("2. Cancellation of Ticket")
    print("3. Display PNR status")
    print("4. Quit")
    print()         
    n=int(input("Enter your choice : "))
    if(n==1):
        displayTrainDetails()
    elif(n==2):
        cancel()
    elif(n==3):
        displayPNR()
    elif(n==4):
        exit(0)
    else:
        print("Wrong Choice. Try again with one of the valid choices")
        print()
        railresmenu()
 
def seats(flag,clas,train,date,no):
    date=str(date)
    sql="select {} from availability where (tnum={} and date='{}')".format(clas,train,date)
    mycursor.execute(sql)
    r=mycursor.fetchall()[0][0]
    if(flag==1):
        sql="update availability set {}={}+{} where (tnum={} and date='{}')".format(clas,clas,no,train,date)
        mycursor.execute(sql)
        mydb.commit()
    if(r>=no):
        if(flag==-1):
            sql="update availability set {}={}-{} where (tnum={} and date='{}')".format(clas,clas,no,train,date)
            mycursor.execute(sql)
            mydb.commit()
    elif(r<no):
        return 0

def displayTrainDetails():
    print()
    print("All Train Details:")
    sql = "select tnum,tname,src,des from train_details"
    mycursor.execute(sql)
    result =mycursor.fetchall()
    result.insert(0,("Train Number","Train Name","Source","Destination"))
    print(tabulate(result,headers='firstrow',tablefmt='pretty'))
    print()
    tn=int(input(("Enter Train Number to view more details: ")))
    eachtrain(tn)
    print("Go back to menu")
    print('\n' *2)
    print("======================================================")
    railresmenu()

def eachtrain(num):
    sql="select Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday,Timings from train_timings where tnum={}".format(num)
    mycursor.execute(sql)
    result=mycursor.fetchall()
    result.insert(0,("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday","Timings"))
    result=zip(result[0],result[1])
    print(tabulate(result,tablefmt='pretty'))
    print()
    a=input("Do you want to book tickets in this train?(Enter 'yes' or 'no'): ").lower()
    if(a=='yes'):
        reservation(num)

    
def reservation(n):
    l1=[];l2=[]
    pname=input("Enter Passenger Name :")
    l1.append(pname)
    age=input("Enter Age of Passenger :")
    l1.append(age)
    l1.append(n);l2.append(n)
    np=int(input("Enter number of passengers :"))
    l1.append(np)
    print("Select a class you would like to travel in...")
    print("1. AC FIRST CLASS(Rs. 1000 per ticket)")
    print("2. AC SECOND CLASS(Rs. 800 per ticket)")
    print("3. AC THIRD CLASS(Rs. 500 per ticket)")
    print("4. SLEEPER CLASS(Rs. 350 per ticket)")
    cp=int(input("Enter your choice:"))
    if(cp==1):
        amount=np*1000
        cls='ac1'
    elif(cp==2):
        amount=np*800
        cls='ac2'
    elif(cp==3):
        amount=np*500
        cls='ac3'
    else:
        amount=np*350
        cls='slp'
    l1.append(cls)
    d=input("Enter date of travel(in YYYY-MM-DD format): ")
    year,month,day=map(int, d.split('-'))
    d=datetime.date(year,month,day)
    day=d.strftime("%A")
    sql="select {} from train_timings where tnum={}".format(day,n)
    mycursor.execute(sql)
    result=mycursor.fetchall()[0][0]
    if(result=='Running' and d>date):
        l1.append(d);l2.append(d)
        sql="select date,tnum from availability"
        mycursor.execute(sql)
        result=mycursor.fetchall()
        if((d,n) in result):
            if(seats(-1,cls,n,d,np)==0):
                print("There are not enough seats in this class. Try a different class or train.")
                displayTrainDetails()
        else:
            sql="insert into availability(tnum,date) values(%s,%s)"
            mycursor.execute(sql,(n,d))
            mydb.commit()
            sql="update availability set ac1=(select ac1 from train_details where availability.tnum=train_details.tnum),ac2=(select ac2 from train_details where availability.tnum=train_details.tnum),ac3=(select ac3 from train_details where availability.tnum=train_details.tnum),slp=(select slp from train_details where availability.tnum=train_details.tnum) where (tnum=%s and date=%s)"
            mycursor.execute(sql,(n,d))
            mydb.commit()
            seats(-1,cls,n,d,np)
    else:
        print()
        print("The train is not available on the selected date. Please try again.")
        print()
        displayTrainDetails()
    l1.append(amount)
    status='confirmed'
    l1.append(status)
    sql="""INSERT\
    INTO passengers\
    (passenger_name,age,train_no,no_of_pas,class,date,amount,status)\
    VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"""
    mycursor.execute(sql,l1)
    mydb.commit()
    print("Total amount to be paid:", amount)           
    print("Status: Confirmed")
    sql= "select pnr_no from passengers where passenger_name=%s"
    pn=(pname,)
    mycursor.execute(sql,pn)
    record = mycursor.fetchall()
    print("PNR Number of the reservation is :",record[0][0])
    print("Cancellation Policy: If tickets are cancelled on the day of departure, 50% cancellation fee will be applied.")

def cancel():
    check=0
    print("\nTicket CANCEL Window")
    print()
    pnr=int(input("Enter PNR for cancellation of Ticket : "))
    sql="select status from passengers where pnr_no={}".format(pnr)
    mycursor.execute(sql)
    res=mycursor.fetchall()[0][0]
    if(res=='confirmed'):check+=1
    sql="update passengers set status='deleted' where pnr_no={}".format(pnr)
    mycursor.execute(sql)
    mydb.commit()
    sql="select * from passengers where pnr_no={}".format(pnr)
    mycursor.execute(sql)
    res=mycursor.fetchall()
    if(res!=[]):
        if(check==1):
            seats(1,res[0][4],res[0][2],res[0][5],res[0][3])
        print("Ticket Deletion completed")
        if(date==res[0][5]):
            refund=res[0][6]*0.5
            print("Amount to be refunded :",refund)
            sql="update passengers set refund={} where pnr_no={}".format(refund,pnr)
            mycursor.execute(sql)
            mydb.commit()
        else:
            refund=res[0][6]
            print("Amount to be rufunded :",refund)
            sql="update passengers set refund={} where pnr_no={}".format(refund,pnr)
            mycursor.execute(sql)
            mydb.commit()
        sql="select * from passengers where pnr_no={}".format(pnr)
    else:
        print("PNR not found.")
    print("Go back to menu")
    print('\n' *2)
    print("======================================================")
    railresmenu()

def displayPNR():
    print("PNR Status Check...")
    pnr=input("Enter PNR Number : ")
    pn=(pnr,) 
    sql="select * from passengers where pnr_no=%s"
    mycursor.execute(sql,pn)
    res=mycursor.fetchall()
    if(res!=[]):
        print("PNR STATUS is as follows :",res[0][7])
    else:
        print("PNR not found.") 
    print("Go back to menu")
    print('\n' *2)
    print("======================================================")
    railresmenu()
    


date=datetime.date.today()
sql="update passengers set status='deleted' where date<%s"
mycursor.execute(sql,(date,))
mydb.commit()
sql="delete from availability where date<%s"
mycursor.execute(sql,(date,))
mydb.commit()
railresmenu()

print("You have entered an incorrect input. Please try again.")
print('\n' *2)
print("======================================================")
railresmenu()
