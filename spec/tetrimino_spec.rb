require "tetrimino"

describe TetriminoO do
    it "should initialize game_board_width and game_board_height" do
        tet = TetriminoO.new(10,20)
        expect(tet.game_board_width).to eq(10)
        expect(tet.game_board_height).to eq(20)
    end
    
    describe "game_board_size" do
        it "should be game_board_width * game_board_height" do
            tet = TetriminoO.new(10,20)
            expect(tet.game_board_size).to eq(20*10)
        end
    end
    
    describe "#indexes" do
        it "should throw an BoardEdgeError when a root at the right edge and not at the top of the board is chosen" do
            tet = TetriminoO.new(10,20)
            expect {
                for row in 1..tet.game_board_height-1
                    tet.indexes(row*tet.game_board_width-1)
                end
            }.to raise_error(BoardEdgeError)
        end
        
        it "should throw an BoardTopError when a root at the top of the board is chosen" do
            tet = TetriminoO.new(10,20)
            expect {
                for col in 1..tet.game_board_width
                    tet.indexes(tet.game_board_size - col)
                end
             }.to raise_error(BoardTopError)
        end
        
        it "should return correct indexes for valid roots" do
            tet = TetriminoO.new(10,20)
            expect(tet.indexes(0)).to eq([0, 1, 10, 11])
            expect(tet.indexes(11)).to eq([11, 12, 21, 22])
        end
    end
end