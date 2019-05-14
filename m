From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Date: Tue, 14 May 2019 15:42:41 +0300
Message-ID: <20190514124241.GD9224@smile.fi.intel.com>
References: <87pnp11112.fsf@haabendal.dk>
 <20190507093239.GB4529@dell>
 <87sgtqjy3l.fsf@haabendal.dk>
 <20190507115325.GV9224@smile.fi.intel.com>
 <87k1f2jvyd.fsf@haabendal.dk>
 <20190507150847.GW9224@smile.fi.intel.com>
 <87k1etmrfk.fsf@haabendal.dk>
 <CAHp75VfrP6SLVzmp6LepN7dU1c7QYxfRDRtj7dCTuWzmYp2tCA@mail.gmail.com>
 <CAHp75VetoajaeqUnUuj4sNjhujqDkbqvQmxE+LMtzFN4so_jwA@mail.gmail.com>
 <87zhnpkzvj.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zhnpkzvj.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: Lee Jones <lee.jones@linaro.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 14, 2019 at 02:02:40PM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> 
> > On Tue, May 14, 2019 at 12:23 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Tue, May 14, 2019 at 10:24 AM Esben Haabendal <esben@haabendal.dk> wrote:
> >
> >> > Please take a look at https://lkml.org/lkml/2019/4/9/576
> >> > ("[PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip")
> >>
> >> Thank you for this link.
> >> Now, look at this comment:
> >>
> >> + /*
> >> + * Map all IOC3 registers.  These are shared between subdevices
> >> + * so the main IOC3 module manages them.
> >> + */
> >>
> >> Is it your case? Can we see the code?
> >
> > They do not request resources by the way.
> 
> Actually, that looks like a bug in ioc3.c driver.

Nope. This is the right thing to do.

> It is using mfd_add_devices() with a mem_base that has not been properly
> requested, and the platform_get_resource() calls made by child drivers
> does not guarantee exclusive access to the memory resources, as they are
> not inserted in the root memory resource tree.

Should platform_get_resource() guarantee that? I think no, otherwise entire MFD
and other logic will collapse.

> > You may do the same, I told you this several times.
> 
> In drivers/mfd/ioc3.c:
> 
> First, the uart resources are defined.  The register memory resource is
> defined relative to the mfd driver memory resource.
> 
> +static struct resource ioc3_uarta_resources[] = {
> +	DEFINE_RES_MEM(offsetof(struct ioc3, sregs.uarta),
> +		       sizeof_field(struct ioc3, sregs.uarta)),
> +	DEFINE_RES_IRQ(6)
> +};
> 
> This is then used when creating the uart cell.
> 
> +		cell->name = "ioc3-serial8250";
> +		cell->id = ioc3_serial_id++;
> +		cell->resources = ioc3_uarta_resources;
> +		cell->num_resources = ARRAY_SIZE(ioc3_uarta_resources);
> 
> Finally, the mfd_add_devices() call is made, giving the resource for the
> BAR0 region (&ipd->pdev->resource[0]) as mem_base argument:
> 
> +	mfd_add_devices(&ipd->pdev->dev, -1, ioc3_mfd_cells,
> +			cell - ioc3_mfd_cells, &ipd->pdev->resource[0],
> +			0, ipd->domain);
> 
> This is just what I want to do.
> 

> But in order to guarantee exclusive access to the memory resource, I
> need to have it requested.

Here the root of our misunderstanding each other.

Every driver till now works fine and entire model works fine without resources
being requested.

I told you already that if you want your way that has to be done not in 8250
driver, but in generic code (driver core or even resource framework).

-- 
With Best Regards,
Andy Shevchenko
