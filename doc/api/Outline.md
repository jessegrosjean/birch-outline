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
  <h1>Outline</h1>
  <p>A mutable outline of <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s.</p>
<p>Use outlines to create new items, find existing items, watch for changes
in items, and add/remove items.</p>
<p>When you add/remove items using the outline’s methods the items children are
left in place. For example if you remove an item, it’s chilren stay in the
outline and are reasigned to a new parent item.</p>
  <h2>Examples</h2>
<p>Group multiple changes:</p>
<pre><code class="lang-javascript">outline.groupUndoAndChanges(<span class="hljs-function"><span class="hljs-keyword">function</span>(<span class="hljs-params"></span>) </span>{
  root = outline.root;
  root.appendChildren(outline.createItem());
  root.appendChildren(outline.createItem());
  root.firstChild.bodyString = <span class="hljs-string">'first'</span>;
  root.lastChild.bodyString = <span class="hljs-string">'last'</span>;
});
</code></pre>
<p>Watch for outline changes:</p>
<pre><code class="lang-javascript">disposable = outline.onDidChange(<span class="hljs-function"><span class="hljs-keyword">function</span>(<span class="hljs-params">mutation</span>) </span>{
  <span class="hljs-keyword">switch</span>(mutation.type) {
    <span class="hljs-keyword">case</span> Mutation.ATTRIBUTE_CHANGED:
      <span class="hljs-built_in">console</span>.log(mutation.attributeName);
      <span class="hljs-keyword">break</span>;
    <span class="hljs-keyword">case</span> Mutation.BODY_CHANGED:
      <span class="hljs-built_in">console</span>.log(mutation.target.bodyString);
      <span class="hljs-keyword">break</span>;
    <span class="hljs-keyword">case</span> Mutation.CHILDREN_CHANGED:
      <span class="hljs-built_in">console</span>.log(mutation.addedItems);
      <span class="hljs-built_in">console</span>.log(mutation.removedItems);
      <span class="hljs-keyword">break</span>;
  }
});
...
disposable.dispose()
</code></pre>
  
<h2>Construction</h2>
<dl>
  <dt class='method-def' id='static-createTaskPaperOutline'>
  <code class='signature'>.createTaskPaperOutline(content)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>The outline is configured to handle TaskPaper content at runtime. For
example when you set attributes through the <a class='reference' href='Item.html'>
  <code>Item</code>
</a> API they are encoded in
the item body text as @tags. And when you modify the body text @tags are
parsed out and stored as attributes.</p>
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
  <th><code>content</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> (optional) outline content in TaskPaper format.</td>
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
    <tr><td>Returns a TaskPaper <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a>.
</td></tr>
  </tbody>
</table>
</dd>
  <dt class='method-def' id='instance-constructor'>
  <code class='signature'>::constructor(type<sup>?</sup>, serialization<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Create a new outline.</p>
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
  <th><code>type<sup>?</sup></code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> outline type. Default to <a class='reference' href='ItemSerializer.html#static-TEXTType'>
  <code>ItemSerializer.TEXTType</code>
</a>.</td>
</tr>
<tr>
  <th><code>serialization<sup>?</sup></code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> Serialized outline content of <code>type</code> to load.</td>
</tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Finding Outlines</h2>
<dl>
  <dt class='property-def' id='instance-id'>
  <code class='signature'>::id</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only unique (not persistent) <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> outline ID. </p>
</dd>
  <dt class='method-def' id='static-getOutlines'>
  <code class='signature'>.getOutlines()</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Retrieves all open <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a>s.</p>
  <table class='m-t return-value table table-condensed'>
  <thead>
    <tr>
      <th>Return Values</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>Returns an <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a>s.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='static-getOutlineForID'>
  <code class='signature'>.getOutlineForID(id)</code>
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
  <th><code>id</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> outline id.</td>
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
    <tr><td>Returns existing <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a> with the given outline id.
</td></tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Events</h2>
<dl>
  <dt class='method-def' id='instance-onDidBeginChanges'>
  <code class='signature'>::onDidBeginChanges(callback)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Invoke the given callback when the outline begins a series of
changes.</p>
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
  <th><code>callback</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function'>
  <code>Function</code>
</a> to be called when the outline begins updating.</td>
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
    <tr><td>Returns a <a class='reference' href='https://atom.io/docs/api/latest/Disposable'>
  <code>Disposable</code>
</a> on which <code>.dispose()</code> can be called to unsubscribe.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-onWillChange'>
  <code class='signature'>::onWillChange(callback)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Invoke the given callback <em>before</em> the outline changes.</p>
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
  <th><code>callback</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function'>
  <code>Function</code>
</a> to be called when the outline will change.
  <ul>
  <li>
  <code>mutation</code>
  &mdash;
  <a class='reference' href='Mutation.html'>
  <code>Mutation</code>
</a> describing the change.
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
    <tr><td>Returns a <a class='reference' href='https://atom.io/docs/api/latest/Disposable'>
  <code>Disposable</code>
</a> on which <code>.dispose()</code> can be called to unsubscribe.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-onDidChange'>
  <code class='signature'>::onDidChange(callback)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Invoke the given callback when the outline changes.</p>
<p>See <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a> Examples for an example of subscribing to this event.</p>
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
  <th><code>callback</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function'>
  <code>Function</code>
</a> to be called when the outline changes.
  <ul>
  <li>
  <code>mutation</code>
  &mdash;
  <a class='reference' href='Mutation.html'>
  <code>Mutation</code>
</a> describing the changes.
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
    <tr><td>Returns a <a class='reference' href='https://atom.io/docs/api/latest/Disposable'>
  <code>Disposable</code>
</a> on which <code>.dispose()</code> can be called to unsubscribe.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-onDidEndChanges'>
  <code class='signature'>::onDidEndChanges(callback)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Invoke the given callback when the outline ends a series of
changes.</p>
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
  <th><code>callback</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function'>
  <code>Function</code>
</a> to be called when the outline ends updating.
  <ul>
  <li>
  <code>changes</code>
  &mdash;
  <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of <a class='reference' href='Mutation.html'>
  <code>Mutation</code>
</a>s.
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
    <tr><td>Returns a <a class='reference' href='https://atom.io/docs/api/latest/Disposable'>
  <code>Disposable</code>
</a> on which <code>.dispose()</code> can be called to unsubscribe.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-onDidUpdateChangeCount'>
  <code class='signature'>::onDidUpdateChangeCount(callback)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Invoke the given callback when the outline’s change count is
updated.</p>
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
  <th><code>callback</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function'>
  <code>Function</code>
</a> to be called when change count is updated.
  <ul>
  <li>
  <code>changeType</code>
  &mdash;
  The type of change made to the document.
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
    <tr><td>Returns a <a class='reference' href='https://atom.io/docs/api/latest/Disposable'>
  <code>Disposable</code>
</a> on which <code>.dispose()</code> can be called to unsubscribe.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-onDidDestroy'>
  <code class='signature'>::onDidDestroy(callback)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Invoke the given callback when the outline is destroyed.</p>
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
  <th><code>callback</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function'>
  <code>Function</code>
</a> to be called when the outline is destroyed.</td>
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
    <tr><td>Returns a <a class='reference' href='https://atom.io/docs/api/latest/Disposable'>
  <code>Disposable</code>
</a> on which <code>.dispose()</code> can be called to unsubscribe.
</td></tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Reading Items</h2>
<dl>
  <dt class='property-def' id='instance-root'>
  <code class='signature'>::root</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only root <a class='reference' href='Item.html'>
  <code>Item</code>
</a> in the outline. </p>
</dd>
<dt class='property-def' id='instance-items'>
  <code class='signature'>::items</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s in the outline (except the root). </p>
</dd>
  <dt class='method-def' id='instance-getItemForID'>
  <code class='signature'>::getItemForID(id)</code>
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
  <th><code>id</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> id.</td>
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
    <tr><td>Returns <a class='reference' href='Item.html'>
  <code>Item</code>
</a> for given id.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-evaluateItemPath'>
  <code class='signature'>::evaluateItemPath(itemPath, contextItem<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Evaluate the <a href="https://guide.taskpaper.com/reference/searches/">item path
search</a> starting from
this outline’s <a class='reference' href='Outline.html#static-root'>
  <code>Outline.root</code>
</a> item or from the passed in <code>contextItem</code> if
present.</p>
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
  <th><code>itemPath</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> itempath expression.</td>
</tr>
<tr>
  <th><code>contextItem<sup>?</sup></code></th>
  <td>defaults to <a class='reference' href='Outline.html#static-root'>
  <code>Outline.root</code>
</a>.</td>
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
    <tr><td>Returns an <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of matching <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s.
</td></tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Creating Items</h2>
<dl>
  <dt class='method-def' id='instance-createItem'>
  <code class='signature'>::createItem(text<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Create a new item. The new item is owned by this outline, but is
not yet inserted into it so it won’t be visible until you insert it.</p>
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
  <th><code>text<sup>?</sup></code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> or <a class='reference' href='AttributedString.html'>
  <code>AttributedString</code>
</a>.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-cloneItem'>
  <code class='signature'>::cloneItem(item, deep<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>The cloned item is owned by this outline, but is not yet inserted
into it so it won’t be visible until you insert it.</p>
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
  <td><a class='reference' href='Item.html'>
  <code>Item</code>
</a> to clone.</td>
</tr>
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
    <tr><td>Returns Clone of the given <a class='reference' href='Item.html'>
  <code>Item</code>
</a>.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-importItem'>
  <code class='signature'>::importItem(item, deep<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Creates a clone of the given <a class='reference' href='Item.html'>
  <code>Item</code>
</a> from an external outline that
can be inserted into the current outline.</p>
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
  <td><a class='reference' href='Item.html'>
  <code>Item</code>
</a> to import.</td>
</tr>
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
    <tr><td>Returns <a class='reference' href='Item.html'>
  <code>Item</code>
</a> clone.
</td></tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Insert &amp; Remove Items</h2>
<dl>
  <dt class='method-def' id='instance-insertItemsBefore'>
  <code class='signature'>::insertItemsBefore(items, referenceItem)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Insert the items before the given <code>referenceItem</code>. If the
reference item isn’t defined insert at the end of this outline.</p>
<p>Unlike <a class='reference' href='Item.html#instance-insertChildrenBefore'>
  <code>Item::insertChildrenBefore</code>
</a> this method uses <a class='reference' href='Item.html#instance-indent'>
  <code>Item::indent</code>
</a> to
determine where in the outline structure to insert the items. Depending on
the indent value these items may become referenceItem’s parent, previous
sibling, or unrelated.</p>
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
</a> or <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> of <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s to insert.</td>
</tr>
<tr>
  <th><code>referenceItem</code></th>
  <td>Reference <a class='reference' href='Item.html'>
  <code>Item</code>
</a> to insert before.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-removeItems'>
  <code class='signature'>::removeItems(items)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Remove the items but leave their child items in the outline and
give them new parents.</p>
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
</a> or <a class='reference' href='Item.html'>
  <code>Item</code>
</a> <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array'>
  <code>Array</code>
</a> to remove.</td>
</tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Changes</h2>
<dl>
  <dt class='property-def' id='instance-isChanging'>
  <code class='signature'>::isChanging</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean'>
  <code>Boolean</code>
</a> true if outline is changing. </p>
</dd>
  <dt class='method-def' id='instance-isChanged'>
  <code class='signature'>::isChanged()</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Determine if the outline is changed.</p>
  <table class='m-t return-value table table-condensed'>
  <thead>
    <tr>
      <th>Return Values</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>Returns a <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean'>
  <code>Boolean</code>
</a>.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-updateChangeCount'>
  <code class='signature'>::updateChangeCount()</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Updates the receiver’s change count according to the given change
type. </p>
</dd>
<dt class='method-def' id='instance-groupChanges'>
  <code class='signature'>::groupChanges(callback)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Group changes to the outline for better performance.</p>
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
  <th><code>callback</code></th>
  <td>Callback that contains code to change <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s in this <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a>.</td>
</tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Undo</h2>
<dl>
  <dt class='method-def' id='instance-groupUndo'>
  <code class='signature'>::groupUndo(callback)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Group multiple changes into a single undo group.</p>
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
  <th><code>callback</code></th>
  <td>Callback that contains code to change <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s in this <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a>.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-groupUndoAndChanges'>
  <code class='signature'>::groupUndoAndChanges(callback)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Group multiple changes into a single undo and change
group. This is a shortcut for:</p>
<pre><code class="lang-javascript">outline.groupUndo(<span class="hljs-function"><span class="hljs-keyword">function</span>(<span class="hljs-params"></span>) </span>{
  outline.groupChanges(<span class="hljs-function"><span class="hljs-keyword">function</span>(<span class="hljs-params"></span>) </span>{
    <span class="hljs-built_in">console</span>.log(<span class="hljs-string">'all grouped up!'</span>);
  });
});
</code></pre>
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
  <th><code>callback</code></th>
  <td>Callback that contains code to change <a class='reference' href='Item.html'>
  <code>Item</code>
</a>s in this <a class='reference' href='Outline.html'>
  <code>Outline</code>
</a>.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-undo'>
  <code class='signature'>::undo()</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Undo the last undo group. </p>
</dd>
<dt class='method-def' id='instance-redo'>
  <code class='signature'>::redo()</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Redo the last undo group. </p>
</dd>
</dl>
<h2>Serialization</h2>
<dl>
  <dt class='method-def' id='instance-serialize'>
  <code class='signature'>::serialize(options<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Return a serialized <a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> version of this Outline’s content.</p>
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
  <th><code>options<sup>?</sup></code></th>
  <td>Serialization options as defined in <a class='reference' href=''>
  <code></code>
</a>. <code>type</code> key defaults to <a class='reference' href=''>
  <code></code>
</a>.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-reloadSerialization'>
  <code class='signature'>::reloadSerialization(serialization, options<sup>?</sup>)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Reload the content of this outline using the given string serilaization.</p>
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
  <th><code>serialization</code></th>
  <td><a class='reference' href='https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String'>
  <code>String</code>
</a> outline serialization.</td>
</tr>
<tr>
  <th><code>options<sup>?</sup></code></th>
  <td>Deserialization options as defined in <a class='reference' href=''>
  <code></code>
</a>. <code>type</code> key defaults to <a class='reference' href=''>
  <code></code>
</a>.</td>
</tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Debug</h2>
<dl>
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