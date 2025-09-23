Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD615853B;
	Tue, 23 Sep 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654404; cv=none; b=HY6+9oITkYbeEXDyEJ3UKFHFoucGH7KO5mKxc12umXq7hKVESbuq+06fQ0fUcM5gKZ4a1G7SKLCQZRg47pQtNN7Z1mSPRBUCNvon320JGhxj7oLSyluCnKA0h+3rxsho3THkpgMaS2SU1WUbXk9ArUrUvU0CX9UkMBMjaUbLjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654404; c=relaxed/simple;
	bh=7P42Q/vcWhmWMXKCBhXjJM9Hy40nKSHi835euslZlmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLeBH4HrE62JR+JOWPDcePqKW90OH8EXLmI8wdSuDdOijTJwoCo3AKVjX5HglwcezvzFtbNNrrTUadwLYuS0q4MNFy5JhCiJJ0E0Nus7ktMKq/zOYGpVm/MJ9O/yoZDIu2IN+KZtJMjQPdz83MTZaRH0w2ZAO7p2Oq1Hpo8FtBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phvwjb00; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phvwjb00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEDFC4CEF5;
	Tue, 23 Sep 2025 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654404;
	bh=7P42Q/vcWhmWMXKCBhXjJM9Hy40nKSHi835euslZlmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Phvwjb00clUqKrLEIDqT+JUWC1IMZOHYQvn3zsRlsU7iAsonB3a4/hhk+1+wA5QOY
	 iRKfO6UKWhZWw/EwbZWaIAPUKaBLIJ7/w3BdfYbP+EyVwaihnzaA0DhBFtNFiFUOdN
	 Txs+FruZeY0gyxU2mFygy7Ec+sm6+bXj0SOYvi5S2yRR6xBdxGqpVgA9mS0SaYDkSN
	 aErHOp05ViG37S33PIufOgkhJ55N7jLmi12QHj6RcE5ilvAgLsNIlFobcLPsNEAF2t
	 h7S6m5XCTlwzdwsXSSBshK56WsgeVxy0uQFzwz+VTC0bXOfxR+o0Q2vH40F1ktRGka
	 iZr7IB3MvqmMw==
Date: Tue, 23 Sep 2025 20:06:38 +0100
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
Subject: Re: [PATCH v2 05/11] dt-bindings: interrupt-controller: Add Anlogic
 DR1V90 PLIC
Message-ID: <20250923-reward-washroom-8982b121b0da@spud>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250922-dr1v90-basic-dt-v2-5-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1+aBwOsY00baIh+O"
Content-Disposition: inline
In-Reply-To: <20250922-dr1v90-basic-dt-v2-5-64d28500cb37@pigmoral.tech>


--1+aBwOsY00baIh+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--1+aBwOsY00baIh+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLvvgAKCRB4tDGHoIJi
0t9eAQDg4LDFpDPzjWSwixC0UScRcXJASZEIdXfu8SMBE7UYGgEAqLALUB/4kBOw
iuLF2GErnxYpG+cgPUXKx8iW3/Z6LA8=
=tGbp
-----END PGP SIGNATURE-----

--1+aBwOsY00baIh+O--
