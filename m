Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474C81B422A;
	Wed,  7 May 2025 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589424; cv=none; b=c5EuSE6lV60Ho5QmV1Zpb9rI9xRUHbhGIzHDt9Qm+0FKZK6ohKf+uukXazD5PzgP7ESNgRbv7bwjkOLC8bhHpjXNqpPB28vibERK5qNuRg62PRhy1vKloDmagX5Bz2BSEg4z6zohD73y3O2pTQ0r+e9YeFmu/s11RNpzDIhwpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589424; c=relaxed/simple;
	bh=Aed/X3ndFGxW3Cv/Mmx0GvVxagOhwtAd9qDxrnSW1W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BdVImOzTIWSBDhjngv+gkBO0XTuoBh/2KV9EGY0Ko87GsInlOFJEEilPEVynW0Z0piu7//Ij/vSZd8LJy4f9oEyBwzuztPYhWaqeyONPNyn/u/tDzYv2q1XJzAiwZcPJz1WcNOoSOuFE5PEuQIml913zecefdM4yBPRNmBmuWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=JA9vqH9d; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="JA9vqH9d"
Received: from localhost (unknown [10.0.8.2])
	by mail.tkos.co.il (Postfix) with ESMTP id 0599A440758;
	Wed,  7 May 2025 06:43:23 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1746589403;
	bh=Aed/X3ndFGxW3Cv/Mmx0GvVxagOhwtAd9qDxrnSW1W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JA9vqH9dNiRJAb04g3xMN2FZ5MlRAPpYW6VFuRa1wUgBJsIkmEXj0eLdnPxVBKmOD
	 rVHf0doxKFbF5OWm6tEOkwE8/ey9MbR0WSTG2+OGwG+CrImazH4hP04lIl/qqJcDaR
	 DiU3EhDlo/7ffReeP8FQ+8Uq1jds6Pidv3tBZcQr5RkqinKG67BZC8Wn/zjNpmHN1U
	 OiqPtp4Os8IB1GYbDnsciGtCfv8tvKzoGV1OWr216MDbExxKfi5qesQrUnZ/cZyJ98
	 4L8d+ikEwi3aWxGmA20iJBPKVRddYoJ7XYHeIRri9Iz2mfKbnR/Jn5vGYNKw5q+Ewe
	 8vcHZUlVfoy4Q==
From: Baruch Siach <baruch@tkos.co.il>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Jiri Slaby
 <jirislaby@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-serial@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: serial: Convert cnxt,cx92755-usart to DT
 schema
In-Reply-To: <20250506220025.2545995-1-robh@kernel.org> (Rob Herring's message
	of "Tue, 6 May 2025 17:00:24 -0500")
References: <20250506220025.2545995-1-robh@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 07 May 2025 06:43:30 +0300
Message-ID: <878qn9ytjx.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Rob,

On Tue, May 06 2025, Rob Herring (Arm) wrote:

> Convert the Conexant Digicolor USART binding to DT schema. It is a
> straight-forward conversion.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  .../bindings/serial/cnxt,cx92755-usart.yaml   | 48 +++++++++++++++++++
>  .../bindings/serial/digicolor-usart.txt       | 27 -----------
>  2 files changed, 48 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/cnxt,cx92755-usart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/digicolor-usart.txt
>
> diff --git a/Documentation/devicetree/bindings/serial/cnxt,cx92755-usart.yaml
> b/Documentation/devicetree/bindings/serial/cnxt,cx92755-usart.yaml
> new file mode 100644
> index 000000000000..720229455330
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/cnxt,cx92755-usart.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/cnxt,cx92755-usart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Conexant Digicolor USART
> +
> +maintainers:
> +  - Baruch Siach <baruch@tkos.co.il>
> +
> +description: >
> +  Note: this binding is only applicable for using the USART peripheral as UART.
> +  USART also support synchronous serial protocols like SPI and I2S.
> +  Use the binding that matches the wiring of your system.
> +
> +allOf:
> +  - $ref: /schemas/serial/serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: cnxt,cx92755-usart
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    serial@f0000740 {
> +        compatible = "cnxt,cx92755-usart";
> +        reg = <0xf0000740 0x20>;
> +        clocks = <&main_clk>;
> +        interrupts = <44>;
> +    };
> diff --git a/Documentation/devicetree/bindings/serial/digicolor-usart.txt
> b/Documentation/devicetree/bindings/serial/digicolor-usart.txt
> deleted file mode 100644
> index 2d3ede66889d..000000000000
> --- a/Documentation/devicetree/bindings/serial/digicolor-usart.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -Binding for Conexant Digicolor USART
> -
> -Note: this binding is only applicable for using the USART peripheral as
> -UART. USART also support synchronous serial protocols like SPI and I2S. Use
> -the binding that matches the wiring of your system.
> -
> -Required properties:
> -- compatible : should be "cnxt,cx92755-usart".
> -- reg: Should contain USART controller registers location and length.
> -- interrupts: Should contain a single USART controller interrupt.
> -- clocks: Must contain phandles to the USART clock
> -  See ../clocks/clock-bindings.txt for details.
> -
> -Note: Each UART port should have an alias correctly numbered
> -in "aliases" node.
> -
> -Example:
> -	aliases {
> -		serial0 = &uart0;
> -	};
> -
> -	uart0: uart@f0000740 {
> -		compatible = "cnxt,cx92755-usart";
> -		reg = <0xf0000740 0x20>;
> -		clocks = <&main_clk>;
> -		interrupts = <44>;
> -	};

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
