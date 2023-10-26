<script>
    import "./auth.scss";
    import NavBar from "$lib/navbar/NavBar.svelte";
    function validationFormulaire(e) {
        console.log("VALIDATION");
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
                required
            />
            <label for="floatingPassword">Password</label>
        </div>

        <div class="checkbox mb-3">
            <div class="form-check form-switch">
                <input
                    class="form-check-input"
                    type="checkbox"
                    value="1"
                    name="remember_me"
                    id="rememberMeSwitch"
                />
                <label class="form-check-label" for="rememberMeSwitch">
                    Remember me</label
                >
            </div>
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
