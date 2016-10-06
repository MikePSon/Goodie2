CKEDITOR.editorConfig = function (config) {
  config.skin = 'bootstrapck';
  config.toolbar_standard = [
    ["Bold",  "Italic",  "Underline",  "Strike",  "-",  "Subscript",  "Superscript"],
    ["PasteFromWord", "Paste", "Undo", 'Redo'],
	["Find", "Replace", "SelectAll", "Scayt"],
	["NumberedList", "BulletedList", "Outdent", "Indent", "Blockquote", "CreateDiv", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock", "BidiLtr", "BidiRtl"],
	["Styles", "Format", "Font", "FontSize", "TextColor", "BGColor"],


  ];
  config.toolbar = "standard";
}