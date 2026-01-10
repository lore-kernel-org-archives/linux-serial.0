Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7E33F371;
	Sat, 10 Jan 2026 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768046113; cv=none; b=ppx10hI60sPPY43F0big119sQAmz9soR61fwNurjPOyZwa/WOAk6p0JmoyQOLnuSyV6iQXqdE/6eujXUhv3FuCglIkVaT/BzWG78+Ckh0TWtFRdVWPvWOtmiOrI2QgNgb3lL7MtD/kb03RtlauAPRgGFjtYrp6kDRqZtxzRtsWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768046113; c=relaxed/simple;
	bh=iX4MiZGQL2z/88fUjb1EaNDBM4frLV4bsSb1g8BCzKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYa4jTM9A1YUUx74Ppn9SwF0RWZFbDbuK7A28FaQ/Lvn7dU09DCeLVfkZP8DRyigQJmKpKOgV/bqTTFtKuNJ6V3u+7A2BMPoCk7yjJONnPRj9Ay50iuG/gWT6B2G3HNAgpqRs3DWw1NDcOaRHQOhipnJABUYt4il6GYu4SGEyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 23849340EA9;
	Sat, 10 Jan 2026 11:55:08 +0000 (UTC)
Date: Sat, 10 Jan 2026 19:55:03 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor@kernel.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 05/11] dt-bindings: riscv: spacemit: add K3 and
 Pico-ITX board bindings
Message-ID: <20260110115503-GYC12783@gentoo.org>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-5-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110-k3-basic-dt-v4-5-d492f3a30ffa@riscstar.com>

Hi Guodong,

On 13:18 Sat 10 Jan     , Guodong Xu wrote:
> Add DT binding documentation for the SpacemiT K3 SoC and the board Pico-ITX
> which is a 2.5-inch single-board computer.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

Reviewed-by: Yixun Lan <dlan@gentoo.org>

> ---
> v4: Adjust maintainers list in alphabetic order.
>     Declare spacemit,k3-pico-itx as an enum, which can save future
>      code change when adding new boards.
> v3: No change.
> v2: Use one-blank-space between name and email address.
> ---
>  Documentation/devicetree/bindings/riscv/spacemit.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> index 9c49482002f7..b958b94a924d 100644
> --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> @@ -7,6 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: SpacemiT SoC-based boards
>  
>  maintainers:
> +  - Guodong Xu <guodong@riscstar.com>
>    - Yangyu Chen <cyy@cyyself.name>
>    - Yixun Lan <dlan@gentoo.org>
>  
> @@ -26,6 +27,10 @@ properties:
>                - xunlong,orangepi-r2s
>                - xunlong,orangepi-rv2
>            - const: spacemit,k1
> +      - items:
> +          - enum:
> +              - spacemit,k3-pico-itx
> +          - const: spacemit,k3
>  
>  additionalProperties: true
>  
> 
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
