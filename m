Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF32302759;
	Tue, 23 Sep 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654563; cv=none; b=CwXcRYdZ1WbDLPCtGG2Hg+Xu/6nUaxXS7tFziE6LTmYEZLDHB4EhJ0TDePmjqLx1ASfzo7zQ9xaqI+vkITkArfZEPqk5ZyCMlw7F5b/wNSdOTMrfqRggi4nH35sPa3miSlYvLWs32Uxw9CXEy3j5KxLeLdwnzdtUXjcY0mWAGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654563; c=relaxed/simple;
	bh=7LS8gjNHsPEMZPMGHBYnZ5awE0YIkS+TnTm8xVhKxJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcLyUehlWzas6bAQG/4StJeSOCQxiVnLVyML3ANIWbQPIoK8nG29QshpiEoy+KD8NLAYR/QGaUqHAvhw8zTc/p04sRjMrGaQRsAWXjNkCSAhM+LUkzZn5JWvPsw/LjlyvwOfFmxy5JcSbSrHz0eff4wvsDY5P/U/I3gnRsxwPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6KwAStQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6KwAStQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE91FC4CEF5;
	Tue, 23 Sep 2025 19:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654562;
	bh=7LS8gjNHsPEMZPMGHBYnZ5awE0YIkS+TnTm8xVhKxJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6KwAStQTZXF8JqqjgWhhau6i3uU5x4b1VW2Cz/5I/4vTOKvyJuamq0QLBRDzDyLy
	 xX57VP0hiq5pgzwudrA3tZDEBolW+niULpK3JKAnXV7+HaUGUvZfnIelCu+UpQmyz8
	 ZwNNH/zWRuKyLWrGOnePn6SXs+Qe/bBWcEr/Gp+XL7nSy7kOIPZV8D7zh7eyNsljF9
	 l62IknpQNLJTF1Jnl9cQMVGfljwIfwRZRq9t7tGMcZp2NwsOj5Li/ojII4cwd+a23L
	 Fm2N+j9iN3qjp3HJQlQcJMmi9NjIWEIL6X/ACNPiBp9/JdbuNn/M4Af1MvBycpEom0
	 7soy6ZKRhac6Q==
Date: Tue, 23 Sep 2025 20:09:16 +0100
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
Subject: Re: [PATCH v2 11/11] MAINTAINERS: Setup support for Anlogic DR1V90
 SoC tree
Message-ID: <20250923-proofs-crumpet-2951df149529@spud>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250922-dr1v90-basic-dt-v2-11-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QIhgSGAC/a8UPzR0"
Content-Disposition: inline
In-Reply-To: <20250922-dr1v90-basic-dt-v2-11-64d28500cb37@pigmoral.tech>


--QIhgSGAC/a8UPzR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--QIhgSGAC/a8UPzR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLwXAAKCRB4tDGHoIJi
0v8UAP95rgfYb/Q3MF8e0/ovh3F8y3LdFGV9FElTCwnkZg96+AEA818LkOuzpSVR
gbkzL4Q4bnvLwFFOiYyCvUVymLzeyAM=
=ZfIE
-----END PGP SIGNATURE-----

--QIhgSGAC/a8UPzR0--
