Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068714A0A0;
	Mon,  1 Jul 2024 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836747; cv=none; b=Z9F/yPPZY+u7C4ohisn0V0+rksTEMIh7zsi1LWHY0D4dtdXLYyp0ykdunq1/kuj6yeBRjisW07nyNpgO47Wg4PvlRMxe4vqbW+7zLHHgOEZkuWyN/WywI7Yuxapcn28A6OJkzsIyhDgbH4W8AQicl5gyIt91R6ApVjq4wLcHg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836747; c=relaxed/simple;
	bh=qde1oJVpemXAs9VLKdKSyfrUTKpxHHBTcoNVyrzgcFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTO+0OqFHnZsm1YcKczeOlEgv2yNFlamk+1+80C4u49Lgh4LiC6P9yUbbdu8Jb7CTZHPpoL9ipMF84OxzC/VvNyxcE7LKrZn8uEhqB/EmFp/lCyT2YNmbasdoUP8Bn1bD973KJ41TJYldI/3ub628DJBhA5yrw6RxQdzlmgq8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGzDkZkY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGzDkZkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F02EC2BD10;
	Mon,  1 Jul 2024 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719836747;
	bh=qde1oJVpemXAs9VLKdKSyfrUTKpxHHBTcoNVyrzgcFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGzDkZkYkMctQkF16w4/cFgGieXThI1XLKOeF8wrtDw/vdborkn5Od7PGrbPXP9MQ
	 8dorpJLPaSHD2FbdkGEUHZvRfKKLw44E/nZYdVunGu2+XyQdyeOP+kN80mzwni8c0Q
	 XY3/O/qBq1fnVRngWTGHfISUUUKgXy6l8kg+S0MknDYFj3FDPtztVMSNGfnaphXEs7
	 ZDDqgQVw+V+3LdGxYVvyKyYNEoo73iQGtMhLUV5yz2UgHYEWYjQHNqDIOlWWOPMv61
	 tDs8SQEUbb1H2x3BjKSR97RiyNdPqRI3Yv7/kCJC+7bujOjjebCUc46QPQ+5Piv5jy
	 5zY9I3NYcdlvQ==
Date: Mon, 1 Jul 2024 13:25:41 +0100
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
Subject: Re: [PATCH v2 07/10] riscv: add SpacemiT SOC family Kconfig support
Message-ID: <20240701-brilliant-accuracy-9bc4effff9e1@spud>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-7-cc06c7555f07@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="12R8+aDawiuRLv5y"
Content-Disposition: inline
In-Reply-To: <20240627-k1-01-basic-dt-v2-7-cc06c7555f07@gentoo.org>


--12R8+aDawiuRLv5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 03:31:21PM +0000, Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
>=20
> The first SoC in the SpacemiT series is K1, which contains 8 RISC-V
> cores with RISC-V Vector v1.0 support.
>=20
> Link: https://www.spacemit.com/en/spacemit-key-stone-2/
>=20

Remove the blank line please.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  arch/riscv/Kconfig.socs | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index f51bb24bc84c6..1916cf7ba450e 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -24,6 +24,11 @@ config ARCH_SOPHGO
>  	help
>  	  This enables support for Sophgo SoC platform hardware.
> =20
> +config ARCH_SPACEMIT
> +	bool "SpacemiT SoCs"
> +	help
> +	  This enables support for SpacemiT SoC platform hardware.
> +
>  config ARCH_STARFIVE
>  	def_bool SOC_STARFIVE
> =20
>=20
> --=20
> 2.45.2
>=20

--12R8+aDawiuRLv5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoKgRQAKCRB4tDGHoIJi
0p9iAQC6whE/bHeDyJ/S98q/OVqAyxeKWcEecg7ABkELD8ToKQD+Ocn7yyKVtHz5
poXOBPvWSuMmvDEKjND0F5EvN8pviwA=
=bdgu
-----END PGP SIGNATURE-----

--12R8+aDawiuRLv5y--
