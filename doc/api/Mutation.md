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
  <h1>Mutation</h1>
  <p>A record of a single change in an <a class='reference' href='Item.html'>
  <code>Item</code>
</a>.</p>
<p>A new mutation is created to record each attribute set, body text change,
and child item update. Use <a class='reference' href='Outline.html#instance-onDidChange'>
  <code>Outline::onDidChange</code>
</a> to receive this mutation
record so you can track what changes as an outline is edited. </p>
  
<h2>Constants</h2>
<dl>
  <dt class='property-def' id='static-ATTRIBUTE_CHANGED'>
  <code class='signature'>.ATTRIBUTE_CHANGED</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>ATTRIBUTE_CHANGED Mutation type constant. </p>
</dd>
<dt class='property-def' id='static-BODY_CHANGED'>
  <code class='signature'>.BODY_CHANGED</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>BODY_CHANGED Mutation type constant. </p>
</dd>
<dt class='property-def' id='static-CHILDREN_CHANGED'>
  <code class='signature'>.CHILDREN_CHANGED</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>CHILDREN_CHANGED Mutation type constant. </p>
</dd>
</dl>
<h2>Attribute</h2>
<dl>
  <dt class='property-def' id='instance-target'>
  <code class='signature'>::target</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='Item.html'>
  <code>Item</code>
</a> target of the mutation. </p>
</dd>
<dt class='property-def' id='instance-type'>
  <code class='signature'>::type</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only type of change. <a class='reference' href='Mutation.html#static-ATTRIBUTE_CHANGED'>
  <code>Mutation.ATTRIBUTE_CHANGED</code>
</a>,
<a class='reference' href='Mutation.html#static-BODY_CHANGED'>
  <code>Mutation.BODY_CHANGED</code>
</a>, or <a class='reference' href='Mutation.html#static-CHILDREN_CHANGED'>
  <code>Mutation.CHILDREN_CHANGED</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-attributeName'>
  <code class='signature'>::attributeName</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only name of changed attribute in the target <a class='reference' href='Item.html'>
  <code>Item</code>
</a>, or null. </p>
</dd>
<dt class='property-def' id='instance-attributeOldValue'>
  <code class='signature'>::attributeOldValue</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only previous value of changed attribute in the target
<a class='reference' href='Item.html'>
  <code>Item</code>
</a>, or null. </p>
</dd>
<dt class='property-def' id='instance-insertedTextLocation'>
  <code class='signature'>::insertedTextLocation</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only value of the body text location where the insert started
in the target <a class='reference' href='Item.html'>
  <code>Item</code>
</a>, or null. </p>
</dd>
<dt class='property-def' id='instance-insertedTextLength'>
  <code class='signature'>::insertedTextLength</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only value of length of the inserted body text in the target
<a class='reference' href='Item.html'>
  <code>Item</code>
</a>, or null. </p>
</dd>
<dt class='property-def' id='instance-replacedText'>
  <code class='signature'>::replacedText</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='AttributedString.html'>
  <code>AttributedString</code>
</a> of replaced body text in the target
<a class='reference' href='Item.html'>
  <code>Item</code>
</a>, or null. </p>
</dd>
<dt class='property-def' id='instance-addedItems'>
  <code class='signature'>::addedItems</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of child <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s added to the target. </p>
</dd>
<dt class='property-def' id='instance-removedItems'>
  <code class='signature'>::removedItems</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of child <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s removed from the target. </p>
</dd>
<dt class='property-def' id='instance-previousSibling'>
  <code class='signature'>::previousSibling</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only previous sibling <a class='reference' href='Item.html'>
  <code>Item</code>
</a> of the added or removed Items,
or null. </p>
</dd>
<dt class='property-def' id='instance-nextSibling'>
  <code class='signature'>::nextSibling</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only next sibling <a class='reference' href='Item.html'>
  <code>Item</code>
</a> of the added or removed Items, or
null. </p>
</dd>
</dl>
</div>