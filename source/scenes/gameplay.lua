local gfx <const> = playdate.graphics
local md <const> = playdate.metadata
local MARGIN <const> = 12

local version = md.version
local VERSION_TEXT_WIDTH = Fonts.asheville14Bold:getTextWidth(version)
local ASHEVILLE14_HEIGHT = Fonts.asheville14Bold:getHeight()

local buttons = {
  { playdate.kButtonUp,    "Up" },
  { playdate.kButtonDown,  "Down" },
  { playdate.kButtonLeft,  "Left" },
  { playdate.kButtonRight, "Right" },
  { playdate.kButtonA,     "A" },
  { playdate.kButtonB,     "B" },
}

local function decodePlaydateButtons(bitmask)
  local pressedButtons = {}

  for _, button in ipairs(buttons) do
    local value, buttonName = button[1], button[2]
    if bitmask & value ~= 0 then
      table.insert(pressedButtons, buttonName)
    end
  end

  return pressedButtons
end

local function update(dt)
  gfx.clear()

  SetFont(Fonts.asheville24Light)
  gfx.drawText(md.name, MARGIN, MARGIN)

  SetFont(Fonts.default)

  for i, button in ipairs(buttons) do
    local value, buttonName = button[1], button[2]
    gfx.drawText(buttonName .. ": " .. tostring(playdate.buttonIsPressed(value)), MARGIN, 24 * i + 32)
  end

  if not playdate.isCrankDocked() then
    gfx.drawText("Crank Pos: " .. tostring(playdate.getCrankPosition()), 160, 56)
    gfx.drawText("Crank Change: " .. tostring(playdate.getCrankChange()), 160, 80)
  end

  gfx.drawText("by " .. md.author, MARGIN, DISPLAY_HEIGHT - ASHEVILLE14_HEIGHT - MARGIN)
  gfx.drawText(version, DISPLAY_WIDTH - VERSION_TEXT_WIDTH - MARGIN, DISPLAY_HEIGHT - ASHEVILLE14_HEIGHT - MARGIN)
end

local scene = {
  update = update,
}

return scene
