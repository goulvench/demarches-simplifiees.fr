describe Cron::ExpiredUsersDeletionJob do
  subject { described_class.perform_now }

  context 'when env[EXPIRE_USER_DELETION_JOB_LIMIT] is present' do
    before { expect(ENV).to receive(:[]).with('EXPIRE_USER_DELETION_JOB_LIMIT').and_return('anything') }

    it 'calls Expired::UsersDeletionService.process_expired' do
      expect(Expired::UsersDeletionService).to receive(:process_expired)
      subject
    end
  end

  context 'when env[EXPIRE_USER_DELETION_JOB_LIMIT] is absent' do
    it 'does not call Expired::UsersDeletionService.process_expired' do
      expect(Expired::UsersDeletionService).not_to receive(:process_expired)
      subject
    end
  end
end
