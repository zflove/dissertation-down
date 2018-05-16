import matplotlib.pyplot as plt
plt.switch_backend('agg') # Very Important in R Markdown
import numpy as np
x = np.arange(0,100,0.00001)
y = x*np.sin(2*np.pi*x)
plt.plot(y)
plt.savefig("demo-svg2.svg", format="svg")
