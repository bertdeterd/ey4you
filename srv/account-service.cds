using { eye.you as my } from '../db/schema';

service AccountService 
//@(requires:'authenticated-user')

{
 entity Patients as projection on my.Patients;

 entity Employees as projection on my.Patients;
}