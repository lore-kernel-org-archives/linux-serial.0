From: schivers@csc.com (Stephen Chivers)
Subject: Re: Linux-3.15-rcX - PowerPC Serial Console woes.
Date: Sat, 03 May 2014 13:44:38 +1000
Message-ID: <20140503034439.2F4F6E0266@canberra.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail86.messagelabs.com ([216.82.242.179]:54698 "EHLO
	mail86.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbaECDqy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 May 2014 23:46:54 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: geert@linux-m68k.org
Cc: cproctor@csc.com, linux-serial@vger.kernel.org, schivers@csc.com

=EF=BB=BFGeert,

> From: Geert Uytterhoeven <geert@linux-m68k.org>
> To: Stephen N Chivers <schivers@csc.com.au>
> Cc: Chris Proctor <cproctor@csc.com.au>, linux-serial@vger.kernel.org
> Date: 05/02/2014 12:05 AM
> Subject: Re: Linux-3.15-rcX - PowerPC Serial Console woes.
> Sent by: geert.uytterhoeven@gmail.com
>=20
> Hi Stephen
>=20
> CC linux-serial
>=20
> On Thu, May 1, 2014 at 11:54 AM, Stephen N Chivers=20
> <schivers@csc.com.au> wrote:
> > Geert,
> >
> > I have a brace of PowerPC computers, most of which are
> > VME Single boards (MVME5100 and MVME4100),
> > but I also have some MPC8349MITX and a SAM440EP.
> >
> > They are all operated diskless from a file server.
> >
> > None of them have a graphical consoles and so as usual
> > I am quite reliant on the serial console.
> >
> > I am having problems with the unexpected disabling of the
> > serial console during the boot process.
> >
> > In all Linux-3.15 release candidates the serial console
> > is disabled during the boot process when the OF Platform
> > devices are registering.
> >
> > I will use the SAM440EP as an example, it is setup using
> > a defaultish configuration with, 8250 uarts configured,
> > serial console support, early printk, the "standardish"
> > UDBG console and the OF platform devices.
> >
> > The disabling of the serial console leads to the loss of
> > boot messages, this is ok for my present configuration as
> > (fortunately) the root file system is mounted and so the
> > boot messages are in /var/log/messages.
> >
> > The tty (ttyS0) device is around as after the machine has gone to
> > run state 3, the console login prompt is present without
> > problems.
> >
> > What is going on is:
> >
> > UDBG does its stuff ok. It is the console:
> >
> > bootconsole [udbg0] enabled
> >
> > The 8250 driver wakes up:
> >
> > Serial: 8250/16550 driver, 10 ports, IRQ sharing disabled
> > serial8250.0: ttyS0 at MMIO 0xef600300 (irq =3D 16, base_baud =3D 5=
09259)=20
is a
> > 16550A
> > console [ttyS0] enabled
> > console [ttyS0] enabled
> > bootconsole [udbg0] disabled
> > bootconsole [udbg0] disabled
>=20
> Here the legacy 8250 driver takes over, as expected.
>=20
> > serial8250.0: ttyS1 at MMIO 0xef600400 (irq =3D 17, base_baud =3D 5=
09259)=20
is a
> > 16550A
> > serial8250.0: ttyS2 at MMIO 0xef600500 (irq =3D 18, base_baud =3D 5=
09259)=20
is a
> > 16550A
> > serial8250.0: ttyS3 at MMIO 0xef600600 (irq =3D 19, base_baud =3D 5=
09259)=20
is a
> > 16550A
> > 0000:00:0c.0: ttyS4 at I/O 0x2000 (irq =3D 25, base_baud =3D 921600=
) is a
> > 16550A
> > 0000:00:0c.0: ttyS5 at I/O 0x2008 (irq =3D 25, base_baud =3D 921600=
) is a
> > 16550A
> >
> > The OF PLATFORM devices kick and disable the serial console:
> >
> > console [ttyS0] disabled
>=20
> Here the OF 8250 driver takes over.
>=20
> > now, the OF serial devices are:
> >
> > ef600300.serial: ttyS0 at MMIO 0xef600300 (irq =3D 16, base_baud =3D=
=20
509259)
> > is a 16550
> > ef600400.serial: ttyS1 at MMIO 0xef600400 (irq =3D 17, base_baud =3D=
=20
509259)
> > is a 16550
> > ef600500.serial: ttyS2 at MMIO 0xef600500 (irq =3D 18, base_baud =3D=
=20
509259)
> > is a 16550
> > ef600600.serial: ttyS3 at MMIO 0xef600600 (irq =3D 19, base_baud =3D=
=20
509259)
> > is a 16550
> >
> > when the devices are registered as part of the platform device prob=
e,
> > serial8250_register_8250_port in 8250_core.c finds that these devic=
es
> > match the earlier ones and so the lines that read:
> >
> > if (uart->port.dev)
> > uart_remove_one_port(&serial8250_reg, &uart->port);
> >
> > are executed. Now uart_remove_one_port calls unregister_console,
> > and that is where the console get disabled.
> >
> > In Linux-3.14 uart_remove_one_port does not call unregister_console
> > and so for that release the serial console remains active.
>=20
> That's correct.
>=20
> It was added in commit 5f5c9ae56c38942623f69c3e6dc6ec78e4da2076
> Author: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Date:   Fri Feb 28 14:21:32 2014 +0100
>=20
>     serial_core: Unregister console in uart_remove_one_port()
>=20
> which fixed a crash on driver rmmod.
>=20
> > Taking CONFIG_OF_PLATFORM out of the configuration fixes this
> > problem. But, shouldn't serial8250_register_8250_port leave things
> > as they are if the ports match? I tried a few things along those li=
nes
> > but the results are truly bad (the machine goes done to a "monitor"
> > that isn't U-Boot).
>=20
> I also don't like how the OF serial driver tries to unregister and
> register the same port.
>=20
> Currently this indeed removes the serial console, just like when doin=
g
> a driver unbind or rmmod, followed by a bind or insmod.
>=20
> But this case is different, as no driver is actually unloaded.
> Can you check why the register_console() in uart_configure_port() is =
not
> called? If it's just due to a simple flag having the wrong state, per=
haps
> it can be fixed easily.
See below.
>=20
> Is it due to port->type being reset to PORT_UNKNOWN in
> uart_remove_one_port()? It seems port->type should already have the
> right value when calling uart_add_one_port().
Yes, it is due to the port type being set to PORT_UNKNOWN in
uart_remove_one_port.

I have found that of_serial does not set the port type
in of_platform_serial_probe before it calls
serial8250_register_8250_port:

	#ifdef CONFIG_SERIAL_8250
	case PORT_8250 ... PORT_MAX_8250:
	{
		struct uart_8250_port port8250;
		memset(&port8250, 0, sizeof(port8250));
		port8250.port =3D port;

Adding:

		port.port_type =3D port_type

immediately before the assignment:

		port8250.port =3D port;

is a partial fix. That helps to get into the stretch of code
in uart_configure_port that would register the console. But
the console is not registered as it is already enabled:

	if (port->cons && !(port->cons->flags & CON_ENABLED))
		  register_console(port->cons);

That is because when the console is disabled by the call to
unregister_console, the CON_ENABLED flag is not reset.

Adding:

	console->flags &=3D ~CON_ENABLED;

to unregister_console immediately before the console is
unlocked fixes that.

I have tested these two changes and they work for my
configurations. But, the disable/enabling of the console
is a bit ugly:

	console [ttyS0] disabled
	console [ttyS0] enabled

If something truly unfortunate occurs while the console
is disabled it may never be observed......

The alternative is to add a call to console_stop
immediately prior to deregistering the console
in uart_remove_one_port. That would reset the
CON_ENABLED bit.

No other clients of unregister_console call console_stop
immediately prior to calling unregister_console.

Opinions?

The following (tentative) patch against 3.15-rc3 fixes the two problems=
=2E

 drivers/tty/serial/of_serial.c |    1 +
 kernel/printk/printk.c         |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_ser=
ial.c
index 9924660..27981e2 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -173,6 +173,7 @@ static int of_platform_serial_probe(struct platform=
_device *ofdev)
 	{
 		struct uart_8250_port port8250;
 		memset(&port8250, 0, sizeof(port8250));
+		port.type =3D port_type;
 		port8250.port =3D port;
=20
 		if (port.fifosize)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a45b509..81c7161 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2413,6 +2413,7 @@ int unregister_console(struct console *console)
 	if (console_drivers !=3D NULL && console->flags & CON_CONSDEV)
 		console_drivers->flags |=3D CON_CONSDEV;
=20
+	console->flags &=3D ~CON_ENABLED;
 	console_unlock();
 	console_sysfs_notify();
 	return res;

>
> Thanks!
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>=20
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like=20
> that.
>                                 -- Linus Torvalds

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
