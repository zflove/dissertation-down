from __future__ import unicode_literals
import numpy as np
import matplotlib
matplotlib.rcParams['text.usetex'] = True
matplotlib.rcParams['text.latex.unicode'] = True
import matplotlib.pyplot as plt
plt.switch_backend('agg') # Very Important in R Markdown

t = np.linspace(0.0, 1.0, 100)
s = np.cos(4 * np.pi * t) + 2

fig, ax = plt.subplots(figsize=(6, 4), tight_layout=True)
ax.plot(t, s)

ax.set_xlabel(r'\textbf{time (s)}')
# ax.set_ylabel(r'\textit{Velocity}(\N{DEGREE SIGN}/sec)', fontsize=16)
ax.set_ylabel(r'\textit{Velocity}($^{\circ}$/sec)', fontsize=16)
ax.set_title(r'\TeX\ is Number $\displaystyle\sum_{n=1}^\infty'
             r'\frac{-e^{i\pi}}{2^n}$!', fontsize=16, color='r')
plt.show()
plt.savefig('test.svg')



import matplotlib.pyplot as plt
plt.switch_backend('agg') # Very Important in R Markdown
import numpy as np
x = np.arange(0,100,0.00001)
y = x*np.sin(2*np.pi*x)
plt.plot(y)
plt.savefig("demo-svg2.svg", format="svg")


import matplotlib.pyplot as plt
plt.switch_backend('agg') # Very Important in R Markdown
import numpy as np

plt.figure(figsize=[6, 6])
x = np.arange(0, 100, 0.00001)
y = x*np.sin(2* np.pi * x)
plt.plot(y)
plt.axis('off')
plt.gca().set_position([0, 0, 1, 1])
plt.savefig("demo-test.svg")
