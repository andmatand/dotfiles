let ticket = matchstr(getline(5), 'On branch \zs[A-Z]\{3}-[0-9]\{1,4}\ze')

if !empty(ticket)
    call setline('.', '[' . ticket . '] ')
    call setpos('.', [0, 1, strlen(ticket) + 3])
endif
