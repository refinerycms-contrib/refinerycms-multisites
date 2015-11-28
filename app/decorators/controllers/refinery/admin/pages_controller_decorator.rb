begin
  Refinery::Admin::PagesController.class_eval do
    def account_layout_templates_pattern
      if Dir.exist?( Rails.root.join('accounts', current_account.subdomain) )
        ['accounts', current_account.subdomain, *Refinery::Pages.layout_templates_pattern]
      else
        Refinery::Pages.layout_templates_pattern
      end
    end

    def account_view_templates_pattern
      if Dir.exist?( Rails.root.join('accounts', current_account.subdomain) )
        ['accounts', current_account.subdomain, *Refinery::Pages.view_templates_pattern]
      else
        Refinery::Pages.view_templates_pattern
      end
    end

    def valid_layout_templates
      Refinery::Pages.layout_template_whitelist & Pages.valid_templates(*account_layout_templates_pattern)
    end

    def valid_view_templates
      Refinery::Pages.valid_templates(*account_view_templates_pattern)
    end
  end
rescue NameError
end