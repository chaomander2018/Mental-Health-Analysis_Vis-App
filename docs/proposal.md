# Tech Mental Health Survey App 

# 1.0 Overview

Mental health issues have become one of the most important contributors to the burden of disease and disability in modern society, especially in workplaces. Researchers from the University of California found that 72% of entrepreneurs surveyed self-reported mental health concerns. Mental illness may result in the inability of concentration, difficulty handling pressures and multiple tasks, difficulty interacting with others.

Employers and employees both benefit from a psychologically healthy workplace. Understanding mental health at the tech workplaces would be helpful in order to foster a better work environment, increase productivity and reduce operating cost. Thus, we propose building an R-shiny-based data visualization app that allows administrators to visually explore the dataset regarding a mental health survey in 2014 in the tech industry. Our app will show the distribution of various factors associated with mental health awareness and the effectiveness of group benefit in regards to mental health. It will also allow decision makers to filter different variables and select different survey results they are interested in for assessing mental health at their own workplaces and the employees’ mental states.



# 2.0 Description of the data

We will visualize a dataset that contains 1295 subjects who participated in the Tech Mental Health Survey in 2014 in the worldwide. The survey examined 24 main factors associated with mental health status (excluding timestamp, state and comments) . We clusters the factors into five main categories based on the type of survey questions. Each survey result contains the demographic information (age, gender and country), mental health condition (family history, treatment and work interfere),  workplace information (number of employees, allow remote work, company type etc), organizational mental health supports (benefits, care options, wellness program etc) and their openness about mental health issues at work.  The results of most survey questions are either yes or no. Some of questions contain scale results. The following is the questions listed in the survey.

#### Category 1. Demographic information

| Factor  | Description  | type | 
|---|---|---|
|Age| Age of participator  |  numeric  | 
|Gender| Gender of participator  | categorical | 
|Country  | Country of participator  | categorical |  

#### Category 2. Mental health condition 

| Factor  | Description  | type | 
|---|---|---|
|family_history | Do you have a family history of mental illness? | categorical |
|treatment | Have you sought treatment for a mental health condition? | categorical |
|work_interfere |  If you have a mental health condition, do you feel that it interferes with your work? | categorical |

#### Category 3. Workplace information

| Factor  | Description  | type | 
|---|---|---|
|self_employed | Are you self-employed? | categorical |
|no_employees | How many employees does your company or organization have? | categorical |
|remote_work | Do you work remotely (outside of an office) at least 50% of the time? | categorical |
| tech_company| Is your employer primarily a tech company/organization? | categorical |

#### Category 4. Organizational mental health supports 

| Factor  | Description  | type | 
|---|---|---|
|benefits| Does your employer provide mental health benefits? | categorical |
|care_options| Do you know the options for mental health care your employer provides? | categorical |
|wellness_program| Has your employer ever discussed mental health as part of an employee wellness program? | categorical |
|seek_help| Does your employer provide resources to learn more about mental health issues and how to seek help? | categorical |
|anonymity| Is your anonymity protected if you choose to take advantage of mental health or substance abuse      treatment resources? | categorical |
|leave| How easy is it for you to take medical leave for a mental health condition? | categorical |

#### Category 5. Openness about mental health

| Factor  | Description  | type | 
|---|---|---|
|mental_health_consequence| Do you think that discussing a mental health issue with your employer would have negative consequences?| categorical |
|phys_health_consequence| Do you think that discussing a physical health issue with your employer would have negative consequences? | categorical |
|coworkers|Would you be willing to discuss a mental health issue with your coworkers? | categorical |
|supervisor| Would you be willing to discuss a mental health issue with your direct supervisor(s)? | categorical |
|mental_health_interview| Would you bring up a mental health issue with a potential employer in an interview? | categorical |
|phys_health_interview| Would you bring up a physical health issue with a potential employer in an interview? | categorical |
|mental_vs_physical| Do you feel that your employer takes mental health as seriously as physical health? | categorical |
|obs_consequence| Have you heard of or observed negative consequences for coworkers with mental health conditions in your workplace? | categorical |


# 3.0 Usage scenario & tasks 


#### Case 1:

Cindy is the Vice President of Human Resource department in a medium-sized tech company. She wants to understand how to promote mental healthiness in order to build a sustainable, efficient workplace for employees.

Each year, Mental health insurance premium accounts for a huge part of the company’s hiring cost, Cindy wants to be able to [explore] a dataset to [acquire] whether employees actually benefit from the program. When Cindy uses this app, she will find employee’s overall awareness of the mental health benefit on the dashboard. Judging from the percentage of employee's awareness about company's benefits and care options, and knowing that only less than half of the employees are aware of mental support. Cindy is considering promoting the program within the company during company-wide events.

From the survey, Cindy may notice a fair share of the workforce believes asking for help could prove detrimental to their careers. She can further understand whether employees feel safe and comfortable seeking helps (either at the workplace or professionals). This will make her ponder what is the best way to encourage dialogues on mental health within teams. 

#### Case 2:

Mark is an entrepreneur of a growing tech start-up in Vancouver. He wants to be able to [explore] and [visualize] the dataset to [determine] if the size of the work group and the concentration affect mental health and work efficiency.  Would employees be happier if they are able to work collaboratively with co-workers in the same office? After exploring the Mental Health Condition report and Workplace Information report in our app, he will be able to sense an employee’s attitude towards on-site work collaboration. This information is valuable to Mark as he is on the fence of about renting a bigger office next year.



# 4.0 Description of app & initial sketch

The main page of the app provides multiple widgets and display windows for users to customize and filter out variables from various visualization of data (table, bar chart and so on). A menu bar on the top of the page contains a logo and a repo link. Clicking on the logo leads user to the main page. The icon of Github links to our main repo, which allows users to read the code and make a better understanding of the app. 

The app consists of two main display windows pages, a data page and a graph page. Since we group the data into five categories, users can select different category of data from a drop-down menu on the control panel, such as demographic information and organizational mental health supports. Radio buttons controls the display of data table in order to provide an overview of raw data. A help button is provided for user guide.

![](../imgs/shinyApp-Page-1.png)
<div align="center">Figure 1. The home page of shiny App</div>

The pie charts and bar charts will show the distribution of each factor corresponding to users’ data selection and variable options. For example, it will display the percentage of staff member knowing the options for mental health care their employer provides.

![](../imgs/shinyApp-Page-2.png)
<div align="center">Figure 2. The graph page of shiny App</div>