import matplotlib.pyplot as plt
import numpy as np

if __name__ == '__main__':
    a = 1
    b = 1
    q = 1
    qf = q
    r = 1
    N = 20
    x0 = 1
    p_list = [0] * (N + 1)
    k_list = [0] * (N + 1)
    state_list = [0] * (N + 2)
    state_list[0] = x0
    cost_list = [0] * (N + 1)

    # Backward computation for p and k
    def LQR(n):
        if n == N:
            p_list[n] = qf
            return
        else:
            LQR(n + 1)
            k_list[n] = p_list[n + 1] * a * b / (r + p_list[n + 1] * b ** 2)
            p_list[n] = q + r * k_list[n] ** 2 + p_list[n + 1] * a ** 2 - 2 * p_list[n + 1] * a * b * k_list[n] + p_list[n + 1] * b ** 2 * k_list[n] ** 2
        return
    LQR(0)

    # Forward computation for the value function
    for t in range(N + 1):
        cost_list[t] = p_list[t] * state_list[t] ** 2
        u_star = - k_list[t] * state_list[t]
        state_list[t + 1] = a * state_list[t] + b * u_star

    x = np.array(np.array(range(N + 1)))
    y = np.array(np.array(cost_list))

    plt.plot(x, y)
    plt.show()
