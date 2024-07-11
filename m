Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30802152533;
	Thu, 11 Jul 2024 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692234; cv=none; b=oCxelkaGqvfWYx1KSG285eSe3mObgHvwA4k0LRMe2kmt3SZ6NMgGwyHhJRdDvfHnq09ZyjRvXTH9s7Qh7YMDIgh5oYyqAgTviX/5aj+Wau0BXzmg9bbogWzqBJb6K93M0fxyBLBxPIFYe+FWEdDz5cNnEcT/ES1FNOE3t+ql2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692234; c=relaxed/simple;
	bh=bytiMLPV2lOGNSZcnjRWSwf1EM6gvvVUhRuOoOG5GjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyXql3hrUt1p0O45J56x8ac22UaKtjuRNbsx0k/5xkEVkCaQP3gyacLMwMWzCgie3Vo0Qa3/nL56aYc9CVRYQR6FeJ3T3fUOuhqZejLdaBN3FnikI+ufP7zlblV32Tm8Zn9h33LOtFQZzmN+YdFotjDKYB2srCu7WsYFiHy5QIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHC/rmrk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHC/rmrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579A5C116B1;
	Thu, 11 Jul 2024 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720692233;
	bh=bytiMLPV2lOGNSZcnjRWSwf1EM6gvvVUhRuOoOG5GjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHC/rmrkFJBNnhHWjhfBtFBIlh534rct1k2taOIkDKk+101uvfPXDBsNvBncJHH69
	 6xokRbwj/7Hx+p9lts6SZYwBYKDaQFm/D9krohWerkboJeYKAu3Ase4YYznVo3nOCb
	 mCmvMl7jOA7ZiKV/Hjz2oyXNYDjjECFA7WTQKbMlc3j9Lp5A03CDYohnrx9+4o8aef
	 5qim+/+1Flo7OSlt2K842XSmwyuZoWHFmv1Y9hmSIWRXyMAd0d/Lkc27CwiVcAiF3a
	 xK4wzF9ezHzSwAp+P4h//HqsCb8jyjokeyil3cMRtNyoEjssQTWqOrR/buY2gMj9PV
	 ubTvHOsL3Xy/g==
Date: Thu, 11 Jul 2024 11:03:47 +0100
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
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jesse Taube <jesse@rivosinc.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Inochi Amaoto <inochiama@outlook.com>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <kevin.z.m@hotmail.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 08/10] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <20240711-legwarmer-repent-b88851e1eefc@spud>
References: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
 <20240709-k1-01-basic-dt-v4-8-ae5bb5e56aaf@gentoo.org>
 <668f8cb0.630a0220.0385.4d00SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ofIF/HTzLj1NJtwG"
Content-Disposition: inline
In-Reply-To: <668f8cb0.630a0220.0385.4d00SMTPIN_ADDED_BROKEN@mx.google.com>


--ofIF/HTzLj1NJtwG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 07:40:53AM +0000, Yixun Lan wrote:
> Hi All
>=20
> On 03:18 Tue 09 Jul     , Yixun Lan wrote:
> > From: Yangyu Chen <cyy@cyyself.name>
> >=20
> > Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].

I seem to have got this message in my inbox 4 times.

--ofIF/HTzLj1NJtwG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo+uAwAKCRB4tDGHoIJi
0npnAQDSIwrWnFT4oPX+7BLubmQIPoFzlorP/nRxCD2Rk1JVWgD+N7hX/QS8vNkV
AxFOywvGmQe87lC62pC5eCo2LGpc8w0=
=Mq4f
-----END PGP SIGNATURE-----

--ofIF/HTzLj1NJtwG--
