# Code taken from Stanislav Minsker's MATH 447.

# Load a part of the Iris dataset
from sklearn import datasets
import numpy as np
import matplotlib.pyplot as plt

irisData = datasets.load_iris()
X = irisData.data[0:99, :2]
Y = irisData.target[0:99]
Y = np.array([1 if i == 1 else -1 for i in Y])

# Plot the data we just imported
plt.plot(X[0:50, 0], X[0:50, 1], 'o', color='blue', label='-1')
plt.plot(X[50:99, 0], X[50:99, 1], 'o', color='red', label='1')
plt.xlabel('Sepal length')
plt.ylabel('Sepal width')
plt.legend()

# Perceptron iteration

# Initialize parameters
w = np.zeros((X.shape[1], 1));
b = 1;
stepSize = 1;
round = 0;
allCorrect = False;

# Start Gradient Descent
while not allCorrect:
    misclassifiedCount = 0
    for i in range(X.shape[0]):
        observation = X[i,]
        label = Y[i]
        if label * (np.dot(w.T, observation.T) + b) < 0:
            w += stepSize * np.dot(observation, label).reshape(2, 1)
            b += stepSize * label
            misclassifiedCount += 1
    if misclassifiedCount == 0:
        allCorrect = True
    else:
        allCorrect = False
    round += 1
print(w)
print(b)

# Finally, we can plot the resulting separating hyperplane (a line in our case):
xCoordinates = np.linspace(4, 7, 10)
yCoordinates = -(w[0] * xCoordinates + b) / w[1]
plt.plot(xCoordinates, yCoordinates)
plt.plot(X[:50, 0], X[:50, 1], 'o', color='blue', label='-1')
plt.plot(X[50:99, 0], X[50:99, 1], 'o', color='red', label='1')
plt.xlabel('Sepal length')
plt.ylabel('Sepal width')
plt.legend()
plt.show()
