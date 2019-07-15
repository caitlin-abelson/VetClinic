echo off

rem batch file to run a script to create a db
rem 7/12/2019

sqlcmd -s localhost -E -i VetClinicDB.sql
rem sqlcmd -S localhost\sqlexpress -E -i VetClinicDB.sql

ECHO .
ECHO if no error messages appear DBJ was created
PAUSE