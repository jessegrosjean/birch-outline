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
  <h1>AttributedString</h1>
  <p>A container holding both characters and associated attributes.</p>
  <h2>Examples</h2>
<p>Enumerate attribute ranges:</p>
<pre><code class="lang-javascript"><span class="hljs-keyword">var</span> effectiveRange = {};
<span class="hljs-keyword">var</span> textLength = attributedString.length;
<span class="hljs-keyword">var</span> index = <span class="hljs-number">0</span>;
<span class="hljs-keyword">while</span> (index &lt; textLength) {
  <span class="hljs-built_in">console</span>.log(attributedString.getAttributesAtIndex(index, effectiveRange));
  index += effectiveRange.length;
}
</code></pre>
  
<h2>Creating</h2>
<dl>
  <dt class='method-def' id='instance-constructor'>
  <code class='signature'>::constructor(text)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Create a new AttributedString with the given text.</p>
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
  <td>Text content for the AttributedString.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-clone'>
  <code class='signature'>::clone()</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Return a clone of this AttributedString. The attributes are
shallow copied. </p>
</dd>
</dl>
<h2>Characters</h2>
<dl>
  <dt class='property-def' id='instance-string'>
  <code class='signature'>::string</code>
</dt>
<dd class='property-def m-t-md m-b-md'>
  <p>Read-only string </p>
</dd>
  <dt class='method-def' id='instance-deleteRange'>
  <code class='signature'>::deleteRange(location, length)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Delete characters and attributes in range.</p>
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
  <td>Range start character index.</td>
</tr>
<tr>
  <th><code>length</code></th>
  <td>Range length.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-insertText'>
  <code class='signature'>::insertText(location, text)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Insert text into the string.</p>
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
  <td>Location to insert at.</td>
</tr>
<tr>
  <th><code>text</code></th>
  <td>text to insert.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-appendText'>
  <code class='signature'>::appendText(text)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Append text to the end of the string.</p>
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
  <td>text to insert.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-replaceRange'>
  <code class='signature'>::replaceRange(location, length, text)</code>
</dt>
<dd class='method-def m-t-md m-b-md'>
  <p>Replace existing text range with new text.</p>
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
  <td>Replace range start character index.</td>
</tr>
<tr>
  <th><code>length</code></th>
  <td>Replace range length.</td>
</tr>
<tr>
  <th><code>text</code></th>
  <td>text to insert.</td>
</tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Attributes</h2>
<dl>
  <dt class='method-def' id='instance-getAttributesAtIndex'>
  <code class='signature'>::getAttributesAtIndex(index, effectiveRange<sup>?</sup>, longestEffectiveRange<sup>?</sup>)</code>
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
  <th><code>index</code></th>
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
character index, and by reference the range over which the
attributes apply.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-getAttributeAtIndex'>
  <code class='signature'>::getAttributeAtIndex(attribute, index, effectiveRange<sup>?</sup>, longestEffectiveRange<sup>?</sup>)</code>
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
  <th><code>index</code></th>
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
character at a given character index, and by reference the range over which
the attribute applies.
</td></tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-addAttributeInRange'>
  <code class='signature'>::addAttributeInRange(attribute, value, index, length)</code>
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
  <th><code>index</code></th>
  <td>Start character index.</td>
</tr>
<tr>
  <th><code>length</code></th>
  <td>Range length.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-addAttributesInRange'>
  <code class='signature'>::addAttributesInRange(attributes, index, length)</code>
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
  <th><code>index</code></th>
  <td>Start index.</td>
</tr>
<tr>
  <th><code>length</code></th>
  <td>Range length.</td>
</tr>
  </tbody>
</table>
</dd>
<dt class='method-def' id='instance-removeAttributeInRange'>
  <code class='signature'>::removeAttributeInRange(attribute, index, length)</code>
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
  <th><code>index</code></th>
  <td>Start character index.</td>
</tr>
<tr>
  <th><code>length</code></th>
  <td>Range length.</td>
</tr>
  </tbody>
</table>
</dd>
</dl>
<h2>Extracting a Substring</h2>
<dl>
  <dt class='method-def' id='instance-attributedSubstringFromRange'>
  <code class='signature'>::attributedSubstringFromRange(location<sup>?</sup>, length<sup>?</sup>)</code>
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
  <th><code>location<sup>?</sup></code></th>
  <td>Range start character index. Defaults to 0.</td>
</tr>
<tr>
  <th><code>length<sup>?</sup></code></th>
  <td>Range length. Defaults to end of string.</td>
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
    <tr><td>Returns an <a class='reference' href='AttributedString.html'>
  <code>AttributedString</code>
</a> object consisting of the characters
and attributes within a given range in the receiver.
</td></tr>
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