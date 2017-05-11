From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Thu, 11 May 2017 17:24:33 +0900
Message-ID: <20170511082433.GA421@jagdpanzerIV.localdomain>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170509082915.GA13236@bistromath.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170509082915.GA13236@bistromath.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org

On (05/09/17 10:29), Sabrina Dubroca wrote:
[..]
> That's caused a change of behavior in my qemu setup, with this cmdline
> 
>     root=/dev/sda1 console=ttyS1 console=ttyS0
> 
> Before, the kernel logs appeared on ttyS1, and I logged in with ttyS0
> (with my setup, ttyS1 is a file and ttyS0 is unix socket). Now, the
> kernel logs go to ttyS0. I need to swap the two console= parameters to
> restore behavior.
> 
> There might be some other problem (in qemu?) though, because adding
> console=tty0 anywhere on that cmdline makes the logs appear on both
> tty0 and one ttyS* (but only one of them, and the ordering of the
> ttyS* matters).

thanks for the report.

so we have ttyS1 first and ttyS0 last.
after commit in question, register_console() iterates console_cmdline
in reverse order so we see ttyS0 first, then we hit `if (newcon->index < 0)'
condition, set newcon to ttyS0, because we iterate in reverse order now, and
break out. so we enable ttyS0, instead of ttyS1.

previously, we iterated console_cmdline from index 0 and saw ttyS1 first.
so the same `if (newcon->index < 0)' condition would set newcone to ttyS1,
and, thus, we would enable ttyS1, not ttyS0.

	-ss
