# Getting Started

1. Install [Node.js](http://nodejs.org)

2. Clone and build Birch-Outline

```shell
git clone https://github.com/jessegrosjean/birch-outline.git
cd birch-outline
npm install
```

You now have `birch-outline` built and ready to use or hack on. The fasted way to get something running is to use the node REPL like this:

```shell
cd..
node # Start node REPL
> var birch = require('./birch-outline') # Import birch-outline into node
> var outline = new birch.Outline.createTaskPaperOutline('Hello world @testing(123)') # Parse TaskPaper outline
> outline.serialize() # Serialize outline back to string
```

You can also use `birch-outline` on a webpage. You can find `birchoutline.js` in `birch-outline/min` and then include that on your web page. Here's an example that builds a nested `UL` from a birch outline:


```html
<!DOCTYPE html>
<html>
  <head>
    <title>Test Birch</title>
    <script src="./min/birchoutline.js" type="text/javascript"></script>
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

Learn more in the [API Docs](./api). The documented API is relatively stable and tested. Everything else is suspect, but if you see something you'd like to use let me know and we can get it tested and documented.
