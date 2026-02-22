import Foundation

struct MarkdownHTML {
    static func generateTemplate() -> String {
        return """
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Markdown Preview</title>

            <!-- KaTeX for LaTeX rendering -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.9/dist/katex.min.css">
            <script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.9/dist/katex.min.js"></script>
            <script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.9/dist/contrib/auto-render.min.js"></script>

            <!-- PrismJS for Syntax Highlighting -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/themes/prism-tomorrow.min.css" rel="stylesheet" />
            <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/prism.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-python.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-swift.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-bash.min.js"></script>

            <!-- Marked for Markdown Parsing -->
            <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

            <style>
                body {
                    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
                    line-height: 1.6;
                    padding: 20px;
                    background-color: #ffffff;
                    color: #24292e;
                }
                pre {
                    background: #f6f8fa;
                    padding: 16px;
                    border-radius: 6px;
                    overflow: auto;
                }
                code {
                    font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, Courier, monospace;
                    font-size: 85%;
                }
                blockquote {
                    border-left: 4px solid #dfe2e5;
                    color: #6a737d;
                    padding-left: 16px;
                    margin-left: 0;
                }
                img {
                    max-width: 100%;
                }
                table {
                    border-collapse: collapse;
                    width: 100%;
                }
                table th, table td {
                    border: 1px solid #dfe2e5;
                    padding: 6px 13px;
                }
                table tr:nth-child(2n) {
                    background-color: #f6f8fa;
                }
            </style>
        </head>
        <body>
            <div id="content"></div>

            <script>
                // Configure marked to use Prism for highlighting
                marked.setOptions({
                    highlight: function(code, lang) {
                        if (Prism.languages[lang]) {
                            return Prism.highlight(code, Prism.languages[lang], lang);
                        } else {
                            return code;
                        }
                    }
                });

                window.updateContent = function(markdown) {
                    const contentDiv = document.getElementById('content');

                    // PROTECTION STEP: Replace LaTeX blocks with placeholders to prevent Marked from mangling them.
                    // We use a simple regex approach for $$...$$, $...$, \[...\], \(...\)
                    // Note: This is a basic implementation.

                    const mathBlocks = [];
                    let protectedMarkdown = markdown.replace(/\\$\\$[\\s\\S]+?\\$\\$|\\$[\\s\\S]+?\\$|\\\\?\\[[\\s\\S]+?\\\\?\\]|\\\\?\\([\\s\\S]+?\\\\?\\)/g, function(match) {
                        mathBlocks.push(match);
                        return "MATHBLOCK" + (mathBlocks.length - 1) + "ENDMATHBLOCK";
                    });

                    // Render Markdown
                    let html = marked.parse(protectedMarkdown);

                    // RESTORE STEP: Put the LaTeX back
                    html = html.replace(/MATHBLOCK(\\d+)ENDMATHBLOCK/g, function(match, id) {
                        return mathBlocks[parseInt(id)];
                    });

                    contentDiv.innerHTML = html;

                    // Render LaTeX with KaTeX
                    renderMathInElement(contentDiv, {
                        delimiters: [
                            {left: "$$", right: "$$", display: true},
                            {left: "$", right: "$", display: false},
                            {left: "\\\\(", right: "\\\\)", display: false},
                            {left: "\\\\[", right: "\\\\]", display: true}
                        ],
                        throwOnError : false
                    });

                    // Trigger Prism highlight again just in case
                    Prism.highlightAll();
                }
            </script>
        </body>
        </html>
        """
    }
}
