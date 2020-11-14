using {eye.you as eye} from '../db/schema';

service AppointmentService
//@(requires:'authenticated-user')

{
    entity Appointments as projection on eye.Appointments;
}
