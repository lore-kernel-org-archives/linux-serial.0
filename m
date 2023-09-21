Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A104E7D0AA
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 20:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjIUU1o (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjIUU1T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 16:27:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9E79F3B
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 10:36:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351ECC32775;
        Thu, 21 Sep 2023 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695287693;
        bh=V/cgN3RT7XkFMIs1Ymp5jlRW/nHPyxxJMaOW3fL0f0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKYBetaKVrim8OhS0EPi4ZuEUv4Sfjh+u/lyZ0eJdLVOs5zcq/jTJ5vjJQjg6xlCP
         IVNJIMlCs0TF1oW8JmUDMrPTFuLRMO7pmm1RI5XnuVuwcwUYg9L4skG+17+F8Zg587
         YHfk3fPOduYIyea9LJqhmZqcGGH984kZH7OV3Jpmirg3O0zPjUh6JQi2wUjcggKagT
         Xpo8kr+iwRIFJp+Vz8CNprz6WIvp2gVQunDjc6HuCyxG3gqSZix8j/MzabD/pPRN7x
         QhsAmffAnDvQGPsJoB58HQUOoG/rsAgNpnaPYRjJXjjsoIyU2Zpkig/hFElEmWKZdY
         DrDfFRyDsPWyw==
Date:   Thu, 21 Sep 2023 10:14:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: mxs: Fix compatible list
Message-ID: <20230921-75ba68806e21c96531ea2d70@fedora>
References: <20230921005258.184705-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y+pvPdlgTf4xkWu3"
Content-Disposition: inline
In-Reply-To: <20230921005258.184705-1-festevam@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--Y+pvPdlgTf4xkWu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Wed, Sep 20, 2023 at 09:52:58PM -0300, Fabio Estevam wrote:
> imx28.dtsi uses the following description:
>=20
> compatible =3D "fsl,imx28-auart", "fsl,imx23-auart";
>=20
> Make it valid so that the following schema warning could be avoided:

Dumb question maybe, but it is not mentioned here - they are actually
compatible devices, right? I see that they have some different match
data in the driver (relating to some DMA erratum on the 23 seemingly),
so it's not immediately obvious to me.

Thanks,
Conor.

>=20
> imx28-apx4devkit.dtb: serial@8006a000: compatible: ['fsl,imx28-auart', 'f=
sl,imx23-auart'] is too long
> 	from schema $id: http://devicetree.org/schemas/serial/fsl-mxs-auart.yaml#
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  .../devicetree/bindings/serial/fsl-mxs-auart.yaml   | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml =
b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> index 6a400a5e6fc7..da032effffe6 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> @@ -14,10 +14,13 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx23-auart
> -      - fsl,imx28-auart
> -      - alphascale,asm9260-auart
> +    oneOf:
> +      - const: fsl,imx23-auart
> +      - const: alphascale,asm9260-auart
> +      - items:
> +          - enum:
> +              - fsl,imx28-auart
> +          - const: fsl,imx23-auart
> =20
>    reg:
>      maxItems: 1
> @@ -82,7 +85,7 @@ examples:
>      };
> =20
>      auart0: serial@8006a000 {
> -        compatible =3D "fsl,imx28-auart";
> +        compatible =3D "fsl,imx28-auart", "fsl,imx23-auart";
>          reg =3D <0x8006a000 0x2000>;
>          interrupts =3D <112>;
>          dmas =3D <&dma_apbx 8>, <&dma_apbx 9>;
> --=20
> 2.34.1
>=20

--Y+pvPdlgTf4xkWu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQwJgQAKCRB4tDGHoIJi
0qZUAQC7Brocu9TpVVd2JRe0wEe8C1p//0FVrMLbGA8l2KKCiAD/QafzhWc7oS82
H4+WOu2tbpQsJlOpTbkK9HN/oEx+9gs=
=9C3G
-----END PGP SIGNATURE-----

--Y+pvPdlgTf4xkWu3--
