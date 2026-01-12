Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1B341072;
	Mon, 12 Jan 2026 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253830; cv=none; b=YgYEP2CrpFjTqPzWYGj7975A/qwbuHHZVcJr/zT9CJ6szRhhvWSOwFujIIwqsiQdwVuCgyeqElkYt0acyEXlMY0dKMWrezwcNhf0yVdweTK08XBVMHm6j+/1XcXiDmMk7/NuXkDLi8EuSlEG8hW3b0QJj1fBDwwC03iMtuccoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253830; c=relaxed/simple;
	bh=KLfsd+rAB5DQE1cOebZTBbLwOW3l7JnPI5gfbjcl0gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGiQdgT6HYgw8DQQHWpR+Z70krzBuTuSxFo8XKyGH1DOCzYeEvRVd5gmmcnI/cbjTduk3yxt9i3rrI/yeqj/GyYEn+Z4Nq/DNJPSdLZmjyl9QfBBeE3din6WLKAflRNbaZnHJgLseMbJ7ljXPh1dm+mJL2IXpJfmzEDCcY5EcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsaoy1gL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsaoy1gL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC26CC116D0;
	Mon, 12 Jan 2026 21:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768253830;
	bh=KLfsd+rAB5DQE1cOebZTBbLwOW3l7JnPI5gfbjcl0gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsaoy1gLa2LZFuoH3Fl5IzK774msMnPQb6ililce51w+6u1YYKJsto4Z1SW9YeJGZ
	 HT+V/71cEkwT1Qk2JUuTvDH7QCuDQjrpGl8IRd3kIuVOI1Nw9LEyX7pqJVetXJoCkg
	 +y/kA2edgrQatOWosEr30WM5N2aI0lLvAi6zVzuVUlBxFchdjeHSDjj5D/Oa+GmCCn
	 BXcLhidS4i+GrkTdNy64EVvPk5DVYgCUuMzEBfpxH6XLXMO6K+S8jTTSoac8FiO3ri
	 OMYB9hZIP7x+rOvJSoSksNFN4+I83BtEHzj59mTYd0z+00FqFBD4Rxm+ZgedZV3rW/
	 KJXSTS9WSUxLg==
Date: Mon, 12 Jan 2026 21:37:02 +0000
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
Subject: Re: [PATCH v4 05/11] dt-bindings: riscv: spacemit: add K3 and
 Pico-ITX board bindings
Message-ID: <20260112-silica-unarmored-6841bb422018@spud>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-5-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q+tNi72KIO0oXHDo"
Content-Disposition: inline
In-Reply-To: <20260110-k3-basic-dt-v4-5-d492f3a30ffa@riscstar.com>


--Q+tNi72KIO0oXHDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 01:18:17PM +0800, Guodong Xu wrote:
> Add DT binding documentation for the SpacemiT K3 SoC and the board Pico-I=
TX
> which is a 2.5-inch single-board computer.
>=20
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Q+tNi72KIO0oXHDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaWVpeQAKCRB4tDGHoIJi
0kl2AP98pMkYuAMKepzV7dfRrNTcYkFAC8J93oGWZzOd2s4UHQEAq6nkowI0ND4J
vCtzUhTNqKUDK0Oa5Hy+1oMYWd3CqQI=
=5I5s
-----END PGP SIGNATURE-----

--Q+tNi72KIO0oXHDo--
