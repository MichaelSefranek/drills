// I have a really hard time mentally thinking about this one:  I know there must be a simpler way.
// my idea is to define an array x (across, or number of columns), by y (down, number of rows)
// and then input the values of the strings into arrays, including proper spaces:
// e.g so     e g              e m q
//            m i h  --->      g i
//            q                  h
//  My head just can't wrap around how to easily define a 2 dimensional array. ( an array of arrays)
//
//


//find the longest length string in array of strings.  --> call instarray on that length.



function instarray(num1) {  //instantiates an array with num1 empty arrays
    var arr = [];
    
    for (var i=0; i<num1; i++){
        arr[i] = [];
    }

console.log(arr)
return(arr)
}

//instarray(4);


function vertstring(hstring){  
    
var arrString = hstring.split("");  //split string into array of letters
    
}


function maxLength (arrStr){   // takes an array of strings and returns length of longest element
    var nmax = 0;
    for (var i = 0; i < arrStr.length; i++) { 
        nmax = Math.max(arrStr[i].length, nmax);
}
//console.log(nmax);
return(nmax);
}

function printVert(astring){
    astring = hstring.split('');
    
}
