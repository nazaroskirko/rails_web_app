class StaticPagesController < ApplicationController
  def home
    if current_user
      redirect_to current_user
    else
      @content = ButterCMS::Content.fetch([
        :homepage_headline,
        :homepage_paragraph,
        :homepage_cta_text,
        :standard_features,
        :enterprise_features
      ]).data

      @lead = Lead.new
      @inquiry = @lead.inquiries.build
    end
  end

  def privacy
  end
end
