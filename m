From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/2] tty: serial: Add mediatek UART driver
Date: Tue, 2 Sep 2014 12:08:40 +0200
Message-ID: <CABuKBeKBr_-riVqDzhepE9goosuaNocHH0K=5XsONEEvSXPi_w@mail.gmail.com>
References: <1407852737-17265-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407852737-17265-1-git-send-email-matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, jslaby-AlSwsSmVLrQ@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Yingjoe Chen <yingjoe.chen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

2014-08-12 16:12 GMT+02:00 Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> This patch set adds support for the UART found in Mediatek SoCs.
> The chip is a changed version of a 8250 controller.
> Especially it introduces a new register called highspeed. The value
> in this register has to be set depending on the baudrate. The value
> in the register influences the way the divisor has to be calculated.
>
> The patch series is build against v3.16-rc1 and tested on mt6589. Should
> work as well on mt6577 and mt6582.
>
> Thanks,
> Matthias

Ping: Does anyone has any comment on this series?
Sorry, last mail was HTML by accident.

>
> Changes for v4:
> - delete owner in platform driver instance
> - pass plattform_device to mtk8250_probe_of
> - reorganise probe function to error out early
> - Fix DTS documentation
>
> Changes for v3:
> - use dev_warn instead of pr_warn
> - use 8250_core function to update termios
>
> Changes for v2:
> - drop 8250_core capability extension for the chip
> - encapsulate set_termios in the driver method
>
> ---
>
> Matthias Brugger (2):
>   tty: serial: 8250: Add Mediatek UART driver
>   DTS: serial: Add bindings documention for the Mediatek UARTs
>
>  .../devicetree/bindings/serial/mtk-uart.txt        |   20 ++
>  drivers/tty/serial/8250/8250_mtk.c                 |  294 ++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig                    |    7 +
>  drivers/tty/serial/8250/Makefile                   |    1 +
>  4 files changed, 322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/mtk-uart.txt
>  create mode 100644 drivers/tty/serial/8250/8250_mtk.c
>
> --
> 1.7.9.5
>



-- 
motzblog.wordpress.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
