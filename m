Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8E1E487;
	Mon,  4 Mar 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578394; cv=none; b=FDg7vpE1R8wDT8YNt7kNcNbAdhi9xYXGRy5j8RBud3nVpb7JCgX8ufLDxE+FbAz/llcz0q7ZEqImiIa13n5fkH8439rhgbMuVdH30BgrSfpjvfam31/4Bwfb9o39zALe6BABO9GA9rhi4u/ea63uvXAUnBpezUgjkd419+dnUOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578394; c=relaxed/simple;
	bh=V37rd8PiGAomhKd4+inZBZxarQhrmyPY3/x1sHNH0Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwtD5qElsLcYD5yG3Yf0nv51Rao1UA9RdPLYFz89Q+7a9hEXj25dGzMJXHfk55vpgXEpHBo+9QTj7lRbbzJcIqi71pH80XIhaLTSCtQgp9voPV7MO8CFqm793ISO+yK/n3HvfBHr0easGFlAR2g+TPTi10NVct4MuTBHVNtov0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chh0mb+L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chh0mb+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F1FC433F1;
	Mon,  4 Mar 2024 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709578393;
	bh=V37rd8PiGAomhKd4+inZBZxarQhrmyPY3/x1sHNH0Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chh0mb+LqnBnkw4LaW7GXGcf4MUfQbxrI1GPiO3rGliHt+iEnuPpVrGL74YA+11eB
	 YKqeYxSxlpofVGMQM0Ja6YGuaQetDJzVb60hbUJEDi1PlVG4cEb4nVdlDtqRQ9JXbq
	 xBD4P6A8pk6pRh83Ib26Riarw33D4f+xUWUobiJzyUK37lSJ4MH4DTgL1ty+ROff6f
	 yEAplu4CapIknsh9V56kknwXU5O2uknTdnA6forEuztZiC95OLeI4Uc2V1tdzE6bh5
	 qZm+mAKS/4704cicL872uYrMIEY/X9AfbnztAqIguotzkk9tiEBGdZBMHcp4/LRSmc
	 /PYattFbOnngQ==
Date: Mon, 4 Mar 2024 18:53:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Inconsistent sifive,fu540-c000-uart binding.
Message-ID: <20240304-whomever-gladly-d43da7ad2fe6@spud>
References: <20240304105947.SJcVAdr1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9HC0fzGtO/m/qkzE"
Content-Disposition: inline
In-Reply-To: <20240304105947.SJcVAdr1@linutronix.de>


--9HC0fzGtO/m/qkzE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 11:59:47AM +0100, Sebastian Andrzej Siewior wrote:
> | $ git grep fu540-c000-uart
> | Documentation/devicetree/bindings/serial/sifive-serial.yaml:          -=
 sifive,fu540-c000-uart
> | Documentation/devicetree/bindings/serial/sifive-serial.yaml:        com=
patible =3D "sifive,fu540-c000-uart", "sifive,uart0";
> | Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.tx=
t:"sifive,fu540-c000-uart".  This way, if SoC-specific
> | Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.tx=
t:    compatible =3D "sifive,fu540-c000-uart", "sifive,uart0";
> | arch/riscv/boot/dts/sifive/fu540-c000.dtsi:                     compati=
ble =3D "sifive,fu540-c000-uart", "sifive,uart0";
> | arch/riscv/boot/dts/sifive/fu540-c000.dtsi:                     compati=
ble =3D "sifive,fu540-c000-uart", "sifive,uart0";
> | drivers/tty/serial/sifive.c:OF_EARLYCON_DECLARE(sifive, "sifive,fu540-c=
000-uart0",
> | drivers/tty/serial/sifive.c:    { .compatible =3D "sifive,fu540-c000-ua=
rt0" },
>=20
> note that the driver has a trailing 0 in the binding while the yaml
> description and the DT part does not.
> The 'sifive,uart' has a trailing 0 where the 0 denotes the version UART
> IP.
>=20
> Was this also intended for the fu540-c000-uart binding? Should the 0 be
> added everywhere or removed from the driver?

I suspect that the driver is what's incorrect, given there's little
value in putting the IP version in the SoC-specific compatible as it's
a fixed implementation. I'd change the driver to match the bindings.

Cheers,
Conor.

--9HC0fzGtO/m/qkzE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYYkgAKCRB4tDGHoIJi
0hLtAQCeh/vjouGnruLo6WjBW4ItX+rl8PSOfBxPoyZ6qLT1pAD/VFIkqqRSQoJT
5af4p39+MyG3lRoOA+H3k7VIM/w0xAE=
=qY/D
-----END PGP SIGNATURE-----

--9HC0fzGtO/m/qkzE--
