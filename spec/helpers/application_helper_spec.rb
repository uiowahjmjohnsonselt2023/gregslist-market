require './spec/rails_helper'
require_relative '../../app/helpers/application_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    context 'when page title is empty' do
      it 'returns the base title' do
        expect(helper.full_title).to eq('Gregslist Marketplace')
      end
    end

    context 'when page title is present' do
      it 'returns the full title with page title' do
        page_title = 'Sample Page'
        expect(helper.full_title(page_title)).to eq("#{page_title} | Gregslist Marketplace")
      end
    end
  end
end