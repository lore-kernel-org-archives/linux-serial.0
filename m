Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69BCC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jan 2022 13:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiAENEo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jan 2022 08:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiAENEn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jan 2022 08:04:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A652C061761
        for <linux-serial@vger.kernel.org>; Wed,  5 Jan 2022 05:04:43 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n55xz-0002mR-Mu; Wed, 05 Jan 2022 14:04:35 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-7899-4998-133d-b4b9.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:7899:4998:133d:b4b9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 94DEA6D199B;
        Wed,  5 Jan 2022 13:04:32 +0000 (UTC)
Date:   Wed, 5 Jan 2022 14:04:31 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        k.drobinski@camlintechnologies.com,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
Message-ID: <20220105130431.b3vb2icesuedaavk@pengutronix.de>
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <YdQndwYc9xaauvpS@kroah.com>
 <877dbe5oct.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n5wwdknbsiwokrkw"
Content-Disposition: inline
In-Reply-To: <877dbe5oct.fsf@osv.gnss.ru>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--n5wwdknbsiwokrkw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.01.2022 16:00:34, Sergey Organov wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>=20
> > On Tue, Jan 04, 2022 at 11:32:03AM +0100, Tomasz Mo=C5=84 wrote:
> >> Triggering RX interrupt for every byte defeats the purpose of aging
> >> timer and leads to interrupt starvation at high baud rates.
> >>=20
> >> Increase receiver trigger level to 8 to increase the minimum period
> >> between RX interrupts to 8 characters time. The tradeoff is increased
> >> latency. In the worst case scenario, where RX data has intercharacter
> >> delay slightly less than aging timer (8 characters time), it can take
> >> up to 63 characters time for the interrupt to be raised since the
> >> reception of the first character.
> >
> > Why can't you do this dynamically based on the baud rate so as to always
> > work properly for all speeds without increased delays for slower ones?
>=20
> I don't like the idea of dynamic threshold as I don't think increased
> complexity is worth it.
>=20
> In fact the threshold works "properly" on any baud rate, as maximum
> latency is proportional to the current baud rate, and if somebody does
> care about *absolute* latency, increasing baud rate is the primary
> solution.

Nope - this only works if you have both sides under control.... Which is
not the case in our $CUSTROMER's use case.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--n5wwdknbsiwokrkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHVl1sACgkQqclaivrt
76lrigf/XMVMiydcKDCJG2w4FJaETuICVfRXcUZdA3wZt22JPaXyFtyiAlri1hSl
vmtbcRNbl100Uf5Bg8CHC9M+hbY9N6fdyHmph8K8FjR8UXs6ulwjd9Dc86ENp9SM
DjEHE5OVDf30UB7wu2sMEoBA8VuNasDfJEpByG793x+VuzC4dj2nTZNLBv8SokfS
IgXUnIZ9vxrhIheighJHHhwjY1Ca/QuhZngELSfMs9g9J6tppCBmE21SUDNOd5SZ
vQHjSuiIk9/Av77RnN2QKhgl1to9PD7rfc+p0dERHA0+BCgcrQh0kuApcLF3VTth
nIB6KH7LMojb4t+FYk3rK8MyyRXjgA==
=g9dw
-----END PGP SIGNATURE-----

--n5wwdknbsiwokrkw--
