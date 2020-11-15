annotate AccountService.Patients with @(



UI : {
    
    HeaderInfo       : {
        TypeName       : 'Patient',
        TypeNamePlural : 'Patienten',
        Title          : {Value : lastName},
        Description    : {Value : firstName}
    },

    SelectionFields  : [ID, city],

    LineItem         : [
        { Value : lastName, Label : 'Achternaam' },
        { Value : city, Label : 'Plaats' }
    ],

    Facets           : [{
        $Type  : 'UI.CollectionFacet',
        Label  : 'Patient info',
        Facets : [{
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Main',
            Label  : 'Patient informatie - algemeen'
        }]
    }],

    FieldGroup#Main : {Data : 
        [
            {Value : ID, Label: 'ID'}, 
            {Value : lastName, Label: 'Achternaam'}, 
            {Value: city, Label: 'Woonplaats'} 
        ]
    }

}

);
