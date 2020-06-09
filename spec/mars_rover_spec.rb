require 'rspec'
require_relative '../lib/mars_rover.rb'

describe MarsRover do
  # let(:rover) {MarsRover.new}
  before :each do
    subject { MarsRover.new(direction: North.new) }
  end

  after do
    # Do nothing
  end

  context 'when condition' do
    it 'start at position [0,0] by default' do
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
    end
    it 'start with pointing to north' do
      expect(subject.direction.is_a? North).to be(true)
    end
    it 'do nothing when received an empty command' do
      subject.receive_command("")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? North).to be(true)
    end

    it 'change direction from N to W when receives a command with an l' do
      subject.receive_command("l")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? West).to be(true)
    end
    it 'change direction from W to S when receives a command with a l' do
      subject.direction = West.new
      subject.receive_command("l")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? South).to be(true)
    end
    it 'change direction from S to E when receives a command with a l' do
      subject.direction = South.new
      subject.receive_command("l")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? East).to be(true)
    end

    it 'change direction from E to N when receives a command with a l' do
      subject.direction = East.new
      subject.receive_command("l")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? North).to be(true)
    end
    it 'change direction from N to E when receives a command with an r' do
      subject.receive_command("r")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? East).to be(true)
    end
    it 'change direction from E to S when receives a command with an r' do
      subject.direction = East.new
      subject.receive_command("r")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? South).to be(true)
    end
    it 'change direction from S to W when receives a command with an r' do
      subject.direction = South.new
      subject.receive_command("r")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? West).to be(true)
    end
    it 'change direction from W to N when receives a command with an r' do
      subject.direction = West.new
      subject.receive_command("r")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? North).to be(true)
    end
    it 'when it starts from N and makes a full turn to the right it returns to N' do
      subject.receive_command("r")
      subject.receive_command("r")
      subject.receive_command("r")
      subject.receive_command("r")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? North).to be(true)
    end
    it 'when it starts from N and makes a full turn to left it returns to N' do
      subject.receive_command("l")
      subject.receive_command("l")
      subject.receive_command("l")
      subject.receive_command("l")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? North).to be(true)
    end


    it 'moves forward to N when receives a command with an f' do
      subject.receive_command("f")
      expect(subject.coordinate).to eq(Coordinate.new(-1, 0))
      expect(subject.direction.is_a? North).to be(true)
    end
    it 'moves backwards to S when receives a command with an b without changing direction' do
      subject.receive_command("b")
      expect(subject.coordinate).to eq(Coordinate.new(1, 0))
      expect(subject.direction.is_a? North).to be(true)
    end
    it 'moves forward to E when its direction is E and receives command with an f' do
      subject.direction = East.new
      subject.receive_command("f")
      expect(subject.coordinate).to eq(Coordinate.new(0, 1))
      expect(subject.direction.is_a? East).to be(true)
    end
    it 'moves backwards to W when receives a command with an b without changing direction' do
      subject.direction = East.new
      subject.receive_command("b")
      expect(subject.coordinate).to eq(Coordinate.new(0, -1))
      expect(subject.direction.is_a? East).to be(true)
    end

    it 'moves forward to W when its direction is E and receives command with an f' do
      subject.direction = West.new
      subject.receive_command("f")
      expect(subject.coordinate).to eq(Coordinate.new(0, -1))
      expect(subject.direction.is_a? West).to be(true)
    end
    it 'moves backwards to W when receives a command with an b without changing direction' do
      subject.direction = West.new
      subject.receive_command("b")
      expect(subject.coordinate).to eq(Coordinate.new(0, 1))
      expect(subject.direction.is_a? West).to be(true)
    end
    it 'moves forward to S when its direction is S and receives command with an f' do
      subject.direction = South.new
      subject.receive_command("f")
      expect(subject.coordinate).to eq(Coordinate.new(1, 0))
      expect(subject.direction.is_a? South).to be(true)
    end
    it 'moves backwards to S when receives a command with an b without changing direction' do
      subject.direction = South.new
      subject.receive_command("b")
      expect(subject.coordinate).to eq(Coordinate.new(-1, 0))
      expect(subject.direction.is_a? South).to be(true)
    end

    it 'do nothing with an empty command' do
      subject.receive_command("")
      expect(subject.coordinate).to eq(Coordinate.new(0, 0))
      expect(subject.direction.is_a? North).to be(true)
    end
    it 'receives an compound command of f and r it moves forward and then turns to the right' do
      subject.receive_command("fr")
      expect(subject.coordinate).to eq(Coordinate.new(-1, 0))
      expect(subject.direction.is_a? East).to be(true)
    end
    it 'receives an compound command of f and r it moves forward and then turns to the right' do
      subject.receive_command("frb")
      expect(subject.coordinate).to eq(Coordinate.new(-1, -1))
      expect(subject.direction.is_a? East).to be(true)
    end

    it 'raise an exception if commands have errors' do
      expect { (subject.receive_command('x')) }.to raise_error(message = 'error en la lectura del comando')
    end
  end
end
