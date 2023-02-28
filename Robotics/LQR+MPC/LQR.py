import math
import matplotlib.pyplot as plt

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

    x_star = [0] * (N+2)
    for t in range(N+2):
        x_star[t] = math.sin(math.pi/10*t)

    # Backward computation for p and k
    def LQR(n):
        if n == N:
            p_list[n] = qf
            return
        else:
            LQR(n + 1)
            k_list[n] = p_list[n + 1] * a * b / (r + p_list[n + 1] * b ** 2)
            p_list[n] = q + r * k_list[n] ** 2 + p_list[n + 1] * a ** 2 - 2 * \
                p_list[n + 1] * a * b * k_list[n] + \
                p_list[n + 1] * b ** 2 * k_list[n] ** 2
        return
    LQR(0)

    # Forward computation for the value function
    for t in range(N + 1):
        cost_list[t] = p_list[t] * (state_list[t] - x_star[t]) ** 2
        u_star = - k_list[t] * (state_list[t] - x_star[t])
        state_list[t + 1] = a * (state_list[t] - x_star[t]) + b * u_star + x_star[t+1]

    # Compute control
    u_list = []
    for t in range(N + 1):
        u_list.append(-k_list[t] * (state_list[t] - x_star[t]))

    # Plot them
    plt.title("q = " + str(q) + ", r = " + str(r))
    plt.plot(range(N + 1), cost_list, label="cost-to-go")
    plt.plot(range(N + 2), state_list, label="state")
    plt.plot(range(N + 1), u_list, label="control")
    plt.legend()
    plt.show()
