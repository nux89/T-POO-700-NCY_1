<script>
    export let open;
    import {page} from '$app/stores'
    let pagename = $page.url.pathname.substr($page.url.pathname.lastIndexOf('/'));
</script>

{#if open}
<nav class="navbar navbar-expand-lg">
        <a class="navbar-brand text-white" href="/"><i class="fa fa-graduation-cap fa-lg mr-2"></i>TimeManager</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#nvbCollapse" aria-controls="nvbCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="nvbCollapse">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item pl-1">
                    <a class="nav-link {pagename === '/profile' && 'active'}" href="/profile"><i class="fa fa-home fa-fw mr-1"></i>Profile</a>
                </li>
                <li class="nav-item active pl-1">
                    <a class="nav-link {pagename === '/login' && 'active'}" href="/login"><i class="fa fa-th-list fa-fw mr-1"></i>Login</a>
                </li>
                <li class="nav-item pl-1">
                    <a class="nav-link {pagename === '/register' && 'active'}" href="/register"><i class="fa fa-info-circle fa-fw mr-1"></i>Register</a>
                </li>
            </ul>
        </div>
</nav>
{/if}

<style>
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
</style>