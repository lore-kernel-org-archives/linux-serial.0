From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 07/45] drivers: tty: serial: 8250_uniphier: use devm_ioremap_resource()
Date: Mon, 18 Mar 2019 16:44:25 +0900
Message-ID: <CAK7LNAT6p41J+voYdrOtPkiq92sRDNv6nbrBdVKsWZYGENxsWw@mail.gmail.com>
References: <1552602855-26086-1-git-send-email-info@metux.net> <1552602855-26086-8-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-8-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom Kernel Feedback List <bcm-kernel-feedback-list@broadcom.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tobias Klauser <tklauser@distanz.ch>, Richard Genoud <richard.genoud@gmail.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Sylvain Lemieux <slemieux.ty>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 15, 2019 at 7:35 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Instead of fetching out data from a struct resource for passing
> it to devm_ioremap(), directly use devm_ioremap_resource()
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---


NACK.


This patch would break my driver.

Probably, all the 8250* drivers would be broken in the same way.


For 8250 drivers, request_mem_region() is called
from 8250_port.c


Let's not touch around the code you do not
understand how it works.


Thanks.

Masahiro Yamada



>  drivers/tty/serial/8250/8250_uniphier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
> index 164ba13..9c1244e 100644
> --- a/drivers/tty/serial/8250/8250_uniphier.c
> +++ b/drivers/tty/serial/8250/8250_uniphier.c
> @@ -171,7 +171,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       membase = devm_ioremap(dev, regs->start, resource_size(regs));
> +       membase = devm_ioremap_resource(dev, regs);
>         if (!membase)
>                 return -ENOMEM;
>
> --
> 1.9.1
>
