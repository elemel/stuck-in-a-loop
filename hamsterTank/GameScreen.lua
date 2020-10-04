local Class = require("hamsterTank.Class")
local Game = require("hamsterTank.Game")

local M = Class.new()

function M:init()
  local resources = {
    images = {
      hamster = {
        head = love.graphics.newImage("resources/images/hamster/head.png"),
        paw = love.graphics.newImage("resources/images/hamster/paw.png"),
        trunk = love.graphics.newImage("resources/images/hamster/trunk.png"),
      },
    },
  }

  self.game = Game.new(resources)
end

function M:update(dt)
  self.game:update(dt)
end

function M:draw()
  self.game:draw()
end

function M:keypressed(key, scancode, isrepeat)
  if key == "escape" then
    local TitleScreen = require("hamsterTank.TitleScreen")
    screen = TitleScreen.new()
    return
  end
end

function M:resize(w, h)
  self.game:resize(w, h)
end

function M:mousemoved(x, y, dx, dy, istouch)
  self.game:mousemoved(x, y, dx, dy, istouch)
end

return M
