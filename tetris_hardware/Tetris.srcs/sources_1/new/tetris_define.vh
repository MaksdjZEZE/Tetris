`ifndef TETRIS_DEFINE_SVH
`define TETRIS_DEFINE_SVH

// This is the header file where we define all necessary types and constants

// block_move_t defines the 5 different movements/actions of the block
typedef enum { MOVE_DOWN,
               MOVE_LEFT,
               MOVE_RIGHT,
               MOVE_ROTATE,
               MOVE_APPEAR } block_move_t;

`define BLOCK_I 0
`define BLOCK_O 1
`define BLOCK_T 2
`define BLOCK_S 3
`define BLOCK_Z 4
`define BLOCK_J 5
`define BLOCK_L 6

`define  BLOCK_SIZE           16
`define  BLOCK_SIZE_WIDTH           $clog2( `BLOCK_SIZE )
`define  PLAYFIELD_WIDTH           (`PLAYFIELD_COL * `BLOCK_SIZE)
`define  PLAYFIELD_HEIGHT          (`PLAYFIELD_ROW * `BLOCK_SIZE)

`define  PLAYFIELD_COL           10
`define  PLAYFIELD_ROW           20
`define  PLAYFIELD_COL_WIDTH     $clog2( `PLAYFIELD_COL )
`define  PLAYFIELD_ROW_WIDTH     $clog2( `PLAYFIELD_ROW )

`define PLAYFIELD_EXT_COL       ( `FIELD_COL_CNT + 2 )
`define PLAYFIELD_EXT_ROW       ( `FIELD_ROW_CNT + 2 )

`define TETRIS_COLORS_NUM       8
`define TETRIS_COLORS_NUM_WIDTH     $clog2( `TETRIS_COLORS_NUM )

typedef struct packed {
          logic        [0:3][3:0][3:0]                 data;
          logic        [`TETRIS_COLORS_NUM_WIDTH-1:0]      color;
          logic        [1:0]                           point;
          logic signed [`PLAYFIELD_COL_WIDTH-1:0]        x;
          logic signed [`PLAYFIELD_ROW_WIDTH-1:0]        y;
} block_info_t;

`endif