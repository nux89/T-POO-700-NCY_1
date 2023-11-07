<script>
  import FusionCharts from 'fusioncharts';
  import Timeseries from 'fusioncharts/fusioncharts.timeseries';
  import SvelteFC, { fcRoot } from 'svelte-fusioncharts';
  import data from "./data";
  import shema from "./shema";



  fcRoot(FusionCharts, Timeseries);

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


      const fusionTableGo = (d) => {
        return fusionDataStore.createDataTable(d, shema);
      }

    const fusionDataStore = new FusionCharts.DataStore();
      let fusionTable = fusionTableGo(data);


    let chartConfig = {
      type: 'timeseries',
      width: '100%',
      height: 450,
      renderAt: 'chart-container',
      dataSource: {
        data: [],
        chart: {
          showLegend: 0
        },
        caption: {
          text: 'Daily Visitors Count of a Website'
        },
        yAxis: [
          {
            plot: {
              value: 'Daily Visitors',
              type: 'column'
            },
            title: 'Daily Visitors (in thousand)'
          }
        ]
      }
    };

    console.log("BASE: ", chartConfig);



  let getChartConfig = ([d, schema]) => {

  };
  console.log({...chartConfig});

    const updateDataHandler = () => {
      chartConfig.dataSource.data = fusionTableGo([
  [
    "2016-01-01",
    5
  ],
  [
    "2016-01-02",
    90
  ]]); 
      // let dataSource = chartConfig.dataSource.data;
      // console.log(",,,,,",dataSource);
      // dataSource[1] = [1451602800000, 5, '0'];
      // console.log(chartConfig.dataSource.data);
      // chartConfig.dataSource.data["_result"]["data"][0] = [];
      // console.log(dataSource);
      // chartConfig.dataSource.data = 
      // dataSource.data[2].value = getRandomNumber();
      // dataSource.data[3].value = getRandomNumber();
      // console.log(chartConfig, "VS", dataSource);
  //     let newdata = fusionTableGo([
  // [
  //   "2016-01-01",
  //   5
  // ],
  // [
  //   "2016-01-02",
  //   90
  // ]]);
  // console.log(chartConfig.dataSource.data, newdata, {...chartConfig});
// chartConfig.dataSource.data = [];
// chartConfig = {
//   ...chartConfig,
//   newdata
// }

      // chartConfig = {
      //   ...chartConfig,
      //   dataSource
      // };
      // chartConfig = chartConfig;
      // donnes = []
    };
</script>

<div id="chart-container" >
    <SvelteFC
    bind:chartConfig
      {...chartConfig}
    />
      <button class="btn btn-outline-secondary btn-sm" on:click={updateDataHandler}>Click to Update Data</button>

</div>