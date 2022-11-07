# Code taken from Stanislav Minsker's MATH 447.

# Load a part of the Iris dataset: in this case, we are using different classes than before
from sklearn import datasets
import numpy as np
import matplotlib.pyplot as plt

irisData = datasets.load_iris()
print(irisData.data.shape)
X = irisData.data[50:150, 0:2]
Y = irisData.target[50:150]
Y = np.array([1 if i == 1 else -1 for i in Y])

# Plot the data we just imported
plt.plot(X[0:50, 0], X[0:50, 1], 'o', color='blue', label='1')
plt.plot(X[50:100, 0], X[50:100, 1], 'o', color='red', label='-1')
plt.xlabel('Sepal length')
plt.ylabel('Sepal width')
plt.legend()
plt.show()

# Logistic regression
from sklearn.linear_model import LogisticRegression

# instantiate the model (using the default parameters)
logReg = LogisticRegression()

# fit the model with data
model = logReg.fit(X, Y)

# read parameters of the resulting linear separator
# extract the model parameters
b = model.intercept_
w = model.coef_

# Plot the resulting line
xCoordinates = np.linspace(4.8, 7.8, 20)
yCoordinates = -(w[0, 0] * xCoordinates + b) / w[0, 1]
plt.plot(xCoordinates, yCoordinates)
plt.plot(X[:50, 0], X[:50, 1], 'o', color='blue', label='1')
plt.plot(X[50:100, 0], X[50:100, 1], 'o', color='red', label='-1')
plt.xlabel('Sepal length')
plt.ylabel('Sepal width')
plt.show()
