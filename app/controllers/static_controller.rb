# frozen_string_literal: true

class StaticController < ApplicationController
  def root
    render json: { message: "No public endpoint available" }
  end
end
