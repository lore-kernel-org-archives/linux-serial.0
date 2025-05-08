Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB1A2797A3;
	Thu,  8 May 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716134; cv=none; b=h3RZntPAqXJnBn9bLHyvh8aBKOvBpgMkUjgiYqW95jOTLUD3uEIdb0LlE+EPvSDdB4yxNqOx95Mx0IfmBUzQb0ZYTCSHqqkHyX6yN1oPta8EsMH1/SupSO8K4exmImW4KAx+wTncNekMWEB/Rn4gvpFm/OnjvUu6s58SO4ynEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716134; c=relaxed/simple;
	bh=1+vwrX2VH2xSClWzk21LoypRAIw4GKWmBFxIDy4xSKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGNl7H8+lKjvtW69axbAJ4D3ZTjrLcM+VwU5LJRh6LjGjiP7lj7yLQzwALb4dm14UIpQy24XXrrioqDhcb25GC70CyAyC5ZKy2f0AnDOL517JXrTelukt1CR2+DqPnLYK+8cviJzfRCeSZegmt1w3f4KOC/y53SVRptEiE7ESz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhxBGcla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhxBGcla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2740C4CEE7;
	Thu,  8 May 2025 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746716133;
	bh=1+vwrX2VH2xSClWzk21LoypRAIw4GKWmBFxIDy4xSKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhxBGclanzLpmpop4xNy7mGbw62FZ/hY+7rR1r987RklleviyWtky9+UE+jPBjA4h
	 G+D6gEhRnX2pm4JwhCrhcdMVMIG8dYLD2uIhdo8onOhmJ9hkQmzu2OPAtLa48+5Khp
	 u2VtUe7Ht2OtK6/gIbG4PiQfKW2o87ymHiAdhfja9lM5nT4XPRPb9TY2f2KLdoJiJp
	 X67l8rHWCAMxI1FVhg3j04CtkoSLvh76PJpSC4jiVfLd+IjYQUqn1oYY9asAxsm67w
	 I+/6nR16xRSFDS+T36UVYSvSCi5HVXCc2Osd+SoL+STlXOgIpPpx3sp+FCUuaGYv4S
	 ElBVJFgSDQpXA==
Date: Thu, 8 May 2025 15:55:29 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrei Pistirica <andrei.pistirica@microchip.com>,
	Chandra Mandal <purna.mandal@microchip.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: Convert microchip,pic32mzda-uart
 to DT schema
Message-ID: <20250508-refinish-legible-dbbfb9d2fd99@spud>
References: <20250507154937.1603190-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="li47EMabrVGucmAs"
Content-Disposition: inline
In-Reply-To: <20250507154937.1603190-1-robh@kernel.org>


--li47EMabrVGucmAs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 10:49:36AM -0500, Rob Herring (Arm) wrote:
> Convert the Microchip PIC32 UART binding to DT schema. The binding was
> unclear there are 3 interrupts. The functions were determined from the
> driver. The 'cts-gpios' property is covered by serial.yaml schema.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Although...

> diff --git a/Documentation/devicetree/bindings/serial/microchip,pic32mzda=
-uart.yaml b/Documentation/devicetree/bindings/serial/microchip,pic32mzda-u=
art.yaml
> new file mode 100644
> index 000000000000..b176fd5b580e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/microchip,pic32mzda-uart.y=
aml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/microchip,pic32mzda-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PIC32 UART
> +
> +maintainers:
> +  - Andrei Pistirica <andrei.pistirica@microchip.com>
> +  - Purna Chandra Mandal <purna.mandal@microchip.com>

I don't think either of these people still work for Microchip.
(I don't have any idea actually who works on this device)

--li47EMabrVGucmAs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBzF4QAKCRB4tDGHoIJi
0gLCAP97mPtcpMhwP17y4SgfNnzizuUNps68bgwbeksNCXdyvgEA3c5uwk9EsAtj
Z/vMir4Bvn2sTP2hqNLH4ilOlpy1pg0=
=Xc3M
-----END PGP SIGNATURE-----

--li47EMabrVGucmAs--
