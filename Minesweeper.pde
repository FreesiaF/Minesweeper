
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
    for(int i = 0; i < 70; i++)
    {
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);

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
    for(int i = 0; i < bombs.size(); i++)
        if(!(bombs.get(i).isMarked() == true))
            return false;
    return true;
}
public void displayLosingMessage()
{  
    for (int r = 0; r <NUM_ROWS; r++){
        for(int c=0; c< NUM_COLS; c++){
            if(bombs.contains(buttons[r][c] ))
                buttons[r][c].clicked= true;
        }
    }
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][9].setLabel("");
    buttons[9][10].setLabel("L");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("S");
    buttons[9][13].setLabel("E");

    for(int i = 0; i < bombs.size(); i++)
    { 
        bombs.get(i).draw();    
    }

}
public void displayWinningMessage()
{
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][9].setLabel("");
    buttons[9][10].setLabel("W");
    buttons[9][11].setLabel("I");
    buttons[9][12].setLabel("N");

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
        if(mouseButton == RIGHT)
        {
             marked = !marked;
            if(marked==false)
                clicked =false; 
        }

    
        else if(clicked == true && bombs.contains(this))
        {
            displayLosingMessage();
        }


        else if(countBombs(r,c)>0){
            label = "" +countBombs(r,c);           
        }


        else{

           for (int r2 = r-1; r2 <= r+1; r2++) 
                for(int c2 = c-1; c2<= c+1; c2++)
                    if(isValid(r2,c2) == true && buttons[r2][c2].isClicked()==false)
                        buttons[r2][c2].mousePressed();

      
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
        if(r <NUM_ROWS && r >= 0)
            if(c<NUM_COLS && c >=0)
                return true;
        return false;
    }

    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int r = row-1; r<=row+1;r++){
            for(int c = col-1; c<=col+1;c++){
                if(isValid(r,c)== true && (bombs.contains(buttons[r][c])))
                    numBombs++;
            }
        }
        return numBombs;
    }
}



