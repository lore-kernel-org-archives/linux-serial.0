From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Wed, 7 Jun 2017 18:13:22 +0900
Message-ID: <20170607091322.GA568@jagdpanzerIV.localdomain>
References: <20170509082915.GA13236@bistromath.localdomain>
 <20170511082433.GA421@jagdpanzerIV.localdomain>
 <20170511084158.GB421@jagdpanzerIV.localdomain>
 <20170512125729.GO3452@pathway.suse.cz>
 <7d312633-d040-240d-ec06-ed296b5251ae@linaro.org>
 <20170518154918.GE8621@pathway.suse.cz>
 <4e679bec-4804-9791-fc2b-0e96ad67d511@linaro.org>
 <20170601120325.GA25497@pathway.suse.cz>
 <20170606143149.GB7604@pathway.suse.cz>
 <20170606160339.GC7604@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170606160339.GC7604@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (06/06/17 18:03), Petr Mladek wrote:
[..]
> From 142d75792d0df874e80493654311f69f6a1ca798 Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Tue, 6 Jun 2017 17:20:38 +0200
> Subject: [PATCH] Revert "printk: fix double printing with earlycon"
> 
> The commit cf39bf58afdaabc ("printk: fix double printing with earlycon")
> caused regression to users that define both console=ttyS1 and console=ttyS0
> on the command line, see
> https://lkml.kernel.org/r/20170509082915.GA13236@bistromath.localdomain
> 
> The kernel log messages always appeared only on one serial port. It is
> even documented in Documentation/admin-guide/serial-console.rst:
> 
> "Note that you can only define one console per device type (serial,
> video)."
> 
> The above mentioned commit changed the order in which the command line
> parameters are searched. As a result, the kernel log messages go to
> the last mentioned ttyS* instead of the first one.
> 
> We long thought that using two console=ttyS* on the command line
> did not make sense. But then we realized that console= parameters
> were handled also by systemd, see
> http://0pointer.de/blog/projects/serial-console.html
> 
> "By default systemd will instantiate one serial-getty@.service on
> the main kernel console, if it is not a virtual terminal."
> 
> where
> 
> "[4] If multiple kernel consoles are used simultaneously, the main
> console is the one listed first in /sys/class/tty/console/active,
> which is the last one listed on the kernel command line."
> 
> This puts the original report into another light. The system is running
> in qemu. The first serial port is used to store the messages into a file.
> The second one is used to login to the system via a socket. It depends
> on systemd and the historic kernel behavior.
> 
> By other words, systemd causes that it makes sense to define both
> console=ttyS1 console=ttyS0 on the command line. The kernel fix
> caused regression related to userspace (systemd) and need to be
> reverted.
> 
> In addition, it went out that the fix helped only partially.
> The messages still were duplicated when the boot console was
> removed early by late_initcall(printk_late_init). Then the entire
> log was replayed when the same console was registered as a normal one.
> 
> This reverts commit cf39bf58afdaabc0b86f141630fb3fd18190294e.

FWIW,

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


the whole thing is too fragile and, may be, it deserves a rewrite.

I agree with the decision to revert the patch. a user space visible
regression is a pretty annoying thing; even a rare one. it takes ~1-2
years until kernel release hits major vendors/users so the biggest part
of regressions might be years away, but in the meantime we can grow a
number of new setups that will depend on a new console= behavior. so
I'd prefer to revert early.

Petr, Aleksey, many thanks, good work.

	-ss
