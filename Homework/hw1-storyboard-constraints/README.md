# hw1-storyboard-constraints

This is the first homework assignment to get you stated with git & gitlab.
This is the repo you will submit with your Xcode project containing the storyboard assignment in your own UNI ID named branch.
Steps:

1) clone this repo to a suitable directory on your mac,
i.e.

<code>% cd ~/Desktop
% mkdir W4995
% cd W4995
% git clone git@gitlab.com:mobileappdevelopmentios/w4995-fall23/hw1-storyboard-constraints.git</code>


2) then create your own local git branch on your mac
i.e.

<code>% cd hw1-storyboard-constraints
% git checkout -b professorthomas (NOTE: please name your branch with your UNI ID)</code>

3) open Xcode & create a new Xcode project & save it to this directory on your Mac

4) make the storyboard changes in Xcode 

5) use the Xcode "Source code" menu to "Commit" your code submission

6) Then "push" the entire project from inside your local Xcode up to the repo
i.e.
use Xcode "Source code" menu again to "push" the local repo up to your branchname on remote (i.e. origin/myBranch) repo on Gitlab


That's it, you're done! (but double check this repo now has your branch added by opening your browser here again)

Alternative approach if you have already created the Xcode project on your local Mac before you cloned the repo

<code>% cd existing_Xcode_project
% git remote add origin https://gitlab.com/mobileappdevelopmentios/w4995-fall23/hw1-storyboard-constraints.git
% git checkout -b myCUNI
% git add .
% git commit -m "project done"
% git push</code>
