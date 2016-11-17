<div class='class-def'>
  <script type="text/javascript" src="https://code.jquery.com/jquery-2.2.0.min.js"></script>
  <script>
    $( document ).ready(function() {
      $('.class-def dd').hide();
      $('.class-def dt').click(function(){
        $(this).next('dd').slideToggle();
      });
    });
  </script>
  <h1>ItemSerializer</h1>
  <p>A class for serializing and deserializing <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s. </p>
  
<h2>Format Constants</h2>
<dl>
  <dt class='property-def' id='static-ItemReferencesType'>
  <code class='signature'>.ItemReferencesType</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Outline and item ID JSON for the pasteboard. </p>
</dd>
<dt class='property-def' id='static-BMLType'>
  <code class='signature'>.BMLType</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>BML type constant.</p>
<ul>
<li>HTML subset for representing outlines in HTML. </li>
</ul>
</dd>
<dt class='property-def' id='static-OPMLType'>
  <code class='signature'>.OPMLType</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>OPML type constant.</p>
<ul>
<li>See <a href="https://en.wikipedia.org/wiki/OPML">https://en.wikipedia.org/wiki/OPML</a> </li>
</ul>
</dd>
<dt class='property-def' id='static-TaskPaperType'>
  <code class='signature'>.TaskPaperType</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>TaskPaper text type constant.</p>
<ul>
<li>Encode item structure with tabs.</li>
<li>Encode item <code>data-*</code> attributes with <code>tag(value)</code> pattern. </li>
</ul>
</dd>
<dt class='property-def' id='static-TEXTType'>
  <code class='signature'>.TEXTType</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Plain text type constant.</p>
<ul>
<li>Encode item structure with tabs. </li>
</ul>
</dd>
</dl>
<h2>Serialize &amp; Deserialize Items</h2>
<dl>
  <dt class='method-def' id='static-serializeItems'>
  <code class='signature'>.serializeItems(items, options<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Serialize items into a supported format.</p>
  <table class='parameter table table-condensed'>
  <col style='width:25%'>
  <col style='width:75%'>
  <thead>
    <tr>
      <th>Argument</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
  <th><code>items</code></th>
  <td><a class='reference' href='Item.html'>
  <code>Item</code>
</a> <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> to serialize.</td>
</tr>
<tr>
  <th><code>options<sup>?</sup></code></th>
  <td>Serialization options.
  <ul>
  <li>
  <code>type</code>
  &mdash;
  <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> (default: ItemSerializer.BMLType)
</li>
<li>
  <code>startOffset</code>
  &mdash;
  <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number'>
  <code>Number</code>
</a> (default: 0) Offset into first into to start at.
</li>
<li>
  <code>endOffset</code>
  &mdash;
  <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number'>
  <code>Number</code>
</a> (default: lastItem.bodyString.length) Offset from end of last item to end at.
</li>
<li>
  <code>expandedItems</code>
  &mdash;
  <a class='reference' href='Item.html'>
  <code>Item</code>
</a> <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of expanded items 
</li>
</ul></td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='static-deserializeItems'>
  <code class='signature'>.deserializeItems(itemsData, outline, options)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Deserialize items from a supported format.</p>
  <table class='parameter table table-condensed'>
  <col style='width:25%'>
  <col style='width:75%'>
  <thead>
    <tr>
      <th>Argument</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
  <th><code>itemsData</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> to deserialize.</td>
</tr>
<tr>
  <th><code>outline</code></th>
  <td><a class='reference' href='Outline.html'>
  <code>Outline</code>
</a> to use when creating deserialized items.</td>
</tr>
<tr>
  <th><code>options</code></th>
  <td>Deserialization options.
  <ul>
  <li>
  <code>type</code>
  &mdash;
  <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> (default: ItemSerializer.TEXTType)
</li>
</ul></td>
</tr>
  </tbody>
</table>
  <table class='m-t return-value table table-condensed'>
  <thead>
    <tr>
      <th>Return Values</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>Returns <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s.
</td></tr>
  </tbody>
</table>
</dd>
</dl>
</div>