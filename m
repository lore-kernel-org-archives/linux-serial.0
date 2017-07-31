From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 3/9] serial: Add common rs485 device tree parsing
 function
Date: Mon, 31 Jul 2017 09:42:57 +0200
Message-ID: <20170731074257.2pjptqmflmflj2mf@pengutronix.de>
References: <20170718105948.21986-1-u.kleine-koenig@pengutronix.de>
 <20170718105948.21986-4-u.kleine-koenig@pengutronix.de>
 <20170730144947.GA18707@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170730144947.GA18707-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Sun, Jul 30, 2017 at 07:49:47AM -0700, Greg KH wrote:
> On Tue, Jul 18, 2017 at 12:59:42PM +0200, Uwe Kleine-König wrote:
> > From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > 
> > Several drivers have the same device tree parsing code. Create
> > a common helper function for it.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > [ukl: implement default <0 0> for rts-delay, unset unspecified flags]
> > Acked-by: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/tty/serial/Kconfig  |  4 ++++
> >  drivers/tty/serial/Makefile |  2 ++
> >  drivers/tty/serial/of.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
> 
> Why is this a separate file, with a Kconfig option that is always
> enabled?  Why not just add the single function to the serial core?

Probably just a matter of taste. If you prefer I can put it into
drivers/tty/serial/serial_core.c
 
> > +/**
> > + * of_get_rs485_mode() - Implement parsing rs485 properties
> > + * @np: uart node
> > + * @rs485conf: output parameter
> > + *
> > + * This function implements the device tree binding described in
> > + * Documentation/devicetree/bindings/serial/rs485.txt.
> > + *
> > + * Return: 0 on success, 1 if the node doesn't contain rs485 stuff.
> 
> 1 is not an error code :(
> 
> Return a proper error please.

Well, it's not an error. These properties are optional and if I return
(say) -ENOENT in this case, a caller looks as follows:

	ret = of_get_rs485_mode(...);
	if (ret == -ENOENT) {
		/*
		 * hmm, does this mean there are no rs485 properties, or
		 * is this a different error that I should propagate
		 * because there is a problem with the device tree?
		 * I'm optimistic and assume the former.
		 * As of_get_rs485_mode already did everything
		 * necessary, there is no need to do anything else.
		 */
	} else if (ret < 0) {
		return ret;
	}

With the semantic I chose it is just:

	ret = of_get_rs485_mode(...);
	if (ret < 0)
		return ret;

without any guessing.

> > + */
> > +int of_get_rs485_mode(struct device_node *np, struct serial_rs485 *rs485conf)
> > +{
> > +	u32 rs485_delay[2];
> > +	int ret;
> > +
> > +	if (!IS_ENABLED(CONFIG_OF) || !np)
> > +		return 1;
> > +
> > +	ret = of_property_read_u32_array(np, "rs485-rts-delay", rs485_delay, 2);
> > +	if (!ret) {
> > +		rs485conf->delay_rts_before_send = rs485_delay[0];
> > +		rs485conf->delay_rts_after_send = rs485_delay[1];
> > +	} else {
> > +		rs485conf->delay_rts_before_send = 0;
> > +		rs485conf->delay_rts_after_send = 0;
> > +	}
> > +
> > +	/*
> > +	 * clear full-duplex and enabled flags to get to a defined state with
> > +	 * the two following properties.
> > +	 */
> > +	rs485conf->flags &= ~(SER_RS485_RX_DURING_TX | SER_RS485_ENABLED);
> > +
> > +	if (of_property_read_bool(np, "rs485-rx-during-tx"))
> > +		rs485conf->flags |= SER_RS485_RX_DURING_TX;
> > +
> > +	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time"))
> > +		rs485conf->flags |= SER_RS485_ENABLED;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(of_get_rs485_mode);
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index 1775500294bb..3a89e8925722 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -501,4 +501,17 @@ static inline int uart_handle_break(struct uart_port *port)
> >  					 (cflag) & CRTSCTS || \
> >  					 !((cflag) & CLOCAL))
> >  
> > +/*
> > + * Common device tree parsing helpers
> > + */
> > +#ifdef CONFIG_OF_SERIAL
> > +int of_get_rs485_mode(struct device_node *np, struct serial_rs485 *rs485conf);
> > +#else
> > +static inline int of_get_rs485_mode(struct device_node *np,
> > +				    struct serial_rs485 *rs485conf)
> > +{
> > +	return 1;
> 
> Again, a real error.

OK, I could agree to return -ENOSYS here. I predict I get complaints
about this though and people will do:

	ret = of_get_rs485_mode(...);
	if (ret == -ENOSYS) {
		/* ignore */
	} else if (ret < 0) {
		return ret;
	}

which one might consider troublesome or even wrong. (See the same
discussions about 22c403676dbbb7c6f186099527af7f065498ef45 where I
wanted to keep -ENOSYS.)
 
> And why not have a "generic" firmware function for this that defaults to
> the of_ for that platform type if present?  What's the odds that acpi
> will need/want this soon anyway?

I don't know about ACPI and all systems I care about are using dt. So
I'd suggest we stick to dt and switch to "generic" if and when the need
arises?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
