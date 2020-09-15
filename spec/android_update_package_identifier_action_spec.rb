describe Fastlane::Actions::AndroidUpdatePackageIdentifierAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The android_update_package_identifier plugin is working!")

      Fastlane::Actions::AndroidUpdatePackageIdentifierAction.run(nil)
    end
  end
end
