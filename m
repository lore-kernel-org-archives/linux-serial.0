From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 1/2] printk: Unconditionally unregister boot consoles if
 in init section
Date: Fri, 7 Jul 2017 13:45:37 +0900
Message-ID: <20170707044537.GB7478@jagdpanzerIV.localdomain>
References: <1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On (07/06/17 11:38), Matt Redfearn wrote:
> Commit 4c30c6f566c0 ("kernel/printk: do not turn off bootconsole in
> printk_late_init() if keep_bootcon") added a check on keep_bootcon to
> ensure that boot consoles were kept around until the real console is
> registered.
> This can lead to problems if the boot console data and code are in the
> init section, since it can be freed before the boot console is
> deregistered. This was fixed by commit 81cc26f2bd11 ("printk: only
> unregister boot consoles when necessary").
> The keep_bootcon flag prevents the unregistration of a boot console,
> even if it's data and code reside in the init section and are about to
> be freed. This can lead to crashes and weird panics when the bootconsole
> is accessed after free, especially if page poisoning is in use and the
> code / data have been overwritten with a poison value.
> To prevent this, always free the boot console if it is within the init
> section.
> 
> Fixes 81cc26f2bd11 ("printk: only unregister boot consoles when necessary").
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

well... hm. don't specify `keep_bootcon' if your bootcon access initdata?
keeping `early_printk' sometimes can be helpful and people even want to
use `early_printk' as a panic() console fallback (because of those nasty
deadlocks that spoil printk->call_console_drivers()).

if someone asked to `keep_bootcon' but we actually don't keep it, then
what's the purpose of the flag and
	pr_info("debug: skip boot console de-registration.\n")?


> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index a1db38abac5b..b5411f44eed4 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2660,7 +2660,7 @@ static int __init printk_late_init(void)
>  	int ret;
>  
>  	for_each_console(con) {
> -		if (!keep_bootcon && con->flags & CON_BOOT) {
> +		if (con->flags & CON_BOOT) {
>  			/*
>  			 * Make sure to unregister boot consoles whose data
>  			 * resides in the init section before the init section

what about bootconsoles that are still not getting de-registered due
to keep_bootcon in register_console()?

	-ss
