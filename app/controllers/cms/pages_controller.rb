# coding: utf-8
class Cms::PagesController < ApplicationController
  include Cms::BaseFilter
  include Cms::CrudFilter
  
  model Cms::Page
  
  navi_view "cms/main/navi"
  menu_view "cms/main/node_menu"
  
  private
    def set_crumbs
      #@crumbs << [:"cms.page", action: :index]
    end
    
    def fix_params
      { cur_user: @cur_user, cur_site: @cur_site, cur_node: false }
    end
    
  public
    def index
      @items = @model.site(@cur_site).allow(read: @cur_user).
        where(depth: 1).
        where(route: "cms/page").
        order_by(updated: -1).
        page(params[:page]).per(100)
    end
end
