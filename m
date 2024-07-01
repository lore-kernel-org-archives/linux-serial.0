Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D699D535D4;
	Mon,  1 Jul 2024 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836569; cv=none; b=sD/L60GK2m9HuxDhF1z7BDwS4GIcTr53PlNvOLMGzf208oHTXwH5qriNmfVLqDSL9wKlvFkyFDTIc6l8qwO9K+FcQIhljDqUP8ngzGfOToHOoOH4Y28qpqsV8UBoD7nv1VRn6DglAOrggtn8R49IvKSqgtWOhRO59T82my+0keU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836569; c=relaxed/simple;
	bh=NMxG4tkqcMPOEcnyGSPtxcQ8JKKz8GSwXxFVukYNc70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtg2//2Q0spVkXjTztY64E955YpEvXT4eBBU5eETLJDENK15OdwJ0rA2/69j0+PSDcJCf4zE5K2vCojgMpIxr+D8djMYhYvoHDKuDqGB1I3L+COwrRd5YUiirDoJGSgK2Ybycy1Iwmk0CHxJjm4QpBzWhzlPo5GFGsXjedzxWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF7lBwBH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF7lBwBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8B1C116B1;
	Mon,  1 Jul 2024 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719836569;
	bh=NMxG4tkqcMPOEcnyGSPtxcQ8JKKz8GSwXxFVukYNc70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MF7lBwBHIyhk572bNPS85tUsjWtRRktMXAWoO8pDI932hLRJ1wphYSv3BejgECVuL
	 4dK108/5DYMFOAcHgvmvlB3mf8VR4a9TuIutzXrdmdwoRZxL/9cb1ecwz1P5hq13oE
	 GvdClh7m7OdqWAU+EyGOlPQBbiErN/uGPaTfBKUSXnvMeeaglMqLX+p675aA9D9gLF
	 ds1cVqIgkxutDiYQ9CXL8egc6kia6nxSPdCFWH4z4gjqgVagjG8q9DG7UfTh0zO6Ee
	 7/gZbmz7Kd/Js7FaWx8Hby08LvwDgeYgZiI23z1s6MrWcEIdPDWrbxEBrdHMuC7Ji6
	 9Ea6vN+38XCCA==
Date: Mon, 1 Jul 2024 13:22:43 +0100
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
Subject: Re: [PATCH v2 04/10] dt-bindings: timer: Add SpacemiT K1 CLINT
Message-ID: <20240701-exorcism-ending-ecd6bdb43471@spud>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-4-cc06c7555f07@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dEuMgQ4pMEmSiiFw"
Content-Disposition: inline
In-Reply-To: <20240627-k1-01-basic-dt-v2-4-cc06c7555f07@gentoo.org>


--dEuMgQ4pMEmSiiFw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 03:31:18PM +0000, Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
>=20
> Add compatible string for SpacemiT K1 CLINT.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/=
Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index fced6f2d8ecbb..c2e68587a806a 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -31,6 +31,7 @@ properties:
>            - enum:
>                - canaan,k210-clint       # Canaan Kendryte K210
>                - sifive,fu540-c000-clint # SiFive FU540
> +              - spacemit,k1-clint       # SpacemiT K1
>                - starfive,jh7100-clint   # StarFive JH7100
>                - starfive,jh7110-clint   # StarFive JH7110
>                - starfive,jh8100-clint   # StarFive JH8100
>=20
> --=20
> 2.45.2
>=20

--dEuMgQ4pMEmSiiFw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoKfkwAKCRB4tDGHoIJi
0phzAQDTLo6+jXi4YLUzBn0ptxxjhdcNHVYChZPWicWGuQkp2wEAy7QmsRHrTdFu
1PNGRZ5q9g+u2uDx6XwJiao34suivQA=
=8fg0
-----END PGP SIGNATURE-----

--dEuMgQ4pMEmSiiFw--
