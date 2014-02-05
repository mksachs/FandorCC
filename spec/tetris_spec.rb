require "tetris"

describe Tetris do
    
    before(:each) do
      @tg = Tetris.new
      @board_width = 10
      @board_height = 20
    end
    
    it "contains a game board array" do
        expect(Tetris.new.board).to be_an_instance_of(Array)
    end
    
    describe "@board" do
        it "is length board_width * board_height" do
            expect(@tg.board.length).to eq(@tg.board_width*@tg.board_height)
        end
    end
    
    describe "#play" do
        it "plays tetris by placing 'quit_after' shapes then  it prints out the board" do
            @tg.play(13)
        end
    end
    
    describe "#remove_filled_rows" do
        it "should set any occupied rows to unoccupied" do
            (@board_width...2*@board_width).each {|index| @tg.board[index] = 1}
            @tg.remove_filled_rows()
            expect(@tg.board[@board_width...2*@board_width].reduce(:+)).to eq(0)
        end
    end
    
    describe "#random_tetrimino" do
        it "should return an object with parent type Tetrimino" do
            expect(@tg.random_tetrimino).to be_a_kind_of(Tetrimino)
        end
    end
    
    describe "#reslove_collision" do
        it "should move the root tetrimino index up the board until there are no collisions" do
            [0,1,5,9,10,11,19].each {|index| @tg.board[index] = 1}
            tet = @tg.random_tetrimino
            expect(@tg.reslove_collision(tet,0)).to eq(20)
            expect(@tg.reslove_collision(tet,1)).to eq(21)
            expect(@tg.reslove_collision(tet,2)).to eq(2)
            expect(@tg.reslove_collision(tet,4)).to eq(14)
            expect(@tg.reslove_collision(tet,5)).to eq(15)
            expect(@tg.reslove_collision(tet,8)).to eq(28)
        end
    end
    
    describe "#get_unoccupied_index" do
        it "should return the lowest index in the given column that is unoccupied" do
            [0,1,5,9,10,11].each {|index| @tg.board[index] = 1}
            test_indexes = []
            
            (0...@board_width).each {|column| test_indexes.push(@tg.get_unoccupied_index(column))}
            
            expect(test_indexes).to eq([20, 21, 2, 3, 4, 15, 6, 7, 8, 19])
        end
    end
    
    describe "#energy" do
        it "should return higher energy at the top edge of the board than the bottom" do
            energy_top = @tg.energy([197,196])
            energy_bottom = @tg.energy([1,2])
            expect(energy_top).to be > energy_bottom
        end
        
        it "should return a higher energy in the middle of the board than at the left edge" do
            energy_left = @tg.energy([10])
            energy_center = @tg.energy([14])
            expect(energy_center).to be > energy_left
        end
        
        it "should return a higher energy in the middle of the board than at the right edge" do
            energy_right = @tg.energy([19])
            energy_center = @tg.energy([14])
            expect(energy_center).to be > energy_right
        end
        
        it "should return a lower energy at the bottom corner than the bottom edge" do
            energy_bottom_corner = @tg.energy([0])
            energy_bottom = @tg.energy([4])
            expect(energy_bottom).to be > energy_bottom_corner
        end
        
        it "should return the same energy for edges in the same row" do
            energy_left = @tg.energy([20])
            energy_right = @tg.energy([29])
            expect(energy_left).to eq(energy_right)
        end
        
        it "should return the same energy for non-edges in the same row" do
            energy_left = @tg.energy([21])
            energy_right = @tg.energy([28])
            expect(energy_left).to eq(energy_right)
        end
        
        it "should return an energy that is lower for every occupied neighbor" do
            @tg.neighbors(12).each {|index| @tg.board[index] = 1}
            energy = @tg.energy([12])
            expect(energy).to eq(-4)
        end
    end
    
     describe "#neighbors" do
        it "should return the neighbor cell indexes for any set of cell indexes" do
            expect(@tg.neighbors([11,12,21,22]).sort).to eq([1, 2, 10, 13, 20, 23, 31, 32])
        end
        
        it "should return 'bottom' when the neighbor is the bottom edge" do
            expect(@tg.neighbors([1,2,12,13])).to include('bottom')
        end
        
        it "should return 'left_{row}' when the neighbor is the left edge" do
            expect(@tg.neighbors([0,1,11,12])).to include('left_0')
        end
        
        it "should return 'right_{row}' when the neighbor is the right edge" do
            expect(@tg.neighbors([19,18,17,16])).to include('right_1')
        end
        
        it "should return 'top' when the neighbor is the top edge" do
            expect(@tg.neighbors([198,199])).to include('top')
        end
    end
    
    describe "#coordinate" do
        it "should return the row, column of any one dimensional index" do
            row, column = @tg.coordinate(1)
            expect([row,column]).to eq([0,1])
        end
    end

end