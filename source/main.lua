import("fonts")
import("settings")
import("sound")

-- gets set to `true` when the pdxinfo version has the `-dev` suffix
IS_DEBUG = string.find(playdate.metadata.version, "-dev") ~= nil
DISPLAY_HEIGHT = playdate.display.getHeight()
DISPLAY_WIDTH = playdate.display.getWidth()

local FPS <const> = 30 -- change this to whatever target framerate you want; Playdate max FPS is 50

SCENE = {
  GAMEPLAY = 1,
}

local scenes = {
  [SCENE.GAMEPLAY] = import("scenes/gameplay"),
}

local currentScene = scenes[SCENE.GAMEPLAY]
local pendingScene = nil

-- Switch the active scene to the specified key from `SCENE`
function SwitchScene(key)
  pendingScene = scenes[key]
end

-- Called once when the game starts
local function init()
  playdate.display.setRefreshRate(FPS)

  LoadSettings()

  local menu = playdate.getSystemMenu()
  menu:addCheckmarkMenuItem("play sfx", Settings.playSFX, function(value)
    UpdateSetting(SETTING.PLAY_SFX, value)
  end)
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.update()
  local dt = playdate.getElapsedTime()
  playdate.resetElapsedTime()

  -- Set default font to prevent lingering setting from last frame
  SetFont(Fonts.default)

  if pendingScene then
    currentScene = pendingScene
    pendingScene = nil
  end

  currentScene.update(dt)

  if IS_DEBUG then
    playdate.drawFPS(DISPLAY_WIDTH - 18, 4)
  end
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.gameWillTerminate()
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.deviceWillSleep()
end

init()
