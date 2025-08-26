# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Zine-based static blog styled with Tufte CSS, designed for minimal, readable content presentation similar to markbucciarelli.com.

## Development Commands

### Running the Development Server
```bash
zine                          # Start dev server on localhost:1990
zine --port 8080             # Use custom port
zine --drafts                # Include draft posts
```

### Building for Production
```bash
zine release                 # Generate static site in zig-out/www/
```

## Project Architecture

### Content Structure
- **Content files** (`content/*.smd`): SuperMD format with frontmatter requiring:
  - `.title` - Page title
  - `.date` - Publication date using `@date("YYYY-MM-DDTHH:MM:SS")`
  - `.author` - Author name (required field)
  - `.layout` - Template to use (e.g., "post.shtml", "index.shtml")
  - `.draft` - Boolean for draft status

### Template System
- **Base template** (`layouts/templates/base.shtml`): Core HTML structure with Tufte CSS
- **Index template** (`layouts/index.shtml`): Lists blog posts with dates as margin notes
- **Post template** (`layouts/post.shtml`): Individual blog post layout
- Templates use SuperHTML with directives like `:text`, `:html`, `:loop`, `:if`

### Key Configuration
- **zine.ziggy**: Main configuration file specifying:
  - Site title and host URL
  - Directory paths for content, layouts, and assets
  - Static assets list

### Styling
- Uses Tufte CSS (`assets/tufte.css`) for typography and layout
- Minimal navigation: home | about
- Focus on readability with generous margins and clean typography

## Important Notes

- Zine automatically rebuilds on file changes in development mode
- The warning about DEBUG BUILD can be ignored - it's a development build notification
- Generated site outputs to `zig-out/www/` directory
- Blog posts at root level (e.g., `content/post1.smd`) appear in the main index
- Nested content in `content/blog/` creates a separate blog section