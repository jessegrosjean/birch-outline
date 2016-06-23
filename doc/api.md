

# <a name='classes'>API</a>

Class |  Summary
------| ------------
<code>[AttributedString](#class-AttributedString)</code> | A container holding both characters and associated attributes.
<code>[DateTime](#class-DateTime)</code> | Date and time parsing and conversion. 
<code>[ItemSerializer](#class-ItemSerializer)</code> | A class for serializing and deserializing <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s. 
<code>[Item](#class-Item)</code> | A paragraph of text in an <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a>.
<code>[Mutation](#class-Mutation)</code> | A record of a single change in an <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>.
<code>[Outline](#class-Outline)</code> | A mutable outline of <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s.


### <a name="class-AttributedString">AttributedString</a><b><sub><sup><code>CLASS </code></sup></sub></b><a href="#classes"><img src="https://rawgit.com/venkatperi/atomdoc-md/master/assets/octicons/arrow-up.svg" alt="Back to Class List" height= "18px"></a>

<p>A container holding both characters and associated attributes.</p>


<table width="100%">
  <tr>
    <td colspan="4"><h4>Properties</h4></td>
  </tr>
  
      <tr>
        <td><code>:: <b>string</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only string </p>
  
    </td>
  </tr>
  
  <tr>
    <td colspan="2"></td>
  </tr>
  <tr>
    <td colspan="4"><h4>Methods</h4></td>
  </tr>
  
  <tr>
    <td><code>:: <b>constructor(</b> text <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>text</code> Text content for the AttributedString. </li>
  </ul>
  
      <p>Create a new AttributedString with the given text.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>clone(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      
      <p>Return a clone of this AttributedString. The attributes are
  shallow copied. </p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>deleteRange(</b> location, length <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>location</code> Range start character index.</li>
  <li><code>length</code> Range length. </li>
  </ul>
  
      <p>Delete characters and attributes in range.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>insertText(</b> location, text <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>location</code> Location to insert at.</li>
  <li><code>text</code> text to insert. </li>
  </ul>
  
      <p>Insert text into the string.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>appendText(</b> text <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>text</code> text to insert. </li>
  </ul>
  
      <p>Append text to the end of the string.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>replaceRange(</b> location, length, text <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>location</code> Replace range start character index.</li>
  <li><code>length</code> Replace range length.</li>
  <li><code>text</code> text to insert. </li>
  </ul>
  
      <p>Replace existing text range with new text.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>getAttributesAtIndex(</b> index[, effectiveRange][, longestEffectiveRange] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>index</code> The character index.</li>
  <li><code>effectiveRange</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> whose <code>location</code> and <code>length</code>  properties are set to effective range of the attributes.</li>
  <li><code>longestEffectiveRange</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> whose <code>location</code> and <code>length</code>  properties are set to longest effective range of the attributes. </li>
  </ul>
  
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns an <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> with keys for each attribute at the given
  character index, and by reference the range over which the
  attributes apply.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>getAttributeAtIndex(</b> attribute, index[, effectiveRange][, longestEffectiveRange] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>attribute</code> Attribute <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> name.</li>
  <li><code>index</code> The character index.</li>
  <li><code>effectiveRange</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> whose <code>location</code> and <code>length</code>  properties are set to effective range of the attribute.</li>
  <li><code>longestEffectiveRange</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> whose <code>location</code> and <code>length</code>  properties are set to longest effective range of the attribute. </li>
  </ul>
  
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns the value for an attribute with a given name of the
  character at a given character index, and by reference the range over which
  the attribute applies.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>addAttributeInRange(</b> attribute, value, index, length <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>attribute</code> The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> attribute name.</li>
  <li><code>value</code> The attribute value.</li>
  <li><code>index</code> Start character index.</li>
  <li><code>length</code> Range length. </li>
  </ul>
  
      <p>Adds an attribute to the characters in the given range.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>addAttributesInRange(</b> attributes, index, length <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>attributes</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> with keys and values for each attribute</li>
  <li><code>index</code> Start index.</li>
  <li><code>length</code> Range length. </li>
  </ul>
  
      <p>Adds attributes to the characters in the given range.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>removeAttributeInRange(</b> attribute, index, length <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>attribute</code> The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> attribute name</li>
  <li><code>index</code> Start character index.</li>
  <li><code>length</code> Range length. </li>
  </ul>
  
      <p>Removes the attribute from the given range.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>attributedSubstringFromRange(</b> [location][, length] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>location</code> Range start character index. Defaults to 0.</li>
  <li><code>length</code> Range length. Defaults to end of string. </li>
  </ul>
  
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns an <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/attributed-string.coffee#L20">AttributedString</a> object consisting of the characters
  and attributes within a given range in the receiver.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>toString(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-AttributedString">AttributedString</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns debug string for this item.</li>
  </ul>
  
    </td>
  </tr>
  
</table>

<hr/>
### <a name="class-DateTime">DateTime</a><b><sub><sup><code>CLASS </code></sup></sub></b><a href="#classes"><img src="https://rawgit.com/venkatperi/atomdoc-md/master/assets/octicons/arrow-up.svg" alt="Back to Class List" height= "18px"></a>

<p>Date and time parsing and conversion. </p>


<table width="100%">
  <tr>
    <td colspan="4"><h4>Methods</h4></td>
  </tr>
  
  <tr>
    <td><code>:: <b>parse(</b> string <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>class</sub></td>
    <td width="8%" align="center"><sub><a href="#class-DateTime">DateTime</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>string</code> The date/time <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a>.</li>
  </ul>
  
      <p>Parse the given string and return associated <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date">Date</a>.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date">Date</a>.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>format(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>class</sub></td>
    <td width="8%" align="center"><sub><a href="#class-DateTime">DateTime</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>dateOrString</code> The date/time <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date">Date</a> to format.</li>
  </ul>
  
      <p>Format the given date/time <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date">Date</a> as a minimal absolute date/time <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a>.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a>.</li>
  </ul>
  
    </td>
  </tr>
  
</table>

<hr/>
### <a name="class-ItemSerializer">ItemSerializer</a><b><sub><sup><code>CLASS </code></sup></sub></b><a href="#classes"><img src="https://rawgit.com/venkatperi/atomdoc-md/master/assets/octicons/arrow-up.svg" alt="Back to Class List" height= "18px"></a>

<p>A class for serializing and deserializing <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s. </p>


<table width="100%">
  <tr>
    <td colspan="4"><h4>Properties</h4></td>
  </tr>
  
      <tr>
        <td><code>:: <b>ItemReferencesType</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>class</sub></td>
        <td width="8%" align="center"><sub><a href="#class-ItemSerializer">ItemSerializer</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Outline and item ID JSON for the pasteboard. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>BMLType</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>class</sub></td>
        <td width="8%" align="center"><sub><a href="#class-ItemSerializer">ItemSerializer</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>BML type constant.</p>
  <ul>
  <li>HTML subset for representing outlines in HTML. </li>
  </ul>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>OPMLType</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>class</sub></td>
        <td width="8%" align="center"><sub><a href="#class-ItemSerializer">ItemSerializer</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>OPML type constant.</p>
  <ul>
  <li>See <a href="https://en.wikipedia.org/wiki/OPML">https://en.wikipedia.org/wiki/OPML</a> </li>
  </ul>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>TaskPaperType</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>class</sub></td>
        <td width="8%" align="center"><sub><a href="#class-ItemSerializer">ItemSerializer</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>TaskPaper text type constant.</p>
  <ul>
  <li>Encode item structure with tabs.</li>
  <li>Encode item <code>data-*</code> attributes with <code>tag(value)</code> pattern. </li>
  </ul>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>TEXTType</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>class</sub></td>
        <td width="8%" align="center"><sub><a href="#class-ItemSerializer">ItemSerializer</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Plain text type constant.</p>
  <ul>
  <li>Encode item structure with tabs. </li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td colspan="2"></td>
  </tr>
  <tr>
    <td colspan="4"><h4>Methods</h4></td>
  </tr>
  
  <tr>
    <td><code>:: <b>serializeItems(</b> items, mimeType <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>class</sub></td>
    <td width="8%" align="center"><sub><a href="#class-ItemSerializer">ItemSerializer</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>items</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> to serialize.</li>
  <li><code>mimeType</code> Supported serialization format. </li>
  </ul>
  
      <p>Serialize items into a supported format.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>deserializeItems(</b> itemsData, outline, mimeType <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>class</sub></td>
    <td width="8%" align="center"><sub><a href="#class-ItemSerializer">ItemSerializer</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>itemsData</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> to deserialize.</li>
  <li><code>outline</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a> to use when creating deserialized items.</li>
  <li><code>mimeType</code> Format to deserialize.</li>
  </ul>
  
      <p>Deserialize items from a supported format.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of `{Items}`.</li>
  </ul>
  
    </td>
  </tr>
  
</table>

<hr/>
### <a name="class-Item">Item</a><b><sub><sup><code>CLASS </code></sup></sub></b><a href="#classes"><img src="https://rawgit.com/venkatperi/atomdoc-md/master/assets/octicons/arrow-up.svg" alt="Back to Class List" height= "18px"></a>

<p>A paragraph of text in an <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a>.</p>
<p>Items cannot be created directly. Use {Outline::createItem} to create items.</p>
<p>Items may contain other child items to form a hierarchy. When you move an
item its children move with it. See the &quot;Structure&quot; and &quot;Mutate Structure&quot;
sections for associated APIs. To move an item while leaving it&#39;s children in
place see the methods in <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a>s &quot;Insert &amp; Remove Items&quot;.</p>
<p>Items may have associated attributes. You can add your own attributes by
using the APIs described in the &quot;Item Attributes&quot; section. For example you might
add a due date using the <code>data-due-date</code> attribute.</p>
<p>Items have an associated paragraph of body text. You can access it as plain
text or as an immutable <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/attributed-string.coffee#L20">AttributedString</a>. You can also add and remove
attributes from ranges of body text. See &quot;Item Body Text&quot; for associated
APIs. While you can add these attributes at runtime, TaskPaper won&#39;t save
them to disk since it saved in plain text without associated text run
attributes.</p>


<table width="100%">
  <tr>
    <td colspan="4"><h4>Properties</h4></td>
  </tr>
  
      <tr>
        <td><code>:: <b>id</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only unique <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> identifier. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>outline</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a> that this item belongs to. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>isInOutline</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only true if item is contained by root of owning <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>isOutlineRoot</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only true if is {::outline} root <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>depth</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only depth of <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> in outline structure. Calculated by
  summing the {Item::indent} of this item and it&#39;s ancestors. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>parent</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only parent <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>firstChild</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only first child <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>lastChild</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only last child <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>previousSibling</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only previous sibling <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>nextSibling</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only next sibling <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>previousBranch</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only previous branch <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>nextBranch</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only next branch <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>ancestors</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of ancestor <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>descendants</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of descendant <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>lastDescendant</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only last descendant <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>branchItems</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of this <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> and its descendants. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>lastBranchItem</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Last <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> in branch rooted at this item. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>previousItem</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only previous <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> in the outline. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>nextItem</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only next <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> in the outline. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>hasChildren</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only has children <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean">Boolean</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>children</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of child <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>indent</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Visual indent of <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> relative to parent. Normally this will be
  1 for children with a parent as they are indented one level beyond there
  parent. But items can be visually over-indented in which case this value
  would be greater then 1. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>attributes</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only key/value object of the attributes associated with this
  <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>attributeNames</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of this <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>&#39;s attribute names. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>bodyString</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Body text as plain text <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a>. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>bodyContentString</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Body &quot;content&quot; text as plain text <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a>. Excludes trailing tags
  and leading syntax. For example used when displaying items to user&#39;s in
  menus. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>bodyAttributedString</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Body text as immutable <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/attributed-string.coffee#L20">AttributedString</a>. Do not modify this
  AttributedString, instead use the other methods in this &quot;Body Text&quot;
  section. They will both modify the string and create the appropriate
  <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/mutation.coffee#L9">Mutation</a> events needed to keep the outline valid. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>bodyHighlightedAttributedString</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Syntax highlighted body text as immutable <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/attributed-string.coffee#L20">AttributedString</a>.
  Unlike <code>bodyAttributedString</code> this string contains attributes created by
  syntax highlighting such as tag name and value ranges.</p>
  <p>Do not modify this AttributedString, instead use the other methods in this
  &quot;Body Text&quot; section. They will both modify the string and create the
  appropriate <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/mutation.coffee#L9">Mutation</a> events needed to keep the outline valid. </p>
  
    </td>
  </tr>
  
  <tr>
    <td colspan="2"></td>
  </tr>
  <tr>
    <td colspan="4"><h4>Methods</h4></td>
  </tr>
  
  <tr>
    <td><code>:: <b>getCommonAncestors(</b> items <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>class</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>items</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s.</li>
  </ul>
  
      <p>Given an array of items determines and returns the common
  ancestors of those items.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns a <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of common ancestor <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>clone(</b> [deep] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>deep</code> defaults to true.</li>
  </ul>
  
      <p>Clones this item.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns a duplicate <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> with a new {::id}.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>contains(</b> item <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>item</code> The <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> to check for containment.</li>
  </ul>
  
      <p>Determines if this item contains the given item.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean">Boolean</a>.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>insertChildrenBefore(</b> children[, referenceSibling] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>children</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s to insert.</li>
  <li><code>referenceSibling</code> The referenced sibling <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> to insert before. </li>
  </ul>
  
      <p>Insert the new children before the referenced sibling in this
  item&#39;s list of children. If referenceSibling isn&#39;t defined the new children are
  inserted at the end. This method resets the indent of children to match
  referenceSibling&#39;s indent or to 1.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>appendChildren(</b> children <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>children</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s to append. </li>
  </ul>
  
      <p>Append the new children to this item&#39;s list of children.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>removeChildren(</b> children <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>children</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of child <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s to remove. </li>
  </ul>
  
      <p>Remove the children from this item&#39;s list of children. When an
  item is removed its the parent&#39;s {::depth} is added to the removed item&#39;s
  {::indent}, preserving the removed items depth if needed later.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>removeFromParent(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      
      <p>Remove this item from it&#39;s parent item if it has a parent. </p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>hasAttribute(</b> name <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>name</code> The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> attribute name. </li>
  </ul>
  
      <p>Return <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean">Boolean</a> <code>true</code> if this item has the given attribute.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>getAttribute(</b> name[, clazz][, array] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>name</code> The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> attribute name.</li>
  <li><code>clazz</code> Class (<a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number">Number</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date">Date</a>) to parse string values to objects of given class.</li>
  <li><code>array</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean">Boolean</a> true if should split comma separated string value to create an array.</li>
  </ul>
  
      <p>Return the value of the given attribute. If the attribute does not
  exist will return <code>null</code>. Attribute values are always stored as <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a>s.
  Use the <code>class</code> and <code>array</code> parameters to parse the string values to other
  types before returning.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns attribute value.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>setAttribute(</b> name, value <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>name</code> The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> attribute name.</li>
  <li><code>value</code> The new attribute value. </li>
  </ul>
  
      <p>Adds a new attribute or changes the value of an existing
  attribute. <code>id</code> is reserved and an exception is thrown if you try to set
  it. Setting an attribute to <code>null</code> or <code>undefined</code> removes the attribute.
  Generally all item attribute names should start with <code>data-</code> to avoid
  conflict with built in attribute names.</p>
  <p>Attribute values are always stored as <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a>s so they will stay
  consistent through any serialization process. For example if you set an
  attribute to the Number <code>1.0</code> when you {::getAttribute} the value is the
  <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> <code>&quot;1.0&quot;</code>. See {::getAttribute} for options to automatically
  convert the stored <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> back to a <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number">Number</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date">Date</a>.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>removeAttribute(</b> name <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>name</code> The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> attribute name. </li>
  </ul>
  
      <p>Removes an item attribute.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>getBodyAttributesAtIndex(</b> characterIndex[, effectiveRange][, longestEffectiveRange] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>characterIndex</code> The character index.</li>
  <li><code>effectiveRange</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> whose <code>location</code> and <code>length</code>  properties are set to effective range of the attributes.</li>
  <li><code>longestEffectiveRange</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> whose <code>location</code> and <code>length</code>  properties are set to longest effective range of the attributes. </li>
  </ul>
  
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns an <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> with keys for each attribute at the given
  character characterIndex, and by reference the range over which the
  attributes apply.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>getBodyAttributeAtIndex(</b> attribute, characterIndex[, effectiveRange][, longestEffectiveRange] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>attribute</code> Attribute <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> name.</li>
  <li><code>characterIndex</code> The character index.</li>
  <li><code>effectiveRange</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> whose <code>location</code> and <code>length</code>  properties are set to effective range of the attribute.</li>
  <li><code>longestEffectiveRange</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> whose <code>location</code> and <code>length</code>  properties are set to longest effective range of the attribute. </li>
  </ul>
  
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns the value for an attribute with a given name of the
  character at a given characterIndex, and by reference the range over which
  the attribute applies.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>addBodyAttributeInRange(</b> attribute, value, location, length <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>attribute</code> The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> attribute name.</li>
  <li><code>value</code> The attribute value.</li>
  <li><code>location</code> Start character index.</li>
  <li><code>length</code> Range length. </li>
  </ul>
  
      <p>Adds an attribute to the characters in the given range.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>addBodyAttributesInRange(</b> attributes, location, length <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>attributes</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object">Object</a> with keys and values for each attribute</li>
  <li><code>location</code> Start index.</li>
  <li><code>length</code> Range length. </li>
  </ul>
  
      <p>Adds attributes to the characters in the given range.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>removeBodyAttributeInRange(</b> attribute, location, length <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>attribute</code> The <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> attribute name</li>
  <li><code>location</code> Start character index.</li>
  <li><code>length</code> Range length. </li>
  </ul>
  
      <p>Removes the attribute from the given range.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>replaceBodyRange(</b> location, length, insertedText <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>location</code> Start character index.</li>
  <li><code>length</code> Range length.</li>
  <li><code>insertedText</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> or <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/attributed-string.coffee#L20">AttributedString</a> </li>
  </ul>
  
      <p>Replace body text in the given range.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>appendBody(</b> text <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>text</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> or <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/attributed-string.coffee#L20">AttributedString</a> </li>
  </ul>
  
      <p>Append body text.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>branchToString(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>extended</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns debug string for this item and it&#39;s descendants.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>toString(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>extended</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Item">Item</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns debug string for this item.</li>
  </ul>
  
    </td>
  </tr>
  
</table>

<hr/>
### <a name="class-Mutation">Mutation</a><b><sub><sup><code>CLASS </code></sup></sub></b><a href="#classes"><img src="https://rawgit.com/venkatperi/atomdoc-md/master/assets/octicons/arrow-up.svg" alt="Back to Class List" height= "18px"></a>

<p>A record of a single change in an <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>.</p>
<p>A new mutation is created to record each attribute set, body text change,
and child item update. Use {Outline::onDidChange} to receive this mutation
record so you can track what changes as an outline is edited. </p>


<table width="100%">
  <tr>
    <td colspan="4"><h4>Properties</h4></td>
  </tr>
  
      <tr>
        <td><code>:: <b>ATTRIBUTE_CHANGED</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>class</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>ATTRIBUTE_CHANGED Mutation type constant. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>BODY_CHANGED</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>class</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>BODY_CHANGED Mutation type constant. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>CHILDREN_CHANGED</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>class</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>CHILDREN_CHANGED Mutation type constant. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>target</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> target of the mutation. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>type</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only type of change. {Mutation.ATTRIBUTE_CHANGED},
  {Mutation.BODY_CHANGED}, or {Mutation.CHILDREN_CHANGED}. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>attributeName</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only name of changed attribute in the target <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>, or null. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>attributeOldValue</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only previous value of changed attribute in the target
  <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>, or null. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>insertedTextLocation</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only value of the body text location where the insert started
  in the target <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>, or null. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>insertedTextLength</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only value of length of the inserted body text in the target
  <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>, or null. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>replacedText</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/attributed-string.coffee#L20">AttributedString</a> of replaced body text in the target
  <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>, or null. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>addedItems</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of child <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s added to the target. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>removedItems</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of child <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s removed from the target. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>previousSibling</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only previous sibling <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> of the added or removed Items,
  or null. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>nextSibling</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Mutation">Mutation</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only next sibling <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> of the added or removed Items, or
  null. </p>
  
    </td>
  </tr>
  
  <tr>
    <td colspan="2"></td>
  </tr>
</table>

<hr/>
### <a name="class-Outline">Outline</a><b><sub><sup><code>CLASS </code></sup></sub></b><a href="#classes"><img src="https://rawgit.com/venkatperi/atomdoc-md/master/assets/octicons/arrow-up.svg" alt="Back to Class List" height= "18px"></a>

<p>A mutable outline of <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s.</p>
<p>Use outlines to create new items, find existing items, watch for changes
in items, and add/remove items.</p>
<p>When you add/remove items using the outline&#39;s methods the items children are
left in place. For example if you remove an item, it&#39;s chilren stay in the
outline and are reasigned to a new parent item.</p>


<table width="100%">
  <tr>
    <td colspan="4"><h4>Properties</h4></td>
  </tr>
  
      <tr>
        <td><code>:: <b>id</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only unique (not persistent) <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> outline ID. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>root</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only root <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> in the outline. </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>items</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s in the outline (except the root). </p>
  
    </td>
  </tr>
  
      <tr>
        <td><code>:: <b>isChanging</b>  </code></td>
        <td width="8%" align="center"><sub>public</sub></td>
        <td width="8%" align="center"><sub>instance</sub></td>
        <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
      </tr>
  <tr>
    <td colspan="4">
      <p>Read-only <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean">Boolean</a> true if outline is changing. </p>
  
    </td>
  </tr>
  
  <tr>
    <td colspan="2"></td>
  </tr>
  <tr>
    <td colspan="4"><h4>Methods</h4></td>
  </tr>
  
  <tr>
    <td><code>:: <b>createTaskPaperOutline(</b> content <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>class</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>content</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> (optional) outline content in TaskPaper format. </li>
  </ul>
  
      <p>The outline is configured to handle TaskPaper content at runtime. For
  example when you set attributes through the <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> API they are encoded in
  the item body text as @tags. And when you modify the body text @tags are
  parsed out and stored as attributes.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns a TaskPaper <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a>.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>getOutlines(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>class</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      
      <p>Retrieves all open <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a>s.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns an <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a>s.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>getOutlineForID(</b> id <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>class</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>id</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> outline id. </li>
  </ul>
  
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns existing <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a> with the given outline id.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>constructor(</b> [type][, serialization] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>type</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> outline type. Default to {ItemSerializer.TEXTType}.</li>
  <li><code>serialization</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> Serialized outline content of <code>type</code> to load. </li>
  </ul>
  
      <p>Create a new outline.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>onDidBeginChanges(</b> callback <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>callback</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function">Function</a> to be called when the outline begins updating.</li>
  </ul>
  
      <p>Invoke the given callback when the outline begins a series of
  changes.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns a `{Disposable}` on which <code>.dispose()</code> can be called to unsubscribe.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>onWillChange(</b> callback <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>callback</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function">Function</a> to be called when the outline will change.<ul>
  <li><code>mutation</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/mutation.coffee#L9">Mutation</a> describing the change.</li>
  </ul>
  </li>
  </ul>
  
      <p>Invoke the given callback <em>before</em> the outline changes.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns a `{Disposable}` on which <code>.dispose()</code> can be called to unsubscribe.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>onDidChange(</b> callback <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>callback</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function">Function</a> to be called when the outline changes.<ul>
  <li><code>mutation</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/mutation.coffee#L9">Mutation</a> describing the changes.</li>
  </ul>
  </li>
  </ul>
  
      <p>Invoke the given callback when the outline changes.</p>
  <p>See <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a> Examples for an example of subscribing to this event.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns a `{Disposable}` on which <code>.dispose()</code> can be called to unsubscribe.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>onDidEndChanges(</b> callback <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>callback</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function">Function</a> to be called when the outline ends updating.<ul>
  <li><code>changes</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/mutation.coffee#L9">Mutation</a>s.</li>
  </ul>
  </li>
  </ul>
  
      <p>Invoke the given callback when the outline ends a series of
  changes.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns a `{Disposable}` on which <code>.dispose()</code> can be called to unsubscribe.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>onDidChangeModified(</b> callback <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>callback</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function">Function</a> to be called when {::isModified} changes.<ul>
  <li><code>modified</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean">Boolean</a> indicating whether the outline is modified.</li>
  </ul>
  </li>
  </ul>
  
      <p>Invoke the given callback when the value of {::isModified} changes.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns a `{Disposable}` on which <code>.dispose()</code> can be called to unsubscribe.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>onDidDestroy(</b> callback <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>callback</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function">Function</a> to be called when the outline is destroyed.</li>
  </ul>
  
      <p>Invoke the given callback when the outline is destroyed.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns a `{Disposable}` on which <code>.dispose()</code> can be called to unsubscribe.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>getItemForID(</b> id <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>id</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> id. </li>
  </ul>
  
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> for given id.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>evaluateItemPath(</b> itemPath[, contextItem] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>itemPath</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> itempath expression.</li>
  <li><code>contextItem</code> defaults to {Outline.root}.</li>
  </ul>
  
      <p>Evaluate the item path starting from this outline&#39;s {Outline.root}
  item or from the passed in <code>contextItem</code> if present.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns an <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of matching <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>createItem(</b> [text] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>text</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> or <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/attributed-string.coffee#L20">AttributedString</a>. </li>
  </ul>
  
      <p>Create a new item. The new item is owned by this outline, but is
  not yet inserted into it so it won&#39;t be visible until you insert it.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>cloneItem(</b> item[, deep] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>item</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> to clone.</li>
  <li><code>deep</code> defaults to true.</li>
  </ul>
  
      <p>The cloned item is owned by this outline, but is not yet inserted
  into it so it won&#39;t be visible until you insert it.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns Clone of the given <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>importItem(</b> item[, deep] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>item</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> to import.</li>
  <li><code>deep</code> defaults to true.</li>
  </ul>
  
      <p>Creates a clone of the given <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> from an external outline that
  can be inserted into the current outline.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> clone.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>insertItemsBefore(</b> items, referenceItem <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>items</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> of <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s to insert.</li>
  <li><code>referenceItem</code> Reference <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> to insert before. </li>
  </ul>
  
      <p>Insert the items before the given <code>referenceItem</code>. If the
  reference item isn&#39;t defined insert at the end of this outline.</p>
  <p>Unlike {Item::insertChildrenBefore} this method uses {Item::indent} to
  determine where in the outline structure to insert the items. Depending on
  the indent value these items may become referenceItem&#39;s parent, previous
  sibling, or unrelated.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>removeItems(</b> items <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>items</code> <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> or <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array">Array</a> to remove. </li>
  </ul>
  
      <p>Remove the items but leave their child items in the outline and
  give them new parents.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>groupChanges(</b> callback <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>callback</code> Callback that contains code to change <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s in this <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a>. </li>
  </ul>
  
      <p>Group changes to the outline for better performance.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>groupUndo(</b> callback <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>callback</code> Callback that contains code to change <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s in this <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a>. </li>
  </ul>
  
      <p>Group multiple changes into a single undo group.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>groupUndoAndChanges(</b> callback <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>callback</code> Callback that contains code to change <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/item.coffee#L57">Item</a>s in this <a href="https://github.com/jessegrosjean/birch-outline/blob/v0.1.0/src/outline.coffee#L57">Outline</a>. </li>
  </ul>
  
      <p>Group multiple changes into a single undo and change
  group. This is a shortcut for:</p>
  <pre><code class="lang-javascript">outline.groupUndo(function() {
    outline.groupChanges(function() {
      console.log(&#39;all grouped up!&#39;);
    });
  });
  </code></pre>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>undo(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      
      <p>Undo the last undo group. </p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>redo(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      
      <p>Redo the last undo group. </p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>serialize(</b> [type] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>type</code> Defaults to {outline.type} </li>
  </ul>
  
      <p>Return a serialized <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> version of this Outline&#39;s content.</p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>reloadSerialization(</b> [type] <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      <ul>
  <li><code>type</code> <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a> format to serialize as. Defaults to {outline.type} </li>
  </ul>
  
      <p>Load <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String">String</a></p>
  
      
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>toString(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>extended</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      
      
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns debug string for this item.</li>
  </ul>
  
    </td>
  </tr>
  
  <tr>
    <td><code>:: <b>isModified(</b>  <b>)</b></code></td>
    <td width="8%" align="center"><sub>public</sub></td>
    <td width="8%" align="center"><sub>instance</sub></td>
    <td width="8%" align="center"><sub><a href="#class-Outline">Outline</a></sub></td>
  </tr>
  <tr>
    <td colspan="4">
      
      <p>Determine if the outline has changed since it was loaded.</p>
  <p>If the outline is unsaved, always returns <code>true</code> unless the outline is
  empty.</p>
  
      <p>  <em>Returns</em></p>
  <ul>
  <li>Returns a <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean">Boolean</a>.</li>
  </ul>
  
    </td>
  </tr>
  
</table>




<br>
<sub>Markdown generated by [atomdoc-md](https://github.com/venkatperi/atomdoc-md).</sub>
