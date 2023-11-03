<script>
    export let open;
    import {page} from '$app/stores'
    import { fade } from 'svelte/transition';
    let pagename = $page.url.pathname.substr($page.url.pathname.lastIndexOf('/'));
</script>

{#if open}
<nav class="navbar navbar-expand-lg" transition:fade={{duration: 300}} style="z-index: {open ? 1 : 0}">
        <a class="navbar-brand text-white" href="/"><i class="fa fa-graduation-cap fa-lg mr-2"></i>TimeManager</a>
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

<style>
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
    /* height: 51%;
    font-size: 2em;
    gap: 1em;
    flex-wrap: wrap; */
font-size: 3em;
  margin: auto;
  width: 50%;
  padding: 10px;

    display: flex;
    justify-content: center;
    gap: 1em;
}

</style>