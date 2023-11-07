<script>
    import { getAllContexts } from "svelte";
    import { get } from "svelte/store";

    let teamData;
    let usersData;

function createTeam(e) {
    var myHeaders = new Headers();
myHeaders.append("Content-Type", "application/json");

var raw = JSON.stringify({
  "team": {
    "name": e.target[0].value
  }
});

var requestOptions = {
  method: 'POST',
  headers: myHeaders,
  body: raw,
  redirect: 'follow'
};

fetch("http://localhost:4002/api/team", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));


}

function getUserFromStorage() {
    return JSON.parse(localStorage.getItem("user"));
}

function getTeamFromStorage () {
    return JSON.parse(localStorage.getItem("team"));
}

async function getTeam() {
    var myHeaders = new Headers();
myHeaders.append("Content-Type", "application/json");

var requestOptions = {
  method: 'GET',
  headers: myHeaders,
  redirect: 'follow'
};

await fetch("http://localhost:4002/api/team", requestOptions)
  .then(response => response.text())
  .then(result => localStorage.setItem("team", result))
  .catch(error => console.log('error', error));

  teamData = JSON.parse(localStorage.getItem("team"));
}

function deleteTeam(id) {
    var requestOptions = {
  method: 'DELETE',
  redirect: 'follow'
};
console.log(id)
fetch("http://localhost:4002/api/team/" + id, requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));

}

async function GetAllUsers() {
    var requestOptions = {
  method: 'GET',
  redirect: 'follow'
};

await fetch("http://localhost:4002/api/users/", requestOptions)
  .then(response => response.text())
  .then(result => localStorage.setItem("users", result))
  .catch(error => console.log('error', error));

    usersData = JSON.parse(localStorage.getItem("users"));
}

function setUserTeam(id, team) {
    var myHeaders = new Headers();
    myHeaders.append("Content-Type", "application/json");

    var raw = JSON.stringify({
    "user": {
        "team": team
    }
    });

    var requestOptions = {
    method: 'PUT',
    headers: myHeaders,
    body: raw,
    redirect: 'follow'
    };

    fetch("http://localhost:4002/api/users/" + id, requestOptions)
    .then(response => response.text())
    .then(result => console.log(result))
    .catch(error => console.log('error', error));
    
}

function findTeamById(id) {
        if (teamData) {
            const team = teamData.data.find(team => team.id == id);
            return team ? team.name : "Team Not Found";
        }
        return "Loading...";
    }

GetAllUsers()
getTeam()

function Show(user) {
    console.log(user)
}

</script>

<main>
    <div class="bg">
    <div class="content">
    <div class="container">
    <form on:submit|preventDefault={createTeam}> 
        <input type="text" placeholder="Name" required>
        <button type="submit">Create Team</button>
    </form>
    </div>
    <div class="container">
        {#if usersData && teamData}
            <table class="table">
                <tr class="table-header">
                    <th>User Name</th>
                    <th>Email</th>
                    <th>Current Team</th>
                    <th>Change Team</th>
                </tr>
                {#each usersData.data as user}
                    <tr class="usercard">
                        <td>{user.name}</td>
                        <td>{user.email}</td>
                        <td>{findTeamById(user.team)}</td>
                        <td class="team_changer">
                            <select class="select" bind:value={user.team}>
                                {#each teamData.data as team}
                                    <option value={team.id}>{team.name}</option>
                                {/each}
                            </select>
                            <button class="button" on:click={() => setUserTeam(user.id, user.team)}>Validate</button>
                        </td>
                    </tr>
                {/each}
            </table>
        {:else}
            <p class="loading">Loading...</p>
        {/if}
    </div>
    
    
    
    <div class="container">
        <table class="table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                {#if teamData}
                    {#each teamData.data as team}
                        <tr>
                            <td>{team.name}</td>
                            <td>
                                <button class="button" on:click|preventDefault={() => deleteTeam(team.id)}>Delete</button>
                            </td>
                        </tr>
                    {/each}
                {:else}
                    <tr>
                        <td colspan="2">loading...</td>
                    </tr>
                {/if}
            </tbody>
        </table>
    </div>
    
</div>
</div>
</main>

<style>
        .bg {
    position:absolute;
    z-index:-1;
    top:0;
    right:0;
    bottom:0;
    left:0;
    
    background-image: radial-gradient(circle at 30% 86%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0.03) 8%,transparent 8%, transparent 92%),radial-gradient(circle at 55% 100%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0.03) 8%,transparent 8%, transparent 92%),radial-gradient(circle at 40% 75%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0.03) 6%,transparent 6%, transparent 94%),radial-gradient(circle at 7% 99%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0.03) 6%,transparent 6%, transparent 94%),radial-gradient(circle at 69% 76%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0.03) 6%,transparent 6%, transparent 94%),radial-gradient(circle at 2% 35%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0.03) 6%,transparent 6%, transparent 94%),radial-gradient(circle at 14% 48%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0.03) 6%,transparent 6%, transparent 94%),radial-gradient(circle at 28% 87%, rgba(255,255,255,0.04) 0%, rgba(255,255,255,0.04) 4%,transparent 4%, transparent 96%),radial-gradient(circle at 65% 14%, rgba(255,255,255,0.04) 0%, rgba(255,255,255,0.04) 4%,transparent 4%, transparent 96%),radial-gradient(circle at 51% 36%, rgba(255,255,255,0.04) 0%, rgba(255,255,255,0.04) 4%,transparent 4%, transparent 96%),radial-gradient(circle at 6% 93%, rgba(255,255,255,0.04) 0%, rgba(255,255,255,0.04) 4%,transparent 4%, transparent 96%),linear-gradient(135deg, rgb(23, 233, 173),rgb(29, 24, 208));
    }
    .content {
        max-width: 70%;
        margin: 0 auto;
        padding: 0 20px;
        margin-top: 2%;
        background-color: white;
        border-radius: 15px;
        padding: 20px;
    }

    .container {
        text-align: center;
    }

    .table {
        border-collapse: collapse;
        width: 100%;
        margin: 20px auto;
        border: 1px solid #e0e0e0;
    }

    .table th, .table td {
        border: 1px solid #e0e0e0;
        padding: 12px;
        text-align: left;
    }

    .table th {
        background-color: #f5f5f5;
        font-weight: bold;
    }

    .table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .usercard {
        background-color: #fff;
        border: 1px solid #e0e0e0;
        border-radius: 6px;
        padding: 16px;
        margin-bottom: 10px;
    }

    .select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .button {
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        padding: 10px 20px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .button:hover {
        background-color: #0056b3;
    }

    .loading {
        text-align: center;
    }

    .team_changer {
        display: flex;
        justify-content: space-between;
    }

</style>

