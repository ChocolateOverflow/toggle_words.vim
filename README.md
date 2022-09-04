# toggle_words.nvim

This is my clone of [vim-scripts/toggle_words.vim](https://github.com/vim-scripts/toggle_words.vim). This version simply adds `ToggleWordRev` which is the reversed version of `ToggleWord` and removes the default words dictionary. It likely also has the same vim version restriction as the original.

## How to use

You must first define a dictionary (or dictionaries) of words you want to toggle between. This can be done in either vimscript or lua. The `all` dictionary applies to *all* files. Dictionaries for specific file-types can be defined with a dictionary whose key is the file-type string.

Here's an example dictionary in lua:

```lua
vim.g.toggle_words_dict = {
  all = {
    { 'true', 'false' },
    { 'if', 'else' },
    { 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday' },
  sh = {
    { 'if', 'elif', 'else', 'fi' },
  },
  python = {
    { 'if', 'elif', 'else' },
  },
}
```

Things to note:

- The file-type-specific dictionaries will overwrite the `all` dictionary
- If the word to be toggled is at the end of a list, `ToggleWord` will loop back to the beginning and vice versa for `ToggleWordRev`
- You don't need to create a dictionary for different basic casings like `true`, `True`, and `TRUE` (doesn't support camelCase)
- This only works on words, meaning you can't toggle between special characters like `!=` and `==`

After creating your dictionaries, simply bind `ToggleWord` and `ToggleWordRev` to your preferred key mappings.

## License

MIT license
