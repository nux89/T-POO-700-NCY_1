<script>
    import NavBar from "$lib/navbar/NavBar.svelte";
  import { get } from "svelte/store";
    import "../register/auth.scss";

    let clocks;
    
  import { PUBLIC_URL_API } from '$env/static/public';    
    
    function getUserFromStorage() {
        const user = localStorage.getItem("user");
        if (user) {
            return JSON.parse(user);
        }
        return null;
    }

    async function getclocks() {

      let user = getUserFromStorage();
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch(PUBLIC_URL_API+"/api/clocks/" + user.data.id , requestOptions)
        .then(response => response.text())
        .then(result => localStorage.setItem("clocks", result))
        .catch(error => console.log('error', error));
      clocks = JSON.parse(localStorage.getItem("clocks"));
      return clocks
    }

    async function createClock() {
      await getclocks()
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
      if (clocks.data.length == 0) {
        newclock.clock.status = true
      } else {
        if (clocks.data[clocks.data.length - 1].status == true) {
          newclock.clock.status = false
          CreateWorkingTime()
        }
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

    }




    function CreateWorkingTime() {
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      let workingtime = {
        "workingtime": {
          "end": new Date(),
          "start": "2018-03-29T13:34:00.000"
        }
      } 
      let clocks = JSON.parse(localStorage.getItem("clocks"));
      workingtime.workingtime.start = clocks.data[clocks.data.length - 1].time
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
        clocks = JSON.parse(localStorage.getItem("clocks"));
    }

    getclocks()

    
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