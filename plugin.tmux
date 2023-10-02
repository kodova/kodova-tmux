#!/usr/bin/env fish

set -g tmuxCommands

set -g color_bg "black"
set -g color_fg "white"

set -g thm_msg_bg "black"
set -g thm_msg_fg "cyan"

set -g thm_pane_border "gray"
set -g thm_pane_active_border "cyan"

set -g thm_win_num_bg "white"
set -g thm_win_num_fg "black"
set -g thm_win_bg "black"
set -g thm_win_fg "cyan"

set -g thm_win_active_bg "cyan"
set -g thm_win_active_fg "black"

set -g thm_sess_bg "red"
set -g thm_sess_fg "black"

set -g thm_time_bg "blue"
set -g thm_time_fg "black"

set -g thm_dir_bg "yellow"
set -g thm_dir_fg "black"


function tset
    t "set $argv[1] \"$argv[2]\""
end

function wset
    t "set-window-option -gq $argv[1] \"$argv[2]\""
end

function oset
    t "set-option -ga $argv[1] \"$argv[2]\""
end


function t
    set -ag tmuxCommands "tmux $argv[1]"
end

function main
    #status
    tset status "on"
    tset status-bg $color_bg
    tset status-justify "left"
    tset status-left-length "100"
    tset status-right-length "100"

    # messages
    tset message-style "fg=$thm_msg_fg,bg=$thm_msg_bg"
    tset message-command-style "fg=$thm_msg_fg,bg=$thm_msg_bg"

    # panes
    tset pane-border-style "fg=$thm_pane_border"
    tset pane-active-border-style "fg=$thm_pane_active_border"

    # # windows
    wset window-status-activity-style "fg=$thm_win_fg,bg=$thm_win_bg,none"
    wset window-status-separator ""
    wset window-status-style "fg=$thm_win_fg,bg=$thm_win_bg,none"
    
    wset window-status-current-format "#[fg=black,bg=brightcyan] #I #[fg=white,bg=black] #W "
    wset window-status-format "#[fg=black,bg=white] #I #[fg=white,bg=black] #W "

    set dir_status "#[fg=$thm_dir_bg,bg=$color_bg] #[fg=$thm_dir_fg,bg=$thm_dir_bg] #{pane_current_path} "
    set time_status "#[fg=$thm_time_bg,bg=$thm_dir_bg] #[fg=$thm_time_fg,bg=$thm_time_bg] #(TZ=UTC date +%%H:%%M\ %%m/%%d) "
    set session_status "#[fg=$thm_sess_bg,bg=$thm_time_bg] #[fg=$thm_sess_fg,bg=$thm_sess_bg] #S "
    

    # reset
    tmux set-option -g status-right ""
    oset status-right "$dir_status$time_status$session_status"

        

    for command in $tmuxCommands
        # echo $command
        eval $command
    end
end

main $argv
