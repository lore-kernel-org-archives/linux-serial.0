Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F8233735;
	Mon, 28 Jul 2025 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753743206; cv=none; b=XWklAnetQ0X6kcG0MePwVsE12W0CQBZgmTYTc8pyhLwPyy603X5i4jy2SmlZGFLGcIk3NctE6GlgvQwT1V38NCK0niBeqOPZjIVYTb2GHSPz/M22ENxU36pU75PEZ9PJe6cL1wCTH9dh4h5wtlaLPv7iOGz/PDKt+1OOeAFXDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753743206; c=relaxed/simple;
	bh=1DQjd1hRjLd2X+8zYkRt1hFSKDv+6s9BB/llroO3qMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afSIiQCLZvsM8wOeO1UkHADbqCwXXcWd8HkcD27W/F6G1cmRFQs6EuGvnhUxvWvq4RcGXL+ir+fgvB54hBcPFhnF/qJXL/IaAuXa93rf5ohCbygp7MZpcLtsH6CZIvzICHkQCgNqr8h4Wu1sWQ3bK/LClQQMGPqNNc8Ekc64BrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.124.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E8D24341F0B;
	Mon, 28 Jul 2025 22:53:23 +0000 (UTC)
Date: Tue, 29 Jul 2025 06:53:19 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, lkundrak@v3.sk,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: serial: 8250: allow "main" and "uart" as
 clock names
Message-ID: <20250728225319-GYA900803@gentoo>
References: <20250728220002.599554-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728220002.599554-1-elder@riscstar.com>

Hi Alex,

On 17:00 Mon 28 Jul     , Alex Elder wrote:
> There are two compatible strings defined in "8250.yaml" that require
> two clocks to be specified, along with their names:
>   - "spacemit,k1-uart", used in "spacemit/k1.dtsi"
>   - "nxp,lpc1850-uart", used in "lpc/lpc18xx.dtsi"
> 
> When only one clock is used, the name is not required.  However there
> are two places that do specify a name:
>   - In "mediatek/mt7623.dtsi", the clock for the "mediatek,mtk-btif"
>     compatible serial device is named "main"
>   - In "qca/ar9132.dtsi", the clock for the "ns8250" compatible
>     serial device is named "uart"
> 
> In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock 'uartclk'
> and 'reg' for nxp,lpc1850-uart"), Frank Li added the restriction that two
> named clocks be used for the NXP platform mentioned above.  Extend that
> so that the two named clocks used by the SpacemiT platform are similarly
> restricted.
> 
> Add "main" and "uart" as allowed names when a single clock is specified.
> 
> Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@intel.com/
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index e46bee8d25bf0..cef52ebd8f7da 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -61,11 +61,17 @@ allOf:
>              - const: uartclk
>              - const: reg
..
>      else:
would it be better to drop this 'else', and moving following 'if' block
to the same level with "nxp,lpc1850-uart"?

the reason here would avoid too many indentions if add more constraint in
the future if other SoC uart need different clock-names..

> -      properties:
> -        clock-names:
> -          items:
> -            - const: core
> -            - const: bus
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              const: spacemit,k1-uart
> +      then:
> +        properties:
> +          clock-names:
> +            items:
> +              - const: core
> +              - const: bus
>  
>  properties:
>    compatible:
> @@ -162,6 +168,9 @@ properties:
>      minItems: 1
>      maxItems: 2
>      oneOf:
> +      - enum:
> +          - main
> +          - uart
>        - items:
>            - const: core
>            - const: bus
> 
> base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
> -- 
> 2.48.1
> 

-- 
Yixun Lan (dlan)
