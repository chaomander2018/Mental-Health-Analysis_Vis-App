# Mental Health Analysis Visualization App

**Latest Update Date:** 2019 Jan

# Team

Instructor : Vincenzo Coia

| Name  | Slack Handle | Github.com | Link |
| :------: | :---: | :----------: | :---: |
| Chao Wang | `@Chao` | `@chaomander2018` | [Chao's link](https://github.com/chaomander2018/Mental-Health-Analysis_Vis-App)|
| Mengda Yu | `@Mengda(Albert) Yu` | `@mru4913` | [Albert's link](https://github.com/mru4913/Mental-Health-Analysis_Vis-App) |

# Milestone Progress

| Milestone  | Tasks |
| :------: | :---: |
| Milestone 1.0 | [Proposal](https://github.com/UBC-MDS/Mental-Health-Analysis_Vis-App/blob/master/docs/proposal.md) |

# Milestone 2.0 
| Milestone  | Tasks |
| :------: | :---: |
| Milestone 2.0 | [Writeup](https://github.com/UBC-MDS/Mental-Health-Analysis_Vis-App/blob/master/docs/m2_writeup.md) |
|              | [Deployed Shiny App](https://mru4913.shinyapps.io/Mental-Health-Analysis_Vis-App/)|
|        | [Shiny App Source Code](https://github.com/UBC-MDS/Mental-Health-Analysis_Vis-App/blob/master/src/app.R)|
# Milestone 2 Writeup

Author: Chao Wang, Albert Yu,

### 1.0 Design Philosophy

Our rationale for the set-up of this App is that we wanted to provides users a general picture of the effectiveness of Tech company mental health support via interative plots and datatable. We followed the dashboard design rule of thumb: key information displayed first, on top of the screen, in the upper left-hand corner. The options are given to the user to navigate the app in the left sidebar panel. There is some scientific wisdom behind this placement – most cultures read their written language from left to right and top to bottom, which means that people intuitively look at the upper-left part of a page first. Through the use of dropdown menus and radio buttons we are able to customize the app interface to individual user cases, while offering flexibility of visualization choices, and providing granular details to provide a neat look. The main tab displays the big picture, and the graph tab reflects the survey results according to the user's choice, while the table sections show the overall results.

### 2.0 Tasks:
#### 2.1 Tells a clear story:  

The tasks for Milestone 2 includes building a main page that consists of graph tab and table tab and a about page that shows the description about the shiny App project.

Users are landed on the Main page, Graph tab. In order to display results neatly and logically, the **Topic Drop Menu** enable users to select survey topics are relevant to their user case.

<img src="imgs/main-page_graph_pie.png" alt="table"/>

Bar charts are chosen to be the primary visual encoding as human reacts to length change the best comparing with other pattern changes.Due to the fact that survey results are categorical data, bar charts can quickly compare items in the same category, for example, the number of employers providing mental health care program. Again such charts are easy to understand, clear and compact. On the side panel, users are allowed to filter data display based on country and input variable. Two positions of bar, stack and dodge, are available to be customized according to users’ preference. Using plotly, users can get more specific information by hovering over visualizations and download a plot as a image.

Users can alter the graph type to pie chart through the **radio button** on the side panel. Pie charts can be instantly scanned and users will notice the biggest slice immediately.


#### 2.2 Simplifies Complexities: 

The survey results has been broken down to 5 individual reports. By selecting the Data Categories on the side panel, a specific aspect of the mental health survey results will be displayed. We offer three display styles, datatable, data structure and data summary.  This allows users to understand data from multiple viewpoints. In the datatable mode, the **page length options** and **sorting/searching options** give flexibility while maintaining a tidy look of the App.


<img src="imgs/main-page_table_data.png" alt="table" />


### 3.0 Reflection:

#### 3.1  Staying close to our vision and mission:
Our vision is to foster a better work environment, increase productivity, and reduce operating cost. Our app is able to demonstrate the low awareness of care programs and the importance of support anonymity in the workplace.

Although our goal remains the same, we trimmed down our user scenarios from two to one. This is because of precision, and the targeting the right audience. An HR Vice President deciding on group benefit plans needs different data than a startup owner deciding on an office rental. We focus on the company’s mental health support, and awareness of the mental health support program. On the other hand, we want to answer their questions clearly and give users autonomy to dive deep into the details they need. Users could use the **search bar** to only select U.S. data if they wanted, as a human resource professional in the United States would likely not be interested in the results of companies in the Czech Republic.

Comparing with our App sketch last week, our app displays one chart at one screen instead of four for the sake of brevity. Help button directs user to our github repo, this way we get rid of the github button to achieve minimalism.

### 4.0 Bugs:

So far, no bugs detected. We welcome feedbacks from TAs and MDS students.

## 5.0 Reference:
1. *How to Create Documentation for Dashboards*.\[online\] Available at:<https://chartio.com/learn/dashboards-and-charts/how-to-create-documentation-for-dashboards/>.\[Accessed 16 Jan. 2019\]
2. *10 Dashboard Design Principles & Best Practices To Enhance Your Data Analysis*.  \[online\] Available at: <https://www.datapine.com/blog/dashboard-design-principles-and-best-practices/>. \[Accessed 16 Jan. 2019\]

3. *User Experience Design*. \[online\] Available at:<https://www.interaction-design.org/literature/topics/ux-design>\[Accessed 16 Jan. 2019\]
4. *Dashboard Design Best
Practices – 4 Key Principles*\[online\] Available at: <https://www.sisense.com/blog/4-design-principles-creating-better-dashboards/> \[Accessed 19 Jan. 2019\]
