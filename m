Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527F53A1E66;
	Sat, 20 Dec 2025 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766272996; cv=none; b=hRu8ohhsYzR8nDHJx+JacIB9elqeUzXgugGXQ3/I8ZCR3QEzNJazwsoHsMWYO1+UG0a2qpt2ARlx0SQKvdYl+i0/DDqE8DsK2eq1VLJQr/aaxTOIXkJ+KgG3PI7SuOtf1d+uadyk5Omk6X/0QQIZGMMlW+LWCksQTKFvMTCbBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766272996; c=relaxed/simple;
	bh=DYYss6ZWpYzoGvO9RlSxm0H4tZWSG7kfM2Z3uoM3hWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN9YpCdtHoeKZBcyosMkdVsLOtxGv5DXZlnT271GG8s6XDDTnHInJz/8xEhjwzKFGdzbJy5H7DX577G9Kmzr0reZ9iPeUFKbL6du3NEIsdCwso31k+DfjAa8zbPWYb2hQWxBmW9k9OZuYm+TMN4GM9G+uaYzdJRgGyTxf0c/gg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hINoR2IE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hINoR2IE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A2EC4CEF5;
	Sat, 20 Dec 2025 23:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766272995;
	bh=DYYss6ZWpYzoGvO9RlSxm0H4tZWSG7kfM2Z3uoM3hWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hINoR2IEQqKuQb88S/+IK4isI2+0Cta8wVGyqPiZuiTa+HptnTzQ/sKsoiDWmZT2j
	 +XNI5LkNczhbCTnMnfwnjPb2SHnBaHZZ4Nk3V9t3uHlNOyYr81l9K9gthH9pDNKYAP
	 kD/M5W7bLLFZmWW2l55EbGOU3PYvmSo+2eqB2HSLcxeqIFQKL7drdfwfVZljv8ochd
	 lNe3wWRbTFL7z2MJyyWURThyprh8rWCXWU/ZSVc6J3NKoTWAbUl21XGJQ1VxKbiTsA
	 I866Xp11qS38rVRlSwptzLkQ35+gnCIq/yVxJ9hl9q5iFoSi5AZ2RZEN2myEOr2TDh
	 ciAWa+J8TKkPA==
Date: Sat, 20 Dec 2025 23:23:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
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
Message-ID: <20251220-repacking-football-c79e660e788a@spud>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com>
 <60948ca2-ed3d-485b-9b11-15df7ef8791d@canonical.com>
 <CAH1PCMb=+TvB1w+G6a2ANDp05HUwC4r6CFBDHXFwSmoP3Mm8xw@mail.gmail.com>
 <f9b6b5e2-ec9e-4208-8267-77020e0a9411@canonical.com>
 <20251218-basil-quantum-225ce16e4699@spud>
 <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SLqy3GCJri0eonfM"
Content-Disposition: inline
In-Reply-To: <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com>


--SLqy3GCJri0eonfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:03:24AM +0800, Guodong Xu wrote:
> Hi, Conor and Heinrich
>=20
> On Thu, Dec 18, 2025 at 8:56=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, Dec 17, 2025 at 09:07:14AM +0100, Heinrich Schuchardt wrote:
> > > On 12/17/25 08:11, Guodong Xu wrote:
> >
> > > > Specifically, I must adhere to
> > > > Documentation/devicetree/bindings/riscv/extensions.yaml (and cpus.y=
aml for
> > > > properties like 'riscv,sv39' which stands for the extension Sv39). =
If I
> > > > add extension strings that are not yet defined in these schemas, su=
ch as
> > > > supm, running 'make dtbs_check W=3D3' fails with: 'supm' is not one=
 of
> > > > ['i', 'm', 'a', ...], followed by "Unevaluated properties are not a=
llowed."
> > >
> > > If Documentation/devicetree/bindings/riscv/extensions.yaml is incompl=
ete
> > > with respect to ratified extensions, I guess the right approach is to=
 amend
> > > it and not to curtail the CPU description.
> >
> > Absolutely. If the cpu supports something that is not documented, then
> > please document it rather than omit from the devicetree.
>=20
> Thanks for the review. May I clarify one thing? Both of you mentioned
> document them, given the amount of missing extensions, is it acceptable if
> I submit a prerequisite patch that only documents these strings in
> riscv/extensions.yaml plus the necessary hwprobe export? Leaving the actu=
al
> usage of these extensions (named features) to the future patches.
>=20
> To provide some context on why I ask: I've investigated the commits & lkml
> history of RISC-V extensions since v6.5, and I summarized the current sta=
tus
> regarding the RVA23 profile here:
> [1] status in v6.18 (inc. v6.19-rc1):
> https://docularxu.github.io/rva23/linux-kernel-coverage.html
> [2] support evolution since v6.5:
> https://docularxu.github.io/rva23/rva23-kernel-support-evolution.html
>=20
> Strictly describing the SpacemiT X100/K3 (or any core) as RVA23-compliant
> requires adding these extensions that are currently missing from
> the kernel bindings:
> RVA23U64: Ziccif, Ziccamoa, Zicclsm, Za64rs
> RVA23S64: Ss1p13, Ssccptr, Sstvecd, Sstvala, Sscounterenw, Ssu64xl,
>           Sha, Shcounterenw, Shvstvala, Shtvala, Shvstvecd, Shvsatpa, Shg=
atpa


> Plus 'Supm', 'Zic64b', 'Ssstateen', 'B' where the kernel supports them but
> they are not literally documented in yaml.

I don't think Supm is suitable for devicetree, doesn't it describe
what the kernel/userspace are capable of rather than hardware?
Zic64b doesn't sound like hardware description (so not really suitable
for devicetree either) but block size information is already represented
by some existing properties (see riscv,cbo*-block-size in riscv/cpus.yaml)
and duplicating that information is not really a great idea.

I'll admit that I do not really understand Sxstateen and how they work,
but my understanding was that knowing about Smstateen is sufficient and
implied Sstateen, but having Ssstateen defined seems harmless and
possible. I think kvm is the only user of this at the moment, so
probably worth CCing Anup and maybe Drew Jones on the patch adding
Ssstateen to make sure it makes sense.

--SLqy3GCJri0eonfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUcv2QAKCRB4tDGHoIJi
0iR2AP9Yk3/6cNreOG5xP/f/Ga3J0EIzYWjEal9Q3S4fWg1J/wD/W51HcFJ+XVx8
UNjjhag+wvjdA/6x6J2/eZYqdoVHUQA=
=M6ap
-----END PGP SIGNATURE-----

--SLqy3GCJri0eonfM--
