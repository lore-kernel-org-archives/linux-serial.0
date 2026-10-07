Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3C648123D;
	Wed,  7 Oct 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378260; cv=none; b=KfhoPsE5Onxd321Km5d8MTDl7jaqB3f2D/VFeBqVWOvFZZeikcAcycbZKjhP/R0VYu3T4dBQpotJlR1K9cOKLGez20U2xTef77orwXD/ldW0nvXjSvwQ0vsWuAL8gvhJ7Z9TEY38TnIBPavfKLJYinExvDZjUtSWFWYgdmi2Pno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378260; c=relaxed/simple;
	bh=5mZkqvWfwnKehqKFwrP7aZW+mFT+j0HzqFsdn24VQTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/TNn7if229I5vWW2bHGB01nz2ziP1+UBWDzt7yGguFUpDe5KtGAwkzoCIF4U+2ekBC5IjPMjmcyH+jQKF3eUEWxn27Tc8JVzkQBIMW+jIzNHQfkPVeUmExL0AEtsmUKGmt8E0FjgF/XyOTU1OydXWCWctU3ZttXaDjTxVFTkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck86f0xc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck86f0xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F1C1F0089C;
	Wed,  7 Oct 2026 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791378249;
	bh=84dEnMeuxrpA4ZytGyYSFXT69ied57NAHmkJ88VCEwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ck86f0xc2CyGGyVLDv7x7A5CYBIiIREoK9vzmSZrJJoVU5Fui+jaOoBwuvPC1akts
	 VK5Vkqyv3ceUs1NDgN2lzNiJZ/WyZ1g9fCWRhSn4CWWLfrS/Pmr1w7JOvyWMTzq2aD
	 EQr9IXjicpH4f35gCg6N26FMrbndK4O0orx5NkbJIUpcTvAZF7ITsBuRPjREWPDP05
	 UvdwEIDsHbnpZZOHorMYCPgIAf3gE4P1TRY+9jKlDwa7wJyivbvnXejfBaJ7CZXCg7
	 BJk1go18+uvlkRXX98pfwLIp+AElof1cXWWFD6moSkHw5ulwXCP3yUQOJokSdaOvhw
	 GWysHkg2VvgNA==
Date: Wed, 7 Oct 2026 14:04:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: snps-dw-apb-uart: Add Synaptics
 sl2610 uart
Message-ID: <20261007-450d3d9a4f4a2c07cc088067@squawk>
References: <20261005151918.25259-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bj9ENhqRtHEDsn4P"
Content-Disposition: inline
In-Reply-To: <20261005151918.25259-1-jszhang@kernel.org>

--bj9ENhqRtHEDsn4P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2026 at 11:19:18PM +0800, Jisheng Zhang wrote:
> Add the compatible for the UARTs of the Synaptics SL2610, which are
> compatible with the Synopsys DesignWare APB UART.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>=20
> since v1:
>  - use sl2610 instead of sl261x
>  - send as a separate patch
>=20
>  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 664305de4986..a40f2737e71b 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -34,7 +34,16 @@ allOf:
>        properties:
>          resets:
>            minItems: 2
> -    else:
> +
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - starfive,jh7110-uart
> +                - syna,sl2610-uart

Is the number of uart resets on this device variable?

> +    then:
>        properties:
>          resets:
>            maxItems: 1
> @@ -80,6 +89,7 @@ properties:
>                - starfive,jh7100-hsuart
>                - starfive,jh7100-uart
>                - starfive,jh7110-uart
> +              - syna,sl2610-uart
>                - ultrarisc,dp1000-uart
>            - const: snps,dw-apb-uart
>        - const: snps,dw-apb-uart
> --=20
> 2.53.0
>=20

--bj9ENhqRtHEDsn4P
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasZDRQAKCRB4tDGHoIJi
0jcSAP0TrHMLDbVz+kxj8bftwsGZujBCJhGVBfHKLKOcWYrA6AD/X6tmnmvPEqja
kAVRwzx2SZtcrWuwhzEkVEC6gvvWswE=
=AK5Q
-----END PGP SIGNATURE-----

--bj9ENhqRtHEDsn4P--
