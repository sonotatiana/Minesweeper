

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
            System.out.println(row + "," + col);
            bombs.add(buttons[row][col]);
        }
    }
    
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    fill(249,15,15);
    textSize(32);
    text("GAME OVER", 200,200 );
}
public void displayWinningMessage()
{
    //your code here
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
        if(keyPressed() == true && isMarked() == false)
        {
            cliked = false;
        }
        else if(keyPressed() == true && bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c) > 0)
        {
            setLabel(countBombs(r,c));
        }
        else
        {
            buttons[row+1][col].mousePressed();
            buttons[row+1][col-1].mousePressed();
            buttons[row+1][col+1].mousePressed();
            buttons[row][col-1].mousePressed();
            buttons[row][col+1].mousePressed();
            buttons[row-1][col].mousePressed();
            buttons[row-1][col-1].mousePressed();
            buttons[row-1][col+1].mousePressed();
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



