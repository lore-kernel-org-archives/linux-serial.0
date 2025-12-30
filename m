Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2BFAD5A;
	Tue, 30 Dec 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767122498; cv=none; b=jlvrV81TrVnKS9QsZd4sNABvcuCeajdmihNWTz/mLF5oMNkK4aMtFh/zI2YJxA9cYa/oDRD+YWctXTJdxSqs1qT0qU2wmvh8ELu/+4moUxUmqrAvDKecsAwMPAwd8V9ljvn+9Ayka+8bIX0S1mEUxuoruJ8NHd4AcP/wLzLZg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767122498; c=relaxed/simple;
	bh=JHeq0sE7x9XUxdE+MvcareElflUYAz3cTd2iOEHjm14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC1KbdxCtTuwymNY3XPrmfDVdqyGDwaeHEeS12iYFQ42yt253j6HP+zfkorZtvLEq7phF5/Ovkbz6UGxLny16Glx2kdC9pS8SLz3zIqpMtzUGG1b7WOydqlBSQypebGVq6BreEpT8mZ2pXjkRGjJjDcB9E4WLaPhzPPgPeITbMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVbdb2wa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVbdb2wa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7355FC4CEFB;
	Tue, 30 Dec 2025 19:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767122498;
	bh=JHeq0sE7x9XUxdE+MvcareElflUYAz3cTd2iOEHjm14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVbdb2wawJgVjJSiF2Us8b8tX5zz+NUWRGvyeOax0xnxWmGR+1GEb4iHW7MkGuh96
	 Nz5pY3xwmumiVuqWQlIVU/lSiOsMmOwAZX5bv9VZhCWAq2bLj4WyShbmAYVXLpGq5b
	 CS9sCr3E0amfDJ4+Ix00gVjykICjtgomP5vSZ6wftkUXKMveVNJvv9GSKly1E38h+8
	 ZYtilKgFaHk3ps9mW6LOUzqtxucZG2KX2JWVCpWnGoyU4zEHlGpExINl8E/7e+dvtD
	 T7G3e1EJ7YFVkZRbJ8/NS5Sw9pKFkZ0t8mOZjitsNDjrCWkvh6Opl3cSlWCf3D9eNf
	 scACs6G9H8Wnw==
Date: Tue, 30 Dec 2025 19:21:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
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
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 07/13] dt-bindings: riscv: Add B ISA extension
 description
Message-ID: <20251230-unselect-canon-842bc2403c47@spud>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com>
 <20251222-stitch-preachy-3fab87fd6f0f@spud>
 <CAH1PCMZ7ywZ3unLy0yHYK+fFHk0y=q2cEtPnRi=qSpf=fc75rw@mail.gmail.com>
 <66c0676a-7920-4825-b916-3c00b1648a08@riscstar.com>
 <20251230-imprison-sleet-6b5a1e26d34b@spud>
 <dc87a3c0-8627-4328-a17a-6510ee8245ac@riscstar.com>
 <20251230-ungloved-unworthy-cacc7e22e1c7@spud>
 <55c2c0e2-2213-4cc9-a752-fce17149bc35@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1e9YdYuLH+dKIj17"
Content-Disposition: inline
In-Reply-To: <55c2c0e2-2213-4cc9-a752-fce17149bc35@riscstar.com>


--1e9YdYuLH+dKIj17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 12:06:39PM -0600, Alex Elder wrote:


> I think it's too bad these "equivalent" extensions can't be used
> to simplify things.
>=20
> I really dislike requiring the both a simpler extension *and*
> the others that it represents/implies.

They generally have been done they way you'd expect, this one just
differs because b is being added much later on rather than at the same
time.

--1e9YdYuLH+dKIj17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaVQmOwAKCRB4tDGHoIJi
0kGhAQCxAzMhUD4RufMSgiCXLmxQYYsaVF6keAz3iTra6Co1VAD9El+gIhJwMplP
Ub7eTbrTxBVP7WgRNQQWd1iA4ooCQwg=
=uC2U
-----END PGP SIGNATURE-----

--1e9YdYuLH+dKIj17--
