From: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH v2 2/2] drivers/serial: Add driver for Aspeed virtual UART
Date: Mon, 10 Apr 2017 12:37:57 +0930
Message-ID: <CACPK8XfJT-sGuTwDDSxevm50DLzh5qJ3+qa4qiA6f3enC6r_iw@mail.gmail.com>
References: <20170405040352.5661-1-joel@jms.id.au> <20170405040352.5661-3-joel@jms.id.au>
 <CAHp75VckYiBccVN+_K+Tm38kcdC10=sekQZg7Uz_HwS4xyW2UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VckYiBccVN+_K+Tm38kcdC10=sekQZg7Uz_HwS4xyW2UA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 5, 2017 at 8:24 PM, Andy Shevchenko
<andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Apr 5, 2017 at 7:03 AM, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org> wrote:
>
>> +       port.port.irq = irq_of_parse_and_map(np, 0);
>
> Isn't better to get this via platform_get_irq() ?

I can't see the benefit.

>
>> +       port.port.irqflags = IRQF_SHARED;
>> +       port.port.iotype = UPIO_MEM;
>
>> +       if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
>
> I would still go with usual pattern.
>
>> +               switch (prop) {
>> +               case 1:
>> +                       port.port.iotype = UPIO_MEM;
>> +                       break;
>> +               case 4:
>
>> +                       port.port.iotype = of_device_is_big_endian(np) ?
>> +                                      UPIO_MEM32BE : UPIO_MEM32;
>
> Hmm... And this one is not in align with IO accessors used in this
> driver. (readx()/writex() are little endian IO accessors).

We only perform readb/writeb, however you raise a good point that
we're assuming LE in the register layout. I will remove checking of this
optional property.

I will send v3 with the other cleanups you mentioned.

Cheers,

Joel

>
>> +                       break;
>> +               default:
>> +                       dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
>> +                                prop);
>> +                       rc = -EINVAL;
>> +                       goto err_clk_disable;
>> +               }
>> +       }
>> +
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
