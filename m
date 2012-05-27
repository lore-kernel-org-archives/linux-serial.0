From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC] serial/8250: Adjusting FIFO parameters for LPC32xx
Date: Sun, 27 May 2012 10:23:16 +0000
Message-ID: <201205271023.16742.arnd@arndb.de>
References: <1338048678-23991-1-git-send-email-stigge@antcom.de> <201205270232.58253.arnd@arndb.de> <4FC1EEA7.2060109@antcom.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61449 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab2E0KXf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 May 2012 06:23:35 -0400
In-Reply-To: <4FC1EEA7.2060109@antcom.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, linux-arm-kernel@lists.infradead.org

On Sunday 27 May 2012, Roland Stigge wrote:
> I did it via the following modification in of_serial.c:
>=20
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -179,6 +179,7 @@ static struct of_device_id __devinitdata of_platf=
orm_serial_table[] =3D {
>         { .compatible =3D "ns16450",  .data =3D (void *)PORT_16450, }=
,
>         { .compatible =3D "ns16550a", .data =3D (void *)PORT_16550A, =
},
>         { .compatible =3D "ns16550",  .data =3D (void *)PORT_16550, }=
,
> +       { .compatible =3D "ns16654",  .data =3D (void *)PORT_16654, }=
,
>         { .compatible =3D "ns16750",  .data =3D (void *)PORT_16750, }=
,
>         { .compatible =3D "ns16850",  .data =3D (void *)PORT_16850, }=
,
>         { .compatible =3D "nvidia,tegra20-uart", .data =3D (void *)PO=
RT_TEGRA, },
>=20
> Works for now, will need to test more thoroughly with LPC32xx (note t=
hat
> the manual explicitly mentions "downwards compatible with the INS16Cx=
50"
> and "Register locations conform to =E2=80=98550 industry standard" bu=
t nothing
> about an EFR register which 16654 is configured for in 8250.c).
>=20
> The patch should be useful in of_serial anyway (even without the LPC3=
2xx
> case).
>=20
> Wondering if it should rather be .compatible =3D "st16654"?
> Will prepare a patch with adjustment of Documentation/.../of-serial.t=
xt when
> we agree on sth.

I think st16654 would be better than ns16654 here, yes.

Actually some of the other entries are wrong, too. The ns8250 entry sho=
uld
be i8250, and I guess the 16750 and 16850 were also not made by nationa=
l.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
