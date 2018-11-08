From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 0/5] serial: Finish sysrq on qcom_geni; fix sysrq vs.
 lockdep on 8250
Date: Thu, 8 Nov 2018 10:41:47 +0100
Message-ID: <20181108094147.clr2nntiqvqkh5q2@pathway.suse.cz>
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
Cc: Dan Carpenter <dan.carpenter@oracle.com>, vigneshr@ti.com, linux-aspeed@lists.ozlabs.org, sergey.senozhatsky@gmail.com, Andrew Jeffery <andrew@aj.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Tony Lindgren <tony@atomide.com>, joel@jms.id.au, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Jeremy Kerr <jk@ozlabs.org>
List-Id: linux-serial@vger.kernel.org

On Wed 2018-11-07 11:26:56, Doug Anderson wrote:
> On Wed, Nov 7, 2018 at 10:23 AM Andy Shevchenko
> Ah!  Based on who you added to the CC list I guess you meant to CC
> "printk" folks?
> 
> PRINTK
> M:      Petr Mladek <pmladek@suse.com>
> M:      Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> R:      Steven Rostedt <rostedt@goodmis.org>
> S:      Maintained
> F:      kernel/printk/
> F:      include/linux/printk.h
> 
> 
> I'd be happy to CC those folks on future spins (if there are any).
> I'm not convinced that these patches are directly relevant to the
> printk subsystem, but I'm always happy for more people to have a
> chance to review patches.

I, as a printk maintainer, am not completely familiar with all
the console driver problems. But we, printk maintainers, come
to similar deadlocks from the printk side, so we are definitely
interested into this kind of patches.

BTW: There was an attempt to avoid the console_unlock() related
deadlocks a more generic way, see
https://lore.kernel.org/lkml/20181016050428.17966-1-sergey.senozhatsky@gmail.com
Unfortunately, there is some push back against introducing a new
printk-related-locking API.


> Hopefully anyone who needs this patch can find it on one of the
> relevant mailing lists.  I screwed up and missed LKML this time
> around, but there are plenty of other mailing lists here that it could
> be found on.  If requested I'm also happy to re-post the same series
> adding those 3 people if that's what everyone wants.

I have glanced over the patches via
https://www.spinics.net/lists/linux-arm-msm/msg44083.html
I still have to think about it. I will be traveling next week
so it might take some time.

Anyway, please CC printk people into v2 if any.

Best Reagards,
Petr
