Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA382C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jan 2022 10:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbiAEK5N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jan 2022 05:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiAEK5M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jan 2022 05:57:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB60C061761
        for <linux-serial@vger.kernel.org>; Wed,  5 Jan 2022 02:57:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n53yb-00088L-4z; Wed, 05 Jan 2022 11:57:05 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-7899-4998-133d-b4b9.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:7899:4998:133d:b4b9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5AF1C6D18A3;
        Wed,  5 Jan 2022 10:57:03 +0000 (UTC)
Date:   Wed, 5 Jan 2022 11:57:02 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        k.drobinski@camlintechnologies.com
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
Message-ID: <20220105105702.vrz7u3nam27izwah@pengutronix.de>
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <YdQndwYc9xaauvpS@kroah.com>
 <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
 <YdQxmQ+OMCrabg2u@kroah.com>
 <20220104224900.u3omfbilejx2jawr@pengutronix.de>
 <4c48200b-cc2e-0766-a002-831a789d4879@camlingroup.com>
 <YdV00WYGGd49WYt9@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5wlq3p55oytqdc3h"
Content-Disposition: inline
In-Reply-To: <YdV00WYGGd49WYt9@kroah.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--5wlq3p55oytqdc3h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.01.2022 11:37:05, Greg Kroah-Hartman wrote:
> On Wed, Jan 05, 2022 at 08:59:09AM +0100, Tomasz Mo=C5=84 wrote:
> > On 04.01.2022 23:49, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Jan 04, 2022 at 12:38:01PM +0100, Greg Kroah-Hartman wrote:
> > >> On Tue, Jan 04, 2022 at 12:13:06PM +0100, Tomasz Mo=C5=84 wrote:
> > >>> On 04.01.2022 11:54, Greg Kroah-Hartman wrote:
> > >>>> Why can't you do this dynamically based on the baud rate so as to =
always
> > >>>> work properly for all speeds without increased delays for slower o=
nes?
> > >>>
> > >>> Could you please advise on which baud rates to consider as slow? Do=
es it
> > >>> sound good to have the old trigger level for rates up to and includ=
ing
> > >>> 115200 and the new one for faster ones?
> > >>
> > >> You tell me, you are the one seeing this issue and are seeing delays=
 on
> > >> slower values with your change.  Do some testing to see where the cu=
rve
> > >> is.
> >=20
> > While the increased latency due to this change is undeniable, it is
> > important to note that latency is not everything. There are applications
> > where the latency is crucial, however using Linux for such applications
> > is questionable. Linux is not a Real Time Operating System after all.
>=20
> Yes, Linux can be used in real time situtations just fine, look at the
> RT patchset for proof of that.
>=20
> So let's not make things any worse for no good reason if at all
> possible.

+1

We have a $CUSTOMER, where serial latency is crucial. And we have a task
to cut down latencies and jitter even more.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5wlq3p55oytqdc3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHVeXsACgkQqclaivrt
76l+Qwf/YWitn8APufBNgU4+dgTHNsMK5ArklPxAAK37cD3Dn+S1ATaRiRFzMcMV
QemXYKmsdP2A+lN0RF+poNpeXORKWP3DUIVx6YiBxqzpkYeKRBKOCHC8bBtGzpmX
RGLMDYPqv9VPJDpuFD/gBaDPum0p9sz+bph0Z43DlUTAAotKT926FJHiZGKwpYk/
+QoOrCAwdoemv83zrASaKeRvLgiVsiRYbRaPABkkFq5YOWnmPYf6lKzxuUE1gfwb
KdtsBpIVz4HWViMmcG4oLrHDqKP9pvxZOxNB47nchoEMJpGBYleJzH+7rBgS9Az6
sxEhetc2Ik1PPzBv8wJdExpmpGibIQ==
=UEzv
-----END PGP SIGNATURE-----

--5wlq3p55oytqdc3h--
