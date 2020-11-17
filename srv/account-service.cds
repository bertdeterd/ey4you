using {eye.you as eye} from '../db/schema';

service AccountService 
@(requires:'authenticated-user')

{
    @odata.draft.enabled : true
    entity Patients as projection on eye.Patients;

    entity Doctors  as projection on eye.Doctors;

}
