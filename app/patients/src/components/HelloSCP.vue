<template>
  <v-container fluid>

    <v-card>
      <v-card-title>
        <v-toolbar flat dense>
          <v-toolbar-title>HANA Cloud</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-text-field max-width="100px" hide-details dense v-model="lname" label="Achternaam"></v-text-field>
          <v-btn color="primary" @click="createPatient">Aanmaken</v-btn>
        </v-toolbar>
      </v-card-title>
      <v-card-text>
        <v-data-table :headers="headers" :items="patientslist">
        </v-data-table>
      </v-card-text>
    </v-card>

    <v-card class="mt-5">
      <v-card-title>
        <v-toolbar flat dense>
          <v-toolbar-title>Kyma Serverless Function</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-text-field max-width="100px" hide-details dense v-model="reden" label="Orderreden"></v-text-field>
          <v-btn :disabled="reden == ''" color="secondary" @click="getRule">Bepalen dvo</v-btn>
          <v-btn :disabled="reden == ''" @click="getRuleHowItShould">Bepalen dvo (1-stop)</v-btn>
          <v-btn @click="reden = ''">Clear</v-btn>
        </v-toolbar>
      </v-card-title>
      <v-card-text>
        <v-chip label :color="(ruleresult)?'orange':'grey'">{{ `uw dvocode is ${ruleresult}`}}</v-chip>
      </v-card-text>
    </v-card>

    <v-card class="mt-5">
      <v-card-title>
        <v-toolbar flat dense>
          <v-toolbar-title>Enterprise Messaging</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-text-field max-width="100px" hide-details dense v-model="postresult.ID" label="Nieuwe persoon"></v-text-field>
          <v-btn color="secondary" @click="sendToEM">naar EM handmatig</v-btn>
        </v-toolbar>
      </v-card-title>
      <v-card-text>
      </v-card-text>
    </v-card>

  </v-container>
</template>

<script>
export default {
  name: "HelloSCP",

  data: () => ({
    patientslist: [],
    lname: "",
    reden: "",
    token: {},
    ruleresult: "",
    postresult: "",
    headers: [
      { text: "ID", value: "ID" },
      { text: "Achternaam", value: "lastName" },
      { text: "Aangemaakt door", value: "createdAt" },
      { text: "Aangemaakt op", value: "createdBy" },
    ],
  }),

  methods: {
    async sendToEM() {
      const _body = JSON.stringify({ id: this.postresult.ID });
       const _hdr = {
        "Content-Type": "application/json;odata.metadata=minimal",
        "OData-Version": "4.0",
        Accept: "application/json",
      };
      const r = await fetch("api/account/notify", {
        method: "post",
          headers: _hdr,
        body: _body,
      });
    },

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
      this.postresult = d;
      this.getPatients();
    },

    async getToken() {
      const _hdr = {
        "Content-Type": "application/x-www-form-urlencoded",
        Accept: "application/json; charset=utf-8",
      };

      const dat = { grant_type: "client_credentials", scope: "read" };
      const URLSearchParams = Object.keys(dat)
        .map((key) => {
          return encodeURIComponent(key) + "=" + encodeURIComponent(dat[key]);
        })
        .join("&");
      //'grant_type=client_credentials&scope=read'
      const r = await fetch("token/", {
        method: "post",
        headers: _hdr,
        body: "grant_type=client_credentials&scope=read",
      });
      this.token = await r.json();
    },

    async getRule() {
      await this.getToken();
      const opt = {
        methode: "get",
        headers: {
          Authorization: `Bearer ${this.token.access_token}`,
        },
      };
      const resp = await fetch(
        `rule/determine-dvocode?orderreason=${this.reden}`,
        opt
      );
      this.ruleresult = await resp.text();
    },

    async getPatients() {
      const resp = await fetch("api/account/Patients");
      const _data = await resp.json();
      this.patientslist = _data.value;
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
