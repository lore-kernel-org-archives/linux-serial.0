From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 04/16] serial: mvebu-uart: support probe of multiple ports
Date: Fri, 13 Oct 2017 13:22:35 +0200
Message-ID: <87376n9ts4.fsf@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
        <20171013090200.31034-5-miquel.raynal@free-electrons.com>
        <877evz9yi7.fsf@free-electrons.com> <20171013131711.4ef63ea0@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013131711.4ef63ea0@xps13> (Miquel RAYNAL's message of "Fri,
        13 Oct 2017 13:17:11 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Allen Yan <yanwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 13 2017, Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi Gregory,
>
> On Fri, 13 Oct 2017 11:40:32 +0200
> Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>
>> Hi Miquel,
>>  
>>  On ven., oct. 13 2017, Miquel Raynal
>> <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> 
>> > -	port = &mvebu_uart_ports[0];
>> > +	/* Assume that all UART ports have a DT alias or none has
>> > */
>> > +	id = of_alias_get_id(pdev->dev.of_node, "serial");  
>> 
>> You stil need to check the pdev->dev.of_node before calling
>> of_alias_get_id.
>
> Thanks for your feedback but I don't think we still need to check it,
> because the of_alias_get_id() function will either return -ENOSYS if
> CONFIG_OF is not defined, or -ENODEV if the node is not found. As the
> function does not dereference pdev->dev.of_node at any moment but
> instead compares the value with another pointer, I think this call is
> safe like this.

Fair enough, I expected that the pointer was dereferenced but I was
wrong, was so no need for a new version.

Acked-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks,

Gregory

>
> Thanks,
> Miquèl
>
>> 
>> Once it will be fixed, you can add:
>> 
>> Acked-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> 
>> Thanks,
>> 
>> Gregory
>> 
>> 
>> > +	if (!pdev->dev.of_node || id < 0)
>> > +		pdev->id = uart_num_counter++;
>> > +	else
>> > +		pdev->id = id;
>> > +
>> > +	if (pdev->id >= MVEBU_NR_UARTS) {
>> > +		dev_err(&pdev->dev, "cannot have more than %d UART
>> > ports\n",
>> > +			MVEBU_NR_UARTS);
>> > +		return -EINVAL;
>> > +	}
>> > +
>> > +	port = &mvebu_uart_ports[pdev->id];
>> >  
>> >  	spin_lock_init(&port->lock);
>> >  
>> > @@ -572,7 +588,7 @@ static int mvebu_uart_probe(struct
>> > platform_device *pdev) port->fifosize   = 32;
>> >  	port->iotype     = UPIO_MEM32;
>> >  	port->flags      = UPF_FIXED_PORT;
>> > -	port->line       = 0; /* single port: force line number
>> > to  0 */
>> > +	port->line       = pdev->id;
>> >  
>> >  	port->irq        = irq->start;
>> >  	port->irqflags   = 0;
>> > -- 
>> > 2.11.0
>> >  
>> 
>
>
>
> -- 
> Miquel Raynal, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
