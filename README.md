# cangjie.github — Cangjie TextMate Grammar

A [TextMate](https://macromates.com/manual/en/language_grammars) grammar for the
[Cangjie](https://cangjie-lang.cn/) programming language (`仓颉`), the language of
HarmonyOS NEXT application development.

- **scopeName**: `source.cj`
- **file extension**: `.cj`
- **License**: MIT

This grammar is a direct port of the [`cangjie.vim`](https://github.com/WuJunkai2004/cangjie.vim)
syntax script, written and maintained by the same author, which has been merged into
the Vim and Neovim mainlines:

- Vim patch [`9.1.1647`](https://github.com/vim/vim/commit/0c4405a6b2) — add `runtime/syntax/cangjie.vim`
- Vim patch [`37c8ce7`](https://github.com/vim/vim/commit/37c8ce7fac) — fixes and improvements
- Vim patch [`77a59be`](https://github.com/vim/vim/commit/77a59be594) — update syntax script
- Neovim: [`neovim#35399`](https://github.com/neovim/neovim/pull/35399),
  [`neovim#36150`](https://github.com/neovim/neovim/pull/36150),
  [`neovim#37267`](https://github.com/neovim/neovim/pull/37267) (vim-patch syncs)

The grammar is intended to power syntax highlighting on GitHub (via
[github-linguist](https://github.com/github-linguist/linguist), see issue
[#7172](https://github.com/github-linguist/linguist/issues/7172)) as well as in any
TextMate-compatible editor (VS Code, Sublime, Zed, …).

---

# cangjie.github — 仓颉 TextMate 语法

面向仓颉编程语言的 TextMate 语法文件，用于 GitHub 网页端及各 TextMate 兼容编辑器的语法高亮。

- **scopeName**: `source.cj`
- **文件扩展名**: `.cj`
- **许可证**: MIT

语法规则移植自本人编写并维护的 [`cangjie.vim`](https://github.com/WuJunkai2004/cangjie.vim)，
后者已合入 Vim 与 Neovim 主线（见上方补丁链接）。两份实现由同一作者维护，规则保持同步。

## 使用

### VS Code（本地测试壳）

本仓库自带一个最小 VS Code 扩展壳（`package.json`），无需发布 Marketplace：

```bash
# 方式一：软链到扩展目录
ln -s /path/to/cangjie.github ~/.vscode/extensions/cangjie-grammar

# 方式二：VSIX 打包安装
npx @vscode/vsce package
code --install-extension cangjie-grammar-0.1.0.vsix
```

打开 `examples/sample.cj`，用 `Developer: Inspect Editor Tokens and Scopes` 检查 scope 输出。

### 其他编辑器

任意支持 TextMate 语法（`.tmLanguage`）的编辑器，将 `scopeName: source.cj` 绑定到 `*.cj` 即可。

## 从 cangjie.vim 移植的映射

| Vim 组 | TextMate scope |
|---|---|
| `cangjieComment` / `cangjieTodo` / `cangjieDocKeyword` | `comment.*.cj` / `keyword.other.todo.cj` / `keyword.other.documentation.cj` |
| `cangjieDeclaration` | `keyword.declaration.cj` |
| `cangjieStatement` | `keyword.control.cj` |
| `cangjieVariable` (const/let/var) | `keyword.declaration.cj` |
| `cangjieIdentlike` | `true/false` → `constant.language.boolean.cj`；`this` → `variable.language.cj`；`init/main` → `keyword.other.cj` |
| `cangjieOption` | `Some/None` → `constant.language.enum.cj`；`Option` → `support.type.cj` |
| `cangjieSpType/ArrayType/CommonType/…` | `support.type.cj` |
| `cangjieCoreFunc` | `support.function.cj` |
| `cangjieCoreItf/CoreClass` | `support.type.cj` |
| `cangjieCoreError` | `support.class.cj` |
| `cangjieMacro` | `meta.annotation.cj` + `entity.other.attribute-name.cj` |
| `cangjieSpIdentifier` | `variable.other.identifier.cj` |
| `cangjieString/RawString` | `string.quoted.*.cj` |
| `cangjieRune` / `cangjieRuneError` | `constant.character.rune.cj` / `invalid.illegal.rune.cj` |
| `cangjieEscape` | `constant.character.escape.cj` |
| `cangjie*Number` | `constant.numeric.*.cj` |
| `cangjieOperator/VarArgs` | `keyword.operator.cj` |
| `cangjieTypeName`（nextgroup） | `entity.name.function.cj` / `entity.name.type.cj` |

## 与 cangjie.vim 的已知差异

Vim 与 TextMate 的匹配引擎语义不同（Vim 是“同位置最长匹配优先”，TextMate 是
“按规则定义顺序”），以下差异为移植时的必要适配：

1. **规则排序调整**：TextMate 需要长匹配在前。因此 `...` 先于 `..`、`"""` 先于 `"`、
   多字符 rune 错误规则改写为 `{2,}` 与合法规则互斥，匹配结果与 Vim 一致。
2. **声明名高亮**：`func`/`class` 等后接名字的组合规则用 captures 实现；
   `interface` 后的名字也高亮（Vim 版 nextgroup 漏掉了 interface，属顺带修正）。
3. **折叠规则**（`cangjieFold*`）：TextMate 无对应机制，编辑器折叠由缩进策略接管，未移植。
4. **插值内容**：与 Vim 版一致，`${...}` 内部不识别嵌套字符串/注释。
5. **`b'...'` 按字节面量处理为错误**：沿用 Vim 版现行规则；如仓颉规范确认 `b'...'`
   为合法字节字面量，将在两侧同步修正。

## License

[MIT](LICENSE)
