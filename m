Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF22F619A;
	Thu, 25 Sep 2025 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820968; cv=none; b=nzz4dG5YQVxOucIpQxdKnIJAab9sBsHskI70xHqzMrZ0qNw6w6ND6CUYBmhnhBrv57HEWELjL4otDp5RNiT4kokHQ/lTj/QxqGtNnD5FpWrg1FjQY/fIOypwB6NxDu+hQjPH7iXNygGkKUb6SwEQrFPI4OzLf2ntHKxJuak+RWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820968; c=relaxed/simple;
	bh=wlNFWQy/QGmy4ugZQpMqvcZwNqcTbX3wzcNBtn70tgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNe8YgCHqE72LokCyaL0rQmnmjYnpdImQSuqUtqKkdhqMjnkV1wF315WZaDckQ9dTlFIlMa/e0aqoTH9dUKrCPcuhzlKEdCmBxHzfwpfdGolFcgV6HYQ7LxovwfEsXRPaIxhvwgkOn4M39y4X/fRP3XkhgHmrFqmxVncV8Z6z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOeSEwBo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOeSEwBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA8DC4CEF0;
	Thu, 25 Sep 2025 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758820967;
	bh=wlNFWQy/QGmy4ugZQpMqvcZwNqcTbX3wzcNBtn70tgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOeSEwBoMx+rebxEesl5Kn1nXCWNTpQGO+7sNocttr9/JJkWcXrZB/QTJBK5eTyyf
	 WJUiQ1C705eWVN5mtgpXjSpxGsApBWhoglAM9K6vEE3UEb7Hu9SmR24q3rM0bwBRiT
	 SYwuhKa5zOg6lcyffC3pxJzs4e2vag+FwoEilYod034NRDkeEXGs5N5g20s4lmk6n5
	 +Lxn3VOJcLNJn3ZDoHCkMcW+yX5RX6WvqxOMqA8Ny43FuPASiQgL7Jayd5tFxu2xoB
	 7yrYAv1N8K70XckEKYV5C4TVpA2vgfhAhUQJ2HI4PmRxIGNC5814fttrAGu36ppbcY
	 bQAlP6dCgTGXg==
Date: Thu, 25 Sep 2025 18:22:41 +0100
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
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 00/11] riscv: Add initial support for Anlogic DR1V90
Message-ID: <20250925-chowtime-stove-4078dc1af2b0@spud>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MNfIA8O4BYWQqWG8"
Content-Disposition: inline
In-Reply-To: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>


--MNfIA8O4BYWQqWG8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 08:46:30PM +0800, Junhui Liu wrote:
> This patch series introduces initial support for the Anlogic DR1V90 SoC
> [1] and the Milianke MLKPAI-FS01 [2] board.

It's a bit late for v6.18 content, since the merge window likely opens
on Monday, but how do you intend getting the series into mainline?

There is a document https://docs.kernel.org/process/maintainer-soc.html
containing information about how the platform maintenance process works.
Arnd has suggested that the best way to get a platform initially added
is to send the whole patchset, rather than a PR - it leaves you with
fewer things to deal with at once. This patchset should be sent to
soc@kernel.org, with a note saying that it is ready for inclusion in
your cover letter.=20

Ideally, the initial patchset for an SoC should contain clock (and
pinctrl) support, rather than use fake fixed-clocks, but you have none of
those in your base dts so I have no objections. fixed-clocks can become
a problem if the dts is imported into U-Boot via OF_UPSTREAM or
elsewhere, since it can cause regressions for them. I would highly
suggest that upstreaming the clock/reset controller is the next step
that you take, because other peripherals are going to need clocks.

Please let me know if you have any questions - either by email (and it
can be off-list if needed if it relates to platform maintenance
questions) or on irc (I'm conchuod on libera.chat).

Cheers,
Conor.

--MNfIA8O4BYWQqWG8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNV6YQAKCRB4tDGHoIJi
0sTUAQDxOrAl5pk32YMhLmtZaHDiTchFhUiAGM+lO8Yo6wqSswEA8lvwYkNs6FFB
/jn1cq3RoQClzGcAQSmeqYHqeG+8rQ8=
=oXli
-----END PGP SIGNATURE-----

--MNfIA8O4BYWQqWG8--
