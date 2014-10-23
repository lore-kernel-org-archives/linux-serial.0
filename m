From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 09/10] tty: serial: of-serial: Allow OF earlycon to
 default to "on"
Date: Thu, 23 Oct 2014 12:47:30 +0800
Message-ID: <CAL_JsqJbva6i5BwDMf9f0TcuToxzP2u9_oe1t92zQXJyS077oA@mail.gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
 <1413930186-23168-10-git-send-email-cernekee@gmail.com> <CAL_Jsq+AuqTOU7UFdYi28YGjL1QorY=3zOSccN43Vb1a=q6SHw@mail.gmail.com>
 <CAJiQ=7BrfnyOQYptBCTR8GP8hLq4+q1NQ2H988wHK=8PnkqLkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:64479 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaJWErw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Oct 2014 00:47:52 -0400
In-Reply-To: <CAJiQ=7BrfnyOQYptBCTR8GP8hLq4+q1NQ2H988wHK=8PnkqLkg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Oct 23, 2014 at 11:25 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> On Wed, Oct 22, 2014 at 2:27 AM, Rob Herring <robh@kernel.org> wrote:
>> On Wed, Oct 22, 2014 at 6:23 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
>>> On many development systems it is very common to see failures during the
>>> early stages of the boot process, e.g. SMP boot or PCIe initialization.
>>> This is one likely reason why some existing earlyprintk implementations,
>>> such as arch/mips/kernel/early_printk.c, are enabled unconditionally
>>> at compile time.
>>>
>>> Now that earlycon's operating parameters can be passed into the kernel
>>> via DT, it is helpful to be able to configure the kernel to turn it on
>>> automatically.  Introduce a new CONFIG_SERIAL_EARLYCON_FORCE option for
>>> this purpose.
>>
>> You can already force this using the CMDLINE_EXTEND option. I'm not
>> sure we need more options.
>
> Hi Rob,
>
> Now that earlycon can get all of its parameters from DT, do you think
> it might make sense to drop the command line option entirely from
> fdt.c and enable it all of the time if stdout-path is set correctly?
>
> From the user's standpoint, how important is it to be able to run
> without earlycon?

It may affect boot time for one although if you care you probably
disable console altogether.

I think we'd just have to add a noearlycon option instead if we made
it the default. It's never been the default before, so I don't think
we should change now. There's also an implicit requirement that the
bootloader has configured the uart already. You could easily hang if
the uart has not been setup.

>>>  void __init early_init_dt_scan_nodes(void)
>>>  {
>>> +#ifdef CONFIG_SERIAL_EARLYCON_FORCE
>>> +       if (early_init_dt_scan_chosen_serial() < 0)
>>> +               pr_warn("Unable to set up earlycon from stdout-path\n");
>>> +#endif
>>
>> Doesn't this make the earlycon get scanned and setup twice? Hopefully
>> that is safe...
>
> Patch 08/10 makes it safe.  Without Patch 08/10, specifying "earlycon
> earlycon" also generates a backtrace.
>
>> This also introduces the scanning at another point in time during boot
>> which may not work depending on the arch.
>
> Currently the sequence looks like:
>
>  - arch code calls early_init_dt_scan() to populate boot_command_line
> and memory ranges
>
>  - arch code might do some other stuff, possibly setting up page
> tables, register mappings, etc.

Yes, like the page table needed to map your earlycon uart.

>  - arch code calls parse_early_param() to look at the final command line
>
>  - parse_early_param() might call early_init_dt_scan_chosen_serial()
>
> So we're assuming that the arch code knows not to call
> parse_early_param() until the mappings are configured.  But this is an
> implicit requirement, and might not be totally obvious.  Since
> SERIAL_EARLYCON is enabled by the UART driver, not the arch code, it
> is possible that some platforms have ordering issues here that won't
> be discovered until somebody tries to use earlycon.

Right, if you enable earlycon and the architecture doesn't support it,
you will crash. This is not really new. Doing "earlycon=uart8250..."
on ARM will crash as long as the 8250 driver has supported that
option.

> Would it be more straightforward to have the arch code explicitly call
> early_init_dt_scan_chosen_serial() to indicate that it is ready for
> the early UART driver to run?

Yes, but then when do you handle earlycon command line option for
non-DT case? Having these at different points in time is asking for
problems.

Also, I've been trying to reduce the number of DT hooks into the arch
code, so adding that would be moving in the wrong direction.

Rob
