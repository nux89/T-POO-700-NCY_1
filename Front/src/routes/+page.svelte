<script>
  import FusionCharts from "fusioncharts";
  import Charts from "fusioncharts/fusioncharts.charts";

  import FusionTheme from "fusioncharts/themes/fusioncharts.theme.fusion";
  import SvelteFC, { fcRoot } from "svelte-fusioncharts";

  import dataSource from "./data.js";
  import moment from "moment";
  import SvelteHeatmap from "svelte-heatmap";
  import Timeseries from 'fusioncharts/fusioncharts.timeseries';

  let promise,
    jsonify = res => res.json(),
    dataFetch = fetch('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/data/area-chart-with-time-axis-data.json').then(jsonify),
    schemaFetch = fetch('https://s3.eu-central-1.amazonaws.com/fusion.store/ft/schema/area-chart-with-time-axis-schema.json').then(jsonify);

  promise = Promise.all([dataFetch, schemaFetch]);

  const getChartConfig = ([data, schema]) => {
    const fusionDataStore = new FusionCharts.DataStore();
    const fusionTable = fusionDataStore.createDataTable(data, schema);


   const dataSource = {
  "chart": {
    "showlegend": 0
  },
  "caption": {
    "text": "Daily Visitors Count of a Website"
  },
  "yaxis": [
    {
      "plot": {
        "value": "Daily Visitors",
        "type": "area"
      },
      "title": "Daily Visitors Count",
      "format": {
        "suffix": "k"
      }
    }
  ]
};
   dataSource.data = fusionTable;

    return {
      type: 'timeseries',
      width: '100%',
      height: 450,
      renderAt: 'chart-container',
      dataSource,
    };
  };

  // Generate a random number
  function rand(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  // Generate dummy data for a heatmap
  function generateFakeData() {
    const data = [];
    const date = moment().subtract(1, "year");
    const now = moment();

    while (date.isBefore(now)) {
      data.push({
        date: date.toDate(),
        value: rand(0, 4),
      });

      date.add(1, "day");
    }

    return data;
  }

  const fakeData = generateFakeData();

  fcRoot(FusionCharts, Charts, FusionTheme, Timeseries);

  let chartObj,
    chartConfig = {
      id: "column-chart",
      type: "column2d",
      width: "600",
      height: "400",
      renderAt: "chart-container",
      dataSource
    };

  const changeChartTypeHandler = (arg) => {
    chartObj.chartType(arg);
  };

  console.log(fakeData);
</script>

<div class="time-manager">
  <div class="time-manager-container">
    <div id="chart-container">
      <SvelteFC {...chartConfig} bind:chart={chartObj} />
    </div>
    <div>
      <div class="change-type">
        <div id="radio1">
          <input
            name="theme-selecter"
            id="radioButton1"
            type="radio"
            on:change={() => {
              changeChartTypeHandler("column2d");
            }}
            checked="checked"
          />
          <label for="radioButton1">Column 2D Chart</label>
        </div>
        <div id="radio2">
          <input
            name="theme-selecter"
            id="radioButton2"
            type="radio"
            on:change={() => {
              changeChartTypeHandler("bar2d");
            }}
          />
          <label for="radioButton2">Bar 2D Chart</label>
        </div>
        <div id="radio3">
          <input
            name="theme-selecter"
            id="radioButton3"
            type="radio"
            on:change={() => {
              changeChartTypeHandler("pie2d");
            }}
          />
          <label for="radioButton4">Pie 2D Chart</label>
        </div>
        <div id="radio3">
          <input
            name="theme-selecter"
            id="radioButton4"
            type="radio"
            on:change={() => {
              changeChartTypeHandler("timeseries");
            }}
          />
          <label for="radioButton4">Timeserie Chart</label>
        </div>
      </div>
    </div>

    <div class="container">
      <SvelteHeatmap
        allowOverflow={true}
        cellGap={5}
        cellRadius={1}
        colors={["#a1dab4", "#42b6c4", "#2c7fb9", "#263494"]}
        data={fakeData}
        dayLabelWidth={20}
        emptyColor={"#ecedf0"}
        endDate={moment().toDate()}
        monthGap={20}
        monthLabelHeight={20}
        startDate={moment().subtract(5, "months").toDate()}
        view={"monthly"}
      />
    </div>
  </div>

  <div class="bloc-recherche">
    <div class="recherche">
      <input type="text" placeholder="Rechercher un employé" />
      <div class="liste-employe">
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
        <button>hello</button>
      </div>
    </div>
  </div>
</div>

<!-- <div id="chart-container" >
  {#await promise}
    <p>Fetching data and schema...</p>
  {:then value}
    <SvelteFC
    {...chartConfig}
    />
  {:catch error}
    <p>Something went wrong: {error.message}</p>
  {/await}
</div> -->

<style>
  .container {
    border: 1px solid;
    padding: 20px;
  }

  .time-manager {
    display: flex;
    flex-wrap: wrap;
  }

  .time-manager-container {
    display: inline-block;
  }

  .liste-employe {
    display: flex;
    flex-direction: column;
  }

  .bloc-recherche {
    display: flex;
    justify-content: center;
    flex: 1;
  }

</style>

