<script>
    import "./auth.scss";
    import NavBar from "$lib/navbar/NavBar.svelte";
    import { POST, GET } from "$lib/utils";
    function validationFormulaire(e) {
        const formData = new FormData(e.target);

        const data = {};
        for (let field of formData) {
            const [key, value] = field;
            data[key] = value;
        }
        var raw = JSON.stringify({
            "user": {
                "email": data.email,
                "name": data.name,
                "password": data.password,
                "role": data.role,
                "team": "none",
            }
        });

        const r = fetch("http://127.0.0.1:4002/api/users/", {
            method: "post",
            headers: {
                "Content-Type": "application/json",
            },
            body: raw,
        });
        r.then((e) => {
            console.log("OK", e);
        }).catch((e) => {
            console.log("NO OK", e);
        })
    }
</script>

<NavBar />
<div class="bg" />
<main class="form-signin">
    <h1 class="h3">Register</h1>

    <form on:submit|preventDefault={validationFormulaire}>
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
            <select name="role" id="role">
                <option value="employee">Employee</option>
                <option value="manager">Manager</option>
                <option value="supermanager">Super Manager</option>
            </select>
        </div>

        <button class="w-100 btn btn-lg" type="submit">Sign in</button>
    </form>
</main>

<!-- <div class="form-container">
<form on:submit|preventDefault={validationFormulaire}>
    <h1>Registration</h1>
    <label for="email">Email</label>
    <input type="email" name="email" />

    <label for="name">Name</label>
    <input type="text" name="name" />

    <label for="password">Password</label>
    <input type="password" name="password" />

    <label for="passwordConfirmation">Password Confirmation</label>
    <input type="password" name="passwordConfirmation" />

    <button disabled={true} on:click|preventDefault> Submit </button>
</form>
</div> -->
