Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471753F44FB;
	Wed, 14 Oct 2026 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977065; cv=none; b=FvZ5G4BQi2oG/74TZd5Qc5NSpqphsh+XplZX/G1zNUf6Q7G0ureYeMbsRkuEFGi3TN7VXc/RtMOuEW2zxSN3R1W9+x/cB5HUj5ZwtvVEQY/k27XRBnsgAP94+SaefyN5j6L7dhC0pTVvPtgo41lAln+xeHpAKjjucFXl78UwChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977065; c=relaxed/simple;
	bh=4DMLQRv8YY5YnC8tFxFHNadabUlme24AfC7Xnm61jC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byb2z0ijGM0Fti2X53qEJZruRrdym6SCqPnnp8P8BU46oO34Ak1g811mfGNxmBD/+LHV9w/SYiLVxMvQDBzmKL6mqEOZ7D57fV7zeJftfxpMZEaJm/NqhKdGmuTk1Q8oPd5pVLbveLT9/LMvXdGwN1WcSJoBaPM38LNeJYW4eJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVB09rc3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVB09rc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC611F000FF;
	Wed, 14 Oct 2026 11:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791977063;
	bh=C36N3d8xiGu4bHaEfN42Nw1iKaEqUYNj/R0CybW29Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bVB09rc3jcRGTRLYcoUGkrFWU+BJvl57ycvDbu49Tf9jLM2tssdnLKemsiUB3BlGq
	 hZuHzcMJ1wwJU8+H3qHCa/fX0Vcxtc8BenmV6rOCJVn+IJ6JpbiZA8WqBOXfgoZinE
	 szYmpr+NqUgkDv/MZjboQPSqLUISFgLoZHlEnysffbhB+xysh2s2L3wvhg6IeATSw1
	 f4UGpsYeHNo3gHL8mElsTxpZoaC+h/AJx2h65Gbv37O2s9do6aFDwpf5+ygzIZhOny
	 XlgNViBgVnAPdZMtZDtjEpE0SQgj/NoA9c2uMY3j1cr0L/bor7aP6frJEADw5N/VwL
	 4P+Mq5mJf/YCA==
Date: Wed, 14 Oct 2026 13:24:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
Message-ID: <20261014-expensive-shrewd-nautilus-abcab6@quoll>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-5-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013120831.1046590-5-gerg@linux-m68k.org>

On Tue, Oct 13, 2026 at 10:07:02PM +1000, Greg Ungerer wrote:
> Create documentation for a new binding to support the Freescale ColdFire
> UART hardware block. This is found on pretty much all variants of the
> M68K derived Freescale ColdFire family of System-on-Chip devices.
> 
> It is not compatible with any other known UARTs.

You never tested this, so limited review.

> 
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
>  .../bindings/serial/fsl,mcf-uart.yaml         | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
> new file mode 100644
> index 000000000000..d1dba518f67a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/fsl-mcf-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale ColdFire UART
> +
> +maintainers:
> +  - Greg Ungerer <gerg@linux-m68k.org>
> +
> +allof:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: fsl,mcf-uart

What is the SoC name? MCF? Compatibles must be specific (see writing
bindings doc).

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    uart0: serial@fc060000 {

Drop unused label

Best regards,
Krzysztof

