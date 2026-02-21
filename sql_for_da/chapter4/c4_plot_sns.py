import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

sns.set_theme(rc={'figure.figsize':(10, 6)})
plt.style.use("dark_background")
plt.rcParams.update({
    "axes.facecolor": "#2a2a2a",
    "figure.facecolor": "#2a2a2a",
    "axes.edgecolor": "#666666",
    "grid.color": "#cacaca",
    "grid.alpha": 0.5
})
colors = sns.color_palette("tab10")


plt.figure()
df1 = pd.read_csv("sql_for_da/chapter4/c4_plot_1.csv")
sns.lineplot(data=df1, x='period', y='pct_retained')
plt.title('Legistators Retention Percentage')

plt.show()