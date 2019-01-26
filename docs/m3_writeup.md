# Milestone 3 Writeup

Author: Chao Wang, Albert Yu,

# 1.0 Reflection on the feedback

### 1.1 Usability of our app

We absolutely appreciate the feedback lab session, especially two cycles of peer reviews. 

| Team  | Feedback |
| :------: | :---: |
|ellognea-ptung-mental-health | [link](https://github.com/UBC-MDS/Mental-Health-Analysis_Vis-App/issues/28) | 
|DSCI-532-wine-data           | [link](https://github.com/UBC-MDS/Mental-Health-Analysis_Vis-App/issues/27) |

During the review session, our reviewers had no critical issues exploring through our application without any explanation from us, which implies the functionality of the application is self-explaining to a certain extent. They thought this application provides good insight into the mental health support for Tech companies. The features, such as interactive plot and help link, really helped them navigate the App without any introduction. However, we also received several feedbacks about what we should improve in Milestone 3.

### 1.2  Similar feedback from both groups

One of the common themes was that the data structure display is less useful for the general public as data structure is for more R-savvy developers. However our target audiences are HR directors. Another common theme is the vagueness of the variables. For example, our age group was divided into four sub-groups, fresh (age 16-24), junior (age 25 -34), senior (age 35 - 60) and super (age > 60), which were not explicitly shown on the application. On the filter panel, the reviewers felt it was unclear which countries the “Other” option denotes. These issues reduced the readability thus prevented the reviewers from understanding the application. Overall, we thought these reviews are reasonable and we are definitely able to improve the functionality and visualization of our application.

### 1.3 Fly on the wall

The “fly on the wall” session emulated the real world scenarios—apps users are new to the interface, developers would not have a chance to explain the usage of the app, which means our design should be intuitive and simple. We felt that the process is useful and interesting. We understood that minor details can have a significant negative impact on user experience. One significant lesson we learned is that we should always design our application from the perspectives of users. 

### 1.4 The most valuable feedback

One of the most important takeaways is that our design and wording should be clear to users that are fresh to the app and the topic. For example, we segmented age by 5 groups labeled as “fresh, junior, senior and super”. Thought it seems to be clear to us that we divided ages into 4 groups but this might not make sense to users. Thus, we replaced the age groups with a scented widget, a histogram(visual scent) shows the age distribution while the widgets allow users to filter.

<div align="center">
<img src="../imgs/age_filter.png" alt="table"/>
</div>

### 1.5 Challenge

One expectation that is difficult to satisfy is that it is hard to hover over the correct group when there is only one count in a group on our stack bar graph. After consulting with the TA, there is no way to magnify the “one count bar size” other than log scale. We decided to tackle this issue by providing dodge style bar chart.

<div align="center">
<img src="../imgs/stack_dodge.png" alt="table"/>
</div>


## 2.0 Reflection on the update

### 2.1 Dashboard design choice

Although our objective and functionality mostly remained the same, we rolled out changes to enhance user experience. Originally, we split the interface into two main sections and two tab views---side panel and main interface, graph tab and table tab. In the newer design, we moved tabs to the left side panel and created graph filter options in the widgets on right hand side.

<div align="center">
<img src="../imgs/app2-dashboardpage.png" alt="table"/>
</div>

### 2.2 User scenarios

Originally we focused on the demonstration on US survey results so that we aggregated all other countries in the same group. The “other” group turned out to be ambiguous to users. Users were unable to find out which countries’ results are included. Users also wanted to explore the survey results of other countries. To address this issue, our new version allows users to select and deselect countries while US remains the default selection when only one country is selected.

<div align="center">
<img src="../imgs/country_selection.png" alt="table"/>
</div>

### 2.3 Detail Enhancement

Collapse box design are added for the sake of brevity. It reserves the necessary content on the page while keeps the dashboard clean.

<div align="center">
<img src="../imgs/collapse.png" alt="table"/>
</div>

A message notification system was implemented to help users better explore the application. For example, when users select a variable, a message will be poped up to explain the associated description of the variable. A warning system was also built to guide users to select available data range.

<div align="center">
<img src="../imgs/notification.png" width="200" height="100" alt="table"/>
<img src="../imgs/warning.png" width="500" height="400" alt="table"/>
</div>

One the data page, a download button was added for users to continue their work locally. We also implemented a factor description table in order to help users understand better. Both data filter panel and description table are collapsible to maintain a clean visualization.

<div align="center">
<img src="../imgs/app2-datapage.png" alt="table"/>
</div>

# 3.0 Conclusion 

In conlusion, the object of our app remains the same and we have significantly improved the functionality and the visualization of our app based on the useful feedbacks received from our peers and TAs. We built a complete new version of our application including dashboard page. We provided more options for users to customize their web page by implementing a age slider and a country selector as well as removed the ambiguity. A notification and warning system is embeded into the application to guide users better understanding our application. Lastly, we reorganized our widgets to enhance the aesthetic of the app. 

# 4.0 Reference

1. *A Comprehensive Guide To Mobile App Design*.\[online\] Available at:<https://www.smashingmagazine.com/2018/02/comprehensive-guide-to-mobile-app-design/>.\[Accessed 26 Jan. 2019\]
