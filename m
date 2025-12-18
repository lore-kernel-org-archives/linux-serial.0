Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4B3A1E8A;
	Thu, 18 Dec 2025 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019407; cv=none; b=XKkk7+uOtyunNh2rXU2GgluIxLyPlR4rrvNQenwDbAd6KzrKjwwFRZvzMnontW/U5xcf1MoY4wBILy5pDJWYyn7X6hc28fZagDHNQ5L8hRYmEj8F3+IWJwIjaMZArbSsEVk28jcJX8eT/fGOrxHgNi313wZvxkRxQHwxlo3iRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019407; c=relaxed/simple;
	bh=czY9Sg+ZSc2N2YE8/B4cFKlElc2FQdkFTzwudxE1otI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSCSH7WEanZOVVfCK8LGQLuwoqkGn4uF4BrlI45RImMhT8w40/mQayY4YYvxNsM91Q6+0+NQYw/KmENF46GZyaSYcZc2wxUjWyWvWrNEwx1AF1pMmujudvOLnZNcwzEDff0r82OLfZJ/oklpMdwq/7WJB/aIewi6hYKyh3FK0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwdgXbee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwdgXbee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BDBC4CEF5;
	Thu, 18 Dec 2025 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766019407;
	bh=czY9Sg+ZSc2N2YE8/B4cFKlElc2FQdkFTzwudxE1otI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwdgXbeepYIRgtYqXKfF8dOGLwjuiOW/GhDBYtui5LtESSDqgSyxnOc5Ye1R2lDF/
	 o35uXTvJDjvNrg9t+gl1w8jQqzHdWu4EJ86aqem8AxI8vNFaB408hkAA+APshO9xS5
	 noBGt6iaR4KrK800Z22nZrKCdaz1bighCM6ZT1mCKXmQl0HhW9sz+YVBzJXtNKs6DY
	 Ym8UTx+fjZBVfyqqrE40Cggk8gb12R9VeuRTXsiCisLZXzoAsDPpihNd37g5nSGuiq
	 X2sq1v7a1GsH8C6Lzpba4R2Rppm+S7uqN4qYs06eT7KSP3pNyh2oCGGJxa911LrnUd
	 9163xbnjQ6SDw==
Date: Thu, 18 Dec 2025 00:56:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Guodong Xu <guodong@riscstar.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
Message-ID: <20251218-basil-quantum-225ce16e4699@spud>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com>
 <60948ca2-ed3d-485b-9b11-15df7ef8791d@canonical.com>
 <CAH1PCMb=+TvB1w+G6a2ANDp05HUwC4r6CFBDHXFwSmoP3Mm8xw@mail.gmail.com>
 <f9b6b5e2-ec9e-4208-8267-77020e0a9411@canonical.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YFkdgQHnjYXqwI/e"
Content-Disposition: inline
In-Reply-To: <f9b6b5e2-ec9e-4208-8267-77020e0a9411@canonical.com>


--YFkdgQHnjYXqwI/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 09:07:14AM +0100, Heinrich Schuchardt wrote:
> On 12/17/25 08:11, Guodong Xu wrote:

> > Specifically, I must adhere to
> > Documentation/devicetree/bindings/riscv/extensions.yaml (and cpus.yaml =
for
> > properties like 'riscv,sv39' which stands for the extension Sv39). If I
> > add extension strings that are not yet defined in these schemas, such as
> > supm, running 'make dtbs_check W=3D3' fails with: 'supm' is not one of
> > ['i', 'm', 'a', ...], followed by "Unevaluated properties are not allow=
ed."
>=20
> If Documentation/devicetree/bindings/riscv/extensions.yaml is incomplete
> with respect to ratified extensions, I guess the right approach is to ame=
nd
> it and not to curtail the CPU description.

Absolutely. If the cpu supports something that is not documented, then
please document it rather than omit from the devicetree.

--YFkdgQHnjYXqwI/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUNRRwAKCRB4tDGHoIJi
0gf2AP9Ah7Huy/7R/LqU1VTWwMbhQ8V/6Rgj7cDeXHtSYrlVewD7BBA6UzEp4aPh
lCEBxyTGjP6CciQj2IG9BLkKRj66nwk=
=HlHn
-----END PGP SIGNATURE-----

--YFkdgQHnjYXqwI/e--
