# Getting Started

1. Install [Node.js](http://nodejs.org)
2. Clone and build `birch-outline`

```shell
git clone https://github.com/jessegrosjean/birch-outline.git
cd birch-outline
npm install
```

The [documented API](./api.md) is relatively stable. Read read the [Contributing](./contributing.md) guide to make improvements.

## Node

Load `birch-outline` into a Node REPL session:

```shell
node # Start node REPL in birch-outline folder
> var birch = require('.') # Require birch-outline
> var outline = new birch.Outline.createTaskPaperOutline('Hello world') # Create Outline from TaskPaper
> var item = outline.root.firstChild
> item.setAttribute('data-done', '') # Make a change
> outline.serialize() # Serialize outline back to string
```

## Webpage

Use `birch-outline/min/birchoutline.js` for webpages. This example builds a nested `UL` from a TaskPaper outline:


```html
<!DOCTYPE html>
<html>
  <head>
    <title>Test Birch</title>
    <script src="./birch-outline/min/birchoutline.js" type="text/javascript"></script>
    <style type="text/css">
      li[data-type="project"] > p { font-weight: bold; }
      li[data-type="note"] > p { font-style: italic; color: grey; }
      li[data-done] > p { text-decoration: line-through; }
      span[tag] { color: lightgray; font-weight: normal }
    </style>
  </head>
  <body>
    <script type="text/javascript">
      var startText = 'one:\n\t- two\n\t\tthree\n\t\tfour @done\n\t- five\n\t\tsix';
      var taskPaperOutline = new birchoutline.Outline.createTaskPaperOutline(startText);
      var item = taskPaperOutline.root.firstChild;

      function insertChildren(item, parentUL) {
        item.children.forEach(function (each) {
          var itemLI = document.createElement('li');
          each.attributeNames.forEach(function(eachAttribute) {
            itemLI.setAttribute(eachAttribute, each.getAttribute(eachAttribute));
          });

          var itemBodyP = document.createElement('p');
          itemBodyP.innerHTML = each.bodyHighlightedAttributedString.toInlineBMLString();
          itemLI.appendChild(itemBodyP);

          var itemChildrenUL = document.createElement('ul');
          insertChildren(each, itemChildrenUL);
          if (itemChildrenUL.firstChild) {
            itemLI.appendChild(itemChildrenUL);
          }

          parentUL.appendChild(itemLI);
        });
      };

      var ul = document.createElement('ul');
      insertChildren(taskPaperOutline.root, ul);
      document.body.appendChild(ul);
    </script>
  </body>
</html>
```
