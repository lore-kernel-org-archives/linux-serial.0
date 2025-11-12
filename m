Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3632ABD6;
	Wed, 12 Nov 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967887; cv=none; b=F8YLhFfSEzkSMRAsMXArr3qHh06uxQWL/gVoQbUbzMP2TiALD4GNi6OnARXPKBlLG5IsMso3ekGuI9RcMTHYmITXVlYTP39QWrDVtoavhxhDQgALdiZRSZdtLR8mvpWAFxZ31vue66G6gt2lgng8ak9ZaP68rjRr2aOCKcJS6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967887; c=relaxed/simple;
	bh=lywOI3ugT5GWb9bwVFXxkmySZuCeiZT6yvSuaKP0HcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXWTRAO2CedNUgSWMcUgxQsSPPSl9Sq4lY53c5FkQi+NxZn8q9Tb/UZW5FiqcSRtNihhYBVXCrgneN/gaa3fgvGLoKoOO5AaxvwXOmNSsjXrrPcP5LWY1yNetY1LsGPQ+ydrPAux8ICrYgJKaJr9/6V2js7Eatwr3rXgCQ5uPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwK61djM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwK61djM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1882C4CEF7;
	Wed, 12 Nov 2025 17:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762967885;
	bh=lywOI3ugT5GWb9bwVFXxkmySZuCeiZT6yvSuaKP0HcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwK61djMIzlYVBJc4Z+qj++gbp7r+37xPxbLaPk/yQnLIoBvSOEuXsvHZYOd7uFzw
	 AazikNH2wSTsfKCKQoT4J7Yj/XOt83DkO+Y6752a3ur8rfvKcQyL3Md9GHy8pzJj39
	 a+xb2ppjv/PZ2gTEf+8OjgIlhSFPRC/2nMbtXTH7MVDY4S2OpdWnD88oOqp3hdJ/eK
	 UlUcv0XSDLkriDXp1QKO8YIKuxycCakV/M2WvQfoC9HpoLylVoXc7WuafnKiBDQ7Um
	 EoscBrZSBliWNOgV0rJh+az/NLMf1Yj6U23fykSjLTWGDNWPI5v+dSF4nECmNMLnsz
	 IU5A8BD7Dd8PQ==
Date: Wed, 12 Nov 2025 17:17:57 +0000
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
Message-ID: <20251112-bazooka-dragster-cf5c508094e3@spud>
References: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sV5/agMmM68jKYjx"
Content-Disposition: inline
In-Reply-To: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>


--sV5/agMmM68jKYjx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

Thanks for grabbing the irqchip stuff Thomas.

I've applied this, with myself listed as maintainer. I set the status to
"Odd Fixes" because I will be doing no work on it and only applying
patches that people send in. I'll happy pass the platform off to someone
qualified to maintain it, should that person be willing to do so :)

Patches are here:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dan=
logic-initial

I'll submit as a standalone PR to Arnd et al over in the soc group for
the next release.

Cheers,
Conor.

--sV5/agMmM68jKYjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRTBRQAKCRB4tDGHoIJi
0m7BAQD1yYi9jfzMwFoKsn729d+GEAmzldurXKdZYtAcmWmIdAEAxWTgsRJKilvT
RFkLQvvfFeBChW/ncbEBG5CxBatGEg0=
=CwfP
-----END PGP SIGNATURE-----

--sV5/agMmM68jKYjx--
