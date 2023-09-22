Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047E8CD4F49
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 11:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjIVL06 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 07:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjIVL06 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 07:26:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B459AC
        for <linux-serial@vger.kernel.org>; Fri, 22 Sep 2023 04:26:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1ABC433C8;
        Fri, 22 Sep 2023 11:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695382011;
        bh=JKkVlDGe2xzrtW6oP175LdtoOcF9c3kpHbkWebqNpKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guPGqyWUR+z3fClMQo2sgfwbEeI+yMRaACIBWJhVmy+xnNHZrRRT5UxKjEZOgltzb
         fU/n6pSjjVNwXuNAAfg86Zgc5ysboRVvgRSV49DpNSwm9+BrxQP6EV3f/rtvDsa2ZH
         AsOU1tHww+KPg254heu5eAejT9PlyS32BXwkqOx8BR8IMUKrbFL+k57T7rZBm5wvBa
         ndj6wWKWIy4/GMCOjNYWL+ztjjSLjlK4J+MrS03jyu0qdocpu3+ycNlYzKKfzEx8Ev
         YTvy6TEMrGxabRi6rgp02NpmsQ3PRgAXPtL4Lm9Aj7SRS6+Nw6PMSXI2mhBmX2vJWx
         mCSuQ0EnAeMjg==
Date:   Fri, 22 Sep 2023 12:26:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: imx: Document wakeup-source property
Message-ID: <20230922-exhume-rejoicing-f5a36f5dd573@spud>
References: <20230921192729.71259-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2cFYWGC3ZJlQYktI"
Content-Disposition: inline
In-Reply-To: <20230921192729.71259-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--2cFYWGC3ZJlQYktI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 09:27:29PM +0200, Marek Vasut wrote:
> The i.MX UART can be used as a wake-up source, document the 'wakeup-sourc=
e'
> property as allowed property.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--2cFYWGC3ZJlQYktI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ154QAKCRB4tDGHoIJi
0uJ8AQDn/wmFfFruJ8HWzho1PC4AXsfVkovygm5ypQcF2c7RpwD+NkjnK0wRguO3
SJuTBm2GU9DH0uXTuRRgsw028yz/4wU=
=vVBi
-----END PGP SIGNATURE-----

--2cFYWGC3ZJlQYktI--
