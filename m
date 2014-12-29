From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] tty: serial: 8250_mtk: Add earlycon
Date: Mon, 29 Dec 2014 08:54:02 -0600
Message-ID: <CAL_JsqJQPQ2Ngis9GN8pi31pd-Y3E=ioXFoRfXBvMKkasng_Mw@mail.gmail.com>
References: <1418891601-53769-1-git-send-email-eddie.huang@mediatek.com>
 <1418891601-53769-2-git-send-email-eddie.huang@mediatek.com>
 <CAL_JsqKp+1ZWPK4rB4_vxrx-dtNCy7Hc3S67uQ9VHdAby8erjg@mail.gmail.com> <1419827096.6184.128.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1419827096.6184.128.camel@mtksdaap41>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 28, 2014 at 10:24 PM, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> Hi Rob,
>
> On Fri, 2014-12-26 at 15:24 -0600, Rob Herring wrote:
>> On Thu, Dec 18, 2014 at 2:33 AM, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
>> > Mediatek UART has highspeed register, but 8250_early.c doesn't
>> > support this, so add earlycon in 8250_mtk.c
>>
>> I don't see any highspeed register setup here. More generically,
>> aren't you just skipping any UART setup? That may be useful on other
>> platforms with 8250s, too. With the kernel command line version, you
>> could perhaps add a "noinit" flag. The DT case is harder, and I'm not
>> sure how we should handle that. We could perhaps add a
>> "stdout-path-initialized" flag to chosen.
>>
>
> Yes, I skipped UART setup same as msm_serial.c and amba-pl011.c
> (although they are standalone serial driver). Just like earlyprintk, I
> think earlycon should reuse UART setting in loader. Since some other
> platforms with 8250 already depend on this, it's ok to add flags to
> distinguish whether 8250 earlycon driver should init hw or not. As you
> said, add "noinit" flag is simple, but "stdout-path-initialized" need
> more discussion.
>
>> >
>> > Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> > ---
>> >  drivers/tty/serial/8250/8250_mtk.c | 33 +++++++++++++++++++++++++++++++++
>> >  1 file changed, 33 insertions(+)
>> >
>> > diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
>> > index de7aae5..65dd569 100644
>> > --- a/drivers/tty/serial/8250/8250_mtk.c
>> > +++ b/drivers/tty/serial/8250/8250_mtk.c
>> > @@ -23,6 +23,7 @@
>> >  #include <linux/pm_runtime.h>
>> >  #include <linux/serial_8250.h>
>> >  #include <linux/serial_reg.h>
>> > +#include <linux/console.h>
>> >
>> >  #include "8250.h"
>> >
>> > @@ -289,6 +290,38 @@ static struct platform_driver mtk8250_platform_driver = {
>> >  };
>> >  module_platform_driver(mtk8250_platform_driver);
>> >
>> > +#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
>> > +
>> > +static void __init mtk8250_serial_putc(struct uart_port *port, int c)
>> > +{
>> > +       while ((readl(port->membase + (UART_LSR << 2)) & BOTH_EMPTY) !=
>> > +               BOTH_EMPTY)
>> > +               ;
>> > +       writel(c, port->membase + (UART_TX << 2));
>> > +}
>> > +
>> > +static void __init early_mtk8250_write(struct console *console,
>> > +                                       const char *s, unsigned int count)
>>
>> Is there a reason early_serial8250_write can't work for you other than
>> it is currently static?
>>
>> Rob
>>
>
> The reason is only static. I want to keep 8250_early.c untouchable, all
> modifications in 8250_mtk.c

That is not how kernel development works. You should fix 8250_early.c
to do what you need rather than duplicating code.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
