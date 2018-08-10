From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC] serial: sc16is7xx: Use DT sub-nodes for UART ports
Date: Fri, 10 Aug 2018 11:34:00 -0600
Message-ID: <CAL_Jsq+f5VMWZg9GNF=e-UmFjcjbVnE7Dr0EBF56E6gUrdTnuQ@mail.gmail.com>
References: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
 <20180805232651.10605-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180805232651.10605-1-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-MIPS <linux-mips@linux-mips.org>, jringle@gridpoint.com, Michael Allwright <allsey87@gmail.com>, Jakub Kicinski <kubakici@wp.pl>, liuxuenetmail@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Aug 5, 2018 at 5:27 PM Andreas F=C3=A4rber <afaerber@suse.de> wrote=
:
>
> This is to allow using serdev.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
> index 243c96025053..ad7267274f65 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1213,9 +1213,31 @@ static int sc16is7xx_probe(struct device *dev,
>                         SC16IS7XX_IOCONTROL_SRESET_BIT);
>
>         for (i =3D 0; i < devtype->nr_uart; ++i) {
> +#ifdef CONFIG_OF
> +               struct device_node *np;
> +               struct platform_device *pdev;
> +               char name[6] =3D "uartx";
> +#endif
> +
>                 s->p[i].line            =3D i;
>                 /* Initialize port data */
> +#ifdef CONFIG_OF
> +               name[4] =3D '0' + i;
> +               np =3D of_get_child_by_name(dev->of_node, name);
> +               if (IS_ERR(np)) {
> +                       ret =3D PTR_ERR(np);
> +                       goto out_ports;
> +               }
> +               pdev =3D of_platform_device_create(np, NULL, dev);

Ideally, you would use of_platform_default_populate here. I think
you'd have to add a compatible to the child nodes, but that wouldn't
be a bad thing. I could envision that the child nodes ultimately
become their own driver utilizing the standard 8250 driver and a
compatible string would be needed in that case.

You'd then have to loop over each child of 'dev' instead of the DT nodes.

> +               if (IS_ERR(pdev)) {
> +                       ret =3D PTR_ERR(pdev);
> +                       goto out_ports;
> +               }
> +               platform_set_drvdata(pdev, dev_get_drvdata(dev));
> +               s->p[i].port.dev        =3D &pdev->dev;
> +#else
>                 s->p[i].port.dev        =3D dev;
> +#endif
>                 s->p[i].port.irq        =3D irq;
>                 s->p[i].port.type       =3D PORT_SC16IS7XX;
>                 s->p[i].port.fifosize   =3D SC16IS7XX_FIFO_SIZE;
