Return-Path: <SRS0=5b6+=3X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51828C35247
	for <linux-serial@archiver.kernel.org>; Mon,  3 Feb 2020 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292A92082E
	for <linux-serial@archiver.kernel.org>; Mon,  3 Feb 2020 19:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgBCTKZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:10:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:47770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgBCTKZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Feb 2020 14:10:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 056FFB061;
        Mon,  3 Feb 2020 19:10:23 +0000 (UTC)
Message-ID: <dfbe2c94dd52a31826be751f8dd9afc4ed08ec6d.camel@suse.de>
Subject: Re: [PATCH] serial: 8250_early: Add earlycon for BCM2835 aux uart
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, matthias.bgg@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Scott Branden <sbranden@broadcom.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        jslaby@suse.com
Date:   Mon, 03 Feb 2020 20:10:21 +0100
In-Reply-To: <20200131152414.73tgwsfhzgu4apkx@wunner.de>
References: <20200128141958.vwbxoqglt5gw4xj5@wunner.de>
         <C099APQHQAHB.3Q9UVYJYT98TN@linux-9qgx>
         <20200131152414.73tgwsfhzgu4apkx@wunner.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rxZ/SqVaphyyjrFeqQty"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--=-rxZ/SqVaphyyjrFeqQty
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-31 at 16:24 +0100, Lukas Wunner wrote:
> On Thu, Jan 30, 2020 at 05:11:55PM +0100, Nicolas Saenz Julienne wrote:
> > BTW did you had the oportunity to have a go at the patch?
>=20
> I've just performed a quick test and it doesn't work for me.
> If I add stdout-path =3D "serial1:115200n8"; to the chosen node,
> I only get a regular console with this patch, not an earlycon.

That's surprising, you're using u-boot isn't it? and the upstream device tr=
ee?

> > > The problem is that in mainline, bcm2835_defconfig contains:
> > > CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=3Dy
> > >=20
> > > Likewise in the Foundation's downstream tree, bcmrpi_defconfig as wel=
l
> > > as bcm2711_defconfig and bcm2709_defconfig contain:
> > > CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=3Dy
> > >=20
> > > In contrast to this, we set the following on Revolution Pi devices:
> > > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
> > >=20
> > > Downclocking influences not only the uart1 baud rate but also the
> > > spi0 clock. We attach Ethernet chips to spi0, throughput was
> > > significantly worse with the ondemand governor (which is what we
> > > used previously). We felt that maximum Ethernet performance
> > > outweighs the relatively small powersaving gains.
> >=20
> > In that regard I suggest you use the upstream cpufreq driver which
> > behaves properly in that regard. It disables GPU freq scaling, so as to
> > change CPU frequencies without SPI/I2C/UART issues.
>=20
> Okay, I'll take a look.  But the uart1 baudrate will still be wrong
> if the firmware downclocks because of overheating, right?

You're right, it might happen. The way I understand it you're bound to leav=
e
the GPU at it's lower frequency if you want to use those peripherals and fo=
r
them to be reliable. You could technically try to empirically fine tune the=
 CPU
thermal trip point so as to make sure the upstream kernel cpufreq downclock
always kicks in before videocore's one. I'd actually like to see someone tr=
y
that. However short of using an RT kernel It think you'll never be 100% sur=
e it
can never happen.

Regards,
Nicolas


--=-rxZ/SqVaphyyjrFeqQty
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl44cB0ACgkQlfZmHno8
x/4OKwf+KvsKB8pRgfFS6tQGkcjn5+7rl7qXYEndk80sawqCUn4/ZHkxPdoqD5cO
bU8iTyaNfFQQb9uq8RoWcJrFMKQJhxGe8sjDNkZNqvbTUr3oM8ltCrjVWX7D5wfG
eDSxB7hZqwE+BkdJaK3G5kicCfPl21opnQwZUn7R/0e0bYIuzMu/hq1xk7XiRaLU
hL30AwUY3DLZtOVEeNIeVW9TVuVdnbu219TXZjtwuD+iZ9u2xbkh83fne8s0nW7O
79/Gejgu/e5PDH3CTnbheLNpl9Fws8fGiERnwXNbAD2XSj2kOfTitCVVNK2Efup5
txMswkwfPEC1JsGHkHgANzz5Z5UOVQ==
=AW10
-----END PGP SIGNATURE-----

--=-rxZ/SqVaphyyjrFeqQty--

