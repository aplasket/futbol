# Futbol

Starter repository for the [Turing School](https://turing.io/) Futbol project.

# README

### About 

This application is designed to analyze futbol team performance.
The Futbol - PD project has several learning goals:
Building software in teams
Use Pull Requests to collaborate among multiple partners
Practice giving and receiving feedback with teammates
Establish a project organization process
Design an Object Oriented Solution to a problem with multiple people
Use TDD and write clean Ruby following SRP and DRY principles
We used data from a fictional soccer league to analyze team performance for specific seasons and across seasons. We wanted to see who the best and worst performers are, as well as be able to pull statistics for individual teams. We created a StatTracker class that provided us with information we needed.
The first step of the project focused on establishing norms for our group. This included the following: project organization process, git workflow expectations, and DTR.
Next we planned and designed our solution together as a group, as the primary purpose of this project is to practice building software in a team setting. We needed a good design and plan before team members could break off and work asynchronously.
Once we had strong processes and a plan in place, the project focus shifted on building the base statistics functionality through our StatTracker.

### Built With

Ruby version 2.7 and RSpec version 3.12.0

### Getting Started

Clone this repo in your local terminal, type  
`git clone git@github.com:aplasket/futbol.git`
To run, type 
`ruby lib/runner.rb`

### Testing

In the futbol directory: Run `rspec` then run `open coverage/index.html`
From the futbol_spec_harness directory: Run `bundle exec rspec`

Tests are organized into two Groups: game_statistics and team_statistics.

### Check-Ins

We had async check-ins in the morning including status updates, with a requested response by 9 AM MT. If working in the evening, Slack status updates before signing off for the next morning are acceptable.
Live group check-ins during class group time. Stand up responses state the status of assigned tasks; what the programmer will be working on that day; and questions, comments and concerns that inform the group.

### Workflow

Team members assign tasks to themselves, changing status to “In Progress” and creating a pull request when complete, changing status again to “Pull Request”. Pull request workflow is submitted when ready to merge or if stuck or need help, followed by a slack to the group detailing and documenting further any issues. A team member will respond to claim ownership of the review, and reviewers are designated by morning and evening, with Garrett and Ashley reviewing in the AM and Matthew and Lauren taking the PM review shifts. The timeframe for reviewing is up to 12 hours after pull request submission.  Project Board:  https://github.com/users/aplasket/projects/4

### Project Organization

For Project Managers we chose Github Projects as we found it was potentially more versatile than other manager programs and directly integrated with GitHub. We researched Trello as well but found that some of its features required purchase for full usability and GitHub projects offered better ease of communication between team members. Ashley was chosen to host the repo for this project. Retro was planned for 04/24/2023 at 9 AM MT. 

### Retro

[Retro](https://docs.google.com/presentation/d/1IHU4eWH82O4cl0zvH59zzHXLwvZsc3d5aLF3NinHP9g/edit#slide=id.p)

For the retro we used Google Slides, Google Images, and our Miro board [Miro](https://miro.com/app/board/uXjVMRUb-y0=/) . The takeaways from our retro: 

What went well: 
- Our team was cohesive
- Borrowing code from other methods was effective
- Consistent communication in Slack

Things our team would do differently next time:
- We would have created modules
- We would have taken time to look through Iteration 2 as a group
- We would have workshopped structure together



### Code Design

We established shared conventions for VS Code. We would use double quotes (“”). We would have a vertical attr_reader. In assertions for Hashes or Arrays, we will  expect the return value to be a variable that is defined in the line above for greater readability.  

EX:  
expected = {value}  
expect(hash).to eq(expected)

### DTR Document

https://docs.google.com/document/d/1aQTaoqGz3xtM8JAw5DZGTMAQPFfMce8zIxMc6ZQXAz8/edit?usp=sharing
Initial Document created 04/17/2023, updated 04/23/2023



## CONTRIBUTORS

### Ashley Plasket  	       
Github: https://github.com/aplasket  
LinkedIn: https://www.linkedin.com/in/ashley-plasket/

### Lauren Golden  	       
GitHub: https://github.com/llgolden  
LinkedIn: https://www.linkedin.com/in/goldenll/

### Matthew William Johnson  
Github: https://github.com/MWMJohnson  
LinkedIn: https://www.linkedin.com/in/matthewwjohnsonttu/

### Garrett Varenhorst        
Github: https://github.com/GVarenhorst  
LinkedIn: https://www.linkedin.com/in/garrett-varenhorst-a734b466

