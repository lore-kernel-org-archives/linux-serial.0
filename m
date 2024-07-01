Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234814A604;
	Mon,  1 Jul 2024 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836712; cv=none; b=UU61TiTHnVRuK5ow4ATZ470esjEsrZDuSqr0lyjNy1sg48on2fXdsFM6nO1axc6v0TmiU7PjGuYh2F+fA9zkqfMU074MTDy0yE4afSB9xFA8XcCwAt4pN4lpVRte/pX/Veoy/LQnIKbtn3SMk8OnpnrY27vuQSUXynFE/B+VyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836712; c=relaxed/simple;
	bh=uokN+LJdC2agYZtYBp+On9i8Y82wyfHM+k2m2SnHmzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTb90jCc+Weq5HhYSgPDM94FyNH56u1mz+lrbJ02Tz5P5WLNmEP6Ld15TrqnqwJBvFqDiWYTC6RZoItQf+lWD02HxK04qSKcEf7Ckyt25OpkAhZjJcrwEtwOcrbU4AcY9WDOrl/H7D/zHgnrNzQQddv8se/X+ZYqqO5TNv14IpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw3qbpaN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw3qbpaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D900C116B1;
	Mon,  1 Jul 2024 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719836712;
	bh=uokN+LJdC2agYZtYBp+On9i8Y82wyfHM+k2m2SnHmzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aw3qbpaNOKzKEX9V22J42eKeD9U+duvt0ZcmJLREv44nL7mgiCiai5VS5gMKfbhGf
	 8eADDaVgaaDebfN5zntfFD5tvh4Tz2ej+OyO1a+1cuAeEQI8VB9yETyR18HD29aKAf
	 6PSCpC5MK/Se4wgQCv6P/jk2jC9Tryh0aybbFxUspS3dw1DakEEV3Q9GlatJG6/e7d
	 VeWGz73fgNcVVxqC1mV+sEaWqpplpG0jCsgCDfu9EaALRHfpHx/ZoE2ZxBlKb0ehnC
	 vChlSi4KlSobeZSzS5y0IeKak/r+ccH+hnXryASQ3/UiNOWbU0cppcljYyO+k2PZcD
	 9EkJlTqpc6inw==
Date: Mon, 1 Jul 2024 13:25:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v2 02/10] dt-bindings: riscv: Add SpacemiT X60 compatibles
Message-ID: <20240701-line-congress-f838a8b6b1e7@spud>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-2-cc06c7555f07@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eU5rt2wxl2jPuf8p"
Content-Disposition: inline
In-Reply-To: <20240627-k1-01-basic-dt-v2-2-cc06c7555f07@gentoo.org>


--eU5rt2wxl2jPuf8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 03:31:16PM +0000, Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
>=20
> The X60 is RISC-V CPU cores from SpacemiT and currently used in their K1
> SoC.
>=20
> Link: https://www.spacemit.com/en/spacemit-x60-core/
>=20

Same comment as v1 here :) With that addressed,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index d87dd50f1a4b5..5ad9cb4103356 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -46,6 +46,7 @@ properties:
>                - sifive,u7
>                - sifive,u74
>                - sifive,u74-mc
> +              - spacemit,x60
>                - thead,c906
>                - thead,c910
>                - thead,c920
>=20
> --=20
> 2.45.2
>=20

--eU5rt2wxl2jPuf8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoKgIQAKCRB4tDGHoIJi
0t8pAQDtH2/PmqMu6iMWlqBobOPH26sE744GEAMmDDby/tabTAD/QqARpMzY6jQa
0Qi3mmRENPebG4X8D2w6sYdF8Fms3wU=
=rmPZ
-----END PGP SIGNATURE-----

--eU5rt2wxl2jPuf8p--
