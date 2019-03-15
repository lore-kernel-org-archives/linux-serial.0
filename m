From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 45/45] drivers: tty: serial: mux: use devm_* functions
Date: Fri, 15 Mar 2019 11:08:01 +0200
Message-ID: <CAHp75Vf1F_WQxNRiya=aTqFTEGWDVrD9JTr1VB4pOW0RayDmoA@mail.gmail.com>
References: <1552602855-26086-1-git-send-email-info@metux.net> <1552602855-26086-46-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-46-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tobias Klauser <tklauser@distanz.ch>, Richard Genoud <richard.genoud@gmail.com>, macro@linux-mips.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@g
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 15, 2019 at 12:37 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the safer devm versions of memory mapping functions.

If you are going to use devm_*_free(), what's the point to have this
change from the beginning?

P.S. Disregard that this is untested series...

> --- a/drivers/tty/serial/mux.c
> +++ b/drivers/tty/serial/mux.c
> @@ -456,8 +456,9 @@ static int __init mux_probe(struct parisc_device *dev)
>         printk(KERN_INFO "Serial mux driver (%d ports) Revision: 0.6\n", port_count);
>
>         dev_set_drvdata(&dev->dev, (void *)(long)port_count);
> -       request_mem_region(dev->hpa.start + MUX_OFFSET,
> -                           port_count * MUX_LINE_OFFSET, "Mux");

> +       devm_request_mem_region(&dev->dev,
> +                               dev->hpa.start + MUX_OFFSET,
> +                               port_count * MUX_LINE_OFFSET, "Mux");

...and on top of this where is error checking?

>
>         if(!port_cnt) {
>                 mux_driver.cons = MUX_CONSOLE;
> @@ -474,7 +475,9 @@ static int __init mux_probe(struct parisc_device *dev)
>                 port->iobase    = 0;
>                 port->mapbase   = dev->hpa.start + MUX_OFFSET +
>                                                 (i * MUX_LINE_OFFSET);
> -               port->membase   = ioremap_nocache(port->mapbase, MUX_LINE_OFFSET);
> +               port->membase   = devm_ioremap_nocache(port->dev,
> +                                                      port->mapbase,
> +                                                      MUX_LINE_OFFSET);
>                 port->iotype    = UPIO_MEM;
>                 port->type      = PORT_MUX;
>                 port->irq       = 0;
> @@ -517,10 +520,12 @@ static int __exit mux_remove(struct parisc_device *dev)
>
>                 uart_remove_one_port(&mux_driver, port);
>                 if(port->membase)
> -                       iounmap(port->membase);
> +                       devm_iounmap(port->dev, port->membase);
>         }
>
> -       release_mem_region(dev->hpa.start + MUX_OFFSET, port_count * MUX_LINE_OFFSET);
> +       devm_release_mem_region(&dev->dev,
> +                               dev->hpa.start + MUX_OFFSET,
> +                               port_count * MUX_LINE_OFFSET);
>         return 0;
>  }


-- 
With Best Regards,
Andy Shevchenko
