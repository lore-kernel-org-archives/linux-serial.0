From: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 04/16] serial: mvebu-uart: support probe of multiple
 ports
Date: Fri, 13 Oct 2017 09:29:16 +0200
Message-ID: <20171013092916.2b97db55@xps13>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
        <20171006101344.15590-5-miquel.raynal@free-electrons.com>
        <87poa0foro.fsf@free-electrons.com>
        <20171009091711.528adddd@xps13>
        <87vajkblol.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87vajkblol.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Allen Yan <yanwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello Gregory,

On Thu, 12 Oct 2017 14:22:18 +0200
Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi Miquel,
>  
>  On lun., oct. 09 2017, Miquel RAYNAL
> <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> 
> > On Fri, 06 Oct 2017 14:23:55 +0200
> > Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >  
> >> Hi Miquel,
> >>  
> >>  On ven., oct. 06 2017, Miquel Raynal
> >> <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >>   
> >> > From: Allen Yan <yanwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> >> >
> >> > Until now, the mvebu-uart driver only supported probing a single
> >> > UART port. However, some platforms have multiple instances of
> >> > this UART controller, and therefore the driver should support
> >> > multiple ports.
> >> >
> >> > In order to achieve this, we make sure to assign port->line
> >> > properly, instead of hardcoding it to zero.
> >> >
> >> > Signed-off-by: Allen Yan <yanwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> >> > Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >> > ---
> >> >  drivers/tty/serial/mvebu-uart.c | 13 +++++++++++--
> >> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/tty/serial/mvebu-uart.c
> >> > b/drivers/tty/serial/mvebu-uart.c index
> >> > 7e0a3e9fee15..25b11ede3a97 100644 ---
> >> > a/drivers/tty/serial/mvebu-uart.c +++
> >> > b/drivers/tty/serial/mvebu-uart.c @@ -560,7 +560,16 @@ static
> >> > int mvebu_uart_probe(struct platform_device *pdev) return
> >> > -EINVAL; }
> >> >  
> >> > -	port = &mvebu_uart_ports[0];
> >> > +	if (pdev->dev.of_node)
> >> > +		pdev->id = of_alias_get_id(pdev->dev.of_node,
> >> > "serial");    
> >> 
> >> If the id is retrieved using an of_ function, then I think that the
> >> driver would depend on OF_CONFIG.  
> >
> > Is this okay?
> >
> > if (pdev->dev.of_node && IS_ENABLED(CONFIG_OF))
> >         pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");  
> 
> Actually if CONFIG_OF is not enabled, then dev->dev.of_node. So you
> can keep the test but just remove the test on IS_ENABLED(CONFIG_OF).
> 
> But my remark about CONFIG_OF, was more to point that if there is no
> device tree support then this part of code won't work well if you have
> several ports using the same driver.

Ok.

> 
> So either you keep your driver as is but make it depends on CONFIG_OF
> to make it clear that it won't work with ACPI. Or you add the case for
> ACPI, but I think you don't have a board with ACPI support so you
> won't be able to test it.
> 
> A third solution would be to have a fallback when of_alias_get_id
> failed (either because there is no alias in the device tree or there
> is no device tree at all). In this case you can just increment the id
> for each new port.

This is the solution I choose. I used this driver as an example:
drivers/gpu/drm/omapdrm/dss/display.c

Please have a look at it in the next version.

Thanks,
Miquèl

> 
> Gregory
> 
> 
> > else
> >         pdev->id = 0;
> >
> > BTW, I could not test without CONFIG_OF as it is defined by default
> > in our case: Selected by: ARM64 [=y]
> > I don't think there will be a 32-bit SoC with this UART IP?
> >
> > Thanks,
> > Miquèl
> >  
> >> 
> >> Gregory
> >> 
> >>   
> >> > +
> >> > +	if (pdev->id >= MVEBU_NR_UARTS) {
> >> > +		dev_err(&pdev->dev, "cannot have more than %d
> >> > UART ports\n",
> >> > +			MVEBU_NR_UARTS);
> >> > +		return -EINVAL;
> >> > +	}
> >> > +
> >> > +	port = &mvebu_uart_ports[pdev->id];
> >> >  
> >> >  	spin_lock_init(&port->lock);
> >> >  
> >> > @@ -572,7 +581,7 @@ static int mvebu_uart_probe(struct
> >> > platform_device *pdev) port->fifosize   = 32;
> >> >  	port->iotype     = UPIO_MEM32;
> >> >  	port->flags      = UPF_FIXED_PORT;
> >> > -	port->line       = 0; /* single port: force line number
> >> > to  0 */
> >> > +	port->line       = pdev->id;
> >> >  
> >> >  	port->irq        = irq->start;
> >> >  	port->irqflags   = 0;
> >> > -- 
> >> > 2.11.0
> >> >
> >> >
> >> > _______________________________________________
> >> > linux-arm-kernel mailing list
> >> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> >> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel    
> >>   
> >
> >
> >
> > -- 
> > Miquel Raynal, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com  
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
