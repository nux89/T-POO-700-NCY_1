<script>
    import NavBar from "$lib/navbar/NavBar.svelte";
  import { get } from "svelte/store";
    import "../register/auth.scss";
    
  import { PUBLIC_URL_API } from '$env/static/public';    
    
    function getUserFromStorage() {
        const user = localStorage.getItem("user");
        if (user) {
            return JSON.parse(user);
        }
        return null;
    }

    async function getclocks() {
      console.log("getclocks")

      let user = getUserFromStorage();
      console.log(user.data.id)
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch(PUBLIC_URL_API+"/api/clocks/" + user.data.id , requestOptions)
        .then(response => response.text())
        .then(result => localStorage.setItem("clocks", result))
        .catch(error => console.log('error', error));
      console.log(JSON.parse(localStorage.getItem("clocks")))
    }

    async function createClock() {
      await getclocks()
      console.log(JSON.parse(localStorage.getItem("clocks")))
      let user = getUserFromStorage();
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");
      let clocks = JSON.parse(localStorage.getItem("clocks"));

      let newclock = {
        "clock": {
          "status": true,
          "time": new Date()
        }
      }
      console.log(clocks.data[clocks.data.length - 1])
      if (clocks.data[clocks.data.length-1] == undefined) {
        console.log("undefined debug")
        newclock.clock.status = true
      } else if (clocks.data[clocks.data.length-1].status == true) {
        console.log("true debug")
        newclock.clock.status = false
      } else if (clocks.data[clocks.data.length-1].status == false) {
        console.log("false debug")
        newclock.clock.status = true
      }
      
      var raw = JSON.stringify(newclock);

      var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
      };

      fetch(PUBLIC_URL_API+"/api/clocks/" + user.data.id , requestOptions)
        .then(response => response.text())
        .then(result => console.log(result))
        .catch(error => console.log('error', error));

      if (clocks.data[clocks.data.length - 1] == undefined) {
        return
      } else if (clocks.data[clocks.data.length - 1].status == true) {
        CreateWorkingTime()
      }
    }


    function CreateWorkingTime() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      let workingtime = {
        "workingtime": {
          "end": "2019-03-29T13:34:00.000",
          "start": "2018-03-29T13:34:00.000"
        }
      } 

      getclocks()
      let clocks = JSON.parse(localStorage.getItem("clocks"));
      workingtime.workingtime.start = clocks.data[clocks.data.length - 2].time
      workingtime.workingtime.end = clocks.data[clocks.data.length - 1].time
      var raw = JSON.stringify(workingtime);
      let user = getUserFromStorage();

      var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
      };

      fetch(PUBLIC_URL_API+"/api/workingtimes/" + user.data.id , requestOptions)
        .then(response => response.text())
        .then(result => console.log(result))
        .catch(error => console.log('error', error));
    }

    function debug() {
        console.log("debug")
    }
    
</script>

<NavBar />

    <div class="btn-action">
      <button class="w-100 form-signin btn btn-lg" on:click={getclocks}>GET CLOCK</button>
      <button class="w-100 form-signin btn btn-lg" on:click={createClock}>CREATE CLOCK</button>
      <button class="w-100 form-signin btn btn-lg" on:click={CreateWorkingTime}>CREATE WORKING TIME</button>
    </div>

<style>
.btn-action {
  display: flex;
  flex-direction: column;
  gap: 1em;
}
.btn-action button {
  border: 1px solid white;
  color:white;
}


    
</style>