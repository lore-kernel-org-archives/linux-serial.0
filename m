Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97676C6FD1F
	for <linux-serial@archiver.kernel.org>; Sat, 25 Mar 2023 15:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjCYPLO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Mar 2023 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYPLN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Mar 2023 11:11:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C57E93DE
        for <linux-serial@vger.kernel.org>; Sat, 25 Mar 2023 08:11:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pg5Xu-0004fG-1f; Sat, 25 Mar 2023 16:11:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pg5Xq-006dug-1a; Sat, 25 Mar 2023 16:11:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pg5Xp-007tpK-8I; Sat, 25 Mar 2023 16:11:01 +0100
Date:   Sat, 25 Mar 2023 16:11:00 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Message-ID: <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
 <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="srcremaa3dbmsq3b"
Content-Disposition: inline
In-Reply-To: <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--srcremaa3dbmsq3b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Mar 25, 2023 at 12:31:01PM +0100, Stefan Wahren wrote:
> Am 24.03.23 um 16:00 schrieb Stefan Wahren:
> > Am 24.03.23 um 13:57 schrieb Fabio Estevam:
> > > On Fri, Mar 24, 2023 at 8:48=E2=80=AFAM Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > >=20
> > > > This has come up earlier, see e.g.:
> > > >=20
> > > > https://lore.kernel.org/linux-serial/20221003110850.GA28338@frances=
co-nb.int.toradex.com/
> > > >=20
> > > > My somewhat uninformed suggestion: if the overrun problems
> > > > mostly show up
> > > > with console ports, maybe the trigger level could depend on the port
> > > > being a console or not?
> > > Does the change below help? Taking Ilpo's suggestion into account:
> > this breaks the boot / debug console completely, but i got the idea.
> > >=20
>=20
> based on your patch, i successfully tested this:
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index f07c4f9ff13c..1aacaa637ede 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1277,6 +1277,7 @@ static void imx_uart_clear_rx_errors(struct imx_port
> *sport)
>  }
>=20
>  #define TXTL_DEFAULT 2 /* reset default */
> +#define RXTL_DEFAULT_CONSOLE 1 /* reset default */
>  #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
>  #define TXTL_DMA 8 /* DMA burst setting */
>  #define RXTL_DMA 9 /* DMA burst setting */
> @@ -1286,6 +1287,9 @@ static void imx_uart_setup_ufcr(struct imx_port
> *sport,
>  {
>  	unsigned int val;
>=20
> +	if (uart_console(&sport->port))
> +		rxwl =3D RXTL_DEFAULT_CONSOLE; // fallback
> +
>  	/* set receiver / transmitter trigger level */
>  	val =3D imx_uart_readl(sport, UFCR) & (UFCR_RFDIV | UFCR_DCEDTE);
>  	val |=3D txwl << UFCR_TXTL_SHF | rxwl;

So the current theory that the issue occurs because of a combination of:

 - With a higher watermark value the irq triggers later and so there is
   less time the until the ISR must run before an overflow happens; and

 - serial console activity disables irqs for a (relative) long time

right?

So on an UP system the problem should occur also on a non-console port?
Local irqs are only disabled if some printk is about to be emitted,
isn't it? Does this match the error you're seeing?

That makes me wonder if the error doesn't relate to the UART being a
console port, but the UART being used without DMA?! (So the patch above
fixes the problem for you because on the console port no DMA is used?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--srcremaa3dbmsq3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQfDwMACgkQj4D7WH0S
/k6lJAf3Y34z5uyazjszrejNSoveZGIWbK0aHq2LeE53OdiOT5EK/Hnz/jEy1bt7
r9FCOpiNR5qB5CtT184oslRyMObSvjhnWx88enkOwvH8+beY0821rd0amGVYYmqf
2Vq7Xuv2pmVijjY2462pdkz146r7hxbBcsJymiL27UTvnSodKYebKv6Z0NPY36kF
ouqsOwTXTxffHBPmcPwXtoivAP0XOtVlKWK4U2vaSCBvar+GVURzlVz+zK8TvnJ9
UcwCE/eEWsp2RjJN/yke5zBm1GYI7Ukke5mw19UjhrRAS+DXJiNKof+zb5+lVojr
sH0VAj/ApPHGXEXDjboltSaasOOS
=scZK
-----END PGP SIGNATURE-----

--srcremaa3dbmsq3b--
