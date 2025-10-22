Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D512327A3;
	Wed, 22 Oct 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155844; cv=none; b=qYKLuI6PE8o9E8d0QkzSQ8uduTfpLTo4tiLW3qPO8lKPNVOBvmW0DvHwX1x9adpxGOwqX6RLpAKYCeBScCgKzDnEMBbUjK4Lul88oidon5DrRI/7RDajEPcT8fhRbIiDG7AKJYxCiVj6yr4yW1Yrb1LQSEfPU7UD+u7r7UVROqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155844; c=relaxed/simple;
	bh=NEsjqtrMN+8pP8HTwEn/I8N7EfFcYtZgX1qnvAwcOEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/JlHhSvXd7o5KAiSwSuMvT5V+/OW2xwbq0NsZZiOofigG1Hv1WJZ8G4dF0FsX+PsGv1ut4pJoSBSGHgpXInM0l1/4gGvKwC7zxF1b+dC7Y9zqueGtiFSbi9DpO54s33uA5F7ymLBLuV5I5KYXPi7ZXknGU36jqqMgK7NoooP00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfbs7wiC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfbs7wiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790B5C4CEE7;
	Wed, 22 Oct 2025 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761155844;
	bh=NEsjqtrMN+8pP8HTwEn/I8N7EfFcYtZgX1qnvAwcOEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cfbs7wiCBwWRE/B1xpOu//keoO+OAT2x/zXzE5Egj0iqXNtCT6wY3awVxPYCugQV2
	 ZYgowUItnZDzOwqwHUv71cB2UNvvLzK7BcLjcdU/p7C2JcDBaUJtu4IB7cNdBrajpM
	 2RCrW82gQAkLlgcuwVyScpQsCN8H8y26yP+j7UHWDgpr2YZuyo0Yno91tJSn20Sgb2
	 AkywNcilCB9zj0XKYpl/EwB1TjhIfUtEnFQXifEfVWKvNCEx7+Gm5rmieVB9zc459m
	 jl4ZVVtFjV6/PnPBXFPJu8hP2Rzrh0HU+r2nDMOZPFu1y2JT2ssnKaTO0ykH6bpqLJ
	 TX4TbXjnaYR/A==
Date: Wed, 22 Oct 2025 18:57:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: snps-dw-apb-uart: Add support for
 rk3506
Message-ID: <20251022-yarn-sevenfold-933ad8a0b0c4@spud>
References: <20251021223209.193569-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J8HSJMoEQDYdAuBO"
Content-Disposition: inline
In-Reply-To: <20251021223209.193569-1-heiko@sntech.de>


--J8HSJMoEQDYdAuBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:32:09AM +0200, Heiko Stuebner wrote:
> The uarts used in the RK3506 SoC are still the same dw-apb-uart compatible
> type as on the SoCs that came before, so add the RK3506 to the list
> of variants.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--J8HSJMoEQDYdAuBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkbAAAKCRB4tDGHoIJi
0l6zAPsGGEd9kihOfkDV7ok69YsPRSwfkWR92NeH8HqDrQRyXgEA4D/bSvUZKVAH
bbuEkaPiNpuJPu1XM+5ekVij4/b5KAA=
=T+9r
-----END PGP SIGNATURE-----

--J8HSJMoEQDYdAuBO--
