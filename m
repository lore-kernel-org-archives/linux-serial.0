From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] serial: Fix wakeup init logic to speed up startup
Date: Thu, 19 Jan 2012 12:12:34 -0800
Message-ID: <20120119201234.GG2373@linux.vnet.ibm.com>
References: <1327001336-28703-1-git-send-email-sjg@chromium.org>
 <20120119194242.GE2373@linux.vnet.ibm.com>
 <CAPnjgZ0kB8L6fFrcjq_0MSoh7KkL-051JHYptNQMaZNi89MavQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0kB8L6fFrcjq_0MSoh7KkL-051JHYptNQMaZNi89MavQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 19, 2012 at 11:51:47AM -0800, Simon Glass wrote:
> Hi Paul,
>=20
> On Thu, Jan 19, 2012 at 11:42 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Thu, Jan 19, 2012 at 11:28:56AM -0800, Simon Glass wrote:
> >> The synchronize_rcu() call resulting from making every serial driv=
er
> >> wake-up capable (commit b3b708fa) slows boot down on my Tegra2x sy=
stem
> >> (with CONFIG_PREEMPT disabled).
> >>
> >> But this is avoidable since it is the device_set_wakeup_enable() a=
nd then
> >> subsequence disable which causes the delay. We might as well just =
make
> >> the device wakeup capable but not actually enable it for wakeup un=
til
> >> needed.
> >>
> >> Effectively the current code does this:
> >>
> >> =A0 =A0 =A0 device_set_wakeup_capable(dev, 1);
> >> =A0 =A0 =A0 device_set_wakeup_enable(dev, 1);
> >> =A0 =A0 =A0 device_set_wakeup_enable(dev, 0);
> >>
> >> We can just drop the last two lines.
> >>
> >> Before this change my boot log says:
> >> [ =A0 =A00.227062] Serial: 8250/16550 driver, 4 ports, IRQ sharing=
 disabled
> >> [ =A0 =A00.702928] serial8250.0: ttyS0 at MMIO 0x70006040 (irq =3D=
 69) is a Tegra
> >>
> >> after:
> >> [ =A0 =A00.227264] Serial: 8250/16550 driver, 4 ports, IRQ sharing=
 disabled
> >> [ =A0 =A00.227983] serial8250.0: ttyS0 at MMIO 0x70006040 (irq =3D=
 69) is a Tegra
> >>
> >> for saving of 450ms.
> >
> > You have multiple CPUs running at this point, correct? =A0Before th=
at
> > second CPU starts up, synchronize_rcu() is a no-op.
>=20
> Yes that's right, although I didn't get different behavior with 'nosm=
p'.

If you are running CONFIG_PREEMPT=3Dy, that is expected behavior, thoug=
h
that grace period is a bit on the long side.  What is the value of HZ?

On the other hand, if you are running CONFIG_PREEMPT=3Dn on recent kern=
els,
synchronize_rcu() will be a no-op any time that you are running with
only a single CPU.

The reason for this difference is that with CONFIG_PREEMPT=3Dy, there m=
ight
be a preempted RCU reader, and RCU must check for this condition, waiti=
ng
for any such reader to complete.  In contrast, when CONFIG_PREEMPT=3Dn =
on a
single-CPU system, the fact that you are executing in synchronize_rcu()
guarantees that there are no running RCU readers, so synchronize_rcu()
need do nothing in that case.

							Thanx, Paul

> > The patch looks good to me, but then again, I do not consider mysel=
f
> > qualified to have an opinion on the TTY layer. =A0;-)
>=20
> Thanks, me neither :-)
>=20
> Regards,
> Simon
>=20
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Thanx, Paul
> >
> >> Suggested-by: Rafael J. Wysocki <rjw@sisk.pl>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> ---
> >> =A0drivers/tty/serial/serial_core.c | =A0 =A06 +++---
> >> =A01 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial=
/serial_core.c
> >> index c7bf31a..1305618 100644
> >> --- a/drivers/tty/serial/serial_core.c
> >> +++ b/drivers/tty/serial/serial_core.c
> >> @@ -2348,11 +2348,11 @@ int uart_add_one_port(struct uart_driver *=
drv, struct uart_port *uport)
> >> =A0 =A0 =A0 =A0*/
> >> =A0 =A0 =A0 tty_dev =3D tty_register_device(drv->tty_driver, uport=
->line, uport->dev);
> >> =A0 =A0 =A0 if (likely(!IS_ERR(tty_dev))) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 device_init_wakeup(tty_dev, 1);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 device_set_wakeup_enable(tty_dev, 0);
> >> - =A0 =A0 } else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 device_set_wakeup_capable(tty_dev, 1);
> >> + =A0 =A0 } else {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Cannot register tty d=
evice on line %d\n",
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uport->line);
> >> + =A0 =A0 }
> >>
> >> =A0 =A0 =A0 /*
> >> =A0 =A0 =A0 =A0* Ensure UPF_DEAD is not set.
> >> --
> >> 1.7.7.3
> >>
> >
>=20
