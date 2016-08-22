From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3 3/3] serial: 8250_dw: add ACPI support for uart on
 Hisilicon Hip05 soc
Date: Mon, 22 Aug 2016 17:05:58 +0300
Message-ID: <20160822140558.GB9065@kuha.fi.intel.com>
References: <1468580485-28567-1-git-send-email-wangkefeng.wang@huawei.com>
 <1468580485-28567-4-git-send-email-wangkefeng.wang@huawei.com>
 <1471865054.4887.206.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471865054.4887.206.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, guohanjun@huawei.com, z.liuxinliang@hisilicon.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org
List-Id: linux-serial@vger.kernel.org

Hi,

On Mon, Aug 22, 2016 at 02:24:14PM +0300, Andy Shevchenko wrote:
> On Fri, 2016-07-15 at 19:01 +0800, Kefeng Wang wrote:
> > Use built-in device properties to set device parameters for the
> > existing device probed by acpi.
> 
> acpi -> ACPI
> 
> > 
> > Add ACPI identifier for UART on Hisilicon Hip05 soc, be careful
> 
> soc -> SoC
> 
> > that it is not 16550 compatibal, so we need set "reg-io-width"
> 
> compatibal -> compatible
> 
> > and "reg-shift" by _DSD method in DSDT.
> > 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_dw.c
> > b/drivers/tty/serial/8250/8250_dw.c
> > index d6934310..5ab9cfe 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -297,12 +297,6 @@ static void dw8250_quirks(struct uart_port *p,
> > struct dw8250_data *data)
> >  			p->serial_in = dw8250_serial_in32be;
> >  			p->serial_out = dw8250_serial_out32be;
> >  		}
> > -	} else if (has_acpi_companion(p->dev)) {
> > -		p->iotype = UPIO_MEM32;
> > -		p->regshift = 2;
> > -		p->serial_in = dw8250_serial_in32;
> > -		/* So far none of there implement the Busy
> > Functionality */
> > -		data->uart_16550_compatible = true;
> >  	}
> >  
> >  	/* Platforms with iDMA */
> > @@ -352,6 +346,19 @@ static void dw8250_setup_port(struct uart_port
> > *p)
> >  		up->capabilities |= UART_CAP_AFE;
> >  }
> >  
> > +static struct property_entry dw8250_properties[] = {
> > +	PROPERTY_ENTRY_U32("reg-io-width", 4),
> > +	PROPERTY_ENTRY_U32("reg-shift", 2),
> > +	PROPERTY_ENTRY_BOOL("snps,uart-16550-compatible"),
> > +	{ },
> > +};
> > +
> > +/* non 16550 compatible id list*/
> 
> non 16550 -> Non-16550
> Space before */
> 
> > +static const struct acpi_device_id non_16550_ids[] = {
> > +	{ "HISI0031", 0 },
> > +	{ },
> > +};
> > +
> >  static int dw8250_probe(struct platform_device *pdev)
> >  {
> >  	struct uart_8250_port uart = {};
> > @@ -395,6 +402,9 @@ static int dw8250_probe(struct platform_device
> > *pdev)
> >  	if (!data)
> >  		return -ENOMEM;
> >  
> > +	if (has_acpi_companion(dev) &&
> > !acpi_match_device(non_16550_ids, dev))
> 
> 
> > +		platform_device_add_properties(pdev,
> > dw8250_properties);
> 
> What if we probe device which has already properties assigned?
> 
> Heikki, are you good with such trick?

No this is not the way to do this. As we talked, we need to add the
properties in the mfd drivers when they exist and not in the driver
itself. Only if there is no mfd driver that creates the actual
platform device for dw8250 and when also the ACPI tables don't provide
the properties, we identify the board in dw8250_quirks and handle it
separately. Right now there is only one such board.

I'll prepare the patches for that right now. This series can then be
made on top of those.


Thanks,

-- 
heikki
