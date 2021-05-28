Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F203AC4707F
	for <linux-serial@archiver.kernel.org>; Fri, 28 May 2021 00:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D439D61358
	for <linux-serial@archiver.kernel.org>; Fri, 28 May 2021 00:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhE1Avc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 May 2021 20:51:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56654 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhE1Av3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 May 2021 20:51:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B96E91F43E94
Received: by earth.universe (Postfix, from userid 1000)
        id DD81D3C0C95; Fri, 28 May 2021 02:49:52 +0200 (CEST)
Date:   Fri, 28 May 2021 02:49:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv5 0/2] Fix imx53-ppd UART configuration
Message-ID: <20210528004952.r2dnoxetqdi655d6@earth.universe>
References: <20210430175038.103226-1-sebastian.reichel@collabora.com>
 <YIzxKNV4x6/8GVrB@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m3bl6ymbqbqf4442"
Content-Disposition: inline
In-Reply-To: <YIzxKNV4x6/8GVrB@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--m3bl6ymbqbqf4442
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sat, May 01, 2021 at 08:11:52AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 30, 2021 at 07:50:36PM +0200, Sebastian Reichel wrote:
> > IMHO PATCHv4 was better, but in the end I don't have strong feelings
> > about this. Btw. I think this patchset is a good demonstration of
> > frustrating upstream kernel development can be considering PATCHv5
> > is basically the same as PATCHv1. Thanks for making us go in
> > circles :(
> >=20
> > Changes since PATCHv4:
> >  * https://lore.kernel.org/lkml/20210305115058.92284-1-sebastian.reiche=
l@collabora.com/
> >  * use DT property instead of sysfs config option, like the initial pat=
ch
> >    version did as requested by Greg.
> >=20
> > Changes since PATCHv3:
> >  * https://lore.kernel.org/lkml/1539249903-6316-1-git-send-email-fabien=
=2Elahoudere@collabora.com/
> >  * rewrote commit message to provide a lot more details why this is nee=
ded
> >  * rebased to torvalds/master (5.12-rc1-dontuse), also applies on top o=
f linux-next
> >  * use sysfs_emit() instead of sprintf
> >=20
> > -- Sebastian
> >=20
> > Fabien Lahoudere (2):
> >   serial: imx: Add DMA buffer configuration via DT
> >   ARM: dts: imx53-ppd: add dma-info nodes
> >=20
> >  .../bindings/serial/fsl-imx-uart.yaml         | 12 +++++++++
> >  arch/arm/boot/dts/imx53-ppd.dts               |  2 ++
> >  drivers/tty/serial/imx.c                      | 25 +++++++++++++------
> >  3 files changed, 32 insertions(+), 7 deletions(-)
>
> This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
> You have sent him a patch that has triggered this response.
>=20
> Right now, the development tree you have sent a patch for is "closed"
> due to the timing of the merge window.  Don't worry, the patch(es) you
> have sent are not lost, and will be looked at after the merge window is
> over (after the -rc1 kernel is released by Linus).
>=20
> So thank you for your patience and your patches will be reviewed at this
> later time, you do not have to do anything further, this is just a short
> note to let you know the patch status and so you don't worry they didn't
> make it through.
>=20
> thanks,
>=20
> greg k-h's patch email bot

Any update on this? :)

-- Sebastian

--m3bl6ymbqbqf4442
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCwPjAACgkQ2O7X88g7
+pqdqA//d35uQsHy3QDn1m2ueR83DR8U9ym2Nf0nmfqlaLzVRethCqPc0mb9catT
YGQaQCd2CedvFm+zytcYtq5u5LeFgPQA67wYHQPAIaS7Qdyq/rOys5YYicvJHxjd
ixRI8gE2G1cIAtbfaHJrJkMrcFYHrvF9I+uzq8MaXKJdhu+1i3UijeSPIpFfklFN
EIuQY3LxhaC+lRF5tKWtm9DvwOP7qRDNmS3NeedKCUmthDJDT4f2paBv417v53hw
oiQ4EDyClLb5GWGKdQLYWTRdi5vxQmmmyXIgBqRyEbiHi82umHw3M0bIVsJgt2Bx
6rfZaMnkDLd42+PUU3M/CIwqEiRugr9/UXi6n+d0g51YJZ0Chf3bcvP+rY+QufIh
c9fzcnTV2ossSy1Hdk/wxutpOTtrc2EnuwwGA0iiYozU5sEtIshLYRnUYM/wxiDn
QjdXOog4jX4mWZlruOF5VJg/clJw41PVdX+d5uyuOnUjj2/1SVM/5zqOlqS5All5
1pJJ1j0MYhzGV4O5TfwCNMopPeg4OjLht5wiJj8BxrhSzSH20wDLEuGrrbMMR7xa
yCYAcg4WdGamcuJCta2YPRo3cJ8OV7ceZQmE/+ODxpuRs907LKEgt3/ghlr4dn7E
7YPQd+17AtR8vT7+INGAAqcmOkLGnYAWD4gMpjjYqqg7apGQeoI=
=Gp10
-----END PGP SIGNATURE-----

--m3bl6ymbqbqf4442--
