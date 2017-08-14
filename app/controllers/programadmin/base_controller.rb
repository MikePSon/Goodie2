class Programadmin::BaseController < ApplicationController
	before_filter :require_programadmin!
  def index
  end#End Index

  def notsubscribed
  end

end#End Controller
