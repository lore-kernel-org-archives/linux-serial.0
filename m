Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D945DC433E9
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 12:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6A465033
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 12:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhCEMnU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 07:43:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37744 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbhCEMm4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 07:42:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D6A701F40EA4
Received: by earth.universe (Postfix, from userid 1000)
        id CDD143C0C96; Fri,  5 Mar 2021 13:42:52 +0100 (CET)
Date:   Fri, 5 Mar 2021 13:42:52 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv4] serial: imx: Add DMA buffer configuration via sysfs
Message-ID: <20210305124252.c3ffgca6wjqpkn45@earth.universe>
References: <20210305115058.92284-1-sebastian.reichel@collabora.com>
 <YEIetFdcuYZU98s/@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="66fnbwp2soxqs2g5"
Content-Disposition: inline
In-Reply-To: <YEIetFdcuYZU98s/@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--66fnbwp2soxqs2g5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, Mar 05, 2021 at 01:06:12PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 05, 2021 at 12:50:58PM +0100, Sebastian Reichel wrote:
> > From: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> >=20
> > In order to optimize serial communication (performance/throughput VS
> > latency), we may need to tweak DMA period number and size. This adds
> > sysfs attributes to configure those values before initialising DMA.
> > The defaults will stay the same as before (16 buffers with a size of
> > 1024 bytes). Afterwards the values can be read/write with the
> > following sysfs files:
> >=20
> > /sys/class/tty/ttymxc*/dma_buffer_size
> > /sys/class/tty/ttymxc*/dma_buffer_count
>=20
> Ick no.  Custom sysfs attributes for things like serial ports are crazy.
>=20
> > This is mainly needed for GEHC CS ONE (arch/arm/boot/dts/imx53-ppd.dts),
> > which has multiple microcontrollers connected via UART controlling. One
> > of the UARTs is connected to an on-board microcontroller at 19200 baud,
> > which constantly pushes critical data (so aging character detect
> > interrupt will never trigger). This data must be processed at 50-200 Hz,
> > so UART should return data in less than 5-20ms. With 1024 byte DMA
> > buffer (and a constant data stream) the read operation instead needs
> > 1024 byte / 19200 baud =3D 53.333ms, which is way too long (note: Worst
> > Case would be remote processor sending data with short pauses <=3D 7
> > characters, which would further increase this number). The current
> > downstream kernel instead configures 24 bytes resulting in 1.25ms,
> > but that is obviously not sensible for normal UART use cases and cannot
> > be used as new default.
>=20
> Why can't this be a device tree attribute? Why does this have to be a
> sysfs thing that no one will know how to tune and set over time.  This
> hardware should not force a user to manually tune it to get it to work
> properly, this isn't the 1990's anymore :(
>=20
> Please never force a user to choose stuff like this, they never will
> know what to do.

This used to be a DT attribute in PATCHv1. It has been moved over to
sysfs since PATCHv2, since it does not describe the hardware, but
configuration. Unfortunately lore.kernel.org does not have the full
thread, but this is the discussion:

https://lore.kernel.org/linux-serial/20170629182618.jpahpmuq364ldcv2@pengut=
ronix.de/

=46rom downstream POV this can be done either by adding a DT property
to the UART node, or by adding a udev rule.

=46rom my POV there is not a huge difference. In both cases we will
be bound by an ABI afterwards, in both cases people will usually
stick to the default value and in both cases people that do deviate
=66rom the default probably ran into problems and started to look
for a solution.

Thanks,

-- Sebastian

--66fnbwp2soxqs2g5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBCJ0QACgkQ2O7X88g7
+prIHg/7BN/DGiQXMineQuVl0TvfhROTkESg7Wf58yyWPCWWZVCyVHf4Mcebebq7
+0umIHr8gf5d2K78CdfCuflLpl36JCdP2lhYPR1qXnMBOPlN182JdUqtqyLX88z8
0yTfO20adwNIxld0Bpucc8cquwS2RPP4jWDyrdhU8H2RJEk+pUaQD4TsXRTSwcvd
sIyKTBCDVgfmKwrDJ97iHJhKLddF7ys0z4qF8W/oZIVCJTCljsuLKNx+sxrjhO87
vKxuGM/9LOhaIyfRo2byMeqfNiwEGQGXXSyPPRz0PvBLj5Ftz/SkLuCD+nOxpWLk
KjU6qs0tb9y7X2IYnx3G2Xocep6FxuKGifmMtVJyBpxMdLnSDm6VjCXSouhLaQIi
caVHBa97kJbbfPKihFQvgMNRE+beqN5+z11REtUPH10c68OBdU3RieTK7lxz+gGb
+4tBSKmpkaHCwWf1tjonc4QBfPi3H1vc2ZxafXiHsYAvFgjuupy1Ddfk2Wzt6aFu
rQrGCrHOfKXFA2vPF29wva2q/i5f7SHiOmSliwYL7+Zsu3CoIBHzbMxOtdg60Txs
JLw/JV7Ac/38Xnic7DMBC/W1z9LxyoAoNyje/PRVPQmDgDKMX3Zjh6tKmcNnCgV6
hYFWmQgjptGQctxYHMJTVx9Y6qoO2dTz246QWY/x7/OZdC2+igs=
=vMr7
-----END PGP SIGNATURE-----

--66fnbwp2soxqs2g5--
