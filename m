From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/1] tty: Fix pty master poll() after slave closes
Date: Thu, 09 Oct 2014 12:08:55 -0400
Message-ID: <5436B317.3060208@hurleysoftware.com>
References: <20141008192746.5F9C8485A77@fruggeri-Arora18.sjc.aristanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:52665 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751197AbaJIQI7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Oct 2014 12:08:59 -0400
In-Reply-To: <20141008192746.5F9C8485A77@fruggeri-Arora18.sjc.aristanetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Francesco Ruggeri <fruggeri@aristanetworks.com>, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: fruggeri@arista.com

On 10/08/2014 03:27 PM, Francesco Ruggeri wrote:
> Commit f95499c3030f ("n_tty: Don't wait for buffer work in read() loop")
> introduces a race window where a pty master can be signalled that the pty
> slave was closed before all the data that the slave wrote is delivered.
> Commit f8747d4a466a ("tty: Fix pty master read() after slave closes") fixed the
> problem in case of n_tty_read, but the problem still exists for n_tty_poll.

Hi Francesco,

Thanks for the report and the patch.

I've been testing a different approach for about week now which waits in
pty_close() for input processing to complete before setting TTY_OTHER_CLOSED.
This change also gets rid of the nested sleep problem in n_tty_read().

But this required some extensive changes, including inverting an existing
lock order (which needed to be done anyway), so won't be appropriate for stable.
In which case, something like this patch might be.

Comments below.

> This can be seen by running 'for ((i=0; i<100;i++));do ./test.py ;done'
> where test.py is:
> 
> import os, select, pty
> 
> (pid, pty_fd) = pty.fork()
> 
> if pid == 0:
>    os.write(1, 'This string should be received by parent')
> else:
>    poller = select.epoll()
>    poller.register( pty_fd, select.EPOLLIN )
>    ready = poller.poll( 1 * 1000 )
>    for fd, events in ready:
>       if not events & select.EPOLLIN:
>          print 'missed POLLIN event'
>       else:
>          print os.read(fd, 100)
>    poller.close()
> 
> The string from the slave is missed several times.
> This patch takes the same approach as the fix for read and special cases
> this condition for poll.
> Tested on 3.16.
> 
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> ---
>  drivers/tty/n_tty.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index f44f1ba..cf16aeb 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -2413,14 +2413,16 @@ static unsigned int n_tty_poll(struct tty_struct *tty, struct file *file,
>  
>  	poll_wait(file, &tty->read_wait, wait);
>  	poll_wait(file, &tty->write_wait, wait);
> -	if (input_available_p(tty, 1))
> -		mask |= POLLIN | POLLRDNORM;
>  	if (tty->packet && tty->link->ctrl_status)
>  		mask |= POLLPRI | POLLIN | POLLRDNORM;
>  	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
>  		mask |= POLLHUP;
>  	if (tty_hung_up_p(file))
>  		mask |= POLLHUP;
> +	if (mask & POLLHUP)
> +		tty_flush_to_ldisc(tty);

This isn't necessary for the tty_hung_up_p() case because, when the
poll() is woken from hangup, the read buffer has already been flushed (ie.,
cleared).

Plus, this waits even if input_available_p() would already return true.

So, I think either
1. setting both POLLIN and POLLHUP when TTY_OTHER_CLOSED is set (which would
at least prompt a subsequent read() which would wait for input processing to
complete), or,
2. performing the tty_flush_to_ldisc() only if TTY_OTHER_CLOSED is set, and
then re-checking input_available_p(), just as n_tty_read() does

Regards,
Peter Hurley

> +	if (input_available_p(tty, 1))
> +		mask |= POLLIN | POLLRDNORM;
>  	if (!(mask & (POLLHUP | POLLIN | POLLRDNORM))) {
>  		if (MIN_CHAR(tty) && !TIME_CHAR(tty))
>  			ldata->minimum_to_wake = MIN_CHAR(tty);
> 

