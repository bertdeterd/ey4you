using {managed} from '@sap/cds/common';
using {Street} from './types/address';
using {PostalCode} from 'sap-cds-ddic/address';
using {Person} from 'sap-cds-ddic';
//
namespace eye.you;

entity Patients : managed, Person {
    key ID          : UUID;
        externalId  : Integer;
        postalCode  : PostalCode;
        houseNumber : String(10);
        street      : Street;
        city        : String(50);
}

entity Doctors : managed, Person {
    key ID         : UUID;
        externalId : Integer;
}

entity Appointments : managed {
    key ID           : UUID;
        doctor       : Association to Doctors not null;
        dateTimeFrom : Timestamp;
        dateTimeTo   : Timestamp;
        quickRemark  : String(100);
        remark       : LargeString;
}
