---
date: 2014-01-21T20:52:51Z
title: Never Doubt Tmux
url: /2014/01/21/never-doubt-tmux/
---

Was consistenly running into a minor annoyance when using tmux in different environments, which is; tmux stops to respond to the prefix key, only when after a detach and re-attach the prefix key is usable again. Suspected this was an obscure bug since there was no mention of a similar case anywhere on the Internet. Finally managed to track down the issue; somehow it took me months to realize this issue only occurs when trying to copy/paste something from tmux buffer into X clipboard with the following key bindings:


    bind C-c run "tmux show-buffer | xclip -i -selection clipboard"
    bind C-v run "tmux set-buffer -- \"$(xclip -o -selection clipboard)\"; tmux paste-buffer"


Not sure about what causes this behaviour, but instead of debugging it, removed those lines from `.tmux.conf` and began to use dmenu for tmux buffer-clipboard syncronization operations. Which is done in the following uber primitive manner:

    tmux list-buffers | awk -F '"' '{print $2}' | dmenu -p 'tmux buffers' -l 10
    
However, sometimes recently closed panes are still displayed in the status bar thingy until some kind of refresh, that one surely must be a bug.


Update: Apparently, `tmux list-buffers` only displays a portion of the buffers, which is at most 50 characters long. So, behold the ever increasing primitiveness:


    desired_buffer=$(tmux list-buffer | dmenu -p 'tmux buffers' -i -l 15 | awk -F ':' '{print $1}')
    tmux show-buffer -b $desired_buffer | xclip -i -selection clipboard