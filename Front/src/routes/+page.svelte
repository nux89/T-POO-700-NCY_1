<script>
  import FusionCharts from "fusioncharts";
  import Timeseries from "fusioncharts/fusioncharts.timeseries";
  import SvelteFC, { fcRoot } from "svelte-fusioncharts";
  import data from "./data";
  import shema from "./shema";
  import { GET } from "../lib/utils";
  import { slide } from "svelte/transition";
  import { PUBLIC_URL_API } from '$env/static/public';    
  import { Toaster, toast } from 'svelte-sonner'
  import Select from "$lib/Select.svelte";
    import { onMount } from "svelte";

  fcRoot(FusionCharts, Timeseries);

  let specificUserID;
  let employees = [];
  let valeurRecherge;
  let value;


  fcRoot(FusionCharts, Timeseries);

  // $: valeurRecherge = employees.filter((a) => a.name.toLowerCase().includes(value || ''));

  // let promise,
  //   jsonify = res => res.json(),
  //   dataFetch = fetch(
  //     'https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/column-chart-with-time-axis-data.json'
  //   ).then(jsonify),
  //   schemaFetch = fetch(
  //     'https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/column-chart-with-time-axis-schema.json'
  //   ).then(jsonify);

  // promise = Promise.all([dataFetch, schemaFetch]);
  // donnes = data;
  let selectedTeam = "tout";
  let selected = [];
  let showContent = "";
  let role;
  let infoUser;
  function getUserFromStorage() {
      const user = localStorage.getItem("user");
      if (user) {
          return JSON.parse(user);
      }
      return null;
  }

  onMount(() => {
    infoUser = getUserFromStorage();
    if (!infoUser) {
      window.location.href = "/login";
    }
    role = infoUser.data.role;
    if (role == "employee") {
      updateDataHandler(infoUser.data.id)
    }
  })

  const fusionTableGo = (d) => {
    return fusionDataStore.createDataTable(d, shema);
  };

  const fusionDataStore = new FusionCharts.DataStore();
  let fusionTable = fusionTableGo(data);

  let chartConfig = {
    type: "timeseries",
    width: "100%",
    height: 450,
    renderAt: "chart-container",
    dataSource: {
      data: [],
      chart: {
        showLegend: 0,
      },
      caption: {
        text: "Daily Visitors Count of a Website",
      },
      yAxis: [
        {
          plot: {
            value: "Daily Visitors",
            type: "column",
          },
          title: "Daily Visitors (in thousand)",
        },
      ],
    },
  };

  const updateDataHandler = (id) => {

      chartConfig.dataSource.data = []
    const rep = GET(`/api/workingtimes`)
    .then(v => {

      let donnes = [];
      let search;
      if (id) {
        console.log(",,,",v.data);
        search = v.data.filter(v => v.user_id == id);
        console.log(search);
      } else {
        search = v.data;
      }

      search.map((w) => {
        var date1 = new Date(w.start);
        var date2 = new Date(w.end);

        // Convertissez les dates en timestamps Unix (en millisecondes)
        var timestamp1 = date1.getTime();
        var timestamp2 = date2.getTime();

        // Calculez la différence en millisecondes
        var differenceInMilliseconds = timestamp2 - timestamp1;

        // Convertissez la différence en heures
        var differenceInHours = differenceInMilliseconds / (1000 * 60 * 60);


        // console.log("ID:", id);
        donnes.push([w.start.split("T")[0],differenceInHours])

        // console.log(w.end, w.start);
      })

      chartConfig.dataSource.data = fusionTableGo(donnes);
    })
  };
  // const requestDataUserID = (id) => {
  //   console.log("ID", id);
  //   const rep = GET(`/api/workingtimes`)
  //   .then(v => {
  //     v.data.map((w) => {
  //       var date1 = new Date(w.start);
  //       console.log(date1);
  //       var date2 = new Date(w.end);

  //       // Convertissez les dates en timestamps Unix (en millisecondes)
  //       var timestamp1 = date1.getTime();
  //       var timestamp2 = date2.getTime();

  //       // Calculez la différence en millisecondes
  //       var differenceInMilliseconds = timestamp2 - timestamp1;

  //       // Convertissez la différence en heures
  //       var differenceInHours = differenceInMilliseconds / (1000 * 60 * 60);

  //       console.log("Différence en heures : " + differenceInHours);

  //       console.log("ID:", id);
        


  //       // console.log(w.end, w.start);
  //     })
  //   })
  // }
  const requestDataUserID = (id, payload, specific = false) => {
    showContent = payload === showContent ? "" : payload;


    if (specific) {
    const rep = GET(`/api/workingtimes`).then((v) => {
      v.data.map((e) => {
        console.log(e.user_id);
      })
    });
    } else {
    const rep = GET(`/api/workingtimes`).then((v) => {
      v.data
    });
    }
  };

  async function fetchEmployee() {
    return await GET(`/api/users`);
  }
  async function fetchTeams() {
    return await GET(`/api/teams`);
  }
  let promise = fetchEmployee();

const changeTeam = (id, idx) => {
  const r = fetch(PUBLIC_URL_API+"/api/users/" + id, {
      method: "put",
      headers: {
          "Content-Type": "application/json",
      },
      body: JSON.stringify({ user: {team: selected[idx]} }),
  });
  r.then((e) => e.json()).then((e) => {
    toast('✅ Changes made successfully')
    promise = fetchEmployee();
  })
  
  .catch((e) => {
      toast('❌ An error has occurred')
  })
}

</script>
<Toaster position="top-center" />

<div id="chart-container">
  <SvelteFC {...chartConfig} />
</div>

{#await promise}
  <h1>Chargement</h1>
{:then { data }}
{#if role != "employee"}
  <div class="bloc-recherche">
    <div class="recherche">
      <div class="form-floating">
        <input
          type="email"
          class="form-control mb-2"
          id="floatingInput"
          placeholder="name@example.com"
          required
        />
        <label for="floatingInput">Rechercher un employé</label>
      </div>
      {#await fetchTeams()}
        <p>chargement...</p>
      {:then teams}
        <select
          class="form-select"
          on:change={() => null}
          name="group"
          id="group-team"
        >
          <option value="tout" selected>Tout</option>
          {#each teams.data as val}
            <option value={val.name} on:click={() => updateDataHandler(val.id)}>{val.name}</option>
          {/each}
        </select>
      <ul class="list-group">

        {#each data as employe, i}
        <div style="display: flex;">
          <button
            class="list-group-item active"
            style="flex: 10"
            on:click={() => updateDataHandler(employe.id)}
            >{employe.name}</button
          >
          <!-- <Select options={teams.data} bind:value={selected}></Select> -->
          <select
            bind:value={selected[i]}
            on:change={() => changeTeam(employe.id, i)}
            class="group-team-emp"
            name="group"
            id="group-team"
          >
            {#each teams.data as val}
              <option value={val.name} selected={val.name == employe.team ? true : false}>{val.name}</option>
            {/each}
          </select>
        </div>

          {#if showContent === employe.name}
            <div transition:slide={{ duration: 400 }}>
              <div>email: {employe.email}</div>
              <div>role: {employe.role}</div>
              <div>equipe:</div>
            </div>
          {/if}
        {/each}
      </ul>

      {/await}
    </div>
  </div>
{:else}
<div style="display: flex; justify-content: center; align-items: center;">

<div class="card" style="width: 18rem;">
  <div class="card-body">
    <h5 class="card-title">Welcome <span style="font-weight: bold;color: cornflowerblue;">{infoUser.data.name}</span>,</h5>
    <p class="card-text">User informations.</p>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item"><span style="font-weight: bold;">Email</span>: {infoUser.data.email}</li>
    <li class="list-group-item"><span style="font-weight: bold;">Role</span>: {infoUser.data.role}</li>
    <li class="list-group-item"><span style="font-weight: bold;">Team</span>: {infoUser.data.team}</li>
  </ul>
  <div class="card-body">
    <a href="/profile" class="card-link">Edit</a>
  </div>
</div>
</div>
{/if}

{/await}

<style lang="scss">

  .bloc-recherche {
    width: 100%;
    display: flex;
    justify-content: center;
  }
  :global(.list-group-item.active) {
    background-color: #212529;
  }

  .recherche {
    width: 50vw;
    @media screen and (max-width: 480px) {
        width: auto;
    }
  }

.group-team-emp {
  flex: 1;
    @media screen and (max-width: 480px) {
        flex: 4;
    }
}

  #group-team {
    width: 100%;
  }

#chart-container {
  padding-top: 4em;
  padding-bottom: 2em;
}
  :global(.bg) {
    position: absolute;
    z-index: -1;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background-image: radial-gradient(
        circle at 30% 86%,
        rgba(255, 255, 255, 0.03) 0%,
        rgba(255, 255, 255, 0.03) 8%,
        transparent 8%,
        transparent 92%
      ),
      radial-gradient(
        circle at 55% 100%,
        rgba(255, 255, 255, 0.03) 0%,
        rgba(255, 255, 255, 0.03) 8%,
        transparent 8%,
        transparent 92%
      ),
      radial-gradient(
        circle at 40% 75%,
        rgba(255, 255, 255, 0.03) 0%,
        rgba(255, 255, 255, 0.03) 6%,
        transparent 6%,
        transparent 94%
      ),
      radial-gradient(
        circle at 7% 99%,
        rgba(255, 255, 255, 0.03) 0%,
        rgba(255, 255, 255, 0.03) 6%,
        transparent 6%,
        transparent 94%
      ),
      radial-gradient(
        circle at 69% 76%,
        rgba(255, 255, 255, 0.03) 0%,
        rgba(255, 255, 255, 0.03) 6%,
        transparent 6%,
        transparent 94%
      ),
      radial-gradient(
        circle at 2% 35%,
        rgba(255, 255, 255, 0.03) 0%,
        rgba(255, 255, 255, 0.03) 6%,
        transparent 6%,
        transparent 94%
      ),
      radial-gradient(
        circle at 14% 48%,
        rgba(255, 255, 255, 0.03) 0%,
        rgba(255, 255, 255, 0.03) 6%,
        transparent 6%,
        transparent 94%
      ),
      radial-gradient(
        circle at 28% 87%,
        rgba(255, 255, 255, 0.04) 0%,
        rgba(255, 255, 255, 0.04) 4%,
        transparent 4%,
        transparent 96%
      ),
      radial-gradient(
        circle at 65% 14%,
        rgba(255, 255, 255, 0.04) 0%,
        rgba(255, 255, 255, 0.04) 4%,
        transparent 4%,
        transparent 96%
      ),
      radial-gradient(
        circle at 51% 36%,
        rgba(255, 255, 255, 0.04) 0%,
        rgba(255, 255, 255, 0.04) 4%,
        transparent 4%,
        transparent 96%
      ),
      radial-gradient(
        circle at 6% 93%,
        rgba(255, 255, 255, 0.04) 0%,
        rgba(255, 255, 255, 0.04) 4%,
        transparent 4%,
        transparent 96%
      ),
      linear-gradient(135deg, rgb(23, 233, 173), rgb(29, 24, 208));
  }
</style>
