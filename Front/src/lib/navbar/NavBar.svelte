<script>
    import { page } from '$app/stores';
    let pagename = $page.url.pathname.substr($page.url.pathname.lastIndexOf('/'));
    let user = getUserFromStorage();

    function getUserFromStorage() {
        let user = localStorage.getItem("user");
        if (user) {
            return JSON.parse(user);
        }
        return null;
    }

    function getRoleFromStorage() {
        let user = localStorage.getItem("user");
        if (user) {
            return JSON.parse(user).data.role;
        }
        return null;
    }
    
    function logout() {
        localStorage.removeItem("user");
        window.location.href = "/login";
    }
</script>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand text-white" href="/"><i class="fa fa-graduation-cap fa-lg mr-2"></i>TimeManager</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#nvbCollapse" aria-controls="nvbCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="nvbCollapse">
            <ul class="navbar-nav ml-auto">
                {#if user}
                <li class="nav-item pl-1"><a class="nav-link" href="#" on:click={logout}>Logout</a></li>
                <li class="nav-item pl-1"><a class="nav-link" href="/profile">Profile</a></li>
                {:else}
                <li class="nav-item"><a class="nav-link" href="/login">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="/register">Register</a></li>
                {/if}
                {#if getRoleFromStorage() === 'manager' }
                    <li class="nav-item pl-1">
                        <a class="nav-link {pagename === '/manager' && 'active'}" href="/manager"><i class="fa fa-info-circle fa-fw mr-1"></i>Manager</a>
                    </li>
                {/if}

                {#if getRoleFromStorage() === 'supermanager' }
                    <li class="nav-item pl-1">
                        <a class="nav-link {pagename === '/supermanager' && 'active'}" href="/supermanager"><i class="fa fa-info-circle fa-fw mr-1"></i>Super-Manager</a>
                    </li>
                {/if}

            </ul>
        </div>
    </div>
</nav>
