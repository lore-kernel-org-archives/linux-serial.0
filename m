Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2CD2147E6;
	Mon, 12 Jan 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254016; cv=none; b=OsyLiTu/Il6EzwikTgCLPngJpKHKT3fgi1EAz3VjhaLAMZp1u80Dx6oKPJ6KvhFm9BxRuuVtMiG0F+Gipn8WfsDeokS6ocQ7lE/lTSZ3ym73WWiekUK6fmzfHxnewcR2baBfdfBj1gZ3nPJMOWCos2NfVha6E6PFjtLVBTIBlkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254016; c=relaxed/simple;
	bh=LOKmVbta3KTlWJmOJeErvVo/1aCGqs/kS5P/v8xIT3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZGNqsJzEETyKlys5fvWnlX/i8fJaWR55+9FWOynd8lxNVj5Qq+ZiL3/7f4dx2kZTJZMdiZ4yTLvzLtKYvLa/G00W3OAAwxTHwkDkJpjKYK3mMNRT2imLtObky1ip4q+v9wEv6s+ObEr8Lh/OA6mZcShxpjQMsrVs61fV5tgQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzc0zWr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzc0zWr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E10EC116D0;
	Mon, 12 Jan 2026 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768254015;
	bh=LOKmVbta3KTlWJmOJeErvVo/1aCGqs/kS5P/v8xIT3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzc0zWr2W5aD2r0ZMy3D4N4/K56s2M41SGvIrHAqAQUNJeWnFJ9omfRoDK027cOs6
	 fYegE+qhqx4F63n9SCSobEwwuJ75SVJ8HXzRa4tpYCD2qfEuE2EQjexGkqclkQlxu0
	 mQnBH7p+JC7r0FZjrsXwBkzKsMwyEGdraQ3Zm0Ut2U+kRwwr7zHZZlVsvgFRf5HGqw
	 uR51RPALmPAEn5CTUsyytKOKFLrQ/8na9dfe2yKseFjBanHd/rYC2DsfQIHJ5dwMcA
	 irk8HGDi1bdFooC//9nT70kg5DPoZxO/lKullY6snbMaiyyl97oPNGyt+fAi9GM9BC
	 2uvj/9iPPm/1w==
Date: Mon, 12 Jan 2026 21:40:09 +0000
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
Subject: Re: [PATCH v4 09/11] dt-bindings: riscv: Add Sha and its comprised
 extensions
Message-ID: <20260112-quintuple-reviver-7f5af13e6399@spud>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-9-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OnOpPJV8XtrAgdMC"
Content-Disposition: inline
In-Reply-To: <20260110-k3-basic-dt-v4-9-d492f3a30ffa@riscstar.com>


--OnOpPJV8XtrAgdMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 01:18:21PM +0800, Guodong Xu wrote:
> Add descriptions for the Sha extension and the seven extensions it
> comprises: Shcounterenw, Shgatpa, Shtvala, Shvsatpa, Shvstvala, Shvstvecd,
> and Ssstateen.
>=20
> Sha is ratified in the RVA23 Profiles Version 1.0 (commit 0273f3c921b6
> "rva23/rvb23 ratified") as a new profile-defined extension that captures
> the full set of features that are mandated to be supported along with
> the H extension.
>=20
> Extensions Shcounterenw, Shgatpa, Shtvala, Shvsatpa, Shvstvala, Shvstvecd,
> and Ssstateen are ratified in the RISC-V Profiles Version 1.0 (commit
> b1d806605f87 "Updated to ratified state").
>=20
> The requirement status for Sha and its comprised extension in RISC-V
> Profiles are:
>  - Sha: Mandatory in RVA23S64
>  - H: Optional in RVA22S64; Mandatory in RVA23S64
>  - Shcounterenw: Optional in RVA22S64; Mandatory in RVA23S64
>  - Shgatpa: Optional in RVA22S64; Mandatory in RVA23S64
>  - Shtvala: Optional in RVA22S64; Mandatory in RVA23S64
>  - Shvsatpa: Optional in RVA22S64; Mandatory in RVA23S64
>  - Shvstvala: Optional in RVA22S64; Mandatory in RVA23S64
>  - Shvstvecd: Optional in RVA22S64; Mandatory in RVA23S64
>  - Ssstateen: Optional in RVA22S64; Mandatory in RVA23S64
>=20
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--OnOpPJV8XtrAgdMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaWVqOAAKCRB4tDGHoIJi
0kJIAPwMyqd17Gr0W0AzQIkInGX+fgrRE2t6v3qKpAOfalSyyQEA4En4SHB46aGG
PPpEsCnL16wsGwrk2jfzVNeBYJouUwQ=
=HvhX
-----END PGP SIGNATURE-----

--OnOpPJV8XtrAgdMC--
