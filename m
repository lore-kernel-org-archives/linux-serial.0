Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E06E71094
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 17:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjIURHq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjIURHU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 13:07:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820EC1A3
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 10:03:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28234C4E688;
        Thu, 21 Sep 2023 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695302818;
        bh=tNaMqXlX6gWQEtFXsOSS3Bt8DqFxrB36y2GWLAlRgU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Low1o3cxRNpJ+kr+RcB2p0+vtcRmOjeEZ5P2bevbRwsunSHaR5pZWYq4IcLCu67qx
         L5yUgJ6BOQe+qMaRmOrojjr5ejjpeu6hbCfA+8KhjV6DM+TAqwZHlf+FR96W4No555
         bUnhPQdgRsSsO3z/2lTdLtQ762ENXxcTzxEcxNjuCAbaFXvQai6TeNXh31fMv8e65G
         +pv/5xKBSLUhWWu+zHAr41etwjNMvAGYgEvucYu3XhnmcDoyKhyQAjfV/NGINDG8CM
         hoUakUFn53O7Elu03wt+RqCncdqW46+CyGoD6oKd4IYQKWW1iev+Zb24ldSjikADNv
         oztVuagd8RLBQ==
Date:   Thu, 21 Sep 2023 14:26:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: mxs: Fix compatible list
Message-ID: <20230921-abide-humped-e1bc12732e1c@spud>
References: <20230921005258.184705-1-festevam@gmail.com>
 <20230921-75ba68806e21c96531ea2d70@fedora>
 <CAOMZO5AYTe1mJTvR=2zWCVrYqVVdmP7A9fCCrCPqgisXYQpeYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IcqB6TI9/rs/79Pq"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AYTe1mJTvR=2zWCVrYqVVdmP7A9fCCrCPqgisXYQpeYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--IcqB6TI9/rs/79Pq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 09:53:44AM -0300, Fabio Estevam wrote:
> Hi Conor,
>=20
> On Thu, Sep 21, 2023 at 6:14=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
>=20
> > Dumb question maybe, but it is not mentioned here - they are actually
> > compatible devices, right? I see that they have some different match
> > data in the driver (relating to some DMA erratum on the 23 seemingly),
> > so it's not immediately obvious to me.
>=20
> That's correct.
>=20
> imx23 and imx28 are SoCs from the same family (mxs) and they share the
> same AUART block, so the same programming model.

Right. I wasn't sure if the erratum workaround would also work on the
28, but sounds like it does.

> imx23 is the first member of this family. It had an AUART erratum.
> imx28 is the second member of this family and had this erratum fixed.
>=20
> This means that using:
>=20
> compatible =3D "fsl,imx28-auart", "fsl,imx23-auart";
>=20
> is valid.
>=20
> Would you like me to improve the commit log with the information above?

Your call.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--IcqB6TI9/rs/79Pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQxEngAKCRB4tDGHoIJi
0nuMAP937mO9VNRWDf1l/gDGbqmC05x4T5SZgkaxd+5Z/QYBXwD/RqFy5rSwNJ4n
iHPI5CivOvZwyHkf4Rxv8ZNcmMGy7QM=
=+hsj
-----END PGP SIGNATURE-----

--IcqB6TI9/rs/79Pq--
