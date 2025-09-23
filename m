Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD830274D;
	Tue, 23 Sep 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654523; cv=none; b=gBnrCv8ra+xjeZaP12s+h3IYcNBn7lKSYf6n32oHY83lCPKtAR3IvsbZI6ZHgwLZavACeSybIZUEw25dhj3VFltBAzPhtXTXvAsp05+SKy4IhBsIT2fXf5wq6e++ZLwQx4xm7APblXJJVodiLrHiPGrhp2uNwoEDXRKG4dz60os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654523; c=relaxed/simple;
	bh=dNTH0LFPnJYw+5TtlI2X+f4AebUw6GIjjz4HiRoWJHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUVyCH9zE9hhSnRtsD6WwvI/N/jx4iixm6IYYAntOuNUOpVKUDmoKhuc4aUz/BXklgMgaFKVHZ9O9bTdNMW+8zwNDwzNXTbg59gCkVkQMYn61S/OOz183dPnR0wzhFReY75bVH1T5HDu4yq5QtY7mfwL3O/zkDWuA2lI3UoeejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k13PRQRk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k13PRQRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267E4C4CEF5;
	Tue, 23 Sep 2025 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654523;
	bh=dNTH0LFPnJYw+5TtlI2X+f4AebUw6GIjjz4HiRoWJHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k13PRQRk8h9bxWH0e0xMcb75b5k7xjKMjKCLLJ0R1gIUMxdw/gPHwuY2MUuef6+Ac
	 a3RS5ct0b4/ZFQrZGDpMgzVRRDo8ft3+GTiVbJaSk3RSTpeNIbhT6y2cJ0obirdvSE
	 eTgyZDF8ZaPFNb5erErT35IfOm7aFVeDo7ehPDr/jGDfPrV1ulKTY1awGMxQPrBwD4
	 NHJQJa7Ixx8PpfSHWH7Ei45kN18Xqajh2Q9a2kEdf5zNj4MXPZcwtPon+v1rKe80u8
	 egA/rd3Qm0RasUO2Il+PNfb0tKfIMlmT3BPrR2XGndVvijzGNAauSM3fkPbLBDrtXt
	 Xn7ng+n25lzHg==
Date: Tue, 23 Sep 2025 20:08:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 09/11] riscv: dts: anlogic: Add Milianke MLKPAI FS01
 board
Message-ID: <20250923-banknote-from-2995e8dee5b5@spud>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250922-dr1v90-basic-dt-v2-9-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XXP0VzvVz61GMMd9"
Content-Disposition: inline
In-Reply-To: <20250922-dr1v90-basic-dt-v2-9-64d28500cb37@pigmoral.tech>


--XXP0VzvVz61GMMd9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--XXP0VzvVz61GMMd9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLwNQAKCRB4tDGHoIJi
0uK/AQCY5lymPH+5dOHHaxoasXWiHQgYlnnTSy7BNi1lCs7meQEA7N+nykk1UMpv
SC3yBmtZJTwtlhjw58G3Eb9OJnYJ+gI=
=zrg4
-----END PGP SIGNATURE-----

--XXP0VzvVz61GMMd9--
