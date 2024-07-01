Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37714A09D;
	Mon,  1 Jul 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836514; cv=none; b=Fr0YF5qZZBiBpx4LGhnw7MuWUUDWVMK01C/PmFQE4GTpVKZD9HmJc8STsLVq7tguuiN/ig+3y9D2My1z+wICMJqgXjPMGsZlc967oeNEk+EZt1NIf1xqVg21VoXUTBWAK2S3/w2rT7IDIP45hKP3v4hYlsM6BCY6KrdykSTj9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836514; c=relaxed/simple;
	bh=JE+ce2Bc6XEJf7VUJZSkFPrL8gf2uYh6gE14BffD4dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwzATgLMe9QEOZ5zA+mxwD+RaD1VXFOfO+rVA5e2Zzj4ShPirMiGixkDZUQhmN6lRWZ72AaJ82RhOTiYgPnR3qjAfCSjS95iK4NgAZEKlbmdmKhrz4jMQGVeVFcE4EuVo91bVgUqMIG5QjXxRFsumAh64cdG8GoCmykcGZD+4n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy/8gJxD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy/8gJxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7517C2BD10;
	Mon,  1 Jul 2024 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719836514;
	bh=JE+ce2Bc6XEJf7VUJZSkFPrL8gf2uYh6gE14BffD4dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hy/8gJxDh10XMHIVf2L/WFukvLq9st//F2wTuXY1GNnedZ2pnJ9iRhYSHhIaqYmsV
	 pzod3J5cLEbGR8r9GmALkRTMlcxSfY1jzi9YmRb5+8AJN3HDDFRWUoaYLeM0b8jvsI
	 yBxl2SzeSSERFG7Laqu27v9GzL6fFncVeAqy/HzerJazbLOUsXUXYKBT8BS1KdxQc6
	 aRbyH+Ppu/BgPYTh6ic8BSRmYN/QXiLrw06nMatGgh3Gcf/ksknugWmMFXmRXtSfK0
	 Y6PYPqEKbr3lH80bmwVB3Tyh4ONx4pUuJ/gyrjtLpcQpdfQWu13sMH3G76kWLuEevv
	 GW8Ah9pRD4sQQ==
Date: Mon, 1 Jul 2024 13:21:47 +0100
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
Subject: Re: [PATCH v2 10/10] riscv: defconfig: enable SpacemiT SoC
Message-ID: <20240701-tasty-haste-077c00f16517@spud>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-10-cc06c7555f07@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X8NqZcBC5f6Zm1Wv"
Content-Disposition: inline
In-Reply-To: <20240627-k1-01-basic-dt-v2-10-cc06c7555f07@gentoo.org>


--X8NqZcBC5f6Zm1Wv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 03:31:24PM +0000, Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
>=20
> Enable SpacemiT SoC config in defconfig to allow the default upstream
> kernel to boot on Banana Pi BPI-F3 board.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--X8NqZcBC5f6Zm1Wv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoKfWwAKCRB4tDGHoIJi
0nTFAP9sN0UVi6fNDmbNrKem4UC/W4WV0G+AduAgSpqYdf2OKgEAyY4CNEkClU32
2u5Z24HDzzALjaBwylOnZLuOMuVWUws=
=WJ5T
-----END PGP SIGNATURE-----

--X8NqZcBC5f6Zm1Wv--
