Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A635C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 10:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbhKVKJ1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 05:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbhKVKJ0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 05:09:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03E8C061574
        for <linux-serial@vger.kernel.org>; Mon, 22 Nov 2021 02:06:19 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mp6DA-0003Hk-At; Mon, 22 Nov 2021 11:06:08 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-c7fb-0fe8-e8cb-8e33.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:c7fb:fe8:e8cb:8e33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 10E016B225F;
        Mon, 22 Nov 2021 09:53:22 +0000 (UTC)
Date:   Mon, 22 Nov 2021 10:53:20 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] tty: remove file from tty_ldisc_ops::ioctl and
 compat_ioctl
Message-ID: <20211122095320.uvh2iiaanltch2i4@pengutronix.de>
References: <20211122094529.24171-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wvldmge2peafb4pr"
Content-Disposition: inline
In-Reply-To: <20211122094529.24171-1-jslaby@suse.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--wvldmge2peafb4pr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.11.2021 10:45:29, Jiri Slaby wrote:
> After the previous patches, noone needs 'file' parameter in neither
> ioctl hook from tty_ldisc_ops. So remove 'file' from both of them.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> [NFC]
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
> [v2]
>  - keep arguments aligned as they were as noted by Dmitry.
>=20
>  drivers/bluetooth/hci_ldisc.c |  5 ++---
>  drivers/input/serio/serport.c |  5 ++---
>  drivers/net/can/slcan.c       |  4 ++--

For the slcan.c:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wvldmge2peafb4pr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGbaI4ACgkQqclaivrt
76mm+Qf/ezBzStNQXffSEEFgANnNcfLIjdtGu/f1w1NpLmCZEWmNAuj6+NOWbPEP
6p6ukPgXjgbyu+YnfXBKRmJbrFNSmKpD6RxIM8qAiX8I3Nl9NhtFGaKw7i4vBUW/
LQLElzpZQ2KgulE3JiPhOx6AVE8bH/XFWaoHnvj9xz29pQBpx7Xj35B/7O0/z11m
R7PpR3KiyZ0+g1SbnV5XDBN0wtam5qCcD/4Zt0nPU5fMBm8DShY+vcCkuYL+TLLv
VV7oSLLC+qt5yA8jywHcWdArGp5B500uz7TFNocgKdMbrh+rXh8LzzQbbIugUQ14
aXcnqJxErpNumQk52yUfT60dCA2dow==
=KNUz
-----END PGP SIGNATURE-----

--wvldmge2peafb4pr--
