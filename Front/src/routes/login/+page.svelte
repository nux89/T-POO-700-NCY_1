<svelte:head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
</svelte:head>

<script>
    import NavBar from "$lib/navbar/NavBar.svelte";
    import "../register/auth.scss";
    function validationFormulaire(e) {
        console.log("VALIDATION");
    }
</script>

<NavBar />
<div class="bg">
</div>

  <main class="form-signin">
    
      <h1 class="h3">Login</h1>
    
    <form action="">


      <div class="form-floating">
        <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" required>
        <label for="floatingInput">Email address</label>
      </div>
      <div class="form-floating">
        <input type="password" class="form-control" id="floatingPassword" placeholder="Password" required>
        <label for="floatingPassword">Password</label>
      </div>

      <div class="checkbox mb-3">
        <div class="form-check form-switch">
  <input class="form-check-input" type="checkbox" value="1" name="remember_me" id="rememberMeSwitch">
  <label class="form-check-label" for="rememberMeSwitch"> Remember me</label>
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

<style>


    
</style>