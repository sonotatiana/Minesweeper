

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS]; 
    for(int a = 0; a < buttons.length; a ++)
    {
        for(int b = 0; b<buttons[a].length; b++)
        {
            buttons[a][b] = new MSButton(a,b);
        }
    }
    
    setBombs();
}

public void setBombs()
{
    //your code
    for (int i = 0; i<10; i++)
    {
         int row = (int)(Math.random()*20);
         int col = (int)(Math.random()*20);
        if(!bombs.contains(buttons[row][col]))
        {
            bombs.add(buttons[row][col]);
        }
    }
    
}
 public void draw () 
    {    
        if(isWon() == true)
        {
            displayWinningMessage();
        }
    }


public boolean isWon()
{
    //your code here
    for(int r = 0; r<NUM_ROWS; r++)
        for(int c =0; c<NUM_COLS; c++)
            if(buttons[r][c].isMarked() == false && buttons[r][c].isClicked() == false)
                return false;

    return true;
}
public void displayLosingMessage()
{
    //your code here
    String over = "YOU LOSE!!";
    for(int cc = 2; cc<11; cc++)
    {
        buttons[2][cc].setLabel(over.substring(cc-2, cc-1));
    }

}
public void displayWinningMessage()
{
    //your code here
    String yay = "YOU WON!";
    for(int ccc = 2; ccc<9; ccc++)
    {
        buttons[2][ccc].setLabel(yay.substring(ccc-2, ccc-1));
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(keyPressed == true)
        {
            marked = !marked;
        }
        else if(bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c) > 0)
        {
            setLabel("" + countBombs(r,c));
        }
        else
        {
            if(isValid(r+1, c) == true && buttons[r+1][c].isClicked() == false)
                buttons[r+1][c].mousePressed();
            
            if(isValid(r+1, c-1) == true && buttons[r+1][c-1].isClicked() == false)
                buttons[r+1][c-1].mousePressed();
            
            if(isValid(r+1, c+1) == true && buttons[r+1][c+1].isClicked() == false)
                buttons[r+1][c+1].mousePressed();
            
            if(isValid(r, c-1) == true && buttons[r][c-1].isClicked() == false)
                buttons[r][c-1].mousePressed();
            
            if(isValid(r, c+1) == true && buttons[r][c+1].isClicked() == false)
                buttons[r][c+1].mousePressed();
            
            if(isValid(r-1, c) == true && buttons[r+1][c].isClicked() == false)
                buttons[r-1][c].mousePressed();
            
            if(isValid(r-1, c-1) == true && buttons[r-1][c-1].isClicked() == false)
                buttons[r-1][c-1].mousePressed();
            
            if(isValid(r-1, c+1) == true && buttons[r-1][c+1].isClicked() == false)
                buttons[r-1][c+1].mousePressed();
        }
    }

 public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
          fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);

        //background(0);
    }

    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row +1, col) == true && bombs.contains(buttons[row +1][col])) // above
        {
            numBombs++; 
        }
        if(isValid(row+1, col-1) == true && bombs.contains(buttons[row + 1][col -1])) // above left
        {
            numBombs++; 
        }
        if(isValid(row+1, col+1) == true && bombs.contains(buttons[row + 1][col + 1])) // above right
        {
            numBombs++; 
        }
        if(isValid(row, col-1) == true && bombs.contains(buttons[row][col -1])) // left
        {
            numBombs++; 
        }
        if(isValid(row, col+1) == true && bombs.contains(buttons[row][col + 1])) // right
        {
            numBombs++; 
        }
        if(isValid(row-1, col) == true && bombs.contains(buttons[row -1][col])) // below
        {
            numBombs++; 
        }
        if(isValid(row-1, col -1) == true && bombs.contains(buttons[row -1][col -1])) // below left
        {
            numBombs++; 
        }
        if(isValid(row - 1, col+1) == true && bombs.contains(buttons[row -1][col + 1])) // below right
        {
            numBombs++; 
        }
        
        return numBombs;
    }
}



