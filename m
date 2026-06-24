Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336013911CD;
	Wed, 24 Jun 2026 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285573; cv=none; b=J3hBt2Exll5oqQTjW2PzuPdk7YWDJgEC7FhmO4pfEfWPTw08I5gW4MAQt4NeChnzLxU/2QKOGevgIvDoIoOlRjRPpq6EXGjL3K1tdFFRsffktjW5o87jXsJ57iWp+XOv1rgT9HcvHkxBCNJA30SusZS1xN4493kuBfBnLvY6KYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285573; c=relaxed/simple;
	bh=QdGjFj9D9hADdYJk4mS/iE7Buby5mWfe3/mxqk8kNE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3iIDKlqevtTvUbhoHVgp4fnEdFC95lcQx4Cw4VqRIaTJs4VvMacUdb/86+bxu6FVv51mBYuCEBFUo7bYQjkiejfFXb0HpJmV62wzAnkkjP41ZbPrWj569Ux7kzg+8FSeO717k9vokBzWjbZDm76jdKjrJgWgfMeeVsM6NafGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTSKtRDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTSKtRDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CACA1F000E9;
	Wed, 24 Jun 2026 07:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782285572;
	bh=GwssO+47QsRfChEGZdtxq4U6eIg1dC3mtSSD7D78Iho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GTSKtRDR6CR2tM9kq4Uwbmjs3NPP2dXNmDh4Y0tQctdlO9Gg4BkKyZshlsX5TIrFV
	 B/bTxNwfTo3Sk2NOrtd5qY1CPkos17mbzuUmMFUsSpELWUUfzj/bJK8MDCLWftHH+J
	 v7Z046URD6DHJEOtTQPtUwy6ZXh9rSavoy+zwlcvn37D6me0fy34X1160PqhHMOZRn
	 K3dfuHLFLgSuMZgv5DGH329hYQtbOuXlX4safZpidz/ngLGq8JK4ydCLRxc9qKB0sp
	 +yiKxPzX0rMPSaJ7ymGlOO5VvzMZysxpBQmc96uQmi0DV550ssAZ9SMpU+bVZPyEKs
	 TZPh4gvnoTejA==
Date: Wed, 24 Jun 2026 09:19:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?R3LDqWdvaXJl?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] ARM: dts: aspeed: g6: Change vuart compatible
 string for ast2600
Message-ID: <20260624-copper-albatross-of-youth-6abae8@quoll>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
 <30aedaa9ffd5ba2d763d8802a07b77ef2d5bfcf0.1782224060.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <30aedaa9ffd5ba2d763d8802a07b77ef2d5bfcf0.1782224060.git.gregoire.layet@9elements.com>

On Tue, Jun 23, 2026 at 02:25:44PM +0000, Gr=C3=A9goire Layet wrote:
> Use the ast2600 compatible string.
> This makes it more precise and enables specific ast2600 properties.
> Still use the ast2500 compatible string as a fallback.
>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/=
aspeed/aspeed-g6.dtsi
> index 56bb3b0444f7..7c02633f2bd6 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -707,7 +707,7 @@ emmc: sdhci@1e750100 {
>  			};
> =20
>  			vuart1: serial@1e787000 {
> -				compatible =3D "aspeed,ast2500-vuart";
> +				compatible =3D "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";

Please start testing your patches. This for sure fails tests.

It does not look like you tested the DTS against bindings. Please run
'make dtbs_check W=3D1' (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sourc=
es-with-the-devicetree-schema/
for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

Best regards,
Krzysztof

