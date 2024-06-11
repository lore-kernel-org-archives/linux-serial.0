Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE5880607;
	Tue, 11 Jun 2024 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137722; cv=none; b=P1VdPRNzbDBhQr8onqf929LLPoRn66etALie6RzKUH0R8C0+1WtgB2KIl7SGHwqtGoxBerX/cp3q9LPLLgBivVTt2KYHin6OdRt7+GrfP9J3YpqX2jjyIOgCR0FvHUsrvyPW9RI1sDfIQhCXPNDqts/67NLgi6dF9voLlB/bZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137722; c=relaxed/simple;
	bh=luJqMwS1juyB7P9FhCZ/2se2iPbzDsWfhWxvaQJ4Lx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY7xrrlBLIu0hlXmmEgov1yhD3xdK0Ogf6s8GS9B6tnpt3LTlV28/cL0CznrLqlbeF5BCSfT84w+Dhjxte+pnQt5MzF/EeU2F0QyldT+yurPxsrInf6F0Pg2PwtlSfG9/g4WI2YzOy6Fm/iclwm8MQLG6KJAA+kHlAwwOeCKnr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqkVo+uV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqkVo+uV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68795C2BD10;
	Tue, 11 Jun 2024 20:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718137721;
	bh=luJqMwS1juyB7P9FhCZ/2se2iPbzDsWfhWxvaQJ4Lx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqkVo+uVymCiP3JT77u6WNfcHkvoxjkXutcuhekMKo20I1IoAblmmG/t9e9X4vmFX
	 0HOxijcjlxHswh2xFpVEwfqvkjTt0s8Yb0mrXcxhfUrp9ph2N1/3DCOPcfNBEBdwew
	 E0D/mFVERXxwZCPUQhvL+Ddlje9dku/CLAAGAfA5U0ACrZGbSsm9EscwN4ItitVA/c
	 9zzcYv2ZwPv3bRQkeWtS9f4RyRJhGllD9sa6dM06ZcjqKvWyDaT/v8MPgi9nEsAGp8
	 FXHNQxmNRwSkXwG6Oou+HM5B78ZhyR/rXY064HEyyhKmIkdUIwnyXdMBJ53NTJ3VZd
	 u9tKcAXmG9tGQ==
Date: Tue, 11 Jun 2024 14:28:40 -0600
From: Rob Herring <robh@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: vt8500-uart: convert to json-schema
Message-ID: <20240611202840.GA3013140-robh@kernel.org>
References: <20240611121048.225887-1-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611121048.225887-1-kanakshilledar@gmail.com>

On Tue, Jun 11, 2024 at 05:40:43PM +0530, Kanak Shilledar wrote:
> Convert the VIA VT8500 and WonderMedia WM8xxx UART Controller to
> newer DT schema. Created DT schema based on the .txt file which had
> `compatible`, `reg`, `interrupts` and `clocks` as required properties.
> 
> Additions to the original binding
> - changed the file name from vt8500-uart to via,vt8500-uart.yaml
> - removed unnecessary alias from the example.
> - added Greg and Jiri as maintainers (referred MAINTAINERS file).
> 
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
>  .../bindings/serial/via,vt8500-uart.yaml      | 52 +++++++++++++++++++
>  .../bindings/serial/vt8500-uart.txt           | 27 ----------
>  2 files changed, 52 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/vt8500-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml b/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
> new file mode 100644
> index 000000000000..b38925ab23a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/via,vt8500-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VIA VT8500 and WonderMedia WM8xxx UART Controller
> +
> +maintainers:
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +  - Jiri Slaby <jirislaby@kernel.org>

Don't put subsystem maintainers here. It should be someone with h/w. 
(The VT8500 maintainer if there is one?). If you can't come up with 
anyone, you can put me.

> +  - Kanak Shilledar <kanakshilledar111@protonmail.com>
> +
> +allOf:
> +  - $ref: serial.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - via,vt8500-uart
> +      - wm,wm8880-uart
> +
> +    description: |

Don't need '|' if no formatting.

> +      Should be "via,vt8500-uart" (for VIA/WonderMedia chips up to and
> +      including WM8850/WM8950), or "wm,wm8880-uart" (for WM8880 and later)

Just add a comment after the compatible strings (e.g. "# up 
to WM8850/WM8950") and drop this.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - interrupts
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    serial@d8200000 {
> +        compatible = "via,vt8500-uart";
> +        reg = <0xd8200000 0x1040>;
> +        interrupts = <32>;
> +        clocks = <&clkuart0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/serial/vt8500-uart.txt b/Documentation/devicetree/bindings/serial/vt8500-uart.txt
> deleted file mode 100644
> index 2b64e6107fb3..000000000000
> --- a/Documentation/devicetree/bindings/serial/vt8500-uart.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -* VIA VT8500 and WonderMedia WM8xxx UART Controller
> -
> -Required properties:
> -- compatible: should be "via,vt8500-uart" (for VIA/WonderMedia chips up to and
> -	including WM8850/WM8950), or "wm,wm8880-uart" (for WM8880 and later)
> -
> -- reg: base physical address of the controller and length of memory mapped
> -	region.
> -
> -- interrupts: hardware interrupt number
> -
> -- clocks: shall be the input parent clock phandle for the clock. This should
> -	be the 24Mhz reference clock.
> -
> -Aliases may be defined to ensure the correct ordering of the uarts.
> -
> -Example:
> -	aliases {
> -		serial0 = &uart0;
> -	};
> -
> -	uart0: serial@d8200000 {
> -		compatible = "via,vt8500-uart";
> -		reg = <0xd8200000 0x1040>;
> -		interrupts = <32>;
> -		clocks = <&clkuart0>;
> -	};
> -- 
> 2.45.2
> 
