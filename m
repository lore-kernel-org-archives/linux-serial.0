Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D907282E1;
	Wed,  3 Jul 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024551; cv=none; b=MoP/vA3xnROtpzTWHJc1tsA3uFlgNtmw0+kTgxhWOx0cJ2ldArJNz3Zq0nw7L+UFBh0Yg48vjMt8InwqGT9Cs2a36WPgUmRTzc+aCQJdCLPdx4annIMhZIPTB642jg4sttqKdRg+Ps5ckCq7eXTvqGl8Qzx2YOhMlZj+YvPsvx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024551; c=relaxed/simple;
	bh=EsZFpXIeoKQfJgd3H/gVXC/Yil62xZKPu1DKpUkp0KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b20YuyKuTFoZDzeU7EsMvzsBp5s7x5wG424kczOr+taUEVBY20WcX3CIRdNDTTOPlljn6f481BrsslJFiGtFbqJQ2qkhB58fHUcpoXxFKeljx9hilgJHr8tvVvj1zPZmNYeMkKjQa7O6iAp3xxPV1If2ACB2Nsfph8pDBSWXvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV/sSubh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV/sSubh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1C9C2BD10;
	Wed,  3 Jul 2024 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720024551;
	bh=EsZFpXIeoKQfJgd3H/gVXC/Yil62xZKPu1DKpUkp0KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VV/sSubhL1eBS8FI6ROC7JQcM1lKWt5DwFTWPemUVCAEuMKj6azjnJWXySnw/GNwQ
	 Dxj/kMweubAsj+KHDmF5TESGvvVT8oFnqv/FzmKq6l8rVmlQbPPTeyDfyQ9KjdPc88
	 xVtTKLt6Qtypx58B6SUlXcE4Io9sjWiKHxkFOC1FauHOGWvx7Dn1NmK3XO2b7GMzKZ
	 u8XTFz27YDQ/klavQLp9LJNl5fFKxihR8jIJjeH4mwMTg2XZP/Afxydau8wW9++k2F
	 no/VjV+MZ8C7ARZWZx87s8EE82YTFEBDzV2nC5wS2zarGLSxOuuDi8I/q54fB/vjMr
	 uNEhpqrtY5/ow==
Date: Wed, 3 Jul 2024 18:35:43 +0200
From: Matthias Brugger <matthias.bgg@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Inochi Amaoto <inochiama@outlook.com>, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Meng Zhang <zhangmeng.kevin@spacemit.com>
Subject: Re: [PATCH v3 03/11] dt-bindings: riscv: add SpacemiT K1 bindings
Message-ID: <ZoV93-NzW2fqxQmN@ziggy.stardust>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-3-12f73b47461e@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703-k1-01-basic-dt-v3-3-12f73b47461e@gentoo.org>

On Wed, Jul 03, 2024 at 02:55:06PM +0000, Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
> 
> Add DT binding documentation for the SpacemiT K1 SoC[1] and the Banana
> Pi BPi-F3 board[2] which used it.
> 
> Link: https://www.spacemit.com/en/spacemit-key-stone-2/ [1]
> Link: https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3 [2]
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

Reviewed-by: Matthias Brugger <matthias.bgg@kernel.org>

> ---
>  .../devicetree/bindings/riscv/spacemit.yaml        | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> new file mode 100644
> index 0000000000000..52e55077af1ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/spacemit.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT SoC-based boards
> +
> +maintainers:
> +  - Yangyu Chen <cyy@cyyself.name>
> +  - Yixun Lan <dlan@gentoo.org>
> +
> +description:
> +  SpacemiT SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - bananapi,bpi-f3
> +          - const: spacemit,k1
> +
> +additionalProperties: true
> +
> +...
> 
> -- 
> 2.45.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
