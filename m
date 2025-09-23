Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4A2DE70D;
	Tue, 23 Sep 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654539; cv=none; b=dSu11CwvT3J7roJJHITly9KQGRSbqG2fpfTwMQ5uvXHag4d/KtO8OgKTamUtxh7RzD+EkKukdo/lL9r8KqCTOVl1gxXqCDqk0FxnFO8aO1tB4F1sWxMsqwforFSE6jlau9kLpsnFz/fi3QsyZ+8hpT0dmRq9As5hQOWVF1fMX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654539; c=relaxed/simple;
	bh=U7w0RBhbvZV0tCCq+E/7rvgMmOrzo+yKDpglEYqqbmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQJVvMyeO+B8Ne3SPYvf+Jga8AvUOoMzGTd7n4h2HJZ2pYfa7+TblwP6M8UzVbMhhbxgMPFudVF/hHhbRLFBT2Iff8pUPkT3eCB2nsW9Fb78Oc2bkFZsz+dE7hKZYc4vQGiFKHwogZnQ17nYhIV6LfADG8rISid/PDzDR0HBX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSelzzKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSelzzKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946F7C4CEF5;
	Tue, 23 Sep 2025 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654539;
	bh=U7w0RBhbvZV0tCCq+E/7rvgMmOrzo+yKDpglEYqqbmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSelzzKDhBaPXNH1PUwmkKqVAiB+otctbgli5jzwvFj1FBfFAixXtjRGixJHGxhAH
	 InScH36S0hnN9V12yALB84pQaHC3HeAYqpSido6nCbB5zgGHzj4SWBwW707vBxxd4C
	 opzA7B+FcLmI6me454A3pfb/bRlgPDqYwSlUecwFJOqoX1/Oq1+7Ew9OBVcN5nAlxi
	 thnW/fCLbiyaoRA1Ydc1ryg6degiU+TTpnm+Ea81/J6+ApHONk+Vftn6CuBsqArMxi
	 xPgG0Hqf8KGV+/xbhGtYgt1TPfs3cGG0remjAYdjriLUi6LglwX4mC2Ixo0ZWuoCx+
	 7f+3VEU44hEyA==
Date: Tue, 23 Sep 2025 20:08:53 +0100
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
Subject: Re: [PATCH v2 10/11] riscv: defconfig: Enable Anlogic SoC
Message-ID: <20250923-ivory-gummy-6311b0bb3c36@spud>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250922-dr1v90-basic-dt-v2-10-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="utCFKJUV5pobzqG8"
Content-Disposition: inline
In-Reply-To: <20250922-dr1v90-basic-dt-v2-10-64d28500cb37@pigmoral.tech>


--utCFKJUV5pobzqG8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--utCFKJUV5pobzqG8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLwRQAKCRB4tDGHoIJi
0tuIAP9wGk8z8DY8my4Mk/9R5hIM/OJtA3PhcVHRZ7nnmORq4QD7BOP4w+OTiBPz
CiYJmEll837wt8T9iufOl30j6jaWoQA=
=boQB
-----END PGP SIGNATURE-----

--utCFKJUV5pobzqG8--
