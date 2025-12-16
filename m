Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151A27CB02;
	Tue, 16 Dec 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902829; cv=none; b=j+sU5fyPCZYW3HvpJR7w2RQuEyKlTWqp9Ugrf8MyTYtVkg+PckdBiIhw+lnG5kBm9sunFzZzP+Q7Vt090A8p4fKuC2fGiHD4TV7yk5eQ8JbUvnn3U2wI3q/W6deFdXDwWEggZEwt4LDCaa9LbIHrQU3dPHJshPRYhtIkn7kwy18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902829; c=relaxed/simple;
	bh=YKJMtPFWa6ht+n9Bxx5M3M/3OHahvRpYpniNwtoIfcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4zZw6IUQLzssUBHFLYuA89hfHwq5yOtTw3p5+/tgd0u3RfKJtinTs0CPw5cTgBqoMzoX8+Xn7/yZf4BsNPTcXv316UAO74fRHqtIPtMEkYjYd6U6jpvlIM3bICzbz91qhX7Tel73Zt7aPcfJDlZxIZ6xhSDOzP6YvRa/Nx6uHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rD2pRTmX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rD2pRTmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB5CC4CEF1;
	Tue, 16 Dec 2025 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765902828;
	bh=YKJMtPFWa6ht+n9Bxx5M3M/3OHahvRpYpniNwtoIfcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rD2pRTmX6g38MqEQaqw1UPO3Qn55ibZ/bbyJaoRGufwZLufeGkG88EHBSDXFUabaO
	 640367wbsRRwXZs1Myg2eN36rgpbN1bA1N44fXG8hZgG8H0qEww3e+uxo0g0c7KIfi
	 q2Qs5HMImmZiZjsM6uyoA/5+fN0ZHxYpeZ3pyLA4+tGqEv/HNvNRIj7szFMWYd0Z1j
	 DaeiKBc/0y/WW4bz+TdnR77riKVcs30CTmrBn9WyEbKP+U6PU5YXESVvas52pHfBoV
	 ouJiRXUxFT0t30dxtShiqzxEVijxlxrFRIOus6ondRUejmAstBAnkj26AfvNrfU4Kd
	 E6LbXeRVnlnYA==
Date: Tue, 16 Dec 2025 16:33:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 6/8] dt-bindings: riscv: spacemit: add K3 and Pico-ITX
 board bindings
Message-ID: <20251216-wing-squander-2fed378d3035@spud>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-6-a0d256c9dc92@riscstar.com>
 <20251216150530-GYD1903981@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WOHLg4B2RTM9rCY3"
Content-Disposition: inline
In-Reply-To: <20251216150530-GYD1903981@gentoo.org>


--WOHLg4B2RTM9rCY3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:05:30PM +0800, Yixun Lan wrote:
> Hi Guodong,
>=20
> On 21:32 Tue 16 Dec     , Guodong Xu wrote:
> > Add DT binding documentation for the SpacemiT K3 SoC and the board Pico=
-ITX
> > which is a 2.5-inch single-board computer.
> >=20
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/spacemit.yaml | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Do=
cumentation/devicetree/bindings/riscv/spacemit.yaml
> > index 9c49482002f768cd0cc59be6db02659a43fa31ce..003b0bc1539b621e39172a0=
565dfea1274cbc8b8 100644
> > --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > @@ -8,7 +8,8 @@ title: SpacemiT SoC-based boards
> > =20
> >  maintainers:
> >    - Yangyu Chen <cyy@cyyself.name>
> > -  - Yixun Lan <dlan@gentoo.org>
> > +  - Yixun Lan   <dlan@gentoo.org>
> > +  - Guodong Xu  <guodong@riscstar.com>
> please simply use "one blank space" here, it's more consistent,
> trying to align them like this would result in even worse situation..
> =20
> - only email addresses got aligned while not user names (first, second
>   name?)
> - adding another maintainer in future may break the alignment (if long
>   name)

Yeah, these are never aligned. Just do one space gap.

--WOHLg4B2RTM9rCY3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUGJ4gAKCRB4tDGHoIJi
0kA9AQCvdHdh3ZN6TPbUIs6IjVSdbLXEtx33bODh8014ZkTIPAD+O1FYIibih/H5
/frJtNNEwi9BQrqT/KU1vwpLyBCJQwU=
=4/Ek
-----END PGP SIGNATURE-----

--WOHLg4B2RTM9rCY3--
