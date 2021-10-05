Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD99C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 20:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6155961423
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 20:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhJEUT5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhJEUTq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Oct 2021 16:19:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6C6C061749
        for <linux-serial@vger.kernel.org>; Tue,  5 Oct 2021 13:17:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXqso-00073q-Si; Tue, 05 Oct 2021 22:17:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXqsn-0003ID-FA; Tue, 05 Oct 2021 22:17:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXqsn-0007WD-EI; Tue, 05 Oct 2021 22:17:49 +0200
Date:   Tue, 5 Oct 2021 22:17:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel@collabora.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv5 0/2] Fix imx53-ppd UART configuration
Message-ID: <20211005201749.kpqkb5fxnavrqq2b@pengutronix.de>
References: <20210430175038.103226-1-sebastian.reichel@collabora.com>
 <YIzxKNV4x6/8GVrB@kroah.com>
 <20210528004952.r2dnoxetqdi655d6@earth.universe>
 <YLCx+jhg/j+JmBox@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="byohcmgerwetgykq"
Content-Disposition: inline
In-Reply-To: <YLCx+jhg/j+JmBox@kroah.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--byohcmgerwetgykq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

[adding Rob and devicetree@vger to Cc:]

On Fri, May 28, 2021 at 11:03:54AM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 28, 2021 at 02:49:52AM +0200, Sebastian Reichel wrote:
> > On Sat, May 01, 2021 at 08:11:52AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 30, 2021 at 07:50:36PM +0200, Sebastian Reichel wrote:
> > > > IMHO PATCHv4 was better, but in the end I don't have strong feelings
> > > > about this. Btw. I think this patchset is a good demonstration of
> > > > frustrating upstream kernel development can be considering PATCHv5
> > > > is basically the same as PATCHv1. Thanks for making us go in
> > > > circles :(

I was the one who objected the v1 approach. My frustration is that I
wasn't Cc:d in the later iterations of this patch set. And I also liked
v4 better :-\

> > > > Changes since PATCHv4:
> > > >  * https://lore.kernel.org/lkml/20210305115058.92284-1-sebastian.re=
ichel@collabora.com/
> > > >  * use DT property instead of sysfs config option, like the initial=
 patch
> > > >    version did as requested by Greg.
> > > >=20
> > > > Changes since PATCHv3:
> > > >  * https://lore.kernel.org/lkml/1539249903-6316-1-git-send-email-fa=
bien.lahoudere@collabora.com/
> > > >  * rewrote commit message to provide a lot more details why this is=
 needed
> > > >  * rebased to torvalds/master (5.12-rc1-dontuse), also applies on t=
op of linux-next
> > > >  * use sysfs_emit() instead of sprintf
> > > >=20
> > > > -- Sebastian
> > > >=20
> > > > Fabien Lahoudere (2):
> > > >   serial: imx: Add DMA buffer configuration via DT
> > > >   ARM: dts: imx53-ppd: add dma-info nodes
> > > >=20
> > > >  .../bindings/serial/fsl-imx-uart.yaml         | 12 +++++++++
> > > >  arch/arm/boot/dts/imx53-ppd.dts               |  2 ++
> > > >  drivers/tty/serial/imx.c                      | 25 +++++++++++++--=
----
> > > >  3 files changed, 32 insertions(+), 7 deletions(-)
> > >
> > > This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
> > > You have sent him a patch that has triggered this response.
> > >=20
> > > Right now, the development tree you have sent a patch for is "closed"
> > > due to the timing of the merge window.  Don't worry, the patch(es) you
> > > have sent are not lost, and will be looked at after the merge window =
is
> > > over (after the -rc1 kernel is released by Linus).
> > >=20
> > > So thank you for your patience and your patches will be reviewed at t=
his
> > > later time, you do not have to do anything further, this is just a sh=
ort
> > > note to let you know the patch status and so you don't worry they did=
n't
> > > make it through.
> > >=20
> > > thanks,
> > >=20
> > > greg k-h's patch email bot
> >=20
> > Any update on this? :)
>=20
> I'm waiting for the DT maintainers to review the new changes before I
> can take the driver changes.

I wonder what the DT maintainers said (and where [1]). The patch was
applied (db0a196bd8ad1d6bb4b1a9e54f54c09f8dc2cc25) and I think that's
wrong (as it was in v1) because fsl,dma-info isn't about hardware
description but about software tuning for different use cases.

Best regards
Uwe

[1] neither my mailbox nor lore.kernel.org know about an answer.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--byohcmgerwetgykq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFcsukACgkQwfwUeK3K
7AnvgQf6AvyOmBCat9XRIRXje1sgZfVrkVbTup4o+usJVlr4zG8qPWSwj83FMwRg
pn4XPKlyhA4A5ss//cjbhX/IJMTum0K4yWGtDwa0BMa5clVhesNzqm1nqsD/zwzb
kUNBPSx9Z/QEWXDHgERNLNe30UWIaY/6weCuuZHpHW2/IIjwxoALYD6wX7KN17ip
161roKmpjTk+Sv7whWWWN1k7lviGd/dyQHRlauy+ZG4tDRyS3Cp+srHybTly9asa
4layMre3zXoYxdH/rZxyQWOWCXnmHbjdICZkaesfaP7C8hUswMCqPp3pKB8t9tdk
UWLbhtdROeA9jABtVYSnqHwRBiqHjg==
=lmJz
-----END PGP SIGNATURE-----

--byohcmgerwetgykq--
