local Class = require("hamsterTank.Class")

local M = Class.new()

function M:init()
  self.x = 0
  self.y = 0

  self.angle = 0
  self.scale = 1

  self.viewportX = 0
  self.viewportY = 0

  self.viewportWidth = 1
  self.viewportHeight = 1

  self.cameraToWorld = love.math.newTransform()
  self.worldToCamera = love.math.newTransform()

  self.cameraToScreen = love.math.newTransform()

  self.transform = love.math.newTransform()
  self.previousTransform = love.math.newTransform()

  self:setCameraToWorld(0, 0, 0, 64)
  self:setViewport(0, 0, 800, 600)
end

function M:setCameraToWorld(x, y, angle, scale)
  self.x = x
  self.y = y

  self.angle = angle
  self.scale = scale

  self.cameraToWorld:setTransformation(x, y, angle, scale)
  self.worldToCamera:reset():scale(1 / scale):rotate(-angle):translate(-x, -y)

  self.transform:reset():apply(self.cameraToScreen):apply(self.worldToCamera)
end

function M:setViewport(x, y, width, height)
  self.viewportX = x
  self.viewportY = y

  self.viewportWidth = width
  self.viewportHeight = height

  local x = self.viewportX + 0.5 * self.viewportWidth
  local y = self.viewportY + 0.5 * self.viewportHeight

  local scale = self.viewportHeight
  self.cameraToScreen:setTransformation(x, y, 0, scale)

  self.transform:reset():apply(self.cameraToScreen):apply(self.worldToCamera)
end

function M:draw()
  love.graphics.push("all")
  love.graphics.setScissor(self.viewportX, self.viewportY, self.viewportHeight, self.viewportWidth)
  love.graphics.pop()
end

function M:updatePreviousTransform()
  self.previousTransform:setMatrix(self.transform:getMatrix())
end

return M