using { managed } from '@sap/cds/common';

namespace eye.you;

entity Patients : managed {
    key ID          : UUID;
        externalId  : Integer;
        lastName    : String(50);
        postalCode  : String(10);
        houseNumber : String(10);
        street      : String(50);
        city        : String(50);
}
