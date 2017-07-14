From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/2] printk/console: Enhance the check for consoles using
 init memory
Date: Sat, 15 Jul 2017 07:06:26 +0900
Message-ID: <20170714220626.GB10437@tigerII.localdomain>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
 <1500036673-7122-3-git-send-email-pmladek@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500036673-7122-3-git-send-email-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Fabio M. Di Nitto" <fdinitto@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (07/14/17 14:51), Petr Mladek wrote:
[..]
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f35d3ac3b8c7..1ebe1525ef64 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2659,8 +2659,16 @@ static int __init printk_late_init(void)
>  	int ret;
>  
>  	for_each_console(con) {
> -		if ((con->flags & CON_BOOT) &&
> -		    init_section_intersects(con, sizeof(*con))) {
> +		if (!(con->flags & CON_BOOT))
> +			continue;
> +
> +		/* Check addresses that might be used for enabled consoles. */
> +		if (init_section_intersects(con, sizeof(*con)) ||
> +		    init_section_contains(con->write, 0) ||
> +		    init_section_contains(con->read, 0) ||
> +		    init_section_contains(con->device, 0) ||
> +		    init_section_contains(con->unblank, 0) ||
> +		    init_section_contains(con->data, 0)) {

sort of a problem here is that the next time anyone adds a new ->foo()
callback to struct console, that person also needs to remember to update
printk_late_init().


a completely crazy idea,
can we have a dedicated "console init" section which we will not offload
if we see keep_bootcon?

or... even crazier... disable bootmem offloading (do not offload init
section) at all if we see keep_bootcon? keep_bootcon is a purely debugging
option which people enable when things are bad and unclear, no one should
be using it otherwise, so may be that idea can be a way to go.

thoughts?

	-ss
