From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Thu, 1 Jun 2017 14:03:25 +0200
Message-ID: <20170601120325.GA25497@pathway.suse.cz>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170509082915.GA13236@bistromath.localdomain>
 <20170511082433.GA421@jagdpanzerIV.localdomain>
 <20170511084158.GB421@jagdpanzerIV.localdomain>
 <20170512125729.GO3452@pathway.suse.cz>
 <7d312633-d040-240d-ec06-ed296b5251ae@linaro.org>
 <20170518154918.GE8621@pathway.suse.cz>
 <4e679bec-4804-9791-fc2b-0e96ad67d511@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4e679bec-4804-9791-fc2b-0e96ad67d511@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri 2017-05-26 12:37:12, Aleksey Makarov wrote:
> 
> 
> On 05/18/2017 06:49 PM, Petr Mladek wrote:
> >On Sun 2017-05-14 23:37:50, Aleksey Makarov wrote:
> >>
> >>
> >>On 05/12/2017 03:57 PM, Petr Mladek wrote:
> >>>On Thu 2017-05-11 17:41:58, Sergey Senozhatsky wrote:
> I meant that it is difficult to fix the bug that only one line
> (first matched) of registered console device receives kernel logs.
> That is because of 'index' field of struct console can refer to only one
> tty line.

I think that bigger problem is that con->match() functions have
side effects and we could not try matching all consoles
mentioned in console_cmdline. Otherwise, we would be able
to enable all mentioned ttyS* drivers that are listed.


> - The reason why logs appear twice is that earlycon is not
> deregistered after non-early consoles are available.

OK

> - Earlycon is not deregistered because in some cases
> flag CON_CONSDEV is not set for any of the new non-early
> consoles.

This is one explanation. Another reason might be that
an early console is added into console_cmdline by mistake.
By other words, if early consoles are not mentioned in
console_cmdline we could not mismatch them with the normal
console. See below for more on this idea.


> - That flag is not set when two entries of console_cmdline
> array refer to the same console.  We match the first entry,
> it is not preferred and the flag CON_CONSDEV is set only
> for preferred console.
> 
> - So I changed the order of array walk so that if there
> are two entries referring to the same console, last one is matched.
> If we specify a console as prefered (last entry in command line)
> that means that we expect a driver will eventually register
> its console and for that driver we will match the last
> entry and the earlycon will be deregistered.

This still handles the problem only for the preferred (last entry
in command line) console. In theory, there might be more consoles
listed twice.


> - The subtle question is why we deregister earlycon only
> when CON_CONSDEV is set (i. e. only for preferred console).
> That check for CON_CONSDEV was initially introduced in
> 
> d37bf60de0b4 console: console handover to preferred console
> 
> and then refactored in
> 
> 4d09161196c9 printk: Enable the use of more than one CON_BOOT (early console)
> 8259cf434202 printk: Ensure that "console enabled" messages are printed on the console
> 
> The reason is that some consoles can be registered later or earlier
> and if we deregister earlycon when the first non-early console
> is registered, we can lose some lines of log.  To prevent that
> we specify the console *which is being watched* as preferred
> (the last console in the console_cmdline array) and
> deregister earlycon only when kernel registers its driver.

Good to know. Thanks a lot for the archaeology.


> >BTW: I wonder if we really need to add consoles defined by ACPI SPCR
> >table into the console_cmdline array.
> 
> The console_cmdline array is the place where we add descriptions
> of consoles that should receive log output. ACPI SPCR specifies exactly
> that information, and I believe it should go to that array.

Are consoles defined by earlycon= command line parameter
added to console_cmdline? I do not see this anywhere in
the following functions:

  + param_setup_earlycon()
  + setup_earlycon()
  + register_earlycon()
  + early_init_dt_scan_chosen_stdout()
  + of_setup_earlycon()

IMHO, the main question is whether the console defined by
ACPI SPCR is early or normal one. IMHO, it is early console
and it should be handled the same way as the other early
consoles.


> >I am even more curious when
> >seeing the following code in drivers/acpi/spcr.c:
> >
> >int __init parse_spcr(bool earlycon) { [...] if (earlycon)
> >setup_earlycon(opts);

setup_early() calls register_earlycon() when the console is
found in __earlycon_table. Then it calls register_console().

I guess that the console is enabled here because we do not
have preferred cosole when this is called. Therefore it is
enabled by the following code:

	/*
	 *	See if we want to use this console driver. If we
	 *	didn't select a console we take the first one
	 *	that registers here.
	 */
	if (!has_preferred) {
		if (newcon->index < 0)
			newcon->index = 0;
		if (newcon->setup == NULL ||
		    newcon->setup(newcon, NULL) == 0) {
			newcon->flags |= CON_ENABLED;
			if (newcon->device) {
				newcon->flags |= CON_CONSDEV;
				has_preferred = true;
			}

Note that it gets enabled without being listed in console_cmdline.

> >err = add_preferred_console(uart, 0, opts + strlen(uart) + 1); }

Then it is added to the console_cmdline after being enabled.
Let's discuss why below.

> >Do we really need to call add_preferred_console() for
> these early consoles?
> 
> Yes we need.

Why exactly?

> When we setup an earlycon, we enable output
> to that console immediately.  Drivers can register its real
> non-early consoles much later so we just add description
> of that consoles to the console_cmdline arraly so that
> when the driver registers a matching driver, earlycon is replaced
> by a regular device.

console_cmdline is used to match the newly registered consoles.
If it matches and newcon->setup() succeeds, the console is enabled.
Why do we need to match the new consoles with the already
registered and enabled one?

Please, note that the early consoles are disabled using
the "console_drivers" list. They do not need to be listed in
"console_cmdline" to be disabled.

Do I miss something?

Best Regards,
Petr
