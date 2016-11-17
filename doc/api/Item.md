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
  <h1>Item</h1>
  <p>A paragraph of text in an <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a>.</p>
<p>Items cannot be created directly. Use <a class='reference' href='Outline.html#instance-createItem'>
  <code>Outline::createItem</code>
</a> to create items.</p>
<p>Items may contain other child items to form a hierarchy. When you move an
item its children move with it. See the “Structure” and “Mutate Structure”
sections for associated APIs. To move an item while leaving it’s children in
place see the methods in <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a>s “Insert &amp; Remove Items”.</p>
<p>Items may have associated attributes. You can add your own attributes by
using the APIs described in the “Item Attributes” section. For example you might
add a due date using the <code>data-due-date</code> attribute.</p>
<p>Items have an associated paragraph of body text. You can access it as plain
text or as an immutable <a class='reference' href='AttributedString.html'>
  <code>AttributedString</code>
</a>. You can also add and remove
attributes from ranges of body text. See “Item Body Text” for associated
APIs. While you can add these attributes at runtime, TaskPaper won’t save
them to disk since it saved in plain text without associated text run
attributes.</p>
  <h2>Examples</h2>
<p>Create Items:</p>
<pre><code class="lang-javascript"><span class="hljs-keyword">var</span> item = outline.createItem(<span class="hljs-string">'Hello World!'</span>);
outline.root.appendChildren(item);
</code></pre>
<p>Add attributes to body text:</p>
<pre><code class="lang-javascript"><span class="hljs-keyword">var</span> item = outline.createItem(<span class="hljs-string">'Hello World!'</span>);
item.addBodyAttributeInRange(<span class="hljs-string">'B'</span>, {}, <span class="hljs-number">6</span>, <span class="hljs-number">5</span>);
item.addBodyAttributeInRange(<span class="hljs-string">'I'</span>, {}, <span class="hljs-number">0</span>, <span class="hljs-number">11</span>);
</code></pre>
<p>Reading attributes from body text:</p>
<pre><code class="lang-javascript"><span class="hljs-keyword">var</span> effectiveRange = {};
<span class="hljs-keyword">var</span> textLength = item.bodyString.length;
<span class="hljs-keyword">var</span> index = <span class="hljs-number">0</span>;
<span class="hljs-keyword">while</span> (index &lt; textLength) {
  <span class="hljs-built_in">console</span>.log(item.getBodyAttributesAtIndex(index, effectiveRange));
  index += effectiveRange.length;
}
</code></pre>

  
<h2>Properties</h2>
<dl>
  <dt class='property-def' id='instance-id'>
  <code class='signature'>::id</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only unique <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> identifier. </p>
</dd>
<dt class='property-def' id='instance-outline'>
  <code class='signature'>::outline</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a> that this item belongs to. </p>
</dd>
</dl>
<h2>Clone</h2>
<dl>
  <dt class='method-def' id='instance-clone'>
  <code class='signature'>::clone(deep<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Clones this item.</p>
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
  <th><code>deep<sup>?</sup></code></th>
  <td>defaults to true.</td>
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
    <tr><td>Returns a duplicate <a class='reference' href='Item.html'>
  <code>Item</code>
</a> with a new <a class='reference' href='#instance-id'>
  <code>::id</code>
</a>.
</td></tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Structure</h2>
<dl>
  <dt class='property-def' id='instance-isInOutline'>
  <code class='signature'>::isInOutline</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only true if item is contained by root of owning <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-isOutlineRoot'>
  <code class='signature'>::isOutlineRoot</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only true if is <a class='reference' href='#instance-outline'>
  <code>::outline</code>
</a> root <a class='reference' href='Item.html'>
  <code>Item</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-depth'>
  <code class='signature'>::depth</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only depth of <a class='reference' href='Item.html'>
  <code>Item</code>
</a> in outline structure. Calculated by
summing the <a class='reference' href='Item.html#instance-indent'>
  <code>Item::indent</code>
</a> of this item and it’s ancestors. </p>
</dd>
<dt class='property-def' id='instance-parent'>
  <code class='signature'>::parent</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only parent <a class='reference' href='Item.html'>
  <code>Item</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-firstChild'>
  <code class='signature'>::firstChild</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only first child <a class='reference' href='Item.html'>
  <code>Item</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-lastChild'>
  <code class='signature'>::lastChild</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only last child <a class='reference' href='Item.html'>
  <code>Item</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-previousSibling'>
  <code class='signature'>::previousSibling</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only previous sibling <a class='reference' href='Item.html'>
  <code>Item</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-nextSibling'>
  <code class='signature'>::nextSibling</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only next sibling <a class='reference' href='Item.html'>
  <code>Item</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-previousBranch'>
  <code class='signature'>::previousBranch</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only previous branch <a class='reference' href='Item.html'>
  <code>Item</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-nextBranch'>
  <code class='signature'>::nextBranch</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only next branch <a class='reference' href='Item.html'>
  <code>Item</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-ancestors'>
  <code class='signature'>::ancestors</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of ancestor <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s. </p>
</dd>
<dt class='property-def' id='instance-descendants'>
  <code class='signature'>::descendants</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of descendant <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s. </p>
</dd>
<dt class='property-def' id='instance-lastDescendant'>
  <code class='signature'>::lastDescendant</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only last descendant <a class='reference' href='Item.html'>
  <code>Item</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-branchItems'>
  <code class='signature'>::branchItems</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of this <a class='reference' href='Item.html'>
  <code>Item</code>
</a> and its descendants. </p>
</dd>
<dt class='property-def' id='instance-lastBranchItem'>
  <code class='signature'>::lastBranchItem</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Last <a class='reference' href='Item.html'>
  <code>Item</code>
</a> in branch rooted at this item. </p>
</dd>
<dt class='property-def' id='instance-previousItem'>
  <code class='signature'>::previousItem</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only previous <a class='reference' href='Item.html'>
  <code>Item</code>
</a> in the outline. </p>
</dd>
<dt class='property-def' id='instance-nextItem'>
  <code class='signature'>::nextItem</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only next <a class='reference' href='Item.html'>
  <code>Item</code>
</a> in the outline. </p>
</dd>
<dt class='property-def' id='instance-hasChildren'>
  <code class='signature'>::hasChildren</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only has children <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean'>
  <code>Boolean</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-children'>
  <code class='signature'>::children</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of child <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s. </p>
</dd>
  <dt class='method-def' id='static-getCommonAncestors'>
  <code class='signature'>.getCommonAncestors(items)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Given an array of items determines and returns the common
ancestors of those items.</p>
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
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s.</td>
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
    <tr><td>Returns a <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of common ancestor <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s.
</td></tr>
  </tbody>
</table>
</dd>
  <dt class='method-def' id='instance-contains'>
  <code class='signature'>::contains(item)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Determines if this item contains the given item.</p>
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
  <th><code>item</code></th>
  <td>The <a class='reference' href='Item.html'>
  <code>Item</code>
</a> to check for containment.</td>
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
    <tr><td>Returns <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean'>
  <code>Boolean</code>
</a>.
</td></tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Mutate Structure</h2>
<dl>
  <dt class='property-def' id='instance-indent'>
  <code class='signature'>::indent</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Visual indent of <a class='reference' href='Item.html'>
  <code>Item</code>
</a> relative to parent. Normally this will be
1 for children with a parent as they are indented one level beyond there
parent. But items can be visually over-indented in which case this value
would be greater then 1. </p>
</dd>
  <dt class='method-def' id='instance-insertChildrenBefore'>
  <code class='signature'>::insertChildrenBefore(children, referenceSibling<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Insert the new children before the referenced sibling in this
item’s list of children. If referenceSibling isn’t defined the new children are
inserted at the end. This method resets the indent of children to match
referenceSibling’s indent or to 1.</p>
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
  <th><code>children</code></th>
  <td><a class='reference' href='Item.html'>
  <code>Item</code>
</a> or <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s to insert.</td>
</tr>
<tr>
  <th><code>referenceSibling<sup>?</sup></code></th>
  <td>The referenced sibling <a class='reference' href='Item.html'>
  <code>Item</code>
</a> to insert before.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-appendChildren'>
  <code class='signature'>::appendChildren(children)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Append the new children to this item’s list of children.</p>
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
  <th><code>children</code></th>
  <td><a class='reference' href='Item.html'>
  <code>Item</code>
</a> or <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s to append.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-removeChildren'>
  <code class='signature'>::removeChildren(children)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Remove the children from this item’s list of children. When an
item is removed its the parent’s <a class='reference' href='#instance-depth'>
  <code>::depth</code>
</a> is added to the removed item’s
<a class='reference' href='#instance-indent'>
  <code>::indent</code>
</a>, preserving the removed items depth if needed later.</p>
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
  <th><code>children</code></th>
  <td><a class='reference' href='Item.html'>
  <code>Item</code>
</a> or <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of child <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s to remove.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-removeFromParent'>
  <code class='signature'>::removeFromParent()</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Remove this item from it’s parent item if it has a parent. </p>
</dd>
</dl>
<h2>Item Attributes</h2>
<dl>
  <dt class='property-def' id='instance-attributes'>
  <code class='signature'>::attributes</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only key/value object of the attributes associated with this
<a class='reference' href='Item.html'>
  <code>Item</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-attributeNames'>
  <code class='signature'>::attributeNames</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of this <a class='reference' href='Item.html'>
  <code>Item</code>
</a>‘s attribute names. </p>
</dd>
  <dt class='method-def' id='instance-hasAttribute'>
  <code class='signature'>::hasAttribute(name)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Return <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean'>
  <code>Boolean</code>
</a> <code>true</code> if this item has the given attribute.</p>
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
  <th><code>name</code></th>
  <td>The <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> attribute name.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-getAttribute'>
  <code class='signature'>::getAttribute(name, clazz<sup>?</sup>, array<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Return the value of the given attribute. If the attribute does not
exist will return <code>null</code>. Attribute values are always stored as <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a>s.
Use the <code>class</code> and <code>array</code> parameters to parse the string values to other
types before returning.</p>
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
  <th><code>name</code></th>
  <td>The <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> attribute name.</td>
</tr>
<tr>
  <th><code>clazz<sup>?</sup></code></th>
  <td>Class (<a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number'>
  <code>Number</code>
</a> or <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date'>
  <code>Date</code>
</a>) to parse string values to objects of given class.</td>
</tr>
<tr>
  <th><code>array<sup>?</sup></code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean'>
  <code>Boolean</code>
</a> true if should split comma separated string value to create an array.</td>
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
    <tr><td>Returns attribute value.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-setAttribute'>
  <code class='signature'>::setAttribute(name, value)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Adds a new attribute or changes the value of an existing
attribute. <code>id</code> is reserved and an exception is thrown if you try to set
it. Setting an attribute to <code>null</code> or <code>undefined</code> removes the attribute.
Generally all item attribute names should start with <code>data-</code> to avoid
conflict with built in attribute names.</p>
<p>Attribute values are always stored as <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a>s so they will stay
consistent through any serialization process. For example if you set an
attribute to the Number <code>1.0</code> when you <a class='reference' href='#instance-getAttribute'>
  <code>::getAttribute</code>
</a> the value is the
<a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> <code>&quot;1.0&quot;</code>. See <a class='reference' href='#instance-getAttribute'>
  <code>::getAttribute</code>
</a> for options to automatically
convert the stored <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> back to a <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number'>
  <code>Number</code>
</a> or <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date'>
  <code>Date</code>
</a>.</p>
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
  <th><code>name</code></th>
  <td>The <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> attribute name.</td>
</tr>
<tr>
  <th><code>value</code></th>
  <td>The new attribute value.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-removeAttribute'>
  <code class='signature'>::removeAttribute(name)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Removes an item attribute.</p>
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
  <th><code>name</code></th>
  <td>The <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> attribute name.</td>
</tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Item Body Text</h2>
<dl>
  <dt class='property-def' id='instance-bodyString'>
  <code class='signature'>::bodyString</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Body text as plain text <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a>. </p>
</dd>
<dt class='property-def' id='instance-bodyContentString'>
  <code class='signature'>::bodyContentString</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Body “content” text as plain text <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a>. Excludes trailing tags
and leading syntax. For example used when displaying items to user’s in
menus. </p>
</dd>
<dt class='property-def' id='instance-bodyAttributedString'>
  <code class='signature'>::bodyAttributedString</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Body text as immutable <a class='reference' href='AttributedString.html'>
  <code>AttributedString</code>
</a>. Do not modify this
AttributedString, instead use the other methods in this “Body Text”
section. They will both modify the string and create the appropriate
<a class='reference' href='Mutation.html'>
  <code>Mutation</code>
</a> events needed to keep the outline valid. </p>
</dd>
<dt class='property-def' id='instance-bodyHighlightedAttributedString'>
  <code class='signature'>::bodyHighlightedAttributedString</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Syntax highlighted body text as immutable <a class='reference' href='AttributedString.html'>
  <code>AttributedString</code>
</a>.
Unlike <code>bodyAttributedString</code> this string contains attributes created by
syntax highlighting such as tag name and value ranges.</p>
<p>Do not modify this AttributedString, instead use the other methods in this
“Body Text” section. They will both modify the string and create the
appropriate <a class='reference' href='Mutation.html'>
  <code>Mutation</code>
</a> events needed to keep the outline valid. </p>
</dd>
  <dt class='method-def' id='instance-getBodyAttributesAtIndex'>
  <code class='signature'>::getBodyAttributesAtIndex(characterIndex, effectiveRange<sup>?</sup>, longestEffectiveRange<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
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
  <th><code>characterIndex</code></th>
  <td>The character index.</td>
</tr>
<tr>
  <th><code>effectiveRange<sup>?</sup></code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object'>
  <code>Object</code>
</a> whose <code>location</code> and <code>length</code>  properties are set to effective range of the attributes.</td>
</tr>
<tr>
  <th><code>longestEffectiveRange<sup>?</sup></code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object'>
  <code>Object</code>
</a> whose <code>location</code> and <code>length</code>  properties are set to longest effective range of the attributes.</td>
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
    <tr><td>Returns an <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object'>
  <code>Object</code>
</a> with keys for each attribute at the given
character characterIndex, and by reference the range over which the
attributes apply.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-getBodyAttributeAtIndex'>
  <code class='signature'>::getBodyAttributeAtIndex(attribute, characterIndex, effectiveRange<sup>?</sup>, longestEffectiveRange<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
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
  <th><code>attribute</code></th>
  <td>Attribute <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> name.</td>
</tr>
<tr>
  <th><code>characterIndex</code></th>
  <td>The character index.</td>
</tr>
<tr>
  <th><code>effectiveRange<sup>?</sup></code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object'>
  <code>Object</code>
</a> whose <code>location</code> and <code>length</code>  properties are set to effective range of the attribute.</td>
</tr>
<tr>
  <th><code>longestEffectiveRange<sup>?</sup></code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object'>
  <code>Object</code>
</a> whose <code>location</code> and <code>length</code>  properties are set to longest effective range of the attribute.</td>
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
    <tr><td>Returns the value for an attribute with a given name of the
character at a given characterIndex, and by reference the range over which
the attribute applies.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-addBodyAttributeInRange'>
  <code class='signature'>::addBodyAttributeInRange(attribute, value, location, length)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Adds an attribute to the characters in the given range.</p>
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
  <th><code>attribute</code></th>
  <td>The <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> attribute name.</td>
</tr>
<tr>
  <th><code>value</code></th>
  <td>The attribute value.</td>
</tr>
<tr>
  <th><code>location</code></th>
  <td>Start character index.</td>
</tr>
<tr>
  <th><code>length</code></th>
  <td>Range length.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-addBodyAttributesInRange'>
  <code class='signature'>::addBodyAttributesInRange(attributes, location, length)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Adds attributes to the characters in the given range.</p>
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
  <th><code>attributes</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object'>
  <code>Object</code>
</a> with keys and values for each attribute</td>
</tr>
<tr>
  <th><code>location</code></th>
  <td>Start index.</td>
</tr>
<tr>
  <th><code>length</code></th>
  <td>Range length.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-removeBodyAttributeInRange'>
  <code class='signature'>::removeBodyAttributeInRange(attribute, location, length)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Removes the attribute from the given range.</p>
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
  <th><code>attribute</code></th>
  <td>The <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> attribute name</td>
</tr>
<tr>
  <th><code>location</code></th>
  <td>Start character index.</td>
</tr>
<tr>
  <th><code>length</code></th>
  <td>Range length.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-replaceBodyRange'>
  <code class='signature'>::replaceBodyRange(location, length, insertedText)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Replace body text in the given range.</p>
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
  <th><code>location</code></th>
  <td>Start character index.</td>
</tr>
<tr>
  <th><code>length</code></th>
  <td>Range length.</td>
</tr>
<tr>
  <th><code>insertedText</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> or <a class='reference' href='AttributedString.html'>
  <code>AttributedString</code>
</a></td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-appendBody'>
  <code class='signature'>::appendBody(text)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Append body text.</p>
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
  <th><code>text</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> or <a class='reference' href='AttributedString.html'>
  <code>AttributedString</code>
</a></td>
</tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Debug</h2>
<dl>
  <dt class='method-def' id='instance-branchToString'>
  <code class='signature'>::branchToString()</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <table class='m-t return-value table table-condensed'>
  <thead>
    <tr>
      <th>Return Values</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>Returns debug string for this item and it’s descendants.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-toString'>
  <code class='signature'>::toString()</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <table class='m-t return-value table table-condensed'>
  <thead>
    <tr>
      <th>Return Values</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>Returns debug string for this item.
</td></tr>
  </tbody>
</table>
</dd>
</dl>
</div>