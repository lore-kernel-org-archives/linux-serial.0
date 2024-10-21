Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA01EE038;
	Mon, 21 Oct 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512658; cv=none; b=FonWb6KtujdLapdvxQuRwCxDvy++qSLT2zFxEqu9aIYILC/WtXZh/4kPI9oriifDfwhtiIFyFo0eZBKVLlYy4Al2+SNCz+LSqPF3xKor8CPaT1rFN4rMMU0/B5NyOS9BMxFGyzH6lGCrshkb41OlgUsOjkPQsk4VyXxjfM34xcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512658; c=relaxed/simple;
	bh=wI2COY0sgnb3AcZsuJwcmJ7QtHSQix2hOpVbezvb57I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0wDDYUE/gqOMspk/Nl/1KbgjLyDYHunlymFjuS3uO8CL67SV8LSNkhL916pnSJfgcRdp7xfIVZpE8N7m28W1/noR+0PIrL97KYboDyr6IDwqxoVgD1UnbCMQNSNAPPbIzr4rFvebr8JlDc4csXGFmyIKPyg10hT9iHxGpeBAas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLRy0UKk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLRy0UKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBF0C4CEC3;
	Mon, 21 Oct 2024 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729512657;
	bh=wI2COY0sgnb3AcZsuJwcmJ7QtHSQix2hOpVbezvb57I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLRy0UKkgYzfx4ixS8Yme76364PkYK418L4pbZHahJH/vnawAKS0PzPRh317ovaxX
	 xL2x9d26HDfooouaeGLUCscg+8irbizuNmo66iD1BIMuewtH81CEUrLIjWkZ6YJ88d
	 n3WkF7HsBQXd+8kNChdqZ4uP4Aghb7ujX6onw5uwycsIvF5ZYRLdd3SKR9MMCZv4XZ
	 BcjiUDWizxBeM32rGwX8tpKqG+klHsCQFYFtvW0gFE4853fc1d3A/t3nFgIJrHLya8
	 2dZ13OWGLFZRiAOsRvQA+04vX8VUu58aSBDm9Q49QYNJUR+4TVHsqDfrZX+iIjqL4g
	 UBG1crBORz8kQ==
Date: Mon, 21 Oct 2024 13:10:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo
 SG2044 uarts
Message-ID: <20241021-outlying-washday-8f171dedc703@spud>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l5KL92mOVjkHqDBj"
Content-Disposition: inline
In-Reply-To: <20241021072606.585878-2-inochiama@gmail.com>


--l5KL92mOVjkHqDBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 03:26:05PM +0800, Inochi Amaoto wrote:
> The UART of SG2044 is modified version of the standard Synopsys
> DesignWare UART. The UART on SG2044 relys on the internal divisor
> and can not set right clock rate for the common bitrates.
>=20
> Add compatibles string for the Sophgo SG2044 uarts.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 4cdb0dcaccf3..6963f89a1848 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -58,6 +58,10 @@ properties:
>                - brcm,bcm11351-dw-apb-uart
>                - brcm,bcm21664-dw-apb-uart
>            - const: snps,dw-apb-uart
> +      - items:
> +          - enum:
> +              - sophgo,sg2044-uart
> +          - const: snps,dw-apb-uart

Why does each vendor have an items entry of its own? Seems like needless
clutter of the file IMO, except for the renesas bit.


Cheers,
Conor.

--l5KL92mOVjkHqDBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxZEywAKCRB4tDGHoIJi
0tcSAP9Cg0qOqBlYu4GM4FXNjZvQgfXWi5L9u7SJpQum8USXVgEAtJ5xlHYm9l/w
MiHYei67Y3U+RmvBGpDDkiNm9VwiuQ0=
=YTSF
-----END PGP SIGNATURE-----

--l5KL92mOVjkHqDBj--
