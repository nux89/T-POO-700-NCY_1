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

  const updateDataHandler = () => {
    chartConfig.dataSource.data = fusionTableGo([
      ["2016-01-01", 5],
      ["2016-01-02", 90],
    ]);
  };

  const requestDataUserID = (id, payload) => {
    showContent = payload === showContent ? "" : payload;

    console.log("ID", id);
    const rep = GET(`/api/workingtimes`).then((v) => {
      console.log(v);
    });
  };

  async function fetchEmployee() {
    return await GET(`/api/users`);
  }
  async function fetchTeams() {
    return await GET(`/api/teams`);
  }
  let promise = fetchEmployee();

const changeTeam = (id, idx) => {
  console.log("CHANGE:", selected);
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
<div class="bg" />

<div id="chart-container">
  <SvelteFC {...chartConfig} />
  <button class="btn btn-outline-secondary btn-sm" on:click={updateDataHandler}
    >Click to Update Data</button
  >
</div>

{#await promise}
  <h1>Chargement</h1>
{:then { data }}
  <div class="bloc-recherche">
    <div class="recherche">
      <div class="form-floating">
        <input
          type="email"
          class="form-control"
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
            <option value={val.name}>{val.name}</option>
          {/each}
        </select>
      <ul class="list-group">

        {#each data as employe, i}
        <div style="display: flex;">
          <button
            class="list-group-item active"
            style="flex: 10"
            on:click={() => requestDataUserID(employe.id, employe.name)}
            >{employe.name}</button
          >
          <!-- <Select options={teams.data} bind:value={selected}></Select> -->
          <select
            style="flex: 1"
            bind:value={selected[i]}
            on:change={() => changeTeam(employe.id, i)}
            name="group"
            id="group-team"
          >
            {#each teams.data as val}
              <option value={val.name} selected={val.name == employe.team ? true : false}>{val.name}</option>
              {console.log(val.name, employe.team)}
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

      <div class="liste-employe">
        <!-- {#if valeurRecherge} -->
        <!-- {#each data as employe} -->
        <!-- {console.log(employe)} -->
        <!-- <button on:click={() => requestDataUserID(employe.id, employe.name)}>{employe.name}</button> -->
        <!-- {#if showContent === employe.name}
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
              {/if} -->
        <!-- {/each} -->
        <!-- {/if} -->
      </div>
    </div>
  </div>
{/await}

<style>
  :global(.list-group-item.active) {
    background-color: #212529;
  }

  #group-team {
    width: 100%;
  }
  .bg {
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
