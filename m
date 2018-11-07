From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/5] serial: Finish sysrq on qcom_geni; fix sysrq vs.
 lockdep on 8250
Date: Wed, 7 Nov 2018 21:54:59 +0200
Message-ID: <20181107195459.GQ10650@smile.fi.intel.com>
References: <20181030221107.79758-1-dianders@chromium.org>
 <20181107182349.GP10650@smile.fi.intel.com>
 <CAD=FV=Xyra4+cLB0J64+SWqCF=YKdEJpAuybQboYxOcfrdTeQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xyra4+cLB0J64+SWqCF=YKdEJpAuybQboYxOcfrdTeQg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Doug Anderson <dianders@chromium.org>
Cc: pmladek@suse.com, vigneshr@ti.com, linux-aspeed@lists.ozlabs.org, sergey.senozhatsky@gmail.com, Andrew Jeffery <andrew@aj.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Tony Lindgren <tony@atomide.com>, joel@jms.id.au, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Dan Carpenter <dan.carpenter@oracle.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Jeremy Kerr <jk@ozlabs.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 07, 2018 at 11:26:56AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Nov 7, 2018 at 10:23 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Oct 30, 2018 at 03:11:02PM -0700, Douglas Anderson wrote:
> > > I started out this series trying to make sysrq work over the serial
> > > console on qcom_geni_serial, then fell into a rat's nest.
> > >
> > > To solve the deadlock I faced when enabling sysrq I tried to borrow
> > > code from '8250_port.c' which avoided grabbing the port lock in
> > > console_write().  ...but since these days I try to run with lockdep on
> > > all the time, I found it caused an annoying lockdep splat (which I
> > > also reproduced on my rk3399 board).  ...so I instead changed my
> > > qcom_geni_serial solution to borrow code from 'msm_serial.c'
> > >
> > > I wasn't super happy with the solution in 'msm_serial.c' though.  I
> > > don't like releasing the spinlock there.  Not only is it ugly but it
> > > means we are unlocking / re-locking _all the time_ even though sysrq
> > > characters are rare.  ...so I came up with what I think is a better
> > > solution and then implemented it for qcom_geni_serial.
> > >
> > > Since I had a good way to test 8250-based UARTs, I also fixed that
> > > driver to use my new method.  When doing so, I ran into a missing
> > > include in serial_core.h.  NOTE: I didn't have a way to test
> > > msm_serial.c at all, so I didn't switch that (or all other serial
> > > drivers for that matter) to the new method.
> > >
> > > NOTE: from a serial point of view v2 is the same as v1 but I've
> > > removed the extra kgdb-related patches and made it obvious that this
> > > is really for all sysrq, not just kgdb.  I've also generally tried to
> > > curate the CCs more properly.
> >
> > It seems your forgot console people to Cc.
> 
> Can you be more specific, please?  Which section of the "MAINTAINERS"
> file should I be looking at for the "console" you are thinking of?

I have added them to Cc list: Petr, Sergey, and Steven.

> Certainly there are lots of hits for "console" in MAINTAINERS but I
> don't think I see any that are relevant that I missed.  Grepping:

> Ah!  Based on who you added to the CC list I guess you meant to CC
> "printk" folks?

Correct.

> PRINTK
> M:      Petr Mladek <pmladek@suse.com>
> M:      Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> R:      Steven Rostedt <rostedt@goodmis.org>
> S:      Maintained
> F:      kernel/printk/
> F:      include/linux/printk.h


> I'd be happy to CC those folks on future spins (if there are any).
> I'm not convinced that these patches are directly relevant to the
> printk subsystem, but I'm always happy for more people to have a
> chance to review patches.

If you look retrospectively in the mailing lists, you can find that they are
doing most of the console core work, which I believe includes SysRq behaviour.
So, don't be confused their names are listed under PRINTK.

> Hopefully anyone who needs this patch can find it on one of the
> relevant mailing lists.  I screwed up and missed LKML this time
> around, but there are plenty of other mailing lists here that it could
> be found on.  If requested I'm also happy to re-post the same series
> adding those 3 people if that's what everyone wants.

-- 
With Best Regards,
Andy Shevchenko
