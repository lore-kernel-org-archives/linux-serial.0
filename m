Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B5212562;
	Tue, 28 Oct 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680355; cv=none; b=N1+BSTUhgRGShVlcoL3pdtsx8pO6+9YYiN57xAt0j0PrfS7BZJXFYeGv7ix6lme4MK3ubjT6ZpRCRx9JM0bPJBfMQq2z/1d6AIVZtIaJFZL4BfjpqCgn/OBdlXgH0Z3DGmc4sAboBg6gRHsPL0dUqErJN7WVXS7ZY4TzSb+i60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680355; c=relaxed/simple;
	bh=9IwSPkaTApk9nUXNCx8lCj21HcoG00vqUh5SGTnv6VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaslQio1jl27cpZYy7gUTdinzCVTCHcCzhDjKDRM2raXn0rqbzJYZLFsbhfgLRyC9uidXYvjXfBuG5ZhoHqmzTmfJ7xIY+8uEsBbzzYZDNuCXNlMCpbUNKqxK7Ur/U8tj3XdX7HNN/BHnRc7rQSNfRHIiH8fIWyqS3oFsVYPzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkmM99fm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkmM99fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0766C4CEE7;
	Tue, 28 Oct 2025 19:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761680354;
	bh=9IwSPkaTApk9nUXNCx8lCj21HcoG00vqUh5SGTnv6VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkmM99fm0NErW/Sex3/ALjDKzpb1M3fXJ+LGMZxbi1qOilDgDhGyDHdUDdl32RrXg
	 MO2nBjY8Vs7ZXumhgXsG4a3EclWX326nMt7qeER9Y6hVmFFOAYWv+K5PfbSxRUHp7c
	 tDyFsFmSkCy8ZacGd6pdREywq7BFGwN64lZoF97PrAKA586IHMv0rJwry/1dQCY1xv
	 ocP/nLXQLL1KeV34fwxPh2JuAzRl8NdjpjUw7+MwE2Vc9kHrXEKFZPVJKAg8L6PI8x
	 3T+pVIj9yYGtZP3CcrkRcMioWBfZaK0dnEQ1NMxxrkjJQNIZ58whD4CD+xSxfyiZxG
	 3u0YZ83+iIrEg==
Date: Tue, 28 Oct 2025 19:39:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	Inochi Amaoto <inochiama@outlook.com>, sophgo@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 00/13] riscv: Add initial support for Anlogic DR1V90
Message-ID: <20251028-busybody-disallow-e068b221db6c@spud>
References: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wZNKDox1XiyOXQLZ"
Content-Disposition: inline
In-Reply-To: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>


--wZNKDox1XiyOXQLZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thomas, Junhui,

On Tue, Oct 21, 2025 at 05:41:35PM +0800, Junhui Liu wrote:
> This introduces initial support for the Anlogic DR1V90 SoC [1] and the
> Milianke MLKPAI-FS01 [2] board.
>=20
> The DR1V90 is a RISC-V based FPSoC from Anlogic, featuring a Nuclei
> UX900 [3] core as its processing system (PS) and 94,464 LUTs in the
> programmable logic (PL) part. The Milianke MLKPAI-FS01 board is one of
> the first platforms based on this SoC, with UART1 routed to a Type-C
> interface for console access.
>=20
> Tested on the Milianke MLKPAI-FS01 board with both the vendor's OpenSBI
> and the not-yet-upstreamed mainline OpenSBI [4], as well as the vendor=E2=
=80=99s
> U-Boot. Because the vendor=E2=80=99s OpenSBI is loaded at 0x1f300000, we =
have
> to additionally reserve the DRAM region 0x1fe00000=E2=80=930x1fffffff to =
prevent
> overlap if using vendor's OpenSBI.
>=20
> Link: https://www.anlogic.com/product/fpga/saldragon/dr1 [1]
> Link: https://www.milianke.com/product-item-104.html [2]
> Link: https://nucleisys.com/product/900.php [3]
> Link: https://github.com/pigmoral/opensbi/tree/dr1v90 [4]
> ---
> Changes in v3:
> - Update DT binding to use ACLINT instead of CLINT
> - Drop MAINTAINERS patch
> - Rebase on v6.18-rc1
> - Link to v2: https://lore.kernel.org/r/20250922-dr1v90-basic-dt-v2-0-64d=
28500cb37@pigmoral.tech
>=20
> Changes in v2:
> - Add MAINTAINERS entry for the DR1V90 platform
> - Remove the riscv,isa property of cpu and reorder propertyies
> - Fix clint base address in the dtsi
> - Change the memory node to cover the full 512MB RAM in board dts
> - Link to v1: https://lore.kernel.org/r/20250721-dr1v90-basic-dt-v1-0-574=
0c5199c47@pigmoral.tech
>=20
> ---
> Junhui Liu (13):
>       dt-bindings: vendor-prefixes: Add Anlogic, Milianke and Nuclei
>       dt-bindings: riscv: Add Nuclei UX900 compatibles
>       dt-bindings: riscv: Add Anlogic DR1V90
>       dt-bindings: interrupt-controller: Add Anlogic DR1V90 PLIC
>       dt-bindings: interrupt-controller: Add Anlogic DR1V90 ACLINT MSWI
>       dt-bindings: interrupt-controller: Add Anlogic DR1V90 ACLINT SSWI
>       dt-bindings: timer: Add Anlogic DR1V90 ACLINT MTIMER
>       dt-bindings: serial: snps-dw-apb-uart: Add Anlogic DR1V90 uart
>       irqchip/aclint-sswi: Add Nuclei UX900 support

I'm happy enough with this series to grab it, but while I don't mind
taking some trivial binding changes with it, I don't want to take an
irqchip driver patch. Would you be able to apply the irqchip stuff
Thomas?

Cheers,
Conor.

--wZNKDox1XiyOXQLZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQEb2wAKCRB4tDGHoIJi
0rUEAQCPj7JXw7EGtQkw039iQFE+nl3J7cA4D5rsKJQEPAchSwD/XMnR2VIr4JCq
GvQFwIvj1FrbRB8ItSFbTwU6xsU7lAY=
=HzOq
-----END PGP SIGNATURE-----

--wZNKDox1XiyOXQLZ--
