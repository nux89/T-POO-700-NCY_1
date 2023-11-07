<script>
  import "./bootstrap.min.css"
    import Menu from "../lib/navbar/Menu.svelte";
     import { Hamburger } from 'svelte-hamburgers';


    let open;
 
</script>

<div class="hamburger">
<Hamburger
    bind:open
    --color="white"/>

</div>

<Menu bind:open />


<title>TIME MANAGER</title>
<div>
<slot />
</div>

<style>
    .hamburger {
    position: absolute;
    right: 0;
    top: 0;
    }

    :global(.hamburger button) {
        position: relative;
        z-index: 8;
    }


</style>