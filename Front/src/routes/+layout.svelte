<script>
    import Header from "$lib/header/Header.svelte";

</script>

<title>TIME MANAGER</title>


<div class="site">

<Header />
  
  <main class="site-main">
    <nav class="main-nav flex-center">
      <!-- <h1 class="section-subtitle"></h1> -->
    </nav>
    <section class="main-content">
        <slot />
    </section>
    <aside class="main-aside flex-center">
      <!-- <h1 class="section-subtitle"></h1> -->
    </aside>
  </main>
  
  <footer class="site-footer flex-center">
    <h1 class="section-title">FOOTER</h1>
  </footer>
</div>

<style lang="scss">
.site {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.site-footer {
  height: 80px;
  background: #34495e;
}
.site-main {
  flex: 1;
  display: flex;
}
.main-nav {
  width: 220px;
  background: #eee;
}
.main-content {
  background: #fff;
  flex-grow: 1;
}
.main-aside {
  background: #ccc;
  width: 150px;
}
@media screen and (max-width: 800px) {
  .site-main {
    flex-direction: column;
  }
  .main-nav {
    width: initial;
    height: 50px;
  }
  .main-aside {
    width: initial;
    height: 95px;
  }
}

.flex-center {
  display: flex;
  justify-content: center;
  align-items: center;
}
.section-title {
  font-size: 2.5em;
  font-family: 'Open Sans', sans-serif;
  color: rgba(0,0,0,.25);
  text-align: center;
}
.section-subtitle {
  font-size: 1.5em;
}
</style>
