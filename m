Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088127;
	b=TH5z0dgxTJtQL+5WV4KWrR6AhapLG7Cu21aABuFSWP9D/wSyMWVu5GN7vz0jKH1l+AET
	 E1i1itDqnOO8sDbDKSO7zPICaAqI5MBb86QdbHm9+GvWbZk+SNQ3gEkljg1hO68Wd60Uz
	 MCOI5CtDX8/DQ0BiPoLAIhx1gkGSdWSx4ekK91N3rWypTHkXnKLYx1rPB+irJgdzGKFh7
	 HLq16sHjLeoVuOXK95V9inuIZoSIrDgQ0yGmSNEncZXtdl+8xJSAD7Eeall7S/UXlRgMO
	 3Qpizd1pPIZr9HyU3azonfL6kDDUbMT8ukg+d+hcF7/GK42RKkA/u3Gmp2TVljLqHdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088127;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BsTtHMn7/Bq0A/1jvysGVk9cJngoUv9+EZ/xJZLo98o=;
	b=zd1gj4PWJJJtAU3pHHPFStlLkqnhtvCzY6+++TiENWB+btwWcD0676HXoUHq3gBPbh3P
	 xbSuiYFSNPkMs0TMyJg2QYmEyWLzIEaI+dYGl+UaO0h6gLomW/cy6mcxLmcZfsro5o8zQ
	 zJ+TyH6yRZQgmRGNWYR6VXemiWFTn3yraZ4+dHmYiQ9GEF3+W6Vnx1oVDfEBDYmT5xHVe
	 UbSI+EM3b2wQD3q3LW8yQHsUkE6swplyjI5cib0c1QF2WWPUXi7tXO/7tY17JFYIX0MRO
	 it5+zN9BH7HIEH+fXYG7Vymvm7HRtR1bFGaYlF+9XmZuDyRPSlcX30umizJT+UcT6Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/p3r4pf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9E606A31B;
	Tue, 27 Oct 2026 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/p3r4pf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5531F01825;
	Tue, 27 Oct 2026 08:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793088127;
	bh=BsTtHMn7/Bq0A/1jvysGVk9cJngoUv9+EZ/xJZLo98o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M/p3r4pfigJ7VF+xQ0guSGeBUGwLd64vkoeDEiXMbpltCsl9kIARqtyP5zs+5LJha
	 Dwjr6VP1tBEIK1fHQCUZJO45RR3Iyf0I77avSMKMt+k9fvOm+SWpUQHql6Yy+dUK1r
	 UxaLx9qeY9mxHdCigK8e7b2Z4a1x5qR+6UrVoEf/ni3psUBCTB7vx2Yl6842504Zh9
	 0ySfbkpAJKZhQVDAw4qMMoHOByorG/qzjR4YV/ybSyoIbnm5d27zjGLKqrr0exTZMO
	 koEuEpeep51+fCr+T6Kj2scDB2u/QEycVZ3blpmviHRc17/MwsmvyJNTtciBGiamsY
	 zBpYxE8Ttyp7A==
Date: Tue, 27 Oct 2026 09:02:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 2/4] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
Message-ID: <20261027-nifty-reliable-octopus-6cbac5@quoll>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
 <20261024-submit-h616-uart-fifo-v1-v3-2-286fc1b8c3c1@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-2-286fc1b8c3c1@gmail.com>

On Sat, Oct 24, 2026 at 02:22:24PM -0600, James Hilliard wrote:
> The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
> component parameter register does not report the FIFO depth. Its optional
> register layout also differs from the generic DesignWare integration.
> 
> Add a specific compatible for the integration and allow the standard
> fifo-size property to describe the capacity. Require the documented
> 256-byte size for H616, retaining snps,dw-apb-uart as a fallback.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index e2ca126d58ba..0f8fd0485879 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -13,6 +13,18 @@ allOf:
>    - $ref: serial.yaml#
>    - $ref: rs485.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun50i-h616-uart
> +    then:
> +      properties:
> +        fifo-size:
> +          const: 256
> +      required:
> +        - fifo-size

Why do you require fifo-size if is const? It is implied by the
compatible.

> +
>    - if:
>        properties:
>          compatible:
> @@ -60,6 +72,7 @@ properties:
>            - const: renesas,rzn1-uart
>        - items:
>            - enum:
> +              - allwinner,sun50i-h616-uart
>                - anlogic,dr1v90-uart
>                - brcm,bcm11351-dw-apb-uart
>                - brcm,bcm21664-dw-apb-uart
> @@ -120,6 +133,10 @@ properties:
>        - const: tx
>        - const: rx
>  
> +  fifo-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Transmit and receive FIFO capacity in bytes.

Drop property, not used by any of the devices here.

Best regards,
Krzysztof

