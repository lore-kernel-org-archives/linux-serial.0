Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB01AD9E7;
	Tue,  2 Jul 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933913; cv=none; b=CJjlJDP3drjdIPSaaKCZT3hbHTAIe/+rAAZJ3guTZARc6dJDzakIEDHi9PAU2tAZGCJxXbzZ5WEK6b8SRvXfH7MTFj7QnJnxhS6GV8zKktzRnrllrr590lRaPMsVabzejhHIEkR4at09nYahgvaO2jKXBHPYroGxPjBsMcrzBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933913; c=relaxed/simple;
	bh=cc7nvHqqj6c3V+LFIi1X86+pPFAUbngIvHertngi76w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owLpjFFqf1zVWErpSN1v122a+7JsIWh4gMF9asaEXwVypnjcwLB5rK32DQhgsFLY06yf+gEO+QFc/1XAilGBVaaG1H+jmaiyMdZCvFXiWRyHItqe7gr5hQOiQ1tFHPFNfD0o9Aw+azNbk3dwkGvz8QKgS19LxJ9qXHh+7arOaJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhK+QYhE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhK+QYhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523A0C116B1;
	Tue,  2 Jul 2024 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933912;
	bh=cc7nvHqqj6c3V+LFIi1X86+pPFAUbngIvHertngi76w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhK+QYhE7XaL488ISYDfSItk/bnFEpOvq9q6T8ma2uPOF1C2yzK2VHrRMvApxk+yi
	 l9CfI7GmUe2VQKzm/CJbV7E+Drx5kPrTL+YH5sNAbp/CgVgHrf5naOTT11Dj8fgy5m
	 3HJ6rwcgKb+swO0wtLyfIVWndxnTo287pRy7YYlRVh6kiZ1NDkEMe4bnah5/teQwsL
	 PexfjxVWll9z7nCb06g6s4wZ77uCimP5ayt2mmwxDLMxMyxaCrkQyx6rA0FbOncQKB
	 lGhQQJu22xAdPvM9YPx9cDG1LZejEOIulj0QmT15yu71eH9GOEtLqTMpK2KFlLSUkc
	 0YUj40EpeB3Pw==
Date: Tue, 2 Jul 2024 16:25:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	linux-serial@vger.kernel.org,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v2 08/10] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <20240702-appease-attire-6afbe758bf0f@spud>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-8-cc06c7555f07@gentoo.org>
 <CAJM55Z9jeAQTsVjRiLeofDm1RyMWCuHXC0a-pdKtpUiTkSjJCA@mail.gmail.com>
 <20240702012847.GA2447193@ofsar>
 <IA1PR20MB4953C031CB453AA0E51657B3BBDC2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8t7ClsDF1V/WRNDh"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953C031CB453AA0E51657B3BBDC2@IA1PR20MB4953.namprd20.prod.outlook.com>


--8t7ClsDF1V/WRNDh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 09:35:45AM +0800, Inochi Amaoto wrote:
> On Tue, Jul 02, 2024 at 01:28:47AM GMT, Yixun Lan wrote:
> > On 12:49 Mon 01 Jul     , Emil Renner Berthing wrote:
> > > Yixun Lan wrote:
> > > > From: Yangyu Chen <cyy@cyyself.name>
> > > >
> > > > Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> > > >
> > > > Key features:
> > > > - 4 cores per cluster, 2 clusters on chip
> > > > - UART IP is Intel XScale UART
> > > >
> > > > Some key considerations:
> > > > - ISA string is inferred from vendor documentation[2]
> > > > - Cluster topology is inferred from datasheet[1] and L2 in vendor d=
ts[3]
> > > > - No coherent DMA on this board
> > > >     Inferred by taking vendor ethernet and MMC drivers to the mainl=
ine
> > > >     kernel. Without dma-noncoherent in soc node, the driver fails.
> > > > - No cache nodes now
> > > >     The parameters from vendor dts are likely to be wrong. It has 5=
12
> > > >     sets for a 32KiB L1 Cache. In this case, each set is 64B in siz=
e.
> > > >     When the size of the cache line is 64B, it is a directly mapped
> > > >     cache rather than a set-associative cache, the latter is common=
ly
> > > >     used. Thus, I didn't use the parameters from vendor dts.
> > > >
> > > > Currently only support booting into console with only uart, other
> > > > features will be added soon later.
> > > >
> > ...
> >=20
> > > > +		clint: timer@e4000000 {
> > > > +			compatible =3D "spacemit,k1-clint", "sifive,clint0";
> > > > +			reg =3D <0x0 0xe4000000 0x0 0x10000>;
> > > > +			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>,
> > > > +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> > > > +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> > > > +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> > > > +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> > > > +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> > > > +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> > > > +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> > > > +		};
> > > > +
> > > > +		uart0: serial@d4017000 {
> > > > +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> > > > +			reg =3D <0x0 0xd4017000 0x0 0x100>;
> > > > +			interrupts =3D <42>;
> > > > +			clock-frequency =3D <14857000>;
> > > > +			reg-shift =3D <2>;
> > > > +			reg-io-width =3D <4>;
> > > > +			status =3D "disabled";
> > > > +		};
> > > > +
> > > > +		/* note: uart1 skipped */
> > >=20
> > > The datasheet page you link to above says "-UART (=D710)", but here y=
ou're
> > > skipping one of them. Why? I can see the vendor tree does the same, b=
ut it
> > > would be nice with an explanation of what's going on.
> > >=20
> > /* note: uart1 in 0xf0612000, reserved for TEE usage */
> > I would put something like this, does this sound ok to you?
> >=20
> > more detail, iomem range from 0xf000,0000 - 0xf080,0000 are dedicated f=
or TEE purpose,
> > It won't be exposed to Linux once TEE feature is enabled..
> >=20
> > skipping uart1 may make people confused but we are trying to follow dat=
asheet..
>=20
> Instead of skipping it, I suggest adding this to reserved-memory area,=20
> which make all node visible and avoid uart1 being touched by mistake.

No, don't make it reserved-memory - instead add it as
status =3D "reserved"; /* explanation for why */
Also, I'd appreciate if the nodes were sorted by unit address in the
dtsi.

Thanks,
Conor.

--8t7ClsDF1V/WRNDh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQb0gAKCRB4tDGHoIJi
0tEwAQDbZqSQrUgTmMpfdmDuQPr0P0SBOkFpJs0/aPbXIvDa3AEAltJ5Hgikal1T
3Be6wU3wIZBpw+4BQ/NmiOt4fe2a7AA=
=zeit
-----END PGP SIGNATURE-----

--8t7ClsDF1V/WRNDh--
