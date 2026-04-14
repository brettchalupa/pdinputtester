local gfx <const> = playdate.graphics
local md <const> = playdate.metadata
local MARGIN <const> = 10

local version = md.version
local VERSION_TEXT_WIDTH = Fonts.asheville14Bold:getTextWidth(version)
local ASHEVILLE14_HEIGHT = Fonts.asheville14Bold:getHeight()

local function update(dt)
  gfx.clear()

  SetFont(Fonts.asheville24Light)
  gfx.drawText(md.name, MARGIN, MARGIN)

  SetFont(Fonts.default)
  gfx.drawText("by " .. md.author, 10, DISPLAY_HEIGHT - ASHEVILLE14_HEIGHT - MARGIN)
  gfx.drawText(version, DISPLAY_WIDTH - VERSION_TEXT_WIDTH - MARGIN, DISPLAY_HEIGHT - ASHEVILLE14_HEIGHT - MARGIN)
end

local scene = {
  update = update,
}

return scene
