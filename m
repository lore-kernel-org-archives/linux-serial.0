From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9] serial: support for 16550A serial ports on LP-8x4x
Date: Tue, 1 Mar 2016 22:23:40 +0200
Message-ID: <CAHp75Ve-s+vP3BQcrT22PyQC34vFrM6Esz6sy2UoRCOH8tkdYQ@mail.gmail.com>
References: <1456862078-11795-1-git-send-email-ynvich@gmail.com>
	<1456862903-12392-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456862903-12392-1-git-send-email-ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 1, 2016 at 10:08 PM, Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> The patch adds support for 3 additional LP-8x4x built-in serial
> ports.
>
> The device can also host up to 8 extension cards with 4 serial ports
> on each card for a total of 35 ports. However, I don't have
> the hardware to test extension cards, so they are not supported, yet.
>
> Signed-off-by: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Sorry, but still few nitpicks and then
Reviewed-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> +#define LP8841_DATA_LEN_MASK           0x3
> +#define LP8841_DATA_LEN_SHIFT_OFFSET   3

No need to have _OFFSET suffix.

> +
> +static void lp8841_serial_set_termios(struct uart_port *port,
> +               struct ktermios *termios, struct ktermios *old)
> +{
> +       unsigned int baud;
> +       u8 value;

> +       unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
> +       struct lp8841_serial_data *data = port->private_data;

I would rearrange to have assignments first in the definition block.

Code duplication (no idea if it worth to fix):

+       case 2400:
+               value |= 1;
+               break;
+       default:
+               value |= 1;
+               tty_termios_encode_baud_rate(termios, 2400, 2400);
+               break;

> +static int lp8841_serial_probe(struct platform_device *pdev)
> +{
> +       struct uart_8250_port uart = {};

No need {} since memset().

> +       struct lp8841_serial_data *data;
> +       struct resource *mmres, *mires;
> +       int ret;
> +
> +       memset(&uart, 0, sizeof(uart));

Move this closer to the first assignment of a field.

> +
> +       mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!mmres)
> +               return -ENODEV;
> +
> +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       mires = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       data->ios_mem = devm_ioremap_resource(&pdev->dev, mires);
> +       if (IS_ERR(data->ios_mem))
> +               return PTR_ERR(data->ios_mem);
> +

+       memset(&uart, 0, sizeof(uart));

> +       uart.port.iotype = UPIO_MEM;
> +       uart.port.mapbase = mmres->start;
> +       uart.port.regshift = 1;
> +       uart.port.irq = platform_get_irq(pdev, 0);
> +       uart.port.flags = UPF_IOREMAP;
> +       uart.port.dev = &pdev->dev;
> +       uart.port.uartclk = 14745600;
> +       uart.port.set_termios = lp8841_serial_set_termios;
> +       uart.port.private_data = data;

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
