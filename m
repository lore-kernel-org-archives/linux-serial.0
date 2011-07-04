From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 2/2] serial/imx: add device tree probe support
Date: Mon, 4 Jul 2011 10:36:47 +0800
Message-ID: <20110704023646.GB10245@S2100-06.ap.freescale.net>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
 <1309679760-22796-3-git-send-email-shawn.guo@linaro.org>
 <20110703211434.GC13742@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:46111
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751690Ab1GDCbP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 3 Jul 2011 22:31:15 -0400
Content-Disposition: inline
In-Reply-To: <20110703211434.GC13742@ponder.secretlab.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Shawn Guo <shawn.guo@linaro.org>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Jason Liu <jason.hui@linaro.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Jeremy Kerr <jeremy.kerr@canonical.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org

On Sun, Jul 03, 2011 at 03:14:34PM -0600, Grant Likely wrote:
> On Sun, Jul 03, 2011 at 03:56:00PM +0800, Shawn Guo wrote:
> > It adds device tree probe support for imx tty/serial driver.
> > 
> > Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> > Signed-off-by: Jason Liu <jason.hui@linaro.org>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> 
> Minor comments below, but otherwise looks okay to me.  Feel free to
> add the following when you respin with the first patch:
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> I don't see any reason preventing this from being ready to be queued
> up for v3.1
> 
> g.
> 
> > ---
> >  .../bindings/tty/serial/fsl-imx-uart.txt           |   19 +++++
> >  drivers/tty/serial/imx.c                           |   82 +++++++++++++++++---
> >  2 files changed, 91 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> > new file mode 100644
> > index 0000000..a9c0406
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> > @@ -0,0 +1,19 @@
> > +* Freescale i.MX Universal Asynchronous Receiver/Transmitter (UART)
> > +
> > +Required properties:
> > +- compatible : Should be "fsl,<soc>-uart"
> > +- reg : Address and length of the register set for the device
> > +- interrupts : Should contain uart interrupt
> > +
> > +Optional properties:
> > +- fsl,uart-has-rtscts : Indicate the uart has rts and cts
> > +- fsl,irda-mode : Indicate the uart supports irda mode
> > +
> > +Example:
> > +
> > +uart@73fbc000 {
> > +	compatible = "fsl,imx51-uart", "fsl,imx21-uart";
> > +	reg = <0x73fbc000 0x4000>;
> > +	interrupts = <31>;
> > +	fsl,uart-has-rtscts;
> > +};
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 983f3bd..483c447 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -45,6 +45,8 @@
> >  #include <linux/delay.h>
> >  #include <linux/rational.h>
> >  #include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> >  
> >  #include <asm/io.h>
> >  #include <asm/irq.h>
> > @@ -239,6 +241,12 @@ static struct platform_device_id imx_uart_devtype[] = {
> >  	}
> >  };
> >  
> > +static struct of_device_id imx_uart_dt_ids[] = {
> > +	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
> > +	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX2_UART], },
> > +	{ /* sentinel */ },
> 
> Nit: drop the ',' from the last entry so that nobody inadvertently
> adds another entry to the list.
> 
Ok, will make the change on other patches where the comment applies.

> > +};
> > +
> >  /*
> >   * Handle any change of modem status signal since we were last called.
> >   */
> > @@ -1261,6 +1269,58 @@ static int serial_imx_resume(struct platform_device *dev)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_OF
> > +static int serial_imx_probe_dt(struct imx_port *sport,
> > +		struct platform_device *pdev)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	const struct of_device_id *of_id =
> > +			of_match_device(imx_uart_dt_ids, &pdev->dev);
> > +
> > +	if (!np)
> > +		return -ENODEV;
> > +
> > +	pdev->id = of_alias_get_id(np, "serial");
> > +	if (pdev->id < 0)
> > +		return -ENODEV;
> 
> If you're bailing here, it would be friendly to spit out a klog
> message saying why the driver has bailed.
> 
Ok, will make the change on other patches where the comment applies.

Regards,
Shawn

