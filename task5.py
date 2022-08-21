"""
ADD COMMENTS TO THIS FILE 
"""


def print_combination(arr, n, r):

    # Create an empty list data based on r value
    data = [0] * r
 
    # Call combination_aux() by passing 6 arguments
    combination_aux(arr, n, r, 0, data, 0)
 
def combination_aux(arr, n, r, index, data, i):

    # Checks if index is equal to r
    if (index == r):
        # Goes through the list
        for j in range(r):
            # Print the element in data and separate them with a space
            print(data[j], end = " ")
        # Print a newline
        print()
        # Return from the function
        return
 
    # Check if i >= n
    if (i >= n):
        # If true, return
        return
 
    # Replace data[index] with arr[i]
    data[index] = arr[i]
    # Call combination_aux() again but with index and i incremented by 1
    combination_aux(arr, n, r, index + 1,
                    data, i + 1)
 
    # Call combination_aux() again but only with i incremented by 1
    combination_aux(arr, n, r, index,
                    data, i + 1)
 
def main():
    arr = [1, 2, 3, 4, 5]
    r = 3
    n = len(arr)
    print_combination(arr, n, r)

main()