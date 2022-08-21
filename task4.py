"""
ADD COMMENTS TO THIS FILE 
"""
from typing import List, TypeVar

T = TypeVar('T')

def insertion_sort(the_list: List[T]):
    # Stores the length of the_list into length
    length = len(the_list)
    # Goes through the_list starting from i = 1
    for i in range(1, length):
        # Stores the_list[i] into another variable key so the value of the_list[i] won't be lost
        key = the_list[i]
        # Stores the value of i-1 into j to compare two consecutive elements
        j = i-1
        # j has to be >= 0 to go through the_list
        # Check condition if the key is less than the_list[j]
        while j >= 0 and key < the_list[j] :
                # Replace the (j+1)th element with the (j)th element
                the_list[j + 1] = the_list[j]
                # Subtract 1 from j to refer to the element before
                j -= 1
        # Replace the (j+1)th element with the element in key
        the_list[j + 1] = key

def main() -> None:
    arr = [6, -2, 7, 4, -10]
    insertion_sort(arr)
    for i in range(len(arr)):
        print (arr[i], end=" ")
    print()


main()