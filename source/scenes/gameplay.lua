local gfx <const> = playdate.graphics
local md <const> = playdate.metadata
local mic <const> = playdate.sound.micinput
local MARGIN <const> = 8

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

mic.startListening()
playdate.startAccelerometer()

local function update(_dt)
  gfx.clear()

  SetFont(Fonts.asheville24Light)
  gfx.drawText(md.name, MARGIN, MARGIN)

  SetFont(Fonts.default)

  local anyPressed = false

  for i, button in ipairs(buttons) do
    local value, buttonName = button[1], button[2]
    local isPressed = playdate.buttonIsPressed(value)
    if isPressed then
      anyPressed = true
    end
    gfx.drawText(buttonName .. ": " .. tostring(isPressed), MARGIN, 24 * i + 32)
  end

  if anyPressed then
    PlaySFX("B3")
  end

  gfx.drawText("Mic Source: " .. mic.getSource(), 160, 56)
  gfx.drawText("Mic Level: " .. string.format("%.3f", mic.getLevel()), 160, 80)

  local ax, ay, az = playdate.readAccelerometer()
  gfx.drawText("Accelerometer:", 160, 116)
  gfx.drawText(string.format("%.3f, %.3f, %.3f", ax, ay, az), 160, 140)

  if not playdate.isCrankDocked() then
    gfx.drawText(string.format("Crank Pos: %.3f", playdate.getCrankPosition()), 160, 176)
    gfx.drawText(string.format("Crank Change: %.3f", playdate.getCrankChange()), 160, 200)
  end
end

local scene = {
  update = update,
}

return scene
