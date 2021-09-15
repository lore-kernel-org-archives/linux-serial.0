Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BCCC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 08:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C9E61185
	for <linux-serial@archiver.kernel.org>; Wed, 15 Sep 2021 08:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhIOIGQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbhIOIDn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Sep 2021 04:03:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BD9C061575
        for <linux-serial@vger.kernel.org>; Wed, 15 Sep 2021 01:02:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mQPrt-0002Vm-AT; Wed, 15 Sep 2021 10:02:09 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:8a97:9358:ae:5dc8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E740867E50E;
        Wed, 15 Sep 2021 08:02:03 +0000 (UTC)
Date:   Wed, 15 Sep 2021 10:02:02 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 07/16] tty: remove file from tty_ldisc_ops::ioctl and
 compat_ioctl
Message-ID: <20210915080202.ecgdt34lwas3s7df@pengutronix.de>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-7-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="43j3xayf5qo5ebvb"
Content-Disposition: inline
In-Reply-To: <20210914091134.17426-7-jslaby@suse.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--43j3xayf5qo5ebvb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.09.2021 11:11:25, Jiri Slaby wrote:
> After the previous patches, noone needs 'file' parameter in neither
> ioctl hook from tty_ldisc_ops. So remove 'file' from both of them.
>=20
[...]
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index 9a4ebda30510..de2da1b09a79 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -670,8 +670,8 @@ static void slcan_hangup(struct tty_struct *tty)
>  }
> =20
>  /* Perform I/O control on an active SLCAN channel. */
> -static int slcan_ioctl(struct tty_struct *tty, struct file *file,
> -		       unsigned int cmd, unsigned long arg)
> +static int slcan_ioctl(struct tty_struct *tty, unsigned int cmd,
> +		unsigned long arg)
>  {
>  	struct slcan *sl =3D (struct slcan *) tty->disc_data;
>  	unsigned int tmp;

nitpick:
Checkpatch complains about this:

| CHECK: Alignment should match open parenthesis
| #674: FILE: drivers/net/can/slcan.c:674:
| +static int slcan_ioctl(struct tty_struct *tty, unsigned int cmd,
| +               unsigned long arg)

Same for other hunks in this file.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--43j3xayf5qo5ebvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmFBqHcACgkQqclaivrt
76lOsQf+NcL3akVLazO267pyqBA8tvSCpRf29/7Z8wqJ5Z2oTi61D+CA/H68iXcg
GgjwGBXOMJVTtJN7YvxclkONrchsZeOzq5KfgcLpFWQj0VUKAguY5K/LYrLi+wXd
JPubokNx2N9QWNF4WGlP50Qe/l69HuL5qOJ9Izfim0E6lqKYmPebKInL6XoBP3FD
lP7ZZf56yoJ91hBnjMEf0ulasx6Z1T94oyH0JOqv2lP5iOoF/rHUsHpsPHy+5IiR
57uatCwXcVt/vskseP7NnTC8wsl4FlcnCMxjiGvKrX8Y7gsWcvAx2J3ivty4D7tF
dJK27i6HibLd1ATbLxnb4RFnxw1UEw==
=SNmx
-----END PGP SIGNATURE-----

--43j3xayf5qo5ebvb--
