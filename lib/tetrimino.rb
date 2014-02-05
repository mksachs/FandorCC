# The base class for the tetris tetriminos
class Tetrimino
    def initialize(game_board_width, game_board_height)
        @game_board_width = game_board_width
        @game_board_height = game_board_height
        @game_board_size = game_board_width * game_board_height
        @rotate_state = 0
    end
    
    attr_reader :game_board_width, :game_board_height, :game_board_size
end

# Creates a tetrimino with the following shape:
# XX
# XX
class TetriminoO < Tetrimino
    def initialize(game_board_width, game_board_height)
        super(game_board_width, game_board_height)
    end
    
    def indexes(root)
        if root >= @game_board_size - @game_board_width
            fail BoardTopError.new(root), 'The O Tetrimino cannot hang off the top of the board'
        else
            if root % @game_board_width == @game_board_width - 1
                fail BoardEdgeError.new(root), 'The O Tetrimino cannot hang off the edge of the board'
            end
        end
        [
            root,
            (root + 1) % @game_board_size,
            (root + @game_board_width) % @game_board_size,
            (root + 1 + @game_board_width) % @game_board_size
        ]
    end
end

# Creates a tetrimino with the following shape:
# XXXX
# TODO: Finish implementation of this tetrimino
class TetriminoI < Tetrimino
    def initialize(game_board_width, game_board_height)
        super(game_board_width, game_board_height)
    end
end

# Creates a tetrimino with the following shape:
# XXX
#   X
# TODO: Finish implementation of this tetrimino
class TetriminoJ < Tetrimino
    def initialize(game_board_width, game_board_height)
        super(game_board_width, game_board_height)
    end
end

# Creates a tetrimino with the following shape:
# XXX
# X
# TODO: Finish implementation of this tetrimino
class TetriminoL < Tetrimino
    def initialize(game_board_width, game_board_height)
        super(game_board_width, game_board_height)
    end
end

# Creates a tetrimino with the following shape:
#  XX
# XX
# TODO: Finish implementation of this tetrimino
class TetriminoS < Tetrimino
    def initialize(game_board_width, game_board_height)
        super(game_board_width, game_board_height)
    end
end

# Creates a tetrimino with the following shape:
# XXX
#  X
# TODO: Finish implementation of this tetrimino
class TetriminoT < Tetrimino
    def initialize(game_board_width, game_board_height)
        super(game_board_width, game_board_height)
    end
end

# Creates a tetrimino with the following shape:
# XX
#  XX
# TODO: Finish implementation of this tetrimino
class TetriminoZ < Tetrimino
    def initialize(game_board_width, game_board_height)
        super(game_board_width, game_board_height)
    end
end

# The base class for errors in the tetrimino root index.
class InvalidRootError < RuntimeError
    attr_reader :invalid_root
    def initialize(invalid_root)
        @invalid_root = invalid_root
    end
end

# Thrown when the tetrimino's root index would cause it to hang off the edge of
# the board.
class BoardEdgeError < InvalidRootError
    def initialize(invalid_root)
        super(invalid_root)
    end
end

# Thrown when the tetrimino's root index would cause it to hang off the top of
# the board. This is distinct from the BoardEdgeError because this will result
# in losing the game.
class BoardTopError < InvalidRootError
    def initialize(invalid_root)
        super(invalid_root)
    end
end
