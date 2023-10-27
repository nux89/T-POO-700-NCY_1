<script>
    import "../register/auth.scss";
    import NavBar from "$lib/navbar/NavBar.svelte";
    import { onMount } from "svelte";
    import { Toaster, toast } from 'svelte-sonner'
    let jsonId;
    let url = "http://127.0.0.1:4002/api/users/";

    function checkIfConnected() {
        const id = localStorage.getItem('user')
        jsonId = JSON.parse(id)
        if (!jsonId) {        
            return window.location.href = "/login";
        }
        return jsonId.data.id;
    }


    async function getUserData() {
        const id = checkIfConnected();

        const res = await fetch(url + id)
        .then(e => e.json())
        .then((e) => e);
        return res.data;
    }

    async function validationFormulaire(e) {
        const id = checkIfConnected();
        const formData = new FormData(e.target);

        const data = {};
        for (let field of formData) {
            const [key, value] = field;
            data[key] = value;
        }

        const r = fetch(url + id, {
            method: "put",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ user: data }),
        });
        r.then((e) => {
            toast('✅ Changes made successfully')
        }).catch((e) => {
            toast('❌ An error has occurred')
        })
    }
</script>

<NavBar />
 <Toaster position="top-center" />

<div class="bg" />

<main class="form-signin">
    <h1 class="h3">Profile</h1>
{#await getUserData()}
<p>Chargement...</p>    
{:then data} 
    <form on:submit|preventDefault={validationFormulaire}>
        <div class="form-floating">
            <input
                type="email"
                class="form-control"
                id="floatingInput"
                placeholder="name@example.com"
                name="email"
                value="{data.email}"
                required
            />
            <label for="floatingInput">Change your Email address</label>
        </div>
        <div class="form-floating">
            <input
                type="text"
                class="form-control"
                id="floatingInput2"
                placeholder="YourName"
                name="name"
                value="{data.name}"
                required
            />
            <label for="floatingInput2">Change your name</label>
        </div>
        <div class="form-floating">
            <input
                type="password"
                class="form-control"
                id="floatingPassword"
                placeholder="Password"
                name="password"
                value="{data.password}"
                required
            />
            <label for="floatingPassword">Change Your Password</label>
        </div>

        <div>
            <p class="font-weight-bold role">Your current role : {data.role}</p>
        </div>

        <button class="w-100 btn btn-lg" type="submit">Save changes</button>
    </form>
{/await}
</main>
