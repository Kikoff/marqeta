require 'spec_helper'

describe Marqeta::Card do
  let(:pan) { '1234567890' }
  let(:card_token) { 'CARD_TOKEN' }

  describe 'class methods' do
    describe '.from_pan' do
      before do
        allow_any_instance_of(Marqeta::ApiCaller)
          .to(receive(:post))
          .and_return('card_token' => card_token)
      end

      it 'creates an ApiCaller with the getbypan endpoint' do
        expect(Marqeta::ApiCaller)
          .to(receive(:new))
          .with('cards/getbypan')
          .and_call_original
        fetch_card_from_pan
      end

      it 'posts the pan to an ApiCaller' do
        expect_any_instance_of(Marqeta::ApiCaller)
          .to(receive(:post))
          .with(pan: pan)
        fetch_card_from_pan
      end

      it 'returns a Card with token set correctly' do
        card = fetch_card_from_pan
        expect(card).to be_a(Marqeta::Card)
        expect(card.token).to eq(card_token)
      end

    end

    def fetch_card_from_pan
      Marqeta::Card.from_pan(pan)
    end
  end

  describe 'instance methods' do
    subject(:card) { Marqeta::Card.new(token: card_token, state: state) }

    let(:state) { Marqeta::Card::ACTIVE_STATE }

    describe '#active?' do
      let(:active?) { card.active? }

      context "when its state is 'active'" do
        it 'returns true' do
          expect(active?).to be(true)
        end
      end

      context "when its state is something other than 'active'" do
        let(:state) { 'inactive' }

        it 'returns false' do
          expect(active?).to be(false)
        end
      end
    end

    describe '#retrieve_pan' do
      let(:retrieve_pan) { card.retrieve_pan }

      before do
        allow_any_instance_of(Marqeta::ApiCaller)
          .to(receive(:get))
          .and_return('token' => card_token, 'pan' => pan)
      end

      it 'creates an ApiCaller with the showpan endpoint' do
        expect(Marqeta::ApiCaller)
          .to(receive(:new))
          .with("cards/#{card_token}/showpan")
          .and_call_original
        retrieve_pan
      end

      it 'calls get on an ApiCaller' do
        expect_any_instance_of(Marqeta::ApiCaller).to(receive(:get))
        retrieve_pan
      end

      it 'sets attributes to showpan response' do
        retrieve_pan
        expect(card.token).to eq(card_token)
        expect(card.pan).to eq(pan)
      end
    end
  end
end
