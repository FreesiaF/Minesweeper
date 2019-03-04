
import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );

    bombs = new ArrayList <MSButton>();
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++) {
            buttons[r][c] = new MSButton(r,c); //your code to initialize buttons goes here
        }
    }
    
    
    
    setBombs();
}
public void setBombs()
{
    for(int i = 0; i < 50; i++)
    {
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);

    if(!bombs.contains (buttons[row][col]))
        bombs.add(buttons[row][col]);
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
;
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

        if(mouseButton == RIGHT && marked == false)
            {
                clicked = false;
            }
               
        else if(clicked == true && bombs.contains(this))
            displayLosingMessage();

        else if(countBombs(r,c)>0){
            label = "" +countBombs(r,c);
            System.out.println(countBombs(r,c));            
        }


        else{

           for (int x = r-1; x <=r+1; x++) 
                for(int y = c-1; y<=c+1; y++)
                    if(isValid(x,y) == true && buttons[x][y].isMarked()==false)
                        buttons[x][y].mousePressed();
      
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
        if(r < 20 && r >= 0)
            if(c<20&&c >=0)
                return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int r = row-1; r<=row+1;r++){
            for(int c = col-1; c<=col+1;c++){
                if(isValid(row,col)== true && (bombs.contains(buttons[r][c])))
                    numBombs++;
            }
        }
        return numBombs;
    }
}



