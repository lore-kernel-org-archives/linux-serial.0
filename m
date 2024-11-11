Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7777156C72;
	Mon, 11 Nov 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355643; cv=none; b=jyoKSCd+r68sdHM2sqSEeopnl50Le/GLM8g/QxhSIT1faohocGECA5qo9B8MW2f5b3DsJ7yiJ6ezT5+fL/CodYucSFYKx+SHw8X2cuyeDvnYfbb5TBZ2bb0R/I9p/ucqeJdPZdw/dCoWk+hupLl56Gj7VxcqmMS2iIOAeEtdru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355643; c=relaxed/simple;
	bh=6pVsE2CJCXEP+zojvkWyghZFggypw44sgN8gww7BHhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKpP1JqaW4Hbu0GdBsmGqqKPODvbAkHXOKAdSJdtYP5rba9LSCiZLKAR0iSl6zldoXXQA5rokQaW3LSU0HYpW/G4is9tVvohBBS9+vXN6gcY82rE6pCsBWm+B3xd/gSzrgmcAs4qhmdS5vVHAPup8EbvFLpWEgvH+wW7k9KKaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aahHXekZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aahHXekZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7C0C4CECF;
	Mon, 11 Nov 2024 20:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731355643;
	bh=6pVsE2CJCXEP+zojvkWyghZFggypw44sgN8gww7BHhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aahHXekZGYzHfCqbMox4sD3D1Lvhog4LCwAh+MoJjx/FvoSgXZUNlKfhqwdXcJt4T
	 R7SfynJ6FVvOqwAiGC2rw2psmlSMs8mELb8BNrq7Bd954I6Mo7gH1LjgvFLA8YBykQ
	 05DmayYUN1r0Yu3z3qn5fw2MFzu1qUPDYmfhwczh1QtM6Ty7i3EL8XL0JT2Atag0fo
	 ik8dUDhfEWaM8/bJ4fcP/g4SAcitHgVwNcJPbv7r/73LNAhTl1BcFB2XNWOYcpz/LF
	 zQObnmuX7N8mfU1dmheUxqwPytjkhOJ2/NTaPCKJkzr20NQVM0bhwxNsPOFCbn87Zf
	 S5QwR1tY+UjGw==
Date: Mon, 11 Nov 2024 20:07:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, NXP S32 Linux <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: serial: fsl-linflexuart: add clock
 definitions
Message-ID: <20241111-jinx-paralysis-cedd30e8d814@spud>
References: <20241111112921.2411242-1-ciprianmarian.costea@oss.nxp.com>
 <20241111112921.2411242-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="weSy6AEd5ZgY8ZdK"
Content-Disposition: inline
In-Reply-To: <20241111112921.2411242-2-ciprianmarian.costea@oss.nxp.com>


--weSy6AEd5ZgY8ZdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 01:29:20PM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Add clock definitions for NXP LINFlexD UART bindings.
>=20
> The LINFlexD driver was working because the LINFlexD clocks were
> configured and kept enabled by the downstream bootloader (TF-A [1]
> and U-Boot [2]). This is not ideal since LINFlexD Linux driver should
> manage its clocks independently and not rely on a previous bootloader
> configuration.
>=20
> [1] https://github.com/nxp-auto-linux/arm-trusted-firmware
> [2] https://github.com/nxp-auto-linux/u-boot
>=20
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--weSy6AEd5ZgY8ZdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJj9gAKCRB4tDGHoIJi
0tM3AP4+ylAt5jU2/dXlB4U9kkvigneTQ15jdBARV5cl2P7LfwD/b1TT0y+6ewBD
idDpy3xnQLc7Jhqpids2Jy5Xv0uO7gI=
=vLhV
-----END PGP SIGNATURE-----

--weSy6AEd5ZgY8ZdK--
