require_relative 'tetrimino'

# Plays a game of Tetris.
class Tetris
    def initialize
        @board_width = 10
        @board_height = 20
        @board_size = @board_width * @board_height
        @board = Array.new(@board_size, 0)
        @lose = false
    end

    attr_reader :board, :board_width, :board_height, :board_size

    # TODO : Test for losing condition and get rid of quit_after parameter
    def play(quit_after)
        round = 0
        until @lose
            tet = random_tetrimino
            energies = {}
            (0...@board_width).each do |column|
                begin
                    root = reslove_collision(tet, get_unoccupied_index(column))
                    energies[root] = energy(tet.indexes(root))
                rescue BoardEdgeError
                    next
                rescue BoardTopError
                    next
                end
            end
            
            tet.indexes(energies.sort_by { |_key, value| value }[0][0]).each { |index| @board[index] = 1 }
            
            remove_filled_rows
            
            round += 1
            @lose = true if round == quit_after
        end
        print_board
    end
    
    def print_board
        (@board_height - 1).downto(0).each do |row|
            puts "#{@board[row * @board_width...(row + 1) * @board_width]}"
        end
    end
    
    # TODO : Move any occupied cells above the removed rows down
    def remove_filled_rows
        (0...@board_height).each do |row|
            index_range = row * @board_width...(row + 1) * @board_width
            if @board[index_range].reduce(:+) == @board_width
                index_range.each { |index| @board[index] = 0 }
            end
        end
    end
    
    # TODO : This should include rotations
    def reslove_collision(tetrimino, root_index)
        test_location = @board.values_at(*tetrimino.indexes(root_index))
        index = root_index
        while test_location.include?(1)
            index += board_width
            return nil if index >= @board.length
            test_location = @board.values_at(*tetrimino.indexes(index))
        end
        index
    end
    
    def get_unoccupied_index(column)
        state = @board[column]
        index = column
        while state == 1
            index += board_width
            return nil if index >= @board.length
            state = @board[index]
        end
        index
    end
    
    def random_tetrimino
        TetriminoO.new(@board_width, @board_height)
    end
    
    def coordinate(index)
        [index / @board_width, index % @board_width]
    end

    def energy(indexes)
        energy = 0.0
        neighbors(indexes).each do |neighbor_index|
            if neighbor_index.class == String
                edge_index = neighbor_index.split('_')
                case edge_index[0]
                when 'bottom'
                    energy -= 1.0
                when 'left', 'right'
                    energy -= 1.0 - edge_index[1].to_f / Float(@board_height)
                end
            else
                energy -= @board[neighbor_index]
            end
        end
        energy
    end

    def neighbors(indexes)
        indexes = indexes.class != Array ? [indexes] : indexes
        neighbors = []
        indexes.each do |index|
            row, column = coordinate(index)
            neighbors.concat(
                [
                    column == 0                ? "left_#{row}"  : (index - 1) % @board_size,
                    column == @board_width - 1 ? "right_#{row}" : (index + 1) % @board_size,
                    row == 0                   ? 'bottom'       : (index - @board_width) % @board_size,
                    row == @board_height - 1   ? 'top'          : (index  +@board_width) % @board_size
                ]
            )
        end
        neighbors.delete_if { |index| indexes.include?(index) }
    end
end
