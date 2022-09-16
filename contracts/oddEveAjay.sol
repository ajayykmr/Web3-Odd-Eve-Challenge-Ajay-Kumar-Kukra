pragma solidity >=0.7.0 <0.9.0;
// SPDX-License-Identifier: GPL-3.0

import "@openzeppelin/contracts/utils/Strings.sol";
//we import this library to use the functin Strings.toString(value) so that we can return the required string as given in the task

contract oddEveAjay{
    uint public score;          //stores the current score
    bool public out;            //boolean variable to check wether the batsman is out or not
    uint randomvariable;        //to increase randomness of generated random variable

    constructor()
    {
        score = 0;              //initially the score is zero
        out=false;              //the batsman is not out
        randomvariable=0;
    }
    
    function userinput(uint _inputnumber) public returns (string memory stringg)    
    {
    /*
        this functions takes input from user
        stringg variable stores the string value to return
    */
        
        if (out==true)          //if the batsman is out, we need to reset the game
        {
            stringg = "BatsmanOut,PleaseReset";
            return stringg;
        }
        else                                            //batsman is not out
        {
            if (_inputnumber<1 || _inputnumber >6)      //condition to check if the userinput is valid or not
            {
                stringg = "EnterValidNumber";               
                return stringg;
            }
            
            else                          
            {
                uint randomnumber =randdomnumbergenerator();
                /*
                randdomnumbergenerator is a function to generate a random number between 0 to 5
                if the generated random number is zero, we set the randomnumber variable to 6 since zero is an invalid input
                */
                if (randomnumber==0)
                {
                    randomnumber=6;
                }

                if (randomnumber==_inputnumber)                                    //batsman is out, return: the generated number and string “RUNS” 
                {
                    out=true;
                    stringg = concatenate(Strings.toString(score), "OUT");         //concatenate function is used to concatenate two strings, it is defined below
                    return stringg;                                         
                }

                else
                {
                    score = score + randomnumber;
                    stringg = concatenate(Strings.toString(randomnumber), "RUNS");  
                    return stringg;                                                //return: the total score and string “OUT”
                }
            }
        }
    }

    function reset() public returns(string memory)      //function to reset the game
    {
        score = 0;
        out=false;
        return "ResetSuccessfull";

        //we are not changing randomvariable's value to further increase randomness since it is used in the process to generate random numbers
    }

    function randdomnumbergenerator() private returns(uint)
    {
        /*
            this function is used to generate random numbers using the current values of block.timestamp, score and randomvariable
            all the three values are responsible for generating random values
            modulo 6 reduces the random values in the range 0 to 5.
        */


        unchecked                   //to allow overflow and underflow without any errors
        {
            randomvariable++;       //to increase randomness we increment the randomvariable by one each time we call this function
        }

        return uint(keccak256(abi.encodePacked(block.timestamp, score, randomvariable))) % 6;
    }

    function concatenate(string memory a,string memory b) private pure returns (string memory)  //this function used to concatenate two strings
    {
        return string(bytes.concat(bytes(a), " ", bytes(b)));
    } 
}