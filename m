From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 02/45] drivers: tty: serial: 8250_dw: use devm_ioremap_resource()
Date: Fri, 15 Mar 2019 11:04:12 +0200
Message-ID: <CAHp75VegzKNhH1Uza9gwQMOAEOdh57WTzsHUx7vPdVs7XvJROQ@mail.gmail.com>
References: <1552602855-26086-1-git-send-email-info@metux.net> <1552602855-26086-3-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-3-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tobias Klauser <tklauser@distanz.ch>, Richard Genoud <richard.genoud@gmail.com>, macro@linux-mips.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@g
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 15, 2019 at 12:41 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Instead of fetching out data from a struct resource for passing
> it to devm_ioremap(), directly use devm_ioremap_resource()

I don't see any advantage of this change.
See also below.

> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -526,7 +526,7 @@ static int dw8250_probe(struct platform_device *pdev)
>         p->set_ldisc    = dw8250_set_ldisc;
>         p->set_termios  = dw8250_set_termios;
>
> -       p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
> +       p->membase = devm_ioremap_resource(dev, regs);
>         if (!p->membase)

And how did you test this? devm_ioremap_resource() returns error
pointer in case of error.

>                 return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko
