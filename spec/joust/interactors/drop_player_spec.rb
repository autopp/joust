describe Interactors::DropPlayer do
  let(:interactor) { described_class.new(repo: repo) }
  let(:repo) { instance_double(PlayerRepository) }
end
