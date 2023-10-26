<script>
    import "../register/auth.scss";
    import NavBar from "$lib/navbar/NavBar.svelte";
    function validationFormulaire(e) {
        console.log("VALIDATION");
    }
</script>

<NavBar />
<div class="bg" />

<main class="form-signin">
    <h1 class="h3">Profile</h1>

    <form on:submit|preventDefault={validationFormulaire}>
        <div class="form-floating">
            <input
                type="email"
                class="form-control"
                id="floatingInput"
                placeholder="name@example.com"
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
                required
            />
            <label for="floatingPassword">Change Your Password</label>
        </div>

        <div>
            <p class="font-weight-bold role">Your current role : super</p>
        </div>

        <button class="w-100 btn btn-lg" type="submit">Save changes</button>
    </form>
</main>
