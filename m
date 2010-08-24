From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH RESEND 0/2] two serial_core suspend/resume fixes
Date: Tue, 24 Aug 2010 11:01:31 +0200
Message-ID: <1282640491.4910.35.camel@utx.lan>
References: <1282374882-6651-1-git-send-email-jason77.wang@gmail.com>
	 <1282593975.3526.9.camel@utx.lan>
	 <AANLkTikZgAMvODoFB9O9Mrb98f_xMatQfkb+2dgcrGJn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43413 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754188Ab0HXJBe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Aug 2010 05:01:34 -0400
In-Reply-To: <AANLkTikZgAMvODoFB9O9Mrb98f_xMatQfkb+2dgcrGJn@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jason wang <jason77.wang@gmail.com>
Cc: gregkh@suse.de, alan@linux.intel.com, arnd@arndb.de, linux-serial@vger.kernel.org

jason wang wrote:

>         Well, I experienced no_console_supend breakage on my PXA270
>         based Zaurus
>         SL-C3200 (terrier/spitz) as well.
>        =20
>         But your patches did not fix the behavior, serial port remain=
s
>         dead
>         after resume with no_console_supend.
> =20
> Very strange, I have validated these patches on ti_omap3530evm,
> fsl_imx31pdk and fsl_imx51pdk.
> They work fine.

Well, on spitz it worked in past early after 4547be7 applying, but does
not work in current vanilla. I don't yet see why.

Well, 4547be7 was created by disabling and enabling chunks using trial
and error method comparing result of two boots (with and without
no_console_suspend) and thinking what happened, maybe I did something
bad on omap. Just one resume chunk was removed: "short resume with
no_console_suspend" not going through the whole resume process.

> When we set no_console_suspend to bootargs,  the suspend process will
> skip most sub-callings in the
> serial_core.c->uart_suspend_port(), only call ops->tx_empty().  While
> in resume process, if without my
> first patch, it will call uart_change_pm(), ops->set_termios() and
> console_start(), these callings will make
> the console uart unusable, but if apply my first patch,  it will call
> nothing in the resume process. So
> apply my first patch will balance suspend and resume sub-callings.

I tried to boot:
- without no_console_suspend: works both with and without your patches
- with no_console_suspend: does not work both with and without your
  patches

So your patches surely don't mean a regression here.

> So i guess, your issue is not here. Maybe other parts(like gpio/clock=
)
> of suspend/resume affect your UART.

Yes, it is pretty well possible, but the breakage is triggered by the
no_console_suspend boot parameter as well.

My 4547be7 surely fixed no_console_suspend on Zaurus spitz, and OLPC XO
laptop. But over the time, no_console_suspend stopped to work again, at
least on spitz. I started to debug it independently on you (see below).

So here is the story:

b5b82df6 May 2007 breaks no_console_suspend on some ARM devices
  related ML subject:
  Possible suspend/resume regression in .32-rc?

4547be7  Dec 2009 fixes no_console_suspend on spitz and OLPC.
  related ML subject:
  serial-core: resume serial hardware with no_console_suspend

???????  ??? 2010 breaks no_console_suspend at least on spitz

your patch        fixes no_console_suspend on omap but not on spitz
  related ML subject:
  two serial_core suspend/resume fixes


Attaching my temporary debugging patch (tests done before applying your
patch).

Here is the output without no_console_suspend:
SUSPEND: 1 1 0 0
SUSPEND: 2
SUSPEND: 3
SUSPEND: 6
SUSPEND: 7
SUSPEND: 15
SUSPEND: 16
SUSPEND: 17
SUSPEND: 18
SUSPEND: 1 1 0 0
SUSPEND: 2
SUSPEND: 3
SUSPEND: 6
SUSPEND: 7
SUSPEND: 15
SUSPEND: 16
SUSPEND: 17
SUSPEND: 18
SUSPEND: 1 1 1 0
SUSPEND: 2
SUSPEND: 3
SUSPEND: 6
SUSPEND: 7
SUSPEND: 8
SUSPEND: 9
SUSPEND: 11
SUSPEND: 12
SUSPEND: 13
SUSPEND: 14
SUSPEND: 15
SUSPEND: 16
SUSPEND: 17
SUSPEND: 18
PM: suspend of devices complete after 311.219 msecs
PM: late suspend of devices complete after 0.615 msecs
PM: early resume of devices complete after 1458.544 msecs
RESUME: 1 1 1 1073741824
RESUME: 2
RESUME: 3
RESUME: 6
RESUME: 7
RESUME: 8
RESUME: 9
RESUME: 10
RESUME: 11
RESUME: 13
RESUME: 14
RESUME: 15
RESUME: 1 1 0 0
RESUME: 2
RESUME: 3
RESUME: 6
RESUME: 14
RESUME: 15
RESUME: 1 1 0 0
RESUME: 2
RESUME: 3
RESUME: 6
RESUME: 14
RESUME: 15

Here is the output with no_console_suspend (serial console was broken
after resume):
SUSPEND: 1 0 0 0
SUSPEND: 2
SUSPEND: 3
SUSPEND: 6
SUSPEND: 7
SUSPEND: 15
SUSPEND: 16
SUSPEND: 17
SUSPEND: 18
SUSPEND: 1 0 0 0
SUSPEND: 2
SUSPEND: 3
SUSPEND: 6
SUSPEND: 7
SUSPEND: 15
SUSPEND: 16
SUSPEND: 17
SUSPEND: 18
SUSPEND: 1 0 1 0
SUSPEND: 2
SUSPEND: 3
SUSPEND: 6
SUSPEND: 8
SUSPEND: 11
SUSPEND: 14
SUSPEND: 15
SUSPEND: 16
SUSPEND: 17
SUSPEND: 18
PM: suspend of devices complete after 358.314 msecs
PM: late suspend of devices complete after 0.637 msecs
PM: early resume of devices complete after 1453.923 msecs
RESUME: 1 0 1 0
RESUME: 2
RESUME: 3
RESUME: 6
RESUME: 7
RESUME: 8
RESUME: 14
RESUME: 15
RESUME: 1 0 0 0
RESUME: 2
RESUME: 3
RESUME: 6
RESUME: 14
RESUME: 15
RESUME: 1 0 0 0
RESUME: 2
RESUME: 3
RESUME: 6
RESUME: 14
RESUME: 15

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.=
c
index cd85112..6146712 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1983,25 +1983,35 @@ int uart_suspend_port(struct uart_driver *drv, =
struct uart_port *uport)
 	struct uart_match match =3D {uport, drv};
 	struct tty_struct *tty;
=20
+printk(KERN_INFO "SUSPEND: 1 %d %d %ld\n", console_suspend_enabled, ua=
rt_console(uport), port->flags & ASYNC_SUSPENDED);
 	mutex_lock(&port->mutex);
=20
+printk(KERN_INFO "SUSPEND: 2\n");
 	/* Must be inside the mutex lock until we convert to tty_port */
 	tty =3D port->tty;
=20
 	tty_dev =3D device_find_child(uport->dev, &match, serial_match_port);
+printk(KERN_INFO "SUSPEND: 3\n");
 	if (device_may_wakeup(tty_dev)) {
+printk(KERN_INFO "SUSPEND: 4\n");
 		enable_irq_wake(uport->irq);
 		put_device(tty_dev);
 		mutex_unlock(&port->mutex);
+printk(KERN_INFO "SUSPEND: 5\n");
 		return 0;
 	}
+printk(KERN_INFO "SUSPEND: 6\n");
 	if (console_suspend_enabled || !uart_console(uport))
+{
+printk(KERN_INFO "SUSPEND: 7\n");
 		uport->suspended =3D 1;
+}
=20
 	if (port->flags & ASYNC_INITIALIZED) {
 		const struct uart_ops *ops =3D uport->ops;
 		int tries;
=20
+printk(KERN_INFO "SUSPEND: 8\n");
 		if (console_suspend_enabled || !uart_console(uport)) {
 			set_bit(ASYNCB_SUSPENDED, &port->flags);
 			clear_bit(ASYNCB_INITIALIZED, &port->flags);
@@ -2011,13 +2021,17 @@ int uart_suspend_port(struct uart_driver *drv, =
struct uart_port *uport)
 			ops->set_mctrl(uport, 0);
 			ops->stop_rx(uport);
 			spin_unlock_irq(&uport->lock);
+printk(KERN_INFO "SUSPEND: 9\n");
 		}
=20
 		/*
 		 * Wait for the transmitter to empty.
 		 */
 		for (tries =3D 3; !ops->tx_empty(uport) && tries; tries--)
+{
+printk(KERN_INFO "SUSPEND: 10\n");
 			msleep(10);
+}
 		if (!tries)
 			printk(KERN_ERR "%s%s%s%d: Unable to drain "
 					"transmitter\n",
@@ -2026,20 +2040,30 @@ int uart_suspend_port(struct uart_driver *drv, =
struct uart_port *uport)
 			       drv->dev_name,
 			       drv->tty_driver->name_base + uport->line);
=20
+printk(KERN_INFO "SUSPEND: 11\n");
 		if (console_suspend_enabled || !uart_console(uport))
+{
+printk(KERN_INFO "SUSPEND: 12\n");
 			ops->shutdown(uport);
+printk(KERN_INFO "SUSPEND: 13\n");
+}
+printk(KERN_INFO "SUSPEND: 14\n");
 	}
=20
 	/*
 	 * Disable the console device before suspending.
 	 */
+printk(KERN_INFO "SUSPEND: 15\n");
 	if (console_suspend_enabled && uart_console(uport))
 		console_stop(uport->cons);
=20
+printk(KERN_INFO "SUSPEND: 16\n");
 	if (console_suspend_enabled || !uart_console(uport))
 		uart_change_pm(state, 3);
=20
+printk(KERN_INFO "SUSPEND: 17\n");
 	mutex_unlock(&port->mutex);
+printk(KERN_INFO "SUSPEND: 18\n");
=20
 	return 0;
 }
@@ -2052,26 +2076,35 @@ int uart_resume_port(struct uart_driver *drv, s=
truct uart_port *uport)
 	struct uart_match match =3D {uport, drv};
 	struct ktermios termios;
=20
+printk(KERN_INFO "RESUME: 1 %d %d %ld\n", console_suspend_enabled, uar=
t_console(uport), port->flags & ASYNC_SUSPENDED);
 	mutex_lock(&port->mutex);
+printk(KERN_INFO "RESUME: 2\n");
=20
 	tty_dev =3D device_find_child(uport->dev, &match, serial_match_port);
+printk(KERN_INFO "RESUME: 3\n");
 	if (!uport->suspended && device_may_wakeup(tty_dev)) {
+printk(KERN_INFO "RESUME: 4\n");
 		disable_irq_wake(uport->irq);
 		mutex_unlock(&port->mutex);
+printk(KERN_INFO "RESUME: 5\n");
 		return 0;
 	}
 	uport->suspended =3D 0;
=20
+printk(KERN_INFO "RESUME: 6\n");
 	/*
 	 * Re-enable the console device after suspending.
 	 */
 	if (uart_console(uport)) {
+printk(KERN_INFO "RESUME: 7\n");
 		uart_change_pm(state, 0);
 		uport->ops->set_termios(uport, &termios, NULL);
 		console_start(uport->cons);
+printk(KERN_INFO "RESUME: 8\n");
 	}
=20
 	if (port->flags & ASYNC_SUSPENDED) {
+printk(KERN_INFO "RESUME: 9\n");
 		const struct uart_ops *ops =3D uport->ops;
 		int ret;
=20
@@ -2079,7 +2112,9 @@ int uart_resume_port(struct uart_driver *drv, str=
uct uart_port *uport)
 		spin_lock_irq(&uport->lock);
 		ops->set_mctrl(uport, 0);
 		spin_unlock_irq(&uport->lock);
+printk(KERN_INFO "RESUME: 10\n");
 		if (console_suspend_enabled || !uart_console(uport)) {
+printk(KERN_INFO "RESUME: 11\n");
 			/* Protected by port mutex for now */
 			struct tty_struct *tty =3D port->tty;
 			ret =3D ops->startup(uport);
@@ -2097,14 +2132,18 @@ int uart_resume_port(struct uart_driver *drv, s=
truct uart_port *uport)
 				 * Clear the "initialized" flag so we won't try
 				 * to call the low level drivers shutdown method.
 				 */
+printk(KERN_INFO "RESUME: 12\n");
 				uart_shutdown(tty, state);
 			}
+printk(KERN_INFO "RESUME: 13\n");
 		}
=20
 		clear_bit(ASYNCB_SUSPENDED, &port->flags);
 	}
=20
+printk(KERN_INFO "RESUME: 14\n");
 	mutex_unlock(&port->mutex);
+printk(KERN_INFO "RESUME: 15\n");
=20
 	return 0;
 }


--=20
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarsk=E1 1060/12                            tel: +420 284 028 966
190 00 Praha 9                                fax: +420 284 028 951
Czech Republic                                http://www.suse.cz/

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
