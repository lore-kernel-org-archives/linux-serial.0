Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EBA213254;
	Tue, 16 Dec 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903233; cv=none; b=pz55q9tDKpO9YswxsP5de5ez41dkDk6i8NHwwfhifHVicxTz6ykl/00sz6Qs8mP9/EdrvMgxF9BYapTAgS4wxjNHATsd3VU+b7pXiCcW8tesDF51EqVN1i/JtVdbezdHPv+uOVZ2Bil8e0beohog15ltFDU3Y9WZOWotYPr/0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903233; c=relaxed/simple;
	bh=IyXZRoNRbL0WbL68f2jfKpHRWTYsrTX6ecv3orlH2DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYdtCwY4/5I+PhJeCt4loUYa8wcnMo5EJaIBM6VkPMzL+4xyPsNids4x2jQ1DvTiTehWa4nedqD6T35aI1AEGHUdbgW5lkNd6q/0qzjRGDnqIUm8bmGB7k4UJMGCkyHzinD1UBvfn5x6VhAEC13/dAN2XrOaUlvs0EvCv6vYUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz/uO5OA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz/uO5OA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79251C4CEF1;
	Tue, 16 Dec 2025 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765903233;
	bh=IyXZRoNRbL0WbL68f2jfKpHRWTYsrTX6ecv3orlH2DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pz/uO5OAcXJwx0OQVP3qbACJTye9uv10Z3DI4Ykogwt1CZtIx9ay+xEYXYEuezOFC
	 2xUkESb204/GWq+9luBZc2ufVfi2mJh52bE65akZWXCoHPa4LUPvBIKPXVt4A/03Vr
	 ELW4yE+TmYCgglEZkKVeX0qe2xKnBHx4YmTSTPihmCjpl7io26dBXgyE/VzwemUMZU
	 GmrRvXWFdn+vZ/8RJTbye2iJrBMniUCbILF2WW0F4GmmCgpiZ/SIijFQX5TYv9SKH7
	 YiduLD0GFgiNu3jJPOD1whIOL6ITvoT0wCywGIKRo0h2lL8ZQGHuA13XYO3PxLkefy
	 qf0UgrAaoUWCg==
Date: Tue, 16 Dec 2025 16:40:26 +0000
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
	Palmer Dabbelt <palmer@sifive.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: timer: add SpacemiT K3 CLINT
Message-ID: <20251216-reexamine-civic-79110198c948@spud>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-2-a0d256c9dc92@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oiXnzifGyDDDbsIe"
Content-Disposition: inline
In-Reply-To: <20251216-k3-basic-dt-v1-2-a0d256c9dc92@riscstar.com>


--oiXnzifGyDDDbsIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--oiXnzifGyDDDbsIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUGLegAKCRB4tDGHoIJi
0hwwAPoDrtroebIfLkFlyWTb0bc8LgUEOYjMYPCEYfw50ls0rwEAiNLuqpsrff8R
wHgSUxm7Hd6joVfLniWEW5RfZJviEQI=
=b8Yc
-----END PGP SIGNATURE-----

--oiXnzifGyDDDbsIe--
