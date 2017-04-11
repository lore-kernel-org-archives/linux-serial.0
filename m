From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] drivers/serial: Add driver for Aspeed virtual UART
Date: Tue, 11 Apr 2017 15:15:18 +0300
Message-ID: <CAHp75Vd=oONhzF34Pe8WwYKBWWxcsaQtgJy66aFD68iNKTxEfg@mail.gmail.com>
References: <20170410040400.5509-1-joel@jms.id.au> <20170410040400.5509-3-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170410040400.5509-3-joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 10, 2017 at 7:04 AM, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org> wrote:
> From: Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
>
> This change adds a driver for the 16550-based Aspeed virtual UART
> device. We use a similar process to the of_serial driver for device
> probe, but expose some VUART-specific functions through sysfs too.
>
> The VUART is two UART 'front ends' connected by their FIFO (no actual
> serial line in between). One is on the BMC side (management controller)
> and one is on the host CPU side.
>
> This driver is for the BMC side. The sysfs files allow the BMC
> userspace, which owns the system configuration policy, to specify at
> what IO port and interrupt number the host side will appear to the host
> on the Host <-> BMC LPC bus. It could be different on a different system
> (though most of them use 3f8/4).
>
> OpenPOWER host firmware doesn't like it when the host-side of the
> VUART's FIFO is not drained. This driver only disables host TX discard
> mode when the port is in use. We set the VUART enabled bit when we bind
> to the device, and clear it on unbind.
>
> We don't want to do this on open/release, as the host may be using this
> bit to configure serial output modes, which is independent of whether
> the devices has been opened by BMC userspace.

> +static void aspeed_vuart_set_enabled(struct aspeed_vuart *vuart, bool enabled)
> +{
> +       u8 reg;
> +
> +       reg = readb(vuart->regs + ASPEED_VUART_GCRA);

> +       reg &= ~ASPEED_VUART_GCRA_VUART_EN;
> +       if (enabled)
> +               reg |= ASPEED_VUART_GCRA_VUART_EN;

Usually the pattern is
if (something)
 set x bit;
else
 clear x bit;

It would make it one operation in any case and a bit more understandable.

> +       writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
> +}
> +
> +static void aspeed_vuart_set_host_tx_discard(struct aspeed_vuart *vuart,
> +                                            bool discard)
> +{
> +       u8 reg;
> +
> +       reg = readb(vuart->regs + ASPEED_VUART_GCRA);
> +
> +       /* If the DISABLE_HOST_TX_DISCARD bit is set, discard is disabled */

> +       reg &= ~ASPEED_VUART_GCRA_DISABLE_HOST_TX_DISCARD;
> +       if (!discard)
> +               reg |= ASPEED_VUART_GCRA_DISABLE_HOST_TX_DISCARD;

Ditto.

> +
> +       writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
> +}

> +       /* The 8510 core creates the mapping, which we grab a reference to
> +        * for VUART-specific registers */

Hmm... What about multi-line style?

> +       port.port.irq = irq_of_parse_and_map(np, 0);

The benefit of use platform_get_irq() is to get rid of some OF specific headers.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
