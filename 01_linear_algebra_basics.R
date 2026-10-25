# R101 — Linear algebra foundations in base R
# --------------------------------------------------------------
# Beginner-friendly examples: no additional packages required.
#
# RStudio tips:
#   Ctrl + Enter : execute the current line or selected lines
#   Source       : execute the entire file
#   Environment  : inspect A, B, v, and other variables
#
# Read the comments, execute one section at a time, and change
# the numbers to see what happens.

# 1. Creating matrices -----------------------------------------

# R fills matrices COLUMN by column by default.
# byrow = TRUE makes the input easier to read as written rows.
A <- matrix(c(2, 1,
              3, 4), nrow = 2, byrow = TRUE)

B <- matrix(c(1, 2,
              0, 3), nrow = 2, byrow = TRUE)

cat("\n1. MATRICES\n")
print(A)
print(B)

# A has 2 rows and 2 columns; indexing starts at 1 in R.
print(dim(A))     # rows, columns
print(A[1, 2])    # first row, second column

# 2. Addition, subtraction, scalar multiplication ---------------

cat("\n2. ADDITION AND SCALAR MULTIPLICATION\n")
print(A + B)      # add matching entries
print(A - B)      # subtract matching entries
print(3 * A)      # multiply every entry by 3

# Matrices must have matching dimensions for addition.
# Try defining a 2-by-3 matrix and adding it to A. What happens?

# 3. Element-wise versus matrix multiplication ------------------

cat("\n3. MULTIPLICATION\n")
print(A * B)      # multiply corresponding entries
print(A %*% B)    # true matrix product: row times column
print(B %*% A)    # order matters! Compare with A %*% B.

# Multiplication A %*% B requires:
# number of columns in A = number of rows in B.

v <- c(2, 5)
print(A %*% v)    # matrix times a column vector

u <- c(1, 3)
print(sum(u * v)) # dot product: 1*2 + 3*5 = 17
print(u %*% v)    # same dot product using matrix multiplication

# 4. Transposition ----------------------------------------------

cat("\n4. TRANSPOSITION\n")
print(A)
print(t(A))       # exchange rows and columns
print(t(t(A)))    # transposing twice returns A

# 5. Identity matrix, inverse, and linear systems ----------------

cat("\n5. INVERSE AND LINEAR SYSTEMS\n")
I <- diag(2)          # 2-by-2 identity matrix
A_inverse <- solve(A) # the inverse of A (if it exists)

print(I)
print(A_inverse)
print(A %*% A_inverse) # approximately the identity matrix
print(all.equal(A %*% A_inverse, I)) # TRUE within numerical tolerance

# Solve A x = b. This is normally BETTER than computing an
# inverse and then multiplying it by b.
b <- c(5, 15)
x <- solve(A, b)
print(x)            # expected solution: x = (1, 3)
print(A %*% x)      # check: should reconstruct b

# 6. Determinant, trace, and rank -------------------------------

cat("\n6. DETERMINANT, TRACE, AND RANK\n")
print(det(A))          # determinant; nonzero => A is invertible
print(sum(diag(A)))    # trace = sum of diagonal entries
print(qr(A)$rank)      # rank = number of independent columns

S <- matrix(c(1, 2,
              2, 4), nrow = 2, byrow = TRUE)

print(S)
print(det(S))          # zero: S is singular
print(qr(S)$rank)      # 1: its second column is dependent
# solve(S) would give an error: the inverse does not exist.

# 7. Eigenvalues and eigenvectors -------------------------------

cat("\n7. EIGENVALUES AND EIGENVECTORS\n")
ev <- eigen(A)
print(ev$values)
print(ev$vectors)      # eigenvectors are stored as COLUMNS

# Check A %*% v = lambda * v for the first eigenpair.
lambda <- ev$values[1]
eigenvector <- ev$vectors[, 1]

print(A %*% eigenvector)
print(lambda * eigenvector)

# Rank counts independent columns. It is NOT simply the
# number of eigenvectors returned by eigen().
# For example, S has rank 1 but eigen(S) returns 2 eigenvectors.

# 8. Bonus: matrices in statistics ------------------------------

cat("\n8. BONUS: COVARIANCE MATRIX\n")

# Four observations (rows), two variables (columns).
data <- matrix(c(1, 2,
                 2, 3,
                 3, 5,
                 4, 4), nrow = 4, byrow = TRUE)

colnames(data) <- c("X", "Y")
print(data)

C <- cov(data)         # variance on diagonal; covariance off-diagonal
print(C)
print(eigen(C)$values) # variation along the principal directions

cat("\nFinished. Try changing A or the dataset and rerunning.\n")
