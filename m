Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D851AC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  9 May 2022 18:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbiEISUJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 May 2022 14:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbiEISUG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 May 2022 14:20:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2120F79
        for <linux-serial@vger.kernel.org>; Mon,  9 May 2022 11:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3812F615FA
        for <linux-serial@vger.kernel.org>; Mon,  9 May 2022 18:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B63DC385B2;
        Mon,  9 May 2022 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652120171;
        bh=fityjqx3LAPgs6j3Ab+RUFq57LrBU7RECIxpxYVKf7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFGu9zPByEWxEeLaLwZAOINXLVIUCBbJaslnR53O9GQPouETdtWGpGVcBhp6qezf6
         U8ow/sPecgR/+KSxLwLaGpJIYv/yoH4gt9n8w5RgibLvq3FQswUuie8l6F07YmGkk1
         /XLZHlEqU6zkhqQ1z8Gma7eCZw7hE4Y2V6YuD4OLI9uggbweCU5TLBLr/z1s0JGOqG
         ZTWT/I8eFw7AmqV4mT3mwKA6cVuKCv37Zo6Ul/zaBuiT7zkNEYYrVGQx4odDr2DB6i
         b9ddTb/r2eFavRJ4OXNELb59dhgU21QSzi0UvequrCT3cdt5JVqn/XpAwc/jWm0p26
         GRGGjZZTH4TNw==
Date:   Mon, 9 May 2022 19:16:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: next/pending-fixes bisection: baseline.login on mt8173-elm-hana
Message-ID: <YnlaZgJfGASYwO8Y@sirena.org.uk>
References: <62793d83.1c69fb81.71b96.033e@mx.google.com>
 <YnlBAoZTJ6WbM394@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lqwda+yZWhdsDg4f"
Content-Disposition: inline
In-Reply-To: <YnlBAoZTJ6WbM394@sirena.org.uk>
X-Cookie: Do not apply to broken skin.
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--Lqwda+yZWhdsDg4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 05:27:51PM +0100, Mark Brown wrote:
> On Mon, May 09, 2022 at 09:12:51AM -0700, KernelCI bot wrote:
>=20
> The KernelCI bisection bot found a boot regression on mt8173-elm-hana
> which bisected to 6f81fdded0d02 ("serial: 8250_mtk: Make sure to select
> the right FEATURE_SEL").  With the patch the output terminates at:

There was also a similar report on mt8183-kukui-jacuzzi-juniper-sku16.

--Lqwda+yZWhdsDg4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5WmUACgkQJNaLcl1U
h9BEsQf7BsIqfG+ZeTzFwFvRnTzgzhjZoANmgE0Yqr9ZAj7cW0QJLFmm73HrG4g9
e7Xz3NpznH7ymkVkOHOqtRIZm5ZvaetcbFe9JBUQUdH8rluaa7FVHHAHYH16q66M
Y2SyeVl1TDCbvTSP5B1LQZO01cRhEFhe1tLvUj8DnuH8R0H9rzk4OTeSCK3vQFyA
MKLHQyvKd+q7WqfYHOcz7Ni/LDOe4NJyRXuVBBUqpriE53naLMq1DERUIBVOs4Kk
VhKChrQWLZ5XXhjw3y4Hv6Hq10f3YdBGNr1xt8/g+iTy5ACCrZ3GYpUJGbmA7vui
+iIt0EV6rKpz7PmrSG72jFDTcbL/1Q==
=n5eN
-----END PGP SIGNATURE-----

--Lqwda+yZWhdsDg4f--
