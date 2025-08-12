<script>
  import { onMount } from 'svelte';

  let colors = [
    { name: 'red', code: '#c71e1d' },
    { name: 'blue', code: '#004b97' },
    { name: 'yellow', code: '#ffe400' },
    { name: 'green', code: '#289a1d' },
    { name: 'black', code: '#000000' },
    { name: 'brown', code: '#852d00' },
    { name: 'grey', code: '#727272' },
    { name: 'pink', code: '#ff54a7' },
    { name: 'purple', code: '#9c2c9c' },
    { name: 'orange', code: '#fa8c00' },
    { name: 'white', code: '#ffffff' },
    { name: 'gold', code: '#fcc243' },
    { name: 'silver', code: '#e0e0e0' }
  ];

  let selectedColor = null;
  let dataLyrics = [];
  let dataPoems = [];

  function selectColor(color) {
    selectedColor = color;
  }

  function pluralize(count, singular, plural = null) {
    if (count === 1) return singular;
    return plural || singular + 's';
  }

  onMount(async () => {
    const res1 = await fetch('colorcounts.csv');
    const text1 = await res1.text();
    const lines1 = text1.trim().split('\n');
    dataLyrics = lines1.slice(1).map(line => {
      const [color, timesStr, source] = line.split(',');
      return {
        color,
        times: parseInt(timesStr),
        source
      };
    });

    const res2 = await fetch('shakespeare-color-counts.csv');
    const text2 = await res2.text();
    const lines2 = text2.trim().split('\n');
    dataPoems = lines2.slice(1).map(line => {
      const [color, countStr] = line.split(',');
      return {
        color,
        times: parseInt(countStr)
      };
    });
  });

  $: entryLyrics = dataLyrics.find(entry => entry.color === selectedColor);
  $: entryPoems = dataPoems.find(entry => entry.color === selectedColor);
</script>

<style>
  h1 {
    color: black;
  }

h2 {
    color: black;
  }


  

</style>

<h1>Pick a color!</h1>
<h2>(And find out how often Taylor Swift sings about it.)</h2>

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  {#each colors as color}
    <button
      class="color-button"
      on:click={() => selectColor(color.name)}
      style="
        background-color: {color.code};
        color: {color.name === 'white' || color.name === 'yellow' || color.name === 'silver' || color.name === 'gold' ? 'black' : 'white'};
      "
    >
      {color.name}
    </button>
  {/each}
</div>

{#if selectedColor === 'yellow'}
  <p>Taylor Swift never sings about the color <strong style="color: {colors.find(c => c.name === selectedColor)?.code}">{selectedColor}</strong>. :( <br><br>
  <strong style="color: #004b97">Blue</strong> seems to be Taylor's favorite color.<br><br>

    <iframe
      src="https://datawrapper.dwcdn.net/hjWkd/1/"
      width="100%"
      height="450"
      frameborder="0"
      scrolling="no"
      title="Color counts"
      aria-label="Bar Chart"
      style="border:none;"
    ></iframe>
    
    Funnily enough, <strong style="color: #c71e1d">red</strong> isn't the most prominent color in the album "Red", as one might expect.<br><br>
    Explore how Taylor's usage of colors has developed with each album:<br><br>
    <iframe
      src="https://datawrapper.dwcdn.net/Lbzx7/2/"
      width="100%"
      height="550"
      frameborder="0"
      scrolling="no"
      title="Color counts"
      aria-label="Bar Chart"
      style="border:none;"
    ></iframe><br><br>

    And here is the color palette for every album - which doesn't really match the color they are usually associated with::<br><br>
    <iframe
      src="https://datawrapper.dwcdn.net/tdYrC/1/"
      width="100%"
      height="300"
      frameborder="0"
      scrolling="no"
      title="Color counts"
      aria-label="Bar Chart"
      style="border:none;"
    ></iframe>
  Interesting to see how <strong style="color: #c71e1d">red</strong> disappears with "Midnights" and is replaced by <strong style="color: #852d00">brown</strong>.<br>I'm sure there is a point that could be made there about which are love albums and which are break-up albums.<br><br>
  
  Taylor Swift's most colorful albums are "Lover" and "The Tortured Poets Department" with 8 colors in their lyrics respectively.<br>The latter seems surprising given its grey cover art and marketing.<br><br>

  In general, darker colors dominate her lyrics. This is how light and dark colors are distributed across the albums.<br><br>
    <iframe
      src="https://datawrapper.dwcdn.net/iJU7a/1/"
      width="100%"
      height="760"
      frameborder="0"
      scrolling="no"
      title="Color counts"
      aria-label="Bar Chart"
      style="border:none;"
    ></iframe><br><br>
  
  I guess "Red" is a pretty dark album?!<br><br>
  
  For comparison, William Shakespeare writes about <strong style="color: {colors.find(c => c.name === selectedColor)?.code}">{selectedColor}</strong> 
    <strong>{entryPoems.times}</strong> {pluralize(entryPoems?.times ?? 0, 'time')} in his poems. He is a fan of <strong style="color: black">black</strong>.<br><br>

    <iframe
      src="https://datawrapper.dwcdn.net/Y5aBF/1/"
      width="100%"
      height="350"
      frameborder="0"
      scrolling="no"
      title="Color counts"
      aria-label="Bar Chart"
      style="border:none;"
    ></iframe>
  </p>
{:else if entryLyrics}
  <p>
    Taylor Swift sings about <strong style="color: {colors.find(c => c.name === selectedColor)?.code}">{selectedColor}</strong> 
    <strong>{entryLyrics.times}</strong> {pluralize(entryLyrics.times, 'time')} in her lyrics.<br><br>
    It's mentioned most in her album "{entryLyrics.source}".<br><br>

      <strong style="color: #004b97">Blue</strong> seems to be Taylor's favorite color.<br><br>

    <iframe
      src="https://datawrapper.dwcdn.net/hjWkd/1/"
      width="100%"
      height="450"
      frameborder="0"
      scrolling="no"
      title="Color counts"
      aria-label="Bar Chart"
      style="border:none;"
    ></iframe>
    
    Funnily enough, <strong style="color: #c71e1d">red</strong> isn't the most prominent color in the album "Red", as one might expect.<br><br>
    Explore how Taylor's usage of colors has developed with each album:<br><br>
    <iframe
      src="https://datawrapper.dwcdn.net/Lbzx7/2/"
      width="100%"
      height="550"
      frameborder="0"
      scrolling="no"
      title="Color counts"
      aria-label="Bar Chart"
      style="border:none;"
    ></iframe><br><br>

   And here is the color palette for every album - which doesn't really match the color they are usually associated with:<br><br>
    <iframe
      src="https://datawrapper.dwcdn.net/tdYrC/1/"
      width="100%"
      height="300"
      frameborder="0"
      scrolling="no"
      title="Color counts"
      aria-label="Bar Chart"
      style="border:none;"
    ></iframe>
  
  Interesting to see how <strong style="color: #c71e1d">red</strong> disappears with "Midnights" and is replaced by <strong style="color: #852d00">brown</strong>.<br>I'm sure there is a point that could be made there about which are love albums and which are break-up albums.<br><br>
  
  Taylor Swift's most colorful albums are "Lover" and "The Tortured Poets Department" with 8 colors in their lyrics respectively.<br>The latter seems surprising given its grey cover art and marketing.<br><br>

  In general, darker colors dominate her lyrics. This is how light and dark colors are distributed across the albums.<br><br>
    <iframe
      src="https://datawrapper.dwcdn.net/iJU7a/1/"
      width="100%"
      height="760"
      frameborder="0"
      scrolling="no"
      title="Color counts"
      aria-label="Bar Chart"
      style="border:none;"
    ></iframe><br><br>

  I guess "Red" is a pretty dark album?!<br><br>
  
  For comparison, William Shakespeare writes about <strong style="color: {colors.find(c => c.name === selectedColor)?.code}">{selectedColor}</strong> 
    <strong>{entryPoems.times}</strong> {pluralize(entryPoems?.times ?? 0, 'time')} in his poems. He is a fan of <strong style="color: black">black</strong>.<br><br>

    <iframe
      src="https://datawrapper.dwcdn.net/Y5aBF/1/"
      width="100%"
      height="350"
      frameborder="0"
      scrolling="no"
      title="Color counts"
      aria-label="Bar Chart"
      style="border:none;"
    ></iframe>
  </p>

  {#if selectedColor === 'brown'}
    <p><em>Note: The counts for brown include 'maroon'.</em></p>
  {/if}

  {#if selectedColor === 'purple'}
    <p><em>Note: The counts for purple include 'lilac'.</em></p>
  {/if}

  {#if selectedColor === 'grey'}
    <p><em>Note: The counts for grey include 'greige'.</em></p>
  {/if}

  {#if selectedColor === 'green'}
    <p><em>Note: The counts for green include 'teal'.</em></p>
  {/if}
{/if}

{#if selectedColor}
  <footer>
    <em> This project uses the <a href="https://github.com/sarbor/taylor_swift_api"> Taylor Swift Lyrics API created by sarbor</a> and the <a href="https://bridgesdata.herokuapp.com/api/datasets/shakespeare"> Shakespeare Dataset provided by BridgesData</a>. You can find an explanation of my data analysis <a href="https://github.com/hsellheim/svelte-project">here</a>.</em>
  </footer>
{/if}
