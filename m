Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C509523A;
	Mon, 29 Sep 2025 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759171600; cv=none; b=l54mueNmMCjxzKHi33i4pSKR5ySbU13kG7StQKGfSrNu4kZeLDNiBMnzd4Q6CUYUNhLmg58sMYmxSJJRJNJ8t5au4226Q5choCVt49IGP9d2UcUVvYTW35BGFl/teuYn73mEobxcFae6SU2udzyWWXRoTG++RlcKUrAizPw8k4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759171600; c=relaxed/simple;
	bh=TNlhXabPzTPBnmWxeucl0sJUD7WaZdRbq2zbsllnuPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM6tJEzhhupmiIstnD4CVvx2eE+J2Y+fIRlMTLTWOi+pBYzKdTSm29lsVe3j6U4V3FcVdHDkcD+FoBpqGByB29uj3t33BYTG/R2FesgdUpkCJb8mdhWTLmXQds/mjgfxSeX2Z8z1Nlc0rb+FC8s/u5kX6re7w4hZA22VWGuZeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQcaNUdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQcaNUdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C7CC4CEF4;
	Mon, 29 Sep 2025 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759171599;
	bh=TNlhXabPzTPBnmWxeucl0sJUD7WaZdRbq2zbsllnuPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQcaNUdKQA6pggrC6CKP9nrssk0n+iS1wwK/CpqYxj6HL1Q943J8xN+mHitHJmC/a
	 7oh8mR2bn3LtHTdPHRf4OmmA43NX1EgE8yC+auScD3r228BBf7XvC1dW41bTuD4uQE
	 GoPhVWzrQZekO3MrWnwsoj8Q3r1P5tsfLTJwZ44rg80HFP8CuJeRw3rnCw5MdrrtPC
	 ouxIO4F4vcgb8ybECkfRNtofFg0Fpajv57KKg614+3Vbq86vHjPX9TJKGQwGlzZ0Lc
	 pyd5a31ZCWnB3Tetlp39lTpA8FIAC0JaWcbqCwC3lQZ68uVW1FKLWt+ZIaGtN0SVwW
	 +7cJQAuB9qFSg==
Date: Mon, 29 Sep 2025 19:46:33 +0100
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
Message-ID: <20250929-unhappily-circulate-5e516175ad0f@spud>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250925-chowtime-stove-4078dc1af2b0@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dz2AhysS4RVYF5ne"
Content-Disposition: inline
In-Reply-To: <20250925-chowtime-stove-4078dc1af2b0@spud>


--dz2AhysS4RVYF5ne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 06:22:41PM +0100, Conor Dooley wrote:
> On Mon, Sep 22, 2025 at 08:46:30PM +0800, Junhui Liu wrote:
> > This patch series introduces initial support for the Anlogic DR1V90 SoC
> > [1] and the Milianke MLKPAI-FS01 [2] board.
>=20
> It's a bit late for v6.18 content, since the merge window likely opens
> on Monday, but how do you intend getting the series into mainline?
>=20
> There is a document https://docs.kernel.org/process/maintainer-soc.html
> containing information about how the platform maintenance process works.
> Arnd has suggested that the best way to get a platform initially added
> is to send the whole patchset, rather than a PR - it leaves you with
> fewer things to deal with at once. This patchset should be sent to
> soc@kernel.org, with a note saying that it is ready for inclusion in
> your cover letter.=20
>=20
> Ideally, the initial patchset for an SoC should contain clock (and
> pinctrl) support, rather than use fake fixed-clocks, but you have none of
> those in your base dts so I have no objections. fixed-clocks can become
> a problem if the dts is imported into U-Boot via OF_UPSTREAM or
> elsewhere, since it can cause regressions for them. I would highly
> suggest that upstreaming the clock/reset controller is the next step
> that you take, because other peripherals are going to need clocks.
>=20
> Please let me know if you have any questions - either by email (and it
> can be off-list if needed if it relates to platform maintenance
> questions) or on irc (I'm conchuod on libera.chat).

I had a chat with Junhui on irc the other day, where they expressed
unwillingness to act as the platform maintainer, to avoid being in
conflict with the vendor. I'm disappointed of course that the vendor's
behaviour has had this impact, but of course I understand where Junhui
is coming from.

Fortunately Junhui is still willing to post patches for the platform, as
they want to run mainline on their board. I will add the platform to my
"misc" branch, along with the other platforms I apply patches for until
either Junhui changes their mind or until people who understand the
process and standards wish to take it over.

Cheers,
Conor.

--dz2AhysS4RVYF5ne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrUCQAKCRB4tDGHoIJi
0qzSAP0cvO1DFs2n6IQ7S/IJRMg2ehNjpGRU7+R8PXLZ24qfwgD/T4EEVP1tHhtS
C3gmCx92Pnopimxtjl3Swp77c18Csw4=
=zNQt
-----END PGP SIGNATURE-----

--dz2AhysS4RVYF5ne--
