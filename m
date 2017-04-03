From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC] serial: imx: support an enable-gpio
Date: Mon, 3 Apr 2017 12:01:11 -0300
Message-ID: <CAOMZO5A4e7H-6feNN-cTABOKv+CUCU9Em_yFMhorZwXfeA-h0w@mail.gmail.com>
References: <1468400495-10471-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1468400495-10471-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Uwe,

On Wed, Jul 13, 2016 at 6:01 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> A part of my machine looks as follows (simplified):
>
> ,------------------------.
> | ,---------.            |
> | |  imx25  o--RX----=E2=97=81---o---
> | |         o--GPIO--'   |
> | `---------'            |
> `------------------------'
>
> that is, there is a driver on the RX line that must be enabled before
> the UART can be used. (That is necessary because the default mux of the
> RX pad after reset is an output.)
>
> To represent this in the device tree I do:
>
>         pinctrl_uart5: uart5 {
>                 fsl,pins =3D <
>                         ...
>                         MX25_PAD_LBA__UART5_RXD         0x00000000
>                         MX25_PAD_CS5__GPIO_3_21         0x00002001
>                         ...
>         };
>
>         &uart5 {
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&pinctrl_uart5>;
>
>                 enable-gpio =3D <&gpio3 21 GPIO_ACTIVE_LOW>;
>                 ...
>         };
>
> This way it's ensured that the gpio is only enabled when the LBA pad is
> muxed as RX (together with the bootloader that sets the GPIO high).
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Since this is not imx serial specific it could be made more generic.

What about extending
Documentation/devicetree/bindings/serial/slave-device.txt to handle
this GPIO, or maybe a regulator?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
