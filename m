From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Date: Mon, 6 May 2019 19:44:26 +0300
Message-ID: <20190506164426.GO9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
 <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
 <20190502153124.GA9224@smile.fi.intel.com>
 <87ef5boaa7.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87ef5boaa7.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, May 06, 2019 at 05:46:56PM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> > On Wed, May 01, 2019 at 09:17:37AM +0200, Esben Haabendal wrote:
> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> As an example, the sm501.c driver, the only driver in drivers/mfd/ which
> uses serial8250 driver, does not use any code from mfd-core.
> Incidentally, it is 1 year older than mfd-core.c, and as never been
> refactored to use mfd-core functionality.

So, sm501.c should not request resources for its children. This as simple as
that.

What you are trying to do here is a hack workaround on the current behaviour in
the Linux device model (resource management) as I told you already.

> > Why not? Again, *slicing* resources is OK and that's what MFD for, *requesting*
> > them in the parent is not.
> 
> Why we cannot use request_mem_region() for those memory resources again?

Because it's how it was designed. "One device per one resource". If you would
like to fix this, it should be done obviously not in 8250 driver or any other
driver, but driver core.

Nevertheless there is one particular exception here, i.e. IORESOURCE_MUXED.

> It fails because the resources are now already owned the mfd driver, on
> behalf of the child.

Yes. Behaves in order how it's implementer. No issues here.

> > Nope, *requesting* resources as you mentioned lock them to the certain user.
> 
> I still think there is some confusion in relation to your use of the
> word "requesting".  There is no explicit request/lock action in
> kernel/resource.c.

You have to check IORESOURCE_BUSY. It seems that what you missed in your
picture.

I didn't comment the rest until we will figure out the IO resource management
in general.

-- 
With Best Regards,
Andy Shevchenko
