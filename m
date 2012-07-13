From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 2/2] serial: mxs-auart: Allow device tree probing
Date: Fri, 13 Jul 2012 12:33:12 +0200
Message-ID: <4FFFF968.5000801@pengutronix.de>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com> <1340024769-7122-1-git-send-email-fabio.estevam@freescale.com> <4FDF929B.7000809@grid-net.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC0C6DC2279395724E2A20075"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37826 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783Ab2GMKdn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Jul 2012 06:33:43 -0400
In-Reply-To: <4FDF929B.7000809@grid-net.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Subodh Nijsure <snijsure@grid-net.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, kernel@pengutronix.de, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, shawn.guo@linaro.org, "Matt@grid-net.com" <Matt@grid-net.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC0C6DC2279395724E2A20075
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/18/2012 10:42 PM, Subodh Nijsure wrote:
>=20
> If one were to try run console on one of the /dev/ttyAPP* ports, as is
> the case for hardware I am working with, console output wouldn't show u=
p
> without the following diff:
>=20
> Let me know if should send formal patch or we can include it as part of=
 v5?

Has this patch been applied?

Marc
>=20
> diff --git a/drivers/tty/serial/mxs-auart.c
> b/drivers/tty/serial/mxs-auart.c
> index ca3d25e..2ced332 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -761,7 +761,7 @@ static int __devinit mxs_auart_probe(struct
> platform_device *pdev)
>=20
>         platform_set_drvdata(pdev, s);
>=20
> -       auart_port[pdev->id] =3D s;
> +       auart_port[s->port.line] =3D s;
>=20
>         mxs_auart_reset(&s->port)
>=20
> -Subodh
>=20
> On 06/18/2012 06:06 AM, Fabio Estevam wrote:
>> Allow device tree probing.
>>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Rob Herring<rob.herring@calxeda.com>
>> Cc: Alan Cox<alan@linux.intel.com>
>> Cc:<linux-serial@vger.kernel.org>
>> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>
>> ---
>> Changes since v3:
>> - Remove unneeded mxs_auart_devtype
>> Changes since v2:
>> - Change compatible string
>> - Add aliases information in bindings doc
>> - Remove unneeded mxs_auart_probe_pdev function
>> - Remove "ifdef CONFIG_OF"
>> - Remove of_match_ptr wrapper
>> Changes since v1:
>> - Merged patches 3 and 5 from v1 into this one
>>   .../bindings/tty/serial/fsl-mxs-auart.txt          |   27 ++++++++++=
+++
>>   drivers/tty/serial/mxs-auart.c                     |   40
>> +++++++++++++++++++-
>>   2 files changed, 66 insertions(+), 1 deletions(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
>> b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
>> new file mode 100644
>> index 0000000..2ee903f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
>> @@ -0,0 +1,27 @@
>> +* Freescale MXS Application UART (AUART)
>> +
>> +Required properties:
>> +- compatible : Should be "fsl,<soc>-auart". The supported SoCs includ=
e
>> +  imx23 and imx28.
>> +- reg : Address and length of the register set for the device
>> +- interrupts : Should contain the auart interrupt numbers
>> +
>> +Example:
>> +auart0: serial@8006a000 {
>> +    compatible =3D "fsl,imx28-auart", "fsl,imx23-auart";
>> +    reg =3D<0x8006a000 0x2000>;
>> +    interrupts =3D<112 70 71>;
>> +};
>> +
>> +Note: Each auart port should have an alias correctly numbered in
>> "aliases"
>> +node.
>> +
>> +Example:
>> +
>> +aliases {
>> +    serial0 =3D&auart0;
>> +    serial1 =3D&auart1;
>> +    serial2 =3D&auart2;
>> +    serial3 =3D&auart3;
>> +    serial4 =3D&auart4;
>> +};
>> diff --git a/drivers/tty/serial/mxs-auart.c
>> b/drivers/tty/serial/mxs-auart.c
>> index ec56d83..103087d 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -33,6 +33,7 @@
>>   #include<linux/delay.h>
>>   #include<linux/io.h>
>>   #include<linux/pinctrl/consumer.h>
>> +#include<linux/of_device.h>
>>
>>   #include<asm/cacheflush.h>
>>
>> @@ -675,6 +676,30 @@ static struct uart_driver auart_driver =3D {
>>   #endif
>>   };
>>
>> +/*
>> + * This function returns 1 if pdev isn't a device instatiated by dt,
>> 0 if it
>> + * could successfully get all information from dt or a negative errno=
=2E
>> + */
>> +static int serial_mxs_probe_dt(struct mxs_auart_port *s,
>> +        struct platform_device *pdev)
>> +{
>> +    struct device_node *np =3D pdev->dev.of_node;
>> +    int ret;
>> +
>> +    if (!np)
>> +        /* no device tree device */
>> +        return 1;
>> +
>> +    ret =3D of_alias_get_id(np, "serial");
>> +    if (ret<  0) {
>> +        dev_err(&pdev->dev, "failed to get alias id: %d\n", ret);
>> +        return ret;
>> +    }
>> +    s->port.line =3D ret;
>> +
>> +    return 0;
>> +}
>> +
>>   static int __devinit mxs_auart_probe(struct platform_device *pdev)
>>   {
>>       struct mxs_auart_port *s;
>> @@ -689,6 +714,12 @@ static int __devinit mxs_auart_probe(struct
>> platform_device *pdev)
>>           goto out;
>>       }
>>
>> +    ret =3D serial_mxs_probe_dt(s, pdev);
>> +    if (ret>  0)
>> +        s->port.line =3D pdev->id<  0 ? 0 : pdev->id;
>> +    else if (ret<  0)
>> +        goto out_free;
>> +
>>       pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev);
>>       if (IS_ERR(pinctrl)) {
>>           ret =3D PTR_ERR(pinctrl);
>> @@ -711,7 +742,6 @@ static int __devinit mxs_auart_probe(struct
>> platform_device *pdev)
>>       s->port.membase =3D ioremap(r->start, resource_size(r));
>>       s->port.ops =3D&mxs_auart_ops;
>>       s->port.iotype =3D UPIO_MEM;
>> -    s->port.line =3D pdev->id<  0 ? 0 : pdev->id;
>>       s->port.fifosize =3D 16;
>>       s->port.uartclk =3D clk_get_rate(s->clk);
>>       s->port.type =3D PORT_IMX;
>> @@ -769,12 +799,19 @@ static int __devexit mxs_auart_remove(struct
>> platform_device *pdev)
>>       return 0;
>>   }
>>
>> +static struct of_device_id mxs_auart_dt_ids[] =3D {
>> +    { .compatible =3D "fsl,imx23-auart", },
>> +    { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mxs_auart_dt_ids);
>> +
>>   static struct platform_driver mxs_auart_driver =3D {
>>       .probe =3D mxs_auart_probe,
>>       .remove =3D __devexit_p(mxs_auart_remove),
>>       .driver =3D {
>>           .name =3D "mxs-auart",
>>           .owner =3D THIS_MODULE,
>> +        .of_match_table =3D mxs_auart_dt_ids,
>>       },
>>   };
>>
>> @@ -807,3 +844,4 @@ module_init(mxs_auart_init);
>>   module_exit(mxs_auart_exit);
>>   MODULE_LICENSE("GPL");
>>   MODULE_DESCRIPTION("Freescale MXS application uart driver");
>> +MODULE_ALIAS("platform:mxs-auart");
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC0C6DC2279395724E2A20075
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk//+WwACgkQjTAFq1RaXHMxMgCgg1Qbp8R1uevHec1aiFo6vbKW
LHMAn0yeNOc3Shgg0VgZmB1lTX0R3rZj
=r9QW
-----END PGP SIGNATURE-----

--------------enigC0C6DC2279395724E2A20075--
