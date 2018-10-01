From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG] sleep in atomic in 8250 runtime PM code path
Date: Mon, 1 Oct 2018 11:04:08 -0700
Message-ID: <20181001180408.GY5662@atomide.com>
References: <20180929132036.0323e24b@xhacker.debian>
 <20180929103045.GQ30658@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180929103045.GQ30658@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Phil Edworthy <phil.edworthy@renesas.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [180929 10:35]:
> On Sat, Sep 29, 2018 at 01:20:36PM +0800, Jisheng Zhang wrote:
> > Hi,
> > 
> > Recently I found I could trigger sleep in atomic bug on berlin after commit
> > d76c74387e1c ("serial: 8250_dw: Fix runtime PM handling"). The path looks like:
> > 
> > dw8250_probe => serial850_register_8250_port => uart_add_one_port=>
> > register_console => console_unlock => univ8250_console_write =>
> > serial8250_console_write => serial8250_rpm_get => pm_runtime_get_sync
> > 
> > The irq is disabled by printk_safe_enter_irqsave() in console_unlock, but
> > pm_runtime_get_sync can't be called in atomic context...
> > 
> > I guess the reason why we didn't notice it is due to the fact that
> > only OMAP and DW sets UART_CAP_RPM currently, and DW set the flag in
> > May 2018.
> > 
> > Per my understanding, the bug sits in the 8250 core driver rather than
> > 8250_dw.c.
> 
> (Adding Tony and Sebastian, presumably CAP_RPM comes from OMAP since
> that is the only other user, and this same bug is present there too.)

That only works because of pm_runtime_irq_safe() :( And we should not
use pm_runtime_irq_safe() at all IMO, it takes a permanent RPM usecount
on the parent device.

Adding also Andy to Cc as he's been working on related fixes.

> Correct.  printk() can be called from atomic contexts (consider what
> happens when an oops or similar occurs - we can be in any context,
> holding any locks etc.)  Plain printk() can also be used from within
> spinlocked irqs-off regions.
> 
> This means the console's write function may be called in these contexts.
> Since pm_runtime_get_sync() is may sleep, it means that its use in the
> console path is _fundamentally_ wrong, and will lead to exactly this
> problem.
> 
> I don't see a way around that other than to avoid RPM on consoles.
> (which makes the presence of the RPM code in serial8250_console_write()
> completely unnecessary.)

Yup the way to go is to have some way to attach/detach kernel serial
console via /sys, and have the serial layer take a usecount on the
serial driver RPM when kernel serial console is attached. Then the
user can detach serial console via /sys as needed and have RPM
working.

> When I rewrote the serial drivers and created serial_core & 8250, this
> is something that I realised, and I arranged the PM support at the time
> to always maintain the console in active state (this is prior to RPM).
> 
> While I'm looking at commit d74d5d1b7288 ("tty: serial: 8250_core: add
> run time pm"):
> 
> +static void serial8250_rpm_get_tx(struct uart_8250_port *p)
> +{
> +       unsigned char rpm_active;
> +
> +       if (!(p->capabilities & UART_CAP_RPM))
> +               return;
> +
> +       rpm_active = xchg(&p->rpm_tx_active, 1);
> +       if (rpm_active)
> +               return;
> +       pm_runtime_get_sync(p->port.dev);
> +}
> 
> is particularly "interesting" - if this is called from sections of
> code that allow it to be called concurrently from different contexts,
> then we could have:
> 
> rpm_tx_active	thread 0			thread 1
> 0
> 		xchg(, 1)
> 1
> 						xchg(, 1)
> 						... goes on to use port ...
> 		pm_runtime_get_sync()
> 
> In other words, the port can be used _before_ pm_runtime_get_sync() is
> called.
> 
> If, on the other hand, this can't race, then considering the
> serial8250_rpm_put_tx() path as well, what stops this race from
> happening:
> 
> rpm_tx_active	thread 0			thread 1
> 1
> 		serial8250_rpm_get_tx()
> 						serial8250_rpm_put_tx()
> 		xchg(, 1)
> 1
> 						xchg(, 0)
> 0
> 						pm_runtime_put_autosuspend()
> 
> Now to the real point about the above - if _neither_ race is possible,
> then what is the point of the more expensive xchg() here rather than
> simple test-and-assignment of rpm_tx_active?  Either these paths can't
> race with each other and xchg() is unnecessary, or they can and they
> _could_ fail as shown above.  My suspicion is that xchg() is an attempt
> to reduce the likelyhood of one of these races being hit.

Yeah the driver would need to maintain a is_suspended flag to prevent
that. See also the is_suspended related parts for runtime PM docs at
Documentation/power/runtime_pm.txt.

But let's just make the serial layer take RPM usecount on the
serial driver when console is in use and have some way for users
to attach and detach the kernel serial console via /sys to prevent
PM regressions.

Regards,

Tony
