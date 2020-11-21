<template>
  <v-container fluid>
    <v-row>
      <v-col>
        <v-data-table :headers="headers" :items="patientslist"></v-data-table>
      </v-col>
      <v-col>
        <v-sheet>
          <v-text-field v-model="lname" label="achternaam"></v-text-field>
          <v-btn @click="createPatient">Create</v-btn>
        </v-sheet>
      </v-col>
    </v-row>

    <v-row>
      <v-btn @click="getRule">get Rule</v-btn>
     
      <v-btn @click="getRuleHowItShould">get Rule</v-btn>
   
    </v-row>
    <v-row>
      <v-btn @click="getToken">get Token</v-btn>
    </v-row>

  </v-container>
</template>

<script>
export default {
  name: "HelloWorld",

  data: () => ({
    patientslist: [],
    lname: "",
    token: {},
    headers: [
      { text: "Achternaam", value: "lastName" },
      { text: "ID", value: "ID" },
    ],
  }),

  methods: {
    async createPatient() {
      const _body = JSON.stringify({ lastName: this.lname });
      const _hdr = {
        "Content-Type": "application/json;odata.metadata=minimal",
        "OData-Version": "4.0",
        Accept: "application/json",
      };

      const r = await fetch("api/account/Patients", {
        method: "post",
        headers: _hdr,
        body: _body,
      });
      const d = await r.json();
      console.log(d);
      window.alert(d.ID);
      this.getPatients();
    },

    async getToken() {
      //const _body = JSON.stringify({ lastName: this.lname });
      const _hdr = {
        "Content-Type": "application/x-www-form-urlencoded",
        Accept: "application/json; charset=utf-8",
      };

      const dat = { grant_type: "client_credentials", scope: "read"};
      const URLSearchParams = Object.keys(dat)
        .map((key) => {
          return encodeURIComponent(key) + "=" + encodeURIComponent(dat[key]);
        })
        .join("&");

      const r = await fetch("token/", {
        method: "post",
        headers: _hdr,
        body: URLSearchParams,
      });
      const d = await r.json();
      console.log(d);
      this.token = d
      //window.alert(d.ID);
      //this.getPatients()
    },

    async getPatients() {
      const resp = await fetch("api/account/Patients");
      const _data = await resp.json();
      this.patientslist = _data.value;
    },

    async getRule() {
      const opt = {
        methode: "get",
        headers: {
          "Authorization" : `Bearer ${this.token.access_token}`
        }
      }
      const resp = await fetch("rule/determine-dvocode?orderreason=Z09", opt);
      const _data = await resp.json();

      console.log(_data);
      //this.patientslist = _data.value;
    },
  

     async getRuleHowItShould() {
     
      const resp = await fetch("func/determine-dvocode?orderreason=Z09");
      const _data = await resp.json();

      console.log(_data);
      //this.patientslist = _data.value;
    },
  },


  created() {
    this.getPatients();
  },
};
</script>
