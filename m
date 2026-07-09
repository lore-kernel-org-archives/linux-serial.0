Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882703FC5D8;
	Thu,  9 Jul 2026 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587059; cv=none; b=t0F1JwFOPUM6C5ytK9ghYfU7af4zXeV/MHXD2Z212iouy2fNnYhU4Z26oF1DFl8Qbv+MFQInOp0rl166XUPXkg51sPb11LMsE1bVaV/lHTatGfMM91PV14JzslNj934hYtyiYTNf6u0E0Oj+LXgHoJ+bSujChz/DvjpEj+YB13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587059; c=relaxed/simple;
	bh=fJtmUecI0fgi0aU2q/zJyfwXVuX9+OWKwPRTDA+tlDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZVcp+ZTQ6iVqt1Z9EeeoVfQAHdMU6RFEE01gPi73x/cJvuUyXeSZrZdO/syrshp7L7BxK5odfSJ0bv5Ou21OyQJeBkfiAlQQzDPXVm52e+zUwHSuH/G6IplmTVf7mxi6pSLApxqU34w9sBYAmR5ANmF518W8+4B0Z9AWOvvx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxaMoZ7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxaMoZ7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6478A1F000E9;
	Thu,  9 Jul 2026 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783587058;
	bh=a1rwfWs0eVUYLQvnn313Ek+k2iZwPDLH9jg+S7+NtUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gxaMoZ7DMEct622BGXXQ2Ri8Sr/J+tvZNU6g0FIegAoymMY/llbxd69ppfm/oxOj8
	 F/ygKBf7/fmoDsb4JgXAudUtdk+OVg8nZMkEddDkCi+oINbIN2XjQMqrCqvvYyNcai
	 T++YqXgDP4X5eCQRe5sUImYg26aXYViq8185n4MMoadByVpazZw4C8lFvxMSTdnjhz
	 Iug1z0tdGaZ6DJPqWaNhmNrVLYwxK9IRWFk0GLyCD/rg3VNeX49FxbyvX2qGyWzvGz
	 QNk3i4hWWa7yOqO61Yw8sZmWB2wq/50RN15U9kBPW1u/NSS9f2ekmTeEqX07oEjgiT
	 o9qFAb6Fe4YWg==
Date: Thu, 9 Jul 2026 10:50:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?R3LDqWdvaXJl?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: serial: 8250: aspeed: add compatible
 string for ast2600
Message-ID: <20260709-convivial-classy-mouse-db0b2d@quoll>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>

On Wed, Jul 08, 2026 at 03:35:53PM +0000, Gr=C3=A9goire Layet wrote:
> The ast2600 was using the ast2500 vuart compatible string.
> Make it possible to have ast2600-specific properties.

Then add these properties here as well. Adding a new device is one
commit: its compatible and its properties.

>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 24 ++++++++++++-------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index bb7b9c87a807..8f22121381fc 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -23,7 +23,10 @@ allOf:
>      then:
>        properties:
>          compatible:
> -          const: aspeed,ast2500-vuart
> +          contains:
> +            enum:
> +              - aspeed,ast2500-vuart
> +              - aspeed,ast2600-vuart
>    - if:
>        properties:
>          compatible:
> @@ -106,6 +109,9 @@ properties:
>        - const: ns16850
>        - const: aspeed,ast2400-vuart
>        - const: aspeed,ast2500-vuart
> +      - items:
> +          - const: aspeed,ast2600-vuart
> +          - const: aspeed,ast2500-vuart
>        - const: intel,xscale-uart
>        - const: mrvl,pxa-uart
>        - const: nuvoton,wpcm450-uart
> @@ -287,17 +293,19 @@ properties:
>    aspeed,sirq-polarity-sense:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: |
> -      Phandle to aspeed,ast2500-scu compatible syscon alongside register
> -      offset and bit number to identify how the SIRQ polarity should be
> -      configured. One possible data source is the LPC/eSPI mode bit. Only
> -      applicable to aspeed,ast2500-vuart.
> +      Phandle to aspeed,ast2500-scu or aspeed,ast2600-scu compatible sys=
con

This is a deprecated property, so it cannot apply to a new device -
aspeed,ast2600-vuart. You cannot use deprecated code for new bindings or
device support.


> +      alongside register offset and bit number to identify how the SIRQ
> +      polarity should be configured. One possible data source is the LPC=
/eSPI
> +      mode bit. Only applicable to aspeed,ast2500-vuart and
> +      aspeed,ast2600-vuart.
>      deprecated: true

Best regards,
Krzysztof

