From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Tue, 6 Jun 2017 16:31:49 +0200
Message-ID: <20170606143149.GB7604@pathway.suse.cz>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170509082915.GA13236@bistromath.localdomain>
 <20170511082433.GA421@jagdpanzerIV.localdomain>
 <20170511084158.GB421@jagdpanzerIV.localdomain>
 <20170512125729.GO3452@pathway.suse.cz>
 <7d312633-d040-240d-ec06-ed296b5251ae@linaro.org>
 <20170518154918.GE8621@pathway.suse.cz>
 <4e679bec-4804-9791-fc2b-0e96ad67d511@linaro.org>
 <20170601120325.GA25497@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170601120325.GA25497@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu 2017-06-01 14:03:25, Petr Mladek wrote:
> On Fri 2017-05-26 12:37:12, Aleksey Makarov wrote:
> > The console_cmdline array is the place where we add descriptions
> > of consoles that should receive log output. ACPI SPCR specifies exactly
> > that information, and I believe it should go to that array.
> 
> Are consoles defined by earlycon= command line parameter
> added to console_cmdline? I do not see this anywhere in
> the following functions:
> 
>   + param_setup_earlycon()
>   + setup_earlycon()
>   + register_earlycon()
>   + early_init_dt_scan_chosen_stdout()
>   + of_setup_earlycon()
> 
> IMHO, the main question is whether the console defined by
> ACPI SPCR is early or normal one.

The answer is that it depends. The console defined by ACPI
SPCR is early when just 'earlycon' is defined on the command
line. See param_setup_earlycon() and the use of
earlycon_init_is_deferred. Otherwise, it is supposed to
be a normal console.

We need to call add_preferred_console() in parse_spcr()
to allow using the console as a normal one.

We must also work correctly when the user explicitly defines
the console on the command line, using another alias.

As a result, we could not easily prevent having two matching consoles
in console_cmdline list. And as long as the last mentioned console
has the special status (preferred_console, CON_CONSDEV), it would
make sense to try matching the preferred console first.

Sadly, it causes the change of the behavior of ttyS0 and ttyS1.


Now, systemd seems to handle the console= parameters as well.
According to http://0pointer.de/blog/projects/serial-console.html,
systemd instantiates one serial-getty@.service on the preferred
(last mentioned) console.

This might be a reason to define both console=ttyS0 console=ttyS1
on the command line. People might actually want to get the logs
and the login prompt on different console.

Well, it is a bug that kernel shows the messages only on one
console.


There is one more thing that I found. Early consoles are forcefully
removed in a late_initcall(printk_late_init). It happens when they
use a code that is discarded after all initcalls finishes.
This has two effects.

First, boot consoles are removed even when the preferred one
is not registered. This explains why we need to call both
setup_earlycon() and add_preferred_console() in parse_spcr().

Second, the boot console might be removed before the normal/preferred
one is registered. For example, the normal one might be registered later
by a deferred probe call. As a result, the normal console might miss
that there was an early one, replays the entire log, and you
might see the beginning of the log twice.


All in all, I think that I have finally understood what
Aleksey wanted to say in his great summary, see
https://lkml.kernel.org/r/4e679bec-4804-9791-fc2b-0e96ad67d511@linaro.org
My proposed solution in parse_spcr() do not fly.

And I am still undecided about the Alexey's patch:

  + the patch makes some sense

  + but people might see the changed order as regressions;
    there might be more users, especially because of systemd

  + IMHO, the patch fixed the duplicit output only partly;
    it would not help when the normal console is registered
    later


Best Regards,
Petr
