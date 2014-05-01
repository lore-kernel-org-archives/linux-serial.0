From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Linux-3.15-rcX - PowerPC Serial Console woes.
Date: Thu, 1 May 2014 16:05:32 +0200
Message-ID: <CAMuHMdVzPSjtBBnWEXpeO-29qXsbCUEdL6mb=o6V2n9EfvufEA@mail.gmail.com>
References: <1397960791-16320-1-git-send-email-davidlohr@hp.com>
	<1397960791-16320-3-git-send-email-davidlohr@hp.com>
	<CAMuHMdVBZSC3Kvwsw5pa-m8ZAUCjpkF8gjJH1XbOK2iFbU1KEg@mail.gmail.com>
	<1398032896.19331.25.camel@buesod1.americas.hpqcorp.net>
	<CAMuHMdV5HKvzE6H_JCH=01med8mVuXbVBz92tpNk7poH4ymXOQ@mail.gmail.com>
	<OF5CEC4294.867C780E-ONCA257CCB.00315352-CA257CCB.003674E6@csc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:62847 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbaEAOFd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 May 2014 10:05:33 -0400
Received: by mail-pa0-f45.google.com with SMTP id kq14so3739439pab.4
        for <linux-serial@vger.kernel.org>; Thu, 01 May 2014 07:05:32 -0700 (PDT)
In-Reply-To: <OF5CEC4294.867C780E-ONCA257CCB.00315352-CA257CCB.003674E6@csc.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen N Chivers <schivers@csc.com.au>
Cc: Chris Proctor <cproctor@csc.com.au>, linux-serial@vger.kernel.org

Hi Stephen

CC linux-serial

On Thu, May 1, 2014 at 11:54 AM, Stephen N Chivers <schivers@csc.com.au> wrote:
> Geert,
>
> I have a brace of PowerPC computers, most of which are
> VME Single boards (MVME5100 and MVME4100),
> but I also have some MPC8349MITX and a SAM440EP.
>
> They are all operated diskless from a file server.
>
> None of them have a graphical consoles and so as usual
> I am quite reliant on the serial console.
>
> I am having problems with the unexpected disabling of the
> serial console during the boot process.
>
> In all Linux-3.15 release candidates the serial console
> is disabled during the boot process when the OF Platform
> devices are registering.
>
> I will use the SAM440EP as an example, it is setup using
> a defaultish configuration with, 8250 uarts configured,
> serial console support, early printk, the "standardish"
> UDBG console and the OF platform devices.
>
> The disabling of the serial console leads to the loss of
> boot messages, this is ok for my present configuration as
> (fortunately) the root file system is mounted and so the
> boot messages are in /var/log/messages.
>
> The tty (ttyS0) device is around as after the machine has gone to
> run state 3, the console login prompt is present without
> problems.
>
> What is going on is:
>
> UDBG does its stuff ok. It is the console:
>
> bootconsole [udbg0] enabled
>
> The 8250 driver wakes up:
>
> Serial: 8250/16550 driver, 10 ports, IRQ sharing disabled
> serial8250.0: ttyS0 at MMIO 0xef600300 (irq = 16, base_baud = 509259) is a
> 16550A
> console [ttyS0] enabled
> console [ttyS0] enabled
> bootconsole [udbg0] disabled
> bootconsole [udbg0] disabled

Here the legacy 8250 driver takes over, as expected.

> serial8250.0: ttyS1 at MMIO 0xef600400 (irq = 17, base_baud = 509259) is a
> 16550A
> serial8250.0: ttyS2 at MMIO 0xef600500 (irq = 18, base_baud = 509259) is a
> 16550A
> serial8250.0: ttyS3 at MMIO 0xef600600 (irq = 19, base_baud = 509259) is a
> 16550A
> 0000:00:0c.0: ttyS4 at I/O 0x2000 (irq = 25, base_baud = 921600) is a
> 16550A
> 0000:00:0c.0: ttyS5 at I/O 0x2008 (irq = 25, base_baud = 921600) is a
> 16550A
>
> The OF PLATFORM devices kick and disable the serial console:
>
> console [ttyS0] disabled

Here the OF 8250 driver takes over.

> now, the OF serial devices are:
>
> ef600300.serial: ttyS0 at MMIO 0xef600300 (irq = 16, base_baud = 509259)
> is a 16550
> ef600400.serial: ttyS1 at MMIO 0xef600400 (irq = 17, base_baud = 509259)
> is a 16550
> ef600500.serial: ttyS2 at MMIO 0xef600500 (irq = 18, base_baud = 509259)
> is a 16550
> ef600600.serial: ttyS3 at MMIO 0xef600600 (irq = 19, base_baud = 509259)
> is a 16550
>
> when the devices are registered as part of the platform device probe,
> serial8250_register_8250_port in 8250_core.c finds that these devices
> match the earlier ones and so the lines that read:
>
> if (uart->port.dev)
> uart_remove_one_port(&serial8250_reg, &uart->port);
>
> are executed. Now uart_remove_one_port calls unregister_console,
> and that is where the console get disabled.
>
> In Linux-3.14 uart_remove_one_port does not call unregister_console
> and so for that release the serial console remains active.

That's correct.

It was added in commit 5f5c9ae56c38942623f69c3e6dc6ec78e4da2076
Author: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Date:   Fri Feb 28 14:21:32 2014 +0100

    serial_core: Unregister console in uart_remove_one_port()

which fixed a crash on driver rmmod.

> Taking CONFIG_OF_PLATFORM out of the configuration fixes this
> problem. But, shouldn't serial8250_register_8250_port leave things
> as they are if the ports match? I tried a few things along those lines
> but the results are truly bad (the machine goes done to a "monitor"
> that isn't U-Boot).

I also don't like how the OF serial driver tries to unregister and
register the same port.

Currently this indeed removes the serial console, just like when doing
a driver unbind or rmmod, followed by a bind or insmod.

But this case is different, as no driver is actually unloaded.
Can you check why the register_console() in uart_configure_port() is not
called? If it's just due to a simple flag having the wrong state, perhaps
it can be fixed easily.

Is it due to port->type being reset to PORT_UNKNOWN in
uart_remove_one_port()? It seems port->type should already have the
right value when calling uart_add_one_port().

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
