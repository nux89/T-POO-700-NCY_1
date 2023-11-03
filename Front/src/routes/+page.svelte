<script>
  import "./register/auth.scss";
  import NavBar from "$lib/navbar/NavBar.svelte";
  import FusionCharts from "fusioncharts";
  import Timeseries from "fusioncharts/fusioncharts.timeseries";
  import SvelteFC, { fcRoot } from "svelte-fusioncharts";
  import { GET } from "../lib/utils"
  import { slide } from "svelte/transition";
  import { Toaster, toast } from 'svelte-sonner'

  fcRoot(FusionCharts, Timeseries);

  let specificUserID;
  let employees = [];
  let valeurRecherge;
  let value;
  let teams;
  let selected = 'tout';

let showContent = ''

const getTeams = async () => {
    const rep = GET(`/api/teams`)
    rep.then((v) => {
      teams = v;
    })
    return rep;
}

getTeams()

const changeTeam = (id) => {
  console.log("CHANGE:", selected);
  const r = fetch("http://127.0.0.1:4002/api/users/" + id, {
      method: "put",
      headers: {
          "Content-Type": "application/json",
      },
      body: JSON.stringify({ user: {team: selected} }),
  });
  r.then((e) => e.json()).then((e) => {
    toast('✅ Changes made successfully')
    teams = teams;
    valeurRecherge = valeurRecherge;
    selected = 'tout'
  })
  
  .catch((e) => {
      toast('❌ An error has occurred')
  })
}

  const requestDataUserID = (id, payload) => {
	showContent = payload === showContent ? '' : payload

    console.log("ID", id);
    const rep = GET(`/api/workingtimes`)
    .then(v => {
      v.data.map((w) => {
        var date1 = new Date(w.start);
        console.log(date1);
        var date2 = new Date(w.end);

        // Convertissez les dates en timestamps Unix (en millisecondes)
        var timestamp1 = date1.getTime();
        var timestamp2 = date2.getTime();

        // Calculez la différence en millisecondes
        var differenceInMilliseconds = timestamp2 - timestamp1;

        // Convertissez la différence en heures
        var differenceInHours = differenceInMilliseconds / (1000 * 60 * 60);

        console.log("Différence en heures : " + differenceInHours);

        console.log("ID:", id);
        


        // console.log(w.end, w.start);
      })
    })
  }
  let valeurRechergeTeam;

  $: valeurRecherge = employees.filter((a) => a.name.toLowerCase().includes(value || ''));

  let promise,
    jsonify = (res) => res.json(),
    dataFetch = fetch(
      "/data.json"
    ).then(jsonify),
    schemaFetch = fetch(
      "https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/area-chart-with-time-axis-schema.json"
    ).then(jsonify);
    let getListEmployee = fetch(
      "http://localhost:4002/api/users"
    ).then(jsonify)
    .then((v) => {
      employees = v.data
    });

  promise = Promise.all([dataFetch, schemaFetch]);

  const getChartConfig = ([data, schema]) => {
    const fusionDataStore = new FusionCharts.DataStore(),
      fusionTable = fusionDataStore.createDataTable(data, schema);

    return {
      type: "timeseries",
      width: "70%",
      height: 450,
      renderAt: "chart-container",
      dataSource: {
        language: "fr",
        data: fusionTable,
        chart: {
          showLegend: 0,
          theme: "candy"
        },
        caption: {
          text: "Employee Daily Hours",
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
  };

  function filterTeam(name) {
    console.log("NAME", name);
    if (name == 'tout') {
    let getListEmployee = fetch(
      "http://localhost:4002/api/users"
    ).then(jsonify)
    .then((v) => {
      employees = v.data
      valeurRecherge = name == 'tout' ? employees : employees.filter((a) => a.team.includes(name || ''));
    });
    } else {
      valeurRecherge = employees.filter((a) => a.team.includes(name || ''));
    }
  }



</script>
 <Toaster position="top-center" />
<div class="bg" />
<NavBar />
<div class="container">
  <div class="time-manager">
    <div id="chart-container">
      {#await promise}
        <p>Fetching data and schema...</p>
      {:then value}
        <SvelteFC {...getChartConfig(value)} />
      {:catch error}
        <p>Something went wrong: {error.message}</p>
      {/await}
    </div>
  </div>
</div>
  <div class="bloc-recherche">
    <div class="recherche">
      <div class="form-floating">
        <input
          type="email"
          class="form-control"
          id="floatingInput"
          placeholder="name@example.com"
          bind:value
          required
        />
        <label for="floatingInput">Rechercher un employé</label>
      </div>
        {#if teams }
          <select bind:value={selected} on:change={() => filterTeam(selected)} name="group" id="group-team">
              <option value="tout">Tout</option>
              {#each teams.data as val}
                <option value="{val.name}">{val.name}</option>
              {/each}
          </select>
        {/if}
       <div class="liste-employe">
        {#if valeurRecherge}
          {#each valeurRecherge as employe}
            <button on:click={() => requestDataUserID(employe.id, employe.name)}>{employe.name}</button>
            	{#if showContent === employe.name}
                <div transition:slide={{ duration: 400 }}>
                  <div>email: {employe.email}</div>
                  <div>role: {employe.role}</div>
                  <div>equipe: <select name="team" id="team" bind:value={selected} on:change={() => changeTeam(employe.id)}>
                    {#each teams.data as val}
                        <option selected="{val.name == employe.team}" value="{val.name}">{val.name}</option>
                    {/each}
                  </select>
                  </div>
                </div>
              {/if}
          {/each}
        {/if}
      </div>
    </div>
  </div>


<style>
  :global(body) {
    display: flex;
    justify-content: center;
  }

  button {
    background-image: linear-gradient(#2e2e2f, #1a1f27);
    border: 0;
    border-radius: 4px;
    box-shadow: rgba(0, 0, 0, 0.3) 0 5px 15px;
    box-sizing: border-box;
    color: #fff;
    cursor: pointer;
    font-family: Montserrat, sans-serif;
    font-size: 0.9em;
    margin: 5px;
    padding: 10px 15px;
    text-align: center;
    user-select: none;
    -webkit-user-select: none;
    touch-action: manipulation;
  }

  .container {
    padding: 20px;
    overflow: auto;
    display: flex;
    justify-content: center;
  }

  .time-manager {
    display: flex;
    flex-wrap: wrap;
    gap: 10em;
  }

  .time-manager-container {
    display: inline-block;
  }

  .liste-employe {
    display: flex;
    flex-direction: column;
    height: 37em;
    overflow: auto;
    color: white;
  }

  .bloc-recherche {
    display: flex;
    justify-content: center;
    flex: 1;
  }

  .recherche {
    max-width: 20em;
  }

  .list-team {
    overflow-x: auto;
    display: flex;
  }

  #group-team {
    width: 100%;
  }
</style>
