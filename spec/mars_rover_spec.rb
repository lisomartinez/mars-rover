require 'rspec'
require_relative '../lib/mars_rover.rb'

describe MarsRover do
  # let(:rover) {MarsRover.new}
  before :each do
    subject { MarsRover.new(direction: North.new) }
  end

  def assert_is_at_heading_to(position, heading)
    expect(subject.is_at).to eq(position)
    expect(subject.heading_to).to eq(heading)
  end

  context 'when MarsRover receives a command' do
    it 'start at position [0,0] by default' do
      assert_is_at_heading_to([0, 0], "NORTH")
    end

    it 'start with pointing to north' do
      assert_is_at_heading_to([0, 0], "NORTH")
    end

    it 'do nothing when received an empty command' do
      subject.receive_command("")
      assert_is_at_heading_to([0, 0], "NORTH")
    end

    it 'change direction from N to W when receives a command with an l' do
      subject.receive_command("l")

      assert_is_at_heading_to([0, 0], "WEST")
    end

    it 'change direction from W to S when receives a command with a l' do
      subject.set_at(West.new)
      subject.receive_command("l")

      assert_is_at_heading_to([0, 0], "SOUTH")
    end

    it 'change direction from S to E when receives a command with a l' do
      subject.set_at(South.new)
      subject.receive_command("l")

      assert_is_at_heading_to([0, 0], "EAST")
    end

    it 'change direction from E to N when receives a command with a l' do
      subject.set_at(East.new)
      subject.receive_command("l")

      assert_is_at_heading_to([0, 0], "NORTH")
    end

    it 'change direction from N to E when receives a command with an r' do
      subject.receive_command("r")

      assert_is_at_heading_to([0, 0], "EAST")
    end

    it 'change direction from E to S when receives a command with an r' do
      subject.set_at(East.new)
      subject.receive_command("r")

      assert_is_at_heading_to([0, 0], "SOUTH")
    end

    it 'change direction from S to W when receives a command with an r' do
      subject.set_at(South.new)
      subject.receive_command("r")

      assert_is_at_heading_to([0, 0], "WEST")
    end

    it 'change direction from W to N when receives a command with an r' do
      subject.set_at(West.new)
      subject.receive_command("r")

      assert_is_at_heading_to([0, 0], "NORTH")
    end

    it 'when it starts from N and makes a full turn to the right it returns to N' do
      subject.receive_command("r")
      subject.receive_command("r")
      subject.receive_command("r")
      subject.receive_command("r")

      assert_is_at_heading_to([0, 0], "NORTH")
    end

    it 'when it starts from N and makes a full turn to left it returns to N' do
      subject.receive_command("l")
      subject.receive_command("l")
      subject.receive_command("l")
      subject.receive_command("l")

      assert_is_at_heading_to([0, 0], "NORTH")
    end

    it 'moves forward to N when receives a command with an f' do
      subject.receive_command("f")

      assert_is_at_heading_to([-1, 0], "NORTH")
    end

    it 'moves backwards to S when receives its direction is N and receives a command with an b without changing direction' do
      subject.receive_command("b")

      assert_is_at_heading_to([1, 0], "NORTH")
    end

    it 'moves forward to E when its direction is E and receives command with an f' do
      subject.set_at(East.new)
      subject.receive_command("f")

      assert_is_at_heading_to([0, 1], "EAST")
    end

    it 'moves backwards to W when its direction is E and receives a command with an b without changing direction' do
      subject.set_at(East.new)
      subject.receive_command("b")

      assert_is_at_heading_to([0, -1], "EAST")
    end

    it 'moves forward to W when its direction is W and receives command with an f' do
      subject.set_at(West.new)
      subject.receive_command("f")

      assert_is_at_heading_to([0, -1], "WEST")
    end

    it 'moves backwards to E when its direction is W and receives a command with an b without changing direction' do
      subject.set_at(West.new)
      subject.receive_command("b")

      assert_is_at_heading_to([0, 1], "WEST")
    end

    it 'moves forward to S when its direction is S and receives command with an f' do
      subject.set_at(South.new)
      subject.receive_command("f")

      assert_is_at_heading_to([1, 0], "SOUTH")
    end

    it 'moves backwards to N when its direction is S and receives a command  with an b without changing direction' do
      subject.set_at(South.new)
      subject.receive_command("b")

      assert_is_at_heading_to([-1, 0], "SOUTH")
    end

    it 'receives an compound command of f and r it moves forward and then turns to the right' do
      subject.receive_command("fr")

      assert_is_at_heading_to([-1, 0], "EAST")
    end

    it 'receives an compound command of f and r it moves forward and then turns to the right' do
      subject.receive_command("frb")

      assert_is_at_heading_to([-1, -1], "EAST")
    end

    it 'raise an exception if commands have errors' do
      expect { (subject.receive_command('x')) }.to raise_error(message = 'error en la lectura del comando')
    end

  end
end
