require_relative "../lib/robot"

RSpec.describe Robot do

  context '#initiialize' do
    subject { described_class.new }
    it "has an initialised table" do
      expect(subject.table).not_to be_nil
    end
  end

  context '#process_command' do

    let(:robot) { described_class.new }

    subject { robot.process_command(command) }

    context 'when an invalid command is sent for processing' do
      let(:command) { 'Adele' }
      it "does not process a random command" do
        expect { subject }.to raise_error(Robot::InvalidCommandError)
      end
    end

    context 'when PLACE command is sent in incorrect format' do
      let(:command) { 'PLACE A,B,C' }
      it "does not process an incorrect command" do
        expect { subject }.to raise_error(Robot::InvalidCommandError)
      end
    end

    context 'when PLACE command is sent with coordinates outside the table bound' do
      let(:command) { 'PLACE 5,4,SOUTH' }
      it "does not process a command out of the boundaries of the table" do
        subject
        expect(robot.x).to be_nil
      end
    end

    context 'when MOVE command is sent without placing the robot on table' do
      let(:command) { 'MOVE' }
      it "does not process the command" do
        subject
        expect(robot.x).to be_nil
      end
    end

    context 'when LEFT command is sent without placing the robot on table' do
      let(:command) { 'LEFT' }
      it "does not process the command" do
        expect(robot.x).to be_nil
      end
    end

    context 'when RIGHT command is sent without placing the robot on table' do
      let(:command) { 'RIGHT' }
      it "does not process the command" do
        subject
        expect(robot.x).to be_nil
      end
    end

    context 'when MOVE command would result in moving robot out of table' do

      before do
        robot.process_command('PLACE 4,4,EAST')
      end

      let(:command) { 'MOVE' }
      it "does not process the command" do
        subject
        expect(robot.x).to eq(4)
      end
    end

    context 'when a command would not result in moving robot out of table' do

      context 'when robot is facing East' do
        before do
          robot.process_command('PLACE 3,4,EAST')
        end
        context 'when command is MOVE' do
          let(:command) { 'MOVE' }
          it "will process the command" do
            subject
            expect(robot.x).to eq(4)
          end
        end
        context 'when the command is LEFT' do
          let(:command) { 'LEFT' }
          it 'will reorient the robot to North' do
            subject
            expect(robot.face.name).to eq('North')
          end
        end
        context 'when the command is RIGHT' do
          let(:command) { 'RIGHT' }
          it 'will reorient the robot to SOUTH' do
            subject
            expect(robot.face.name).to eq('South')
          end
        end
      end

      context 'when robot is facing West' do
        before do
          robot.process_command('PLACE 3,4,WEST')
        end
        context 'when command is MOVE' do
          let(:command) { 'MOVE' }
          it "will process the command" do
            subject
            expect(robot.x).to eq(2)
          end
        end
        context 'when the command is LEFT' do
          let(:command) { 'LEFT' }
          it 'will reorient the robot to South' do
            subject
            expect(robot.face.name).to eq('South')
          end
        end
        context 'when the command is RIGHT' do
          let(:command) { 'RIGHT' }
          it 'will reorient the robot to North' do
            subject
            expect(robot.face.name).to eq('North')
          end
        end
      end

      context 'when robot is facing South' do
        before do
          robot.process_command('PLACE 3,4,SOUTH')
        end
        context 'when command is MOVE' do
          let(:command) { 'MOVE' }
          it "will process the command" do
            subject
            expect(robot.y).to eq(3)
          end
        end
        context 'when the command is LEFT' do
          let(:command) { 'LEFT' }
          it 'will reorient the robot to East' do
            subject
            expect(robot.face.name).to eq('East')
          end
        end
        context 'when the command is RIGHT' do
          let(:command) { 'RIGHT' }
          it 'will reorient the robot to West' do
            subject
            expect(robot.face.name).to eq('West')
          end
        end
      end

      context 'when robot is facing North' do
        before do
          robot.process_command('PLACE 4,3,NORTH')
        end
        context 'when command is MOVE' do
          let(:command) { 'MOVE' }
          it "will process the command" do
            subject
            expect(robot.y).to eq(4)
          end
        end
        context 'when the command is LEFT' do
          let(:command) { 'LEFT' }
          it 'will reorient the robot to West' do
            subject
            expect(robot.face.name).to eq('West')
          end
        end
        context 'when the command is RIGHT' do
          let(:command) { 'RIGHT' }
          it 'will reorient the robot to East' do
            subject
            expect(robot.face.name).to eq('East')
          end
        end
      end

    end

  end

end