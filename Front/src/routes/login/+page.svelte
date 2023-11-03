<script>
    import NavBar from "$lib/navbar/NavBar.svelte";
    import "../register/auth.scss";
    let user

    function login(e) {
      const formData = new FormData(e.target);
      const email = formData.get("email");
      const password = formData.get("password");


      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch(`http://localhost:4002/api/users/`+ email + "/name", requestOptions)
        .then(response => response.text())
        .then(result => {console.log(result)
          user = JSON.parse(result)
          if (user.data.password == password) {
            console.log("OK")
            localStorage.setItem("user", JSON.stringify(user))
            window.location.href = "/home"
          } else {
            console.log("NO OK")
          }
        })
        .catch(error => console.log('error', error));

    }

    
</script>

<NavBar />
<div class="bg">
</div>

  <main class="form-signin">
    
      <h1 class="h3">Login</h1>
    
    <form on:submit|preventDefault={login}>


      <div class="form-floating">
        <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" name="email" required>
        <label for="floatingInput">Email address</label>
      </div>
      <div class="form-floating">
        <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password" required>
        <label for="floatingPassword">Password</label>
      </div>
      <button class="w-100 btn btn-lg" type="submit">Sign in</button>
    </form>
  </main>


<style>


    
</style>