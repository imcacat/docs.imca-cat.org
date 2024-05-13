# Documentation Guide

## Table of Contents
1. [Deviations](#deviations)
2. [Creating Documentation Pages](#creating-documentation-pages)
3. [Embedding Assets](#embedding-assets)
4. [Advanced Formatting](#advanced-formatting)
5. [FAQ](#faq)

## Deviations {#deviations}

1. [Page Structure (AsciiDoc)](#page-structure-asciidoc)

## Creating Documentation Pages {#creating-documentation-pages}

### Page Structure (General)

Every documentation page starts with a "front matter" section that specifies the layout, title, and navigation properties. Content starts on the line directly after the "front matter".

```yaml
---
layout: default
title: "Your Page Title"
parent: Parent Page Title
nav_order: 1
---
```

### Page Structure (Markdown)

```markdown
NOTE: Custom, Markdown-specific structure goes here if discovered
```

### Page Structure (AsciiDoc) {#page-structure-asciidoc}

- Front Matter
  - In AsciiDoc, traditional Jekyll front matter isn't used.
  - Attributes (akin to front matter) are defined directly within the document.
  - Each attribute is prefixed with a colon (:).
- Headings
  - AsciiDoc uses "=" for headings.
  - Heading level (impacts size and ordering, among other things) is denoted by the number of "=" used.
  - A "=" used to denote a heading MUST be followed by a space.
- Table of Contents (TOC)
  - Would like to learn more before documenting for everyone.
- Links:
  - Would like to learn more before documenting for everyone.
- Comments
  - Comments are denoted by two forward-slashes "//".
  - Would like to learn more before documenting for everyone.
- Metadata and Settings
  - Would like to learn more before documenting for everyone.

### Examples of AsciiDoc Syntax

- Headings:

```asciidoc
= H1 Level Heading
== H2 Level Heading
=== H3 Level Heading
```

- Paragraphs:

```asciidoc
A simple paragraph looks like this. You can write content directly in AsciiDoc.
```

- Lists:

```asciidoc
* Bullet list item 1
* Bullet list item 2
** Nested bullet list item

. Numbered list item 1
. Numbered list item 2
.. Nested numbered list item
```

## Embedding Assets {#embedding-assets}

### Images

Place images in the "assets/images" directory. Embed an image using:

```asciidoc
image::logo.png[Logo,200,100]
```

### Videos

While direct video embedding isn't supported in AsciiDoc through simple syntax, you can use HTML within your AsciiDoc files:

```html
video::+html+[]
<video controls>
  <source src="demo.mp4" type="video/mp4" />
  Your browser does not support the video tag.
</video>
+html+[]
```

## Advanced Formatting {#advanced-formatting}

### Admonitions

Use admonitions for important tips, notes, or warnings:

```asciidoc
NOTE: Remember to save your work frequently.

TIP: Check the Just-The-Docs documentation for more customization options.

WARNING: Incorrect configurations can lead to build failures.
```

### Code Blocks

Include code snippets using source blocks:

```python
import numpy as np

def mean(numbers):
    return np.mean(numbers)
```

## FAQ {#faq}

### Questions

#### Question

Here are the things I'd wish to know how to do for the documentation solution:

1. How do I clone the repo, make a change, and publish?
2. How do I test a change locally?

#### How do I clone the repo, make a change, and publish?

```shell
# To clone the repository
git clone [repository_URL]
hg clone [repository_URL]

# To make changes
# Follow standard Git or Mercurial workflows

# To publish changes
# Follow standard Git or Mercurial workflows
```

#### How do I test a change locally?

```shell
# To test changes locally
# Follow standard Git or Mercurial workflows for local testing
```

Deviation from CommonMark Standard: The use of `[horizontal]` and `|===` for creating a table-like structure.
