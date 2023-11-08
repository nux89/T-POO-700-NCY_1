<script>
    export let open;
    import {page} from '$app/stores'
    import { fade } from 'svelte/transition';
    let pagename = $page.url.pathname.substr($page.url.pathname.lastIndexOf('/'));
</script>

{#if open}
<nav class="navbar navbar-expand-lg" transition:fade={{duration: 150}} style="z-index: {open ? 4 : 0}">
        <a class="navbar-brand text-white" id="home" href="/" on:click={() => open = false}><i class="fa fa-graduation-cap fa-lg mr-2"></i>TimeManager</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#nvbCollapse" aria-controls="nvbCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item pl-1">
                    <a class="nav-link {pagename === '/profile' && 'active'}" href="/profile" on:click={() => open = false}><i class="fa fa-home fa-fw mr-1"></i>Profile</a>
                </li>
                <li class="nav-item active pl-1">
                    <a class="nav-link {pagename === '/login' && 'active'}" href="/login" on:click={() => open = false}><i class="fa fa-th-list fa-fw mr-1"></i>Login</a>
                </li>
                <li class="nav-item pl-1">
                    <a class="nav-link {pagename === '/register' && 'active'}" href="/register" on:click={() => open = false}><i class="fa fa-info-circle fa-fw mr-1"></i>Register</a>
                </li>
            </ul>
</nav>
{/if}

<style lang="scss">
    ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
}
    .menu {
        text-align: center;
        font-size: 1.5em;
        letter-spacing: 0.15em;
        padding: 1em;
        padding-top: 0;
        color: #eef;
    }
    p {
        cursor: pointer;
        width: max-content;
        margin: 1rem auto;
    }
    p:hover {
        text-decoration: underline;
    }
    .bar {
        border-style: solid;
        border-color: white;
        border-width: 1px;
        height: 0;
    }

.navbar {
    position: absolute;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
    padding-top: 0.5rem;
    background:#0f161bdb;
    left: 0;
    right: 0;
    flex-direction: column;
    top: 0;
    bottom: 0;
}

ul {
font-size: 3em;
  margin: auto;
  width: 50%;
  padding: 10px;

    display: flex;
    justify-content: center;
    gap: 1em;
}

.navbar-brand {
    font-size: 2em;
}

a:link {
  color: #bce8f1 !important;
}

/* visited link */
a:visited {
  color: #0cb2d4 !important;
}

/* mouse over link */
a:hover {
  color: hotpink !important;
}

/* selected link */
a:active {
  color: rgb(0, 221, 255) !important;
}

#home {
    color: white !important;
}



</style>