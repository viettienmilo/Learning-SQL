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
df1 = pd.read_csv("sql_for_da/c3_plot_1.csv")
sns.lineplot(data=df1, x='YEAR(sales_month)', y='SUM(sales)', hue='kind_of_business', palette=colors)
plt.title('TOTAL SALES BY YEAR')


plt.figure()
df2 = pd.read_csv("sql_for_da/c3_plot_2.csv")
sns.lineplot(data=df2, x='YEAR(sales_month)', y='SUM(sales)', hue='kind_of_business', palette=colors)
plt.title('TOTAL SALES BY YEAR')


df3 = pd.read_csv("sql_for_da/c3_plot_3.csv")
fig, axes = plt.subplots(3, 1, figsize=(10,10))
sns.lineplot(data=df3, x='Year', y='Women/Men Diff', ax=axes[0], color=colors[0])
axes[0].set_title('SALES GAP BETWEEN WOMEN SALES AND MEN SALES')
sns.lineplot(data=df3, x='Year', y='Women/Men Times', ax=axes[1], color=colors[1])
axes[1].set_title('TIMES OF WOMEN SALES PER MEN SALES')
sns.lineplot(data=df3, x='Year', y='Women/Men %', ax=axes[2], color=colors[2])
axes[2].set_title('PERCENTAGE OF WOMEN SALES PER MEN SALES')
fig.suptitle('COMPARISION BETWEEN YEARLY WOMEN/MEN SALES', fontsize=16, fontweight='bold' )
plt.tight_layout(rect=[0, 0, 1, 0.96])
plt.subplots_adjust(hspace=0.6, wspace=0.3)

plt.figure()
df4 = pd.read_csv("sql_for_da/c3_plot_4.csv")
sns.lineplot(data=df4, x='sales_month', y='Pct_Yearly', hue='kind_of_business', palette=colors)
plt.title('PERCENTAGE OF SALES BY YEAR')


plt.show()