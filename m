Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0917A589;
	Wed,  3 Jul 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022436; cv=none; b=UNRBzMTD4aGA5JtRIxroq54kWw5KqJ5yIJ5QWhDZ4M9iiCFdgP+8z/S9lXB+4YZVg9wv3Ufr1gY9u0vhscMTtpLfjNQ5K3e4PsUdLnloYNi/4ERbd2IneOhpkATt8B8YmOCfgQCcHg657O0prylExRL182Ff4gv4TnQnXU7vKrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022436; c=relaxed/simple;
	bh=yTHPhsfhAJ4WGzKRVVKRBjIFVfZM0LD+fCx3Igm2aDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sibntm5erYHOgdK1PuG91R7P+G2e9kP46dIKk6WKFRtpMZGttpmVNoIC1V7Yd0k8vAcvyU9yVYi7OSrFElOHtVBCW2coHUfmvJ+suBky1P6ReSX8dgiOAsfDFL2UTrdTu9rcuWbXIupFPtpu3iM8SVZfhPFDcmRNIXFqoOCn+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uY81kNSb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uY81kNSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE426C2BD10;
	Wed,  3 Jul 2024 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720022436;
	bh=yTHPhsfhAJ4WGzKRVVKRBjIFVfZM0LD+fCx3Igm2aDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uY81kNSbilY4ZonPDrgVSVcb9Z2MfLNKP4iLLJKyUj603l7fOKWEmqCr4wmc9O8AV
	 2bHJlWpmyV9Jgfk+ONc46Jiwz2DEubRsPRE5xMBllLoSk6+tz6UBwP2QrmnUum0RrN
	 3+QaqRtiXYJLpXEiQEXnw1Y5KzBgpp3BUm/ZPBzobpU/5+U4AyZfGikR33KaHCYVu4
	 zmQ2JftAJatnT3Lfx8viPu5FFLE9FW/+X/fGnpdmrdJuq8z+HP6ziaRROzpkaFPJEO
	 qGqqyVLUIevBOcnyU3/9hfptkoyl3bRTu0tTG6Q1FxLq+MTQZ84K2SlDaFBA1zn/c3
	 2KJyo0s7PqrIg==
Date: Wed, 3 Jul 2024 17:00:29 +0100
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
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v3 05/11] dt-bindings: interrupt-controller: Add SpacemiT
 K1 PLIC
Message-ID: <20240703-oncoming-chamomile-4f7132d3374a@spud>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-5-12f73b47461e@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t4wAf3UbGKQdKw+B"
Content-Disposition: inline
In-Reply-To: <20240703-k1-01-basic-dt-v3-5-12f73b47461e@gentoo.org>


--t4wAf3UbGKQdKw+B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 02:55:08PM +0000, Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
>=20
> Add compatible string for SpacemiT K1 PLIC.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--t4wAf3UbGKQdKw+B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoV1nQAKCRB4tDGHoIJi
0uXPAP91uQ09kipQ21Z4FRKIaHGfIeBoJeYNSe9AEAAi/N98RAEA7wB6F4xpZyKi
X/gn7dAw72lrmSbMyUTANxeKtwTuMgw=
=4qhD
-----END PGP SIGNATURE-----

--t4wAf3UbGKQdKw+B--
