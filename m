Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21BEC433B4
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 21:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB31613C0
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 21:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbhDEVo5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Apr 2021 17:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbhDEVo4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Apr 2021 17:44:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA1C061756;
        Mon,  5 Apr 2021 14:44:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5DB6B1F4469E
Received: by earth.universe (Postfix, from userid 1000)
        id 7CEDA3C0C96; Mon,  5 Apr 2021 23:44:46 +0200 (CEST)
Date:   Mon, 5 Apr 2021 23:44:46 +0200
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
Message-ID: <20210405214446.zhidvtvahcfp4wxa@earth.universe>
References: <20210305115058.92284-1-sebastian.reichel@collabora.com>
 <YEIetFdcuYZU98s/@kroah.com>
 <20210305124252.c3ffgca6wjqpkn45@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jyl37mmk7opoozsa"
Content-Disposition: inline
In-Reply-To: <20210305124252.c3ffgca6wjqpkn45@earth.universe>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--jyl37mmk7opoozsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 05, 2021 at 01:42:52PM +0100, Sebastian Reichel wrote:
> On Fri, Mar 05, 2021 at 01:06:12PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 05, 2021 at 12:50:58PM +0100, Sebastian Reichel wrote:
> > > From: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > >=20
> > > In order to optimize serial communication (performance/throughput VS
> > > latency), we may need to tweak DMA period number and size. This adds
> > > sysfs attributes to configure those values before initialising DMA.
> > > The defaults will stay the same as before (16 buffers with a size of
> > > 1024 bytes). Afterwards the values can be read/write with the
> > > following sysfs files:
> > >=20
> > > /sys/class/tty/ttymxc*/dma_buffer_size
> > > /sys/class/tty/ttymxc*/dma_buffer_count
> >=20
> > Ick no.  Custom sysfs attributes for things like serial ports are crazy.
> >=20
> > > This is mainly needed for GEHC CS ONE (arch/arm/boot/dts/imx53-ppd.dt=
s),
> > > which has multiple microcontrollers connected via UART controlling. O=
ne
> > > of the UARTs is connected to an on-board microcontroller at 19200 bau=
d,
> > > which constantly pushes critical data (so aging character detect
> > > interrupt will never trigger). This data must be processed at 50-200 =
Hz,
> > > so UART should return data in less than 5-20ms. With 1024 byte DMA
> > > buffer (and a constant data stream) the read operation instead needs
> > > 1024 byte / 19200 baud =3D 53.333ms, which is way too long (note: Wor=
st
> > > Case would be remote processor sending data with short pauses <=3D 7
> > > characters, which would further increase this number). The current
> > > downstream kernel instead configures 24 bytes resulting in 1.25ms,
> > > but that is obviously not sensible for normal UART use cases and cann=
ot
> > > be used as new default.
> >=20
> > Why can't this be a device tree attribute? Why does this have to be a
> > sysfs thing that no one will know how to tune and set over time.  This
> > hardware should not force a user to manually tune it to get it to work
> > properly, this isn't the 1990's anymore :(
> >=20
> > Please never force a user to choose stuff like this, they never will
> > know what to do.
>=20
> This used to be a DT attribute in PATCHv1. It has been moved over to
> sysfs since PATCHv2, since it does not describe the hardware, but
> configuration. Unfortunately lore.kernel.org does not have the full
> thread, but this is the discussion:
>=20
> https://lore.kernel.org/linux-serial/20170629182618.jpahpmuq364ldcv2@peng=
utronix.de/
>=20
> From downstream POV this can be done either by adding a DT property
> to the UART node, or by adding a udev rule.
>=20
> From my POV there is not a huge difference. In both cases we will
> be bound by an ABI afterwards, in both cases people will usually
> stick to the default value and in both cases people that do deviate
> from the default probably ran into problems and started to look
> for a solution.

ping? It's not very nice to get a rejected in cycles :(

-- Sebastian

--jyl37mmk7opoozsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBrhMgACgkQ2O7X88g7
+pqyWhAAqargM2/F1Rs/EcL2QbtjVCapugkkOIjeMaC2QKgTPfrPYkmVUrfeHNbS
HhLKLND5sZnmEfsgu3/y1acGUR0QDbn9HbiI0VrSr1YfLK7us9D7DxeorlW1QLfV
6ZfI1m/xDVdF8Rj216hSb3uawdcUvfbF5jGlXeMN24ZqKPd1wT5paM+sHp6UJO/7
eLfTnD5VdNQT7u/tRFNv3G4SawrEWut0LtFOdP8RXF/kDc+cGSuGRNLojoIeCm8B
X1oKBNPergkXnr5A56bqB6suHrwVOT1BEOstKMZ5VpF1gJDKODu4X5XRMAFNotsV
9WVYDInY3LfVekEtQzQMI/4sCAP48TW5mtoyPJjBgFZRmQAQyviWZZ437EeasFSh
WVtisky1Ure4r0Qes7OdvlITrxh/3TzqiOvqN0gjKjVhwzU5XHGIU1BZ0tfvYvP2
6Z8uVk0sy4JrsB2Gaf5ka2OBB18bzBNNZ0/fPVGlfqinG/Uk8r7U1IwQE6jfj8X7
BL6qXTxB//oWKE5YaeGsQW9Xn7PN3riAZgqV3+NKBoxLPB5rvXuLRY0lNotH6vyY
uWsJm+AD2LwFhuRbfoUUGsnA9fQQy2/NPMubJvvK6LaTPPxShdtSHn6fx4od+pux
gn44W2kG1AzJC0pRCIr4I5UjtqXCWW81W8Wji3AUUJ16GJveUeU=
=pCYr
-----END PGP SIGNATURE-----

--jyl37mmk7opoozsa--
