From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH v1] tty: serial: max310x: Add optional reset gpio
Date: Tue, 02 Jul 2019 16:44:20 +0200
Message-ID: <d9ac1295-e780-409d-b7de-b4c2db586e58@cesnet.cz>
References: <20190614141112.29962-1-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614141112.29962-1-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
List-Id: linux-serial@vger.kernel.org

On p=C3=A1tek 14. =C4=8Dervna 2019 16:11:12 CEST, Myl=C3=A8ne Josserand wrote=
:
> --- a/Documentation/devicetree/bindings/serial/maxim,max310x.txt
> +++ b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
> @@ -15,6 +15,7 @@ Required properties:
>    "osc" if an external clock source is used.
> =20
>  Optional properties:
> +- reset-gpios: Gpio to use for reset.

"GPIO", not "Gpio", for consistency.

>  =09if (spi->dev.of_node) {
> +=09=09struct gpio_desc *reset_gpio;
>  =09=09const struct of_device_id *of_id =3D
>  =09=09=09of_match_device(max310x_dt_ids, &spi->dev);
>  =09=09if (!of_id)
>  =09=09=09return -ENODEV;
> =20
>  =09=09devtype =3D (struct max310x_devtype *)of_id->data;
> +=09=09reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset",
> +=09=09=09=09=09=09     GPIOD_OUT_HIGH);
> +=09=09if (IS_ERR(reset_gpio))
> +=09=09=09return PTR_ERR(reset_gpio);
> +=09=09gpiod_set_value_cansleep(reset_gpio, 0);
>  =09} else {

The RST signal is active-low on the chip, but the code initializes the=20
output to GPIOD_OUT_HIGH. Are you perhaps relying on a DT binding setting=20
an ACTIVE_LOW flag on the reset GPIO lane? This should be documented.

Assuming that this polarity inversion works, the code first asserts the=20
reset, then it performs no explicit waiting, and then it clears the RST=20
signal. I checked MAX14830's datasheet, and there's no minimal reset=20
duration, so perhaps this is safe, but it looks a bit odd to me.

With kind regards,
Jan
