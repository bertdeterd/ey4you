const cds = require('@sap/cds')

module.exports = cds.service.impl ((srv) => {
//module.exports = cds.service.impl(function () {

    srv.before('CREATE', 'Patients', (req) => {
        if(req.data.lastName == 'Sinterklaas') req.reject(400,'Sinterklaas mag niet meedoen')
    })

    srv.after('READ', 'Patients', async(req) => {
        req.forEach(i => {
            i.lastName = i.lastName.toUpperCase()
        })
    })


   srv.on ('notify', async req => {
    //POST > json body with id needed as specified in definition  
    const topic = 'eye/person/created'
    console.log(JSON.stringify(req.data))
    const messaging = await cds.connect.to('messaging')
    messaging.tx(req).emit('eye/person/created', {
        'id': req.data.id,
        'description':'New ID person',
        'location':'From Hana Cloud'
    })

    //RETURN > json body with msg needed as specified in definition
     return { msg: "Successfully sent event" }
   } )

})

