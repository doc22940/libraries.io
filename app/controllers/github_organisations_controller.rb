class GithubOrganisationsController < ApplicationController
  def index
    @most_repos = GithubOrganisation.most_repos.limit(20).to_a
    @most_stars = GithubOrganisation.most_stars.limit(20).to_a
    @newest = GithubOrganisation.newest.limit(20).to_a
  end

  def mozilla
    @org_logins = ['mozilla', 'mozilla-it', 'bugzilla', 'drumbeat-badge-sprint', 'hackasaurus', 'jetpack-labs', 'mdn', 'mozbrick', 'mozilla-appmaker', 'mozilla-b2g', 'mozilla-comm', 'mozilla-cordova', 'mozilla-metrics', 'mozilla-raptor', 'mozilla-services', 'mozilla-svcops', 'mozillatw', 'Mozilla-TWQA', 'mozillahispano', 'MozillaSecurity', 'MozillaWiki', 'mozillayvr', 'mozfr', 'OpenNews', 'rust-lang', 'servo', 'tabulapdf', 'webcompat']
    @orgs = GithubOrganisation.where(login: @org_logins).includes(:source_github_repositories).sort_by{|o| -o.source_github_repositories.length }
    @repositories = GithubRepository.source.where(github_organisation_id: @orgs.map(&:id))
    @licenses = @repositories.group('license').count
    @languages = @repositories.group('language').count
  end
end
