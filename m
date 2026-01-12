Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1EE2BEFFD;
	Mon, 12 Jan 2026 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254117; cv=none; b=cTxhK4+pYj6jptHjy4BCaWsIvmVM3EWYDR/Me9E/4u9H2g6ECnG3lo1k6b/kYmBIgMdIiUwuFohvSN+LzkoShc91tRHTWZmrWx9Vcgojd+te01MlRWP8mE7NSugLiof2urxqgLVOvyDl8voqhDPstSeRo4xv1OuuBFsgBtomOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254117; c=relaxed/simple;
	bh=sGJCmX/HliLDAhFR8jn4f9Rtt6JLol6dbDTmt2tzDk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwMUFLU04hmUYP1BkEVkedknKKe7wPlcliUoKDFd47Zw4GaHmTygPwJpX9kmtmDICZi0hk5XK1AQcZrESlHLDIiIVrkNiVMpXN9aN402//kSY8cg3ojrqUe5Y7ft3DYYiaBP8UCAM3Xx/88cuwNKHSke0h8BFSJWwgOk/p990kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6pGwNll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6pGwNll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3B2C116D0;
	Mon, 12 Jan 2026 21:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768254117;
	bh=sGJCmX/HliLDAhFR8jn4f9Rtt6JLol6dbDTmt2tzDk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6pGwNlliZ6xm7wTeAHvptowfLFeYMm1dKlTw9AKn8l5NB2hf1kNqB0W2FlbcUH8H
	 G7nbLAZD5N+8n3gqVh55QqwyqE86qGmsPCquA9fOLtBRVlXTtIHNtxUKrvXmzRaaFW
	 Se0h7Q0Xux08r3DC3Rm87rHCtc2bATy2X/NAkleGFRRyUGf6IOy4OMsMopLXEsS4TE
	 Fd7mzDpRkY9sDgmkIeDRmct/nj3VTo8YpIjg6OE5vf/JMGOqTvthlebkqV7cD1a7c7
	 9AvziqXSsWN3w4g9JzAWbGfyxC0oLyU2wgBcRk/Ae8D8rZfjKGd+VJINDO4RSH12k1
	 ayWRj5yc2mwTQ==
Date: Mon, 12 Jan 2026 21:41:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 06/11] dt-bindings: riscv: Add B ISA extension
 description
Message-ID: <20260112-veal-retaliate-7cf9a2981aaf@spud>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-6-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jl0lukoungssHXqm"
Content-Disposition: inline
In-Reply-To: <20260110-k3-basic-dt-v4-6-d492f3a30ffa@riscstar.com>


--jl0lukoungssHXqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 01:18:18PM +0800, Guodong Xu wrote:
> Add description of the single-letter B extension for Bit Manipulation.
> B is mandatory for RVA23U64.
>=20
> The B extension is ratified in the 20240411 version of the unprivileged
> ISA specification. According to the ratified spec, the B standard
> extension comprises instructions provided by the Zba, Zbb, and Zbs
> extensions.
>=20
> Add two-way dependency check to enforce that B implies Zba/Zbb/Zbs; and
> when Zba/Zbb/Zbs (all of them) are specified, then B must be added too.
>=20
> The reason why B/Zba/Zbb/Zbs must coexist at the same time is that
> unlike other single-letter extensions, B was ratified (Apr/2024) much
> later than its component extensions Zba/Zbb/Zbs (Jun/2021).
>=20
> When "b" is specified, zba/zbb/zbs must be present to ensure
> backward compatibility with existing software and kernels that only
> look for the explicit component strings.
>=20
> When all three components zba/zbb/zbs are specified, "b" should also be
> present. Making "b" mandatory when all three components are present.

> Existing devicetrees with zba/zbb/zbs but without "b" will generate
> warnings that can be fixed in follow-up patches.

Are you going to send these fixup patches for other devicetrees? The
majority appear to be other spacemit devices.

--jl0lukoungssHXqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaWVqngAKCRB4tDGHoIJi
0qwfAQCamQ336+8Ol6Cm4BGdZ1WngDrqc6adOnM/s3WibPSj1gEA5adimCDCrVEG
eLvwJuJiBsmzP57dHrSu22VBtIaN9gE=
=7BIS
-----END PGP SIGNATURE-----

--jl0lukoungssHXqm--
