annotate AccountService.Patients with @(UI : {
    SelectionFields  : [ID],
    LineItem         : [{
        value : lastName,
        label : 'Naam'
    }],
    HeaderInfo       : {
        TypeName       : 'Patient',
        TypeNamePlural : 'Pa',
        Title          : {value : lastName},
        Description    : {value : firstName}
    },
    FieldGroup#Main : {Data : [{Value : ID}

    ]}

});
