From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 16:59:24 +0100
Message-ID: <20141117155924.GK27002@pengutronix.de>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de>
 <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de>
 <54693A51.5080907@elproma.com.pl>
 <CACQ1gAjpXnnUPOj3paMGeB=NeQWR_7p6k8WPdxS9YzLakphBhw@mail.gmail.com>
 <546A09EC.8080809@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <546A09EC.8080809@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Richard Genoud <richard.genoud@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 17, 2014 at 03:45:00PM +0100, Janusz U=C5=BCycki wrote:
> W dniu 2014-11-17 o 10:26, Richard Genoud pisze:
> >And, honestly, I'm not sure dev_name(dev) is a good name.
> >Having something like dev_name(dev)_port_id_CTS may be better.
> >
>=20
> For names other than device's or driver's name I would need to alloca=
te
> string. Is it so important? You can simple check the interrupt and
> corresponding port:
> cat /proc/interrupts
>  50:          0  gpio-mxs  21  80072000.serial
>  80:          0  gpio-mxs  18  8006c000.serial
>  81:          0  gpio-mxs  19  8006c000.serial
>  83:          0  gpio-mxs  21  8006c000.serial
>  84:          0  gpio-mxs  22  8006c000.serial
I'd say this is good enough.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
