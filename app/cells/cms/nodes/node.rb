# coding: utf-8
module Cms::Nodes::Node
  class EditCell < Cell::Rails
    include Cms::NodeFilter::EditCell
    model Cms::Node::Node
  end
  
  class ViewCell < Cell::Rails
    include Cms::NodeFilter::ViewCell
    helper Cms::ListHelper
    
    public
      def index
        @items = Cms::Node.site(@cur_site).public.
          where(@cur_node.condition_hash).
          order_by(@cur_node.sort_hash).
          page(params[:page]).
          per(@cur_node.limit)
        
        @items.empty? ? "" : render
      end
  end
end
