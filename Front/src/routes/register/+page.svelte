<script>
    import "./auth.scss";
    import NavBar from "$lib/navbar/NavBar.svelte";
    import { PUBLIC_URL_API } from '$env/static/public';    
    import { POST, GET } from "$lib/utils";
    import { fade } from "svelte/transition";
//   import { fade, blur, fly, slide, scale } from "svelte/transition";
//   import { quintOut } from "svelte/easing";
    function validationFormulaire(e) {
        const formData = new FormData(e.target);

        const data = {};
        for (let field of formData) {
            const [key, value] = field;
            data[key] = value;
        }

        const r = fetch(PUBLIC_URL_API+ "/api/users", {
            method: "post",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ user: data }),
        });
        r.then((e) => {
            console.log("OK", e);
            console.log(r.body)
        }).catch((e) => {
            console.log("NO OK", e);
        })
    }
</script>

<NavBar />
<main class="form-signin">
    <h1 class="h3">Register</h1>

    <form on:submit|preventDefault={validationFormulaire} in:fade>
        <div class="form-floating">
            <input
                type="email"
                class="form-control"
                id="floatingInput"
                name="email"
                placeholder="name@example.com"
                required
            />
            <label for="floatingInput">Email address</label>
        </div>
        <div class="form-floating">
            <input
                type="text"
                class="form-control"
                id="floatingInput2"
                name="name"
                placeholder="YourName"
                required
            />
            <label for="floatingInput2">Your amazing name</label>
        </div>
        <div class="form-floating">
            <input
                type="password"
                class="form-control"
                id="floatingPassword"
                placeholder="Password"
                name="password"
                required
            />
            <label for="floatingPassword">Password</label>
        </div>

        <div class="form-floating">
            <select name="role" id="role" class="form-select" >
                <option selected value="employee">Employee</option>
                <option value="manager">Manager</option>
            </select>
        </div>

        <button class="w-100 btn btn-lg" type="submit">Sign in</button>
    </form>
</main>

<style>
    #role {
        height: 3em;
        background: #8080804a;
        color: white;
        margin-bottom: 1em;
        padding-top: 0;
        padding-bottom: 0;
    }
</style>