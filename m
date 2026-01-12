Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836931891A9;
	Mon, 12 Jan 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254366; cv=none; b=UMFvg+QUQaDOsSbyfF74XzO2Tm5GTMywFi9JNjKqi1BhooUp+of64y8Ds0an+QibwKFhDGzflvI/JEESUp/mX/IeQfBtcgM7eYD7Lkp4zppGEt4KO+oli8w5NA12IkgVn9GjkcMwri0QBX8EQbZdv2V+oFr61Q68f/cKkyjjttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254366; c=relaxed/simple;
	bh=+A7nQFMk6BRPZjLEa0VYC39l7M4sHP9QSmOHqvMF7xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVuMRn5DvzK7FliRgsXpfUuuoZgLiQfeoBEHzOdtkwfX+FCqKyukOAyzoVLvHoOpuTNmgolJfEJuUonDdZh/ETxrFUi59no1sb82LpByR1CTkTR7kB2Ijq5RcYMKg+zdUtySGvTZqA0rS7XOtymWQ1oPJcfKrQtL2AZejG9lNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX5JX1Gr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX5JX1Gr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C9BC116D0;
	Mon, 12 Jan 2026 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768254366;
	bh=+A7nQFMk6BRPZjLEa0VYC39l7M4sHP9QSmOHqvMF7xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bX5JX1Grl3nbFcEKpaj45bcdJsFiuhmR3dWVC8VCVXk76K4H9xCRYzRG/Aol6Gs5B
	 OfQK3kb3n+sbGOisprw0w41eHMeCdZ3+XCRHu09e3ixHgoqY5e/KUVibawqQ5SacSi
	 obZbL45Ra+LOhjA4FuI18kyXK/3z713bRnFJeH6+LHfv9vxlD4RKQ01hbHGxw2rAfs
	 1ZJFTcKn+vC/9nkrIIggwswNuGLNCqf6Sb71OLYWMeNOue8TEnvc7LDlq07fAGA7Z5
	 xgiaL1f+4QfLgjNd6oczPE1lq+jinbsqajrOMgciogHocp63w4d8H5AC+5buYug3/6
	 poUA/rY+FHejA==
Date: Mon, 12 Jan 2026 21:45:58 +0000
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
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 00/11] riscv: spacemit: Add SpacemiT K3 SoC and K3
 Pico-ITX board
Message-ID: <20260112-shrivel-sarcastic-36d9acd2d96a@spud>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eGeDqA2+RAjxIlOp"
Content-Disposition: inline
In-Reply-To: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>


--eGeDqA2+RAjxIlOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 01:18:12PM +0800, Guodong Xu wrote:

> Hi, Conor
>=20
> For the binding riscv/extensions.ymal, here's what changed in v3 (no
> change in v4):
>=20
>  1. Dropped the patch of adding "supm" into extensions.yaml. At the same
>     time, I will start another patchset which implements the strategy
>     outlined by Conor in Link [2] and by Samuel in Link [3].

Okay, that seems reasonable to separate out.

>=20
>  2. Dropped the dependency checks for "sha" on "h", "shcounterenw", and
>     6 others. "sha" implies these extensions, and it should be allowed
>     to be declared independently. Like "a" implies "zaamo" and "zalrsc".
>=20
>  3. Enchanced the dependency check of "ziccamoa" on "a". Specifically,
>      - added the dependency check of "ziccamoa" on "zaamo" or on "a".
>      - added the dependency check of "za64rs" on "zalrsc" or on "a".
>      - added the dependency check of "ziccrse" on "zalrsc" or "a".
>     The commit message of this patch is updated too, to better explain the
>     relationship  between "ziccamoa", "za64rs", "ziccrse" and "a".
>=20
>  4. Enhanced checking dependency of "b" and "zba", "zbb", "zbs", making t=
he
>     dependency check in both directions, as discussed in [4]. Since "b"
>     was ratified much later than its component extensions (zba/zbb/zbs),
>     existing software and kernels expect these explicit strings. This
>     bidirectional check ensures cores declaring "b" remain compatible
>     with older software that only recognizes zba/zbb/zbs.

This I asked about in the relevant patch, I would like to know what your
plan for adding the "b"s is.

Spacemit folks, I assume you weren't planning on taking the
extensions.yaml stuff via your tree? If you weren't, I'll grab it once
the question about b is answered.

--eGeDqA2+RAjxIlOp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaWVrlgAKCRB4tDGHoIJi
0st5AQDVaFm0gq6ucDRxlFFW8jqtiLUa1O+EbmMgmTfjYPiaGAEAyjt/iYppXkBk
aori5mGpiMWtHrLZBCiZPe+bPh6TpAY=
=kYkG
-----END PGP SIGNATURE-----

--eGeDqA2+RAjxIlOp--
