From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/9] serial: Add common rs485 device tree parsing function
Date: Thu, 22 Jun 2017 10:22:21 +0200
Message-ID: <20170622082221.v4jf2u5bdw6oyjxw@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
 <20170621102130.21024-2-u.kleine-koenig@pengutronix.de>
 <20170622063157.qih2mriprczpj7zn@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170622063157.qih2mriprczpj7zn-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hello Sascha,

On Thu, Jun 22, 2017 at 08:31:57AM +0200, Sascha Hauer wrote:
> On Wed, Jun 21, 2017 at 12:21:22PM +0200, Uwe Kleine-König wrote:
> > +/**
> > + * of_get_rs485_mode() - Implement parsing rs485 properties
> > + * @np: uart node
> > + * @rs485conf: output parameter
> > + *
> > + * This function implements the device tree binding described in
> > + * Documentation/devicetree/bindings/serial/rs485.txt.
> > + *
> > + * Return: 0 on success, 1 if the node doesn't contain rs485 stuff, or a
> > + * negative error code.
> > + */
> > +int of_get_rs485_mode(struct device_node *np, struct serial_rs485 *rs485conf)
> > +{
> > +	u32 rs485_delay[2];
> > +	int ret;
> > +
> > +	ret = of_property_read_u32_array(np, "rs485-rts-delay" rs485_delay, 2);
> > +	if (ret == -EINVAL) /* property does not exist */
> > +		return 1;
> 
> As the de-facto standard for the drivers implementing the rs485 bindings
> is to make the properties optional, despite the documentation. Wouldn't

I must admit that I failed to mention in the commit log that being
strict here was added by me even though I'm not the author.

> it be better to make this property optional in the binding instead? This
> wouldn't unnecessarily break old device trees and 0/0 seems a sane
> default we can use when the property doesn't exist.

Would be fine for me, too. It was Nicolas Ferre who specified this as
being required in 0331bbf3c6fd9. Added people who discussed the patch
back then (but without questioning rs485-rts-delay being mandatory).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
