local macroName = 'Fuga';
local macroDelay = 100;
local tabName = setDefaultTab('HP');

UI.Separator(tabName)
scrollBar = [[
Panel
  height: 28
  margin-top: 3

  UIWidget
    id: text
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    text-align: center
    
  HorizontalScrollBar
    id: scroll
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: prev.bottom
    margin-top: 3
    minimum: 0
    maximum: 10
    step: 1
]];

storage.scrollBarValues = storage.scrollBarValues or {};
addScrollBar = function(id, title, min, max, defaultValue, dest, tooltip)
    local value = storage.scrollBarValues[id] or defaultValue
    local widget = setupUI(scrollBar, dest)
    widget.text:setTooltip(tooltip)
    widget.scroll.onValueChange = function(scroll, value)
        widget.text:setText(title)
        widget.scroll:setText(value)
        if value == 0 then
            value = 1
        end
        storage.scrollBarValues[id] = value
    end
    widget.scroll:setRange(min, max)
    widget.scroll:setTooltip(tooltip)
    widget.scroll:setValue(value)
    widget.scroll.onValueChange(widget.scroll, value)
end

addTextEdit("Fuga", storage.fugaSpell or "Fuga", function(widget, text)
    storage.fugaSpell = text;
end, tabName);
addScrollBar('percentagefuga', 'Porcentagem Vida', 1, 100, 99, tabName, "Porcentagem de vida para usar o regeneration.");


macro(macroDelay, macroName, function()
    local selfHealth = hppercent();
    if selfHealth <= storage.scrollBarValues.percentagefuga then
        say(storage.fugaSpell)
    end
end, tabName);


UI.Separator(tabName)
