From: Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Tue, 9 May 2017 10:29:15 +0200
Message-ID: <20170509082915.GA13236@bistromath.localdomain>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170405202006.18234-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Aleksey,

2017-04-05, 23:20:00 +0300, Aleksey Makarov wrote:
> If a console was specified by ACPI SPCR table _and_ command line
> parameters like "console=ttyAMA0" _and_ "earlycon" were specified,
> then log messages appear twice.
> 
> The root cause is that the code traverses the list of specified
> consoles (the `console_cmdline` array) and stops at the first match.
> But it may happen that the same console is referred by the elements
> of this array twice:
> 
> 	pl011,mmio,0x87e024000000,115200 -- from SPCR
> 	ttyAMA0 -- from command line
> 
> but in this case `preferred_console` points to the second entry and
> the flag CON_CONSDEV is not set, so bootconsole is not deregistered.
> 
> To fix that, introduce an invariant "The last non-braille console
> is always the preferred one" on the entries of the console_cmdline
> array.  Then traverse it in reverse order to be sure that if
> the console is preferred then it will be the first matching entry.
> Introduce variable console_cmdline_cnt that keeps the number
> of elements of the console_cmdline array (Petr Mladek).  It helps
> to get rid of the loop that searches for the end of this array.

That's caused a change of behavior in my qemu setup, with this cmdline

    root=/dev/sda1 console=ttyS1 console=ttyS0

Before, the kernel logs appeared on ttyS1, and I logged in with ttyS0
(with my setup, ttyS1 is a file and ttyS0 is unix socket). Now, the
kernel logs go to ttyS0. I need to swap the two console= parameters to
restore behavior.

There might be some other problem (in qemu?) though, because adding
console=tty0 anywhere on that cmdline makes the logs appear on both
tty0 and one ttyS* (but only one of them, and the ordering of the
ttyS* matters).


Thanks,

-- 
Sabrina
