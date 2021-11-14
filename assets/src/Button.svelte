<style>
  button {
    padding: 0.3rem 0.6rem;
    background-color: #1b1851;
    border: 1px solid #1b1851 ;
    cursor: pointer;
    color: #fff031;
  }

  button:hover {
    background-color: #fff031;
    border: 1px solid #fff031;
    color: #1b1851;
  }
</style>

<button on:click>
  <slot />
</button>
