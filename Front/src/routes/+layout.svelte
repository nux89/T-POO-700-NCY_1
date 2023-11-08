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

<div class="bg" />
<div class="main-slot">
    <div style="width: 100%">
        <slot />
    </div>
</div>

<style>
    .main-slot {
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        flex-direction: column;
        position: relative;
    }
    .hamburger {
    position: absolute;
    left: 0;
    top: 0;
    }

    :global(.hamburger button) {
        position: relative;
        z-index: 8;
    }


</style>