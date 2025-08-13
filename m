Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E769E1E3DE5;
	Wed, 13 Aug 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103895; cv=none; b=TarPlfx4oFm2alLsYUi37mVs8cbpAsAg46R/jYJx9s+tpGAJuPG0hQmGFiRUrxB9OEsSWNFsKyKoTLTvGDEi5TYn/rRgc01t8WpiCWrmS31AW0sZxjjfFHKyQGB4OAEo/Pc+LCg9QhA4XjRMBwoI1G099P1QJCd1jb4LJnOjdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103895; c=relaxed/simple;
	bh=alZxexKuJRxDY0e4fO9bj6yA3dNEp3f4NpaBSvlkKBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SduT+sJcg+FREwGzf0N72S1i5oAPrJc2uRPHE6izl3Tn3tM0Rwl0jKfyAruWl9fUNowxYKjhiomrVwKZyAVJj03AjWTzctxNHmnZDN+4uygV+l43KRt9HxUcs8stsB/zxYrqDR3S0s/b+AjENuV3ZddMUD5UN/qZ3AZXqs+Ls0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDg2ZCyH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDg2ZCyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F9FC4CEF1;
	Wed, 13 Aug 2025 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755103894;
	bh=alZxexKuJRxDY0e4fO9bj6yA3dNEp3f4NpaBSvlkKBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDg2ZCyH4ajXLj2AbKVypeCzSlWWhmIXAAed3U43vAolmHFPzJIq9xj+2SQS2CGnf
	 A1fi6/1H5G+qtbMRoasHX2D6eKcY7JszjfW52QpacYgT0YMP1tdEpe3HcD3GPv1r9W
	 L+ly6AHYVg70ypQulceswIE+sAUx1g8krjGpvCa5mkV1MvbaYlhbUgx0jXWenuEEW1
	 0Y/ijSPMoHWjq09GvXB9cDpHC78faqTjOJrKxCVp9OzqMF/CRWYgyw/Nytt75o7mC/
	 mXe15yxiS0h6ZqTBOcAYQLMsJ2t4ZW1SCbELcvZBCUDtI+ztjNd7dOaiutegNF+mse
	 RHfwFT3XnI0Dw==
Date: Wed, 13 Aug 2025 17:51:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org, dlan@gentoo.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	lkundrak@v3.sk, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org, spacemit@lists.linux.dev,
	linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] dt-bindings: serial: 8250: allow "main" and "uart" as
 clock names
Message-ID: <20250813-squint-glass-b68c6520a229@spud>
References: <20250813031338.2328392-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1anDfOTh12y5hzMv"
Content-Disposition: inline
In-Reply-To: <20250813031338.2328392-1-elder@riscstar.com>


--1anDfOTh12y5hzMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:13:35PM -0500, Alex Elder wrote:
> There are two compatible strings defined in "8250.yaml" that require
> two clocks to be specified, along with their names:
>   - "spacemit,k1-uart", used in "spacemit/k1.dtsi"
>   - "nxp,lpc1850-uart", used in "lpc/lpc18xx.dtsi"
>=20
> When only one clock is used, the name is not required.  However there
> are two places that do specify a name:
>   - In "mediatek/mt7623.dtsi", the clock for the "mediatek,mtk-btif"
>     compatible serial device is named "main"
>   - In "qca/ar9132.dtsi", the clock for the "ns8250" compatible
>     serial device is named "uart"
>=20
> In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock
> 'uartclk' and 'reg' for nxp,lpc1850-uart"), Frank Li added the
> restriction that two named clocks be used for the NXP platform
> mentioned above.
>=20
> Change that logic, so that an additional condition for (only) the
> SpacemiT platform similarly restricts the two clocks to have the
> names "core" and "bus".
>=20
> Finally, add "main" and "uart" as allowed names when a single clock is
> specified.
>=20
> Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional sec=
ond clock")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@i=
ntel.com/
> Signed-off-by: Alex Elder <elder@riscstar.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--1anDfOTh12y5hzMv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJzCkAAKCRB4tDGHoIJi
0hf5AQCJLTs84F3yXa+J58tT2Ytl+UUy+1ftd0PWZy75L6EgiQEAqd0HSvhT8Kdp
3558GIp4PpqlN9n18fVGmK6z3ca8Cgo=
=iaPg
-----END PGP SIGNATURE-----

--1anDfOTh12y5hzMv--
