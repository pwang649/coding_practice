import matplotlib.pyplot as plt
import cvxpy as cp

if __name__ == '__main__':
    a = 1
    b = 1
    q = 1
    qf = q
    r = 50
    N = 20
    x0 = 1

    x = cp.Variable(N + 1)
    u = cp.Variable(N)

    cost = 0
    constr = []
    T = N

    cost += q * cp.sum_squares(x) + r * cp.sum_squares(u) + qf * x[N] ** 2
    constr += [x[0] == x0]
    constr += [x[N] == 0]
    for t in range(T):
        constr += [x[t + 1] == a * x[t] + b * u[t]]

    prob = cp.Problem(cp.Minimize(cost), constr)

    prob.solve()
    cost = []
    for t in range(N):
        c = q * cp.sum_squares(x[t:]) + r * \
            cp.sum_squares(u[t:]) + qf * x[N] ** 2
        cost.append(c.value)

    # Plot them
    plt.title("q = " + str(q) + ", r = " + str(r))
    plt.plot(range(N), cost, label="cost-to-go")
    plt.plot(range(N + 1), x.value, label="state")
    plt.plot(range(N), u.value, label="control")
    plt.legend()
    plt.show()
