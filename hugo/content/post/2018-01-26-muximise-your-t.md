---
date: 2018-01-26T21:21:49Z
title: Muximise Your T
url: /2018/01/26/muximise-your-t/
---

Dear future me,

Please find the helpful screenshot below when (not if) you once again forget how to configure [tmux](https://github.com/tmux/tmux/wiki) colors. I know you're not doing it for the eye candy but for telling apart different environments and something similarly productivity enhancing.

![Relevant part of tmux configuration](/images/tmuxicorn.png)

Here is the relevant bit again for easier reproducibility:

```
set-option -g status-style 'bg=magenta fg=cyan'
set-option -g window-status-style 'bg=blue fg=white'
set-option -g window-status-activity-style 'bg=green fg=red'
set-option -g window-status-current-style 'bg=yellow fg=black'
set-option -g window-status-last-style 'bg=white fg=green'
```
