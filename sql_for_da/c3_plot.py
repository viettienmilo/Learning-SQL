import pandas as pd
import plotly.express as px
from plotly.subplots import make_subplots
import plotly.graph_objects as go

df1 = pd.read_csv("sql_for_da/c3_plot_1.csv")
fig1 = px.line(df1, x='YEAR(sales_month)', y='SUM(sales)', color='kind_of_business',
              title='TOTAL SALES BY YEAR')
fig1.show()

df2 = pd.read_csv("sql_for_da/c3_plot_2.csv")
fig2 = px.line(df2, x='YEAR(sales_month)', y='SUM(sales)', color='kind_of_business',
              title='TOTAL SALES BY YEAR')
fig2.show()

df3 = pd.read_csv("sql_for_da/c3_plot_3.csv")
fig3 = make_subplots(rows=3, cols=1, subplot_titles=(
    "SALES GAP BETWEEN WOMEN SALES AND MEN SALES",
    "TIMES OF WOMEN SALES PER MEN SALES",
    "PERCENTAGE OF WOMEN SALES PER MEN SALES"
))
fig3.add_trace(go.Scatter(x=df3['Year'], 
                          y=df3['Women/Men Diff'],
                          mode='lines',
                          name='Women/Men Diff'),
                          row=1,
                          col=1)
fig3.add_trace(go.Scatter(x=df3['Year'], 
                          y=df3['Women/Men Times'],
                          mode='lines',
                          name='Women/Men Times'),
                          row=2,
                          col=1)
fig3.add_trace(go.Scatter(x=df3['Year'], 
                          y=df3['Women/Men %'],
                          mode='lines',
                          name='Women/Men %'),
                          row=3,
                          col=1)
fig3.update_layout(title="COMPARISION BETWEEN YEARLY WOMEN/MEN SALES")
fig3.show()

df4 = pd.read_csv("sql_for_da/c3_plot_4.csv")
fig4 = px.line(df4, x='sales_month', y='Pct_Yearly', color='kind_of_business',
              title='PERCENTAGE OF SALES BY YEAR')
fig4.show()