Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F127CB35;
	Sat, 10 Jan 2026 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768039038; cv=none; b=tgdWTaZ1JhKUDqxqclP1IHqR5oZA5BNXJox6eROnSHFEgjMrJKL/2cyIwP/iqOVuw1sGvoGfO/TAVAVV1Z0wguKAxlKaNdiEYtEY/QED9hwLh7bK7T8avIGwGAXVqKvCtyIEiIsRrslbH8NxmJ4Ih5MyD9/lxCiQmIMJG+7lG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768039038; c=relaxed/simple;
	bh=KfNLqkbA2eQOe94ZwIx+5QtHXfS9ImaFx3q75cIRBJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1HfqAsSvHFm46tAqtgEd7YGo+j4qumXyh2sCl7BkJFUgcBrZb68DEzya5MEzHfLWafS+JuW41JAhqGKwoo8Y1fvGhzYoE+CqH0IPvPSK2T0CO2qN0et5I6PtD8khrYGPQy+sJE4MRf4X5/XMANoJPSpVjv84GuX2q3iWbMUD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 5C4CE34106C;
	Sat, 10 Jan 2026 09:57:14 +0000 (UTC)
Date: Sat, 10 Jan 2026 17:57:07 +0800
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
Subject: Re: [PATCH v4 11/11] riscv: dts: spacemit: add SpacemiT K3 Pico-ITX
 board device tree
Message-ID: <20260110095707-GYA12783@gentoo.org>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-11-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110-k3-basic-dt-v4-11-d492f3a30ffa@riscstar.com>

Hi Guodong,

I have a minor comment for the subject, it's kind of little bit redundant..
so, how about (also apply to patch 10):

[PATCH v4 10/11] riscv: dts: spacemit: add initial support for K3 SoC
[PATCH v4 11/11] riscv: dts: spacemit: add K3 Pico-ITX board support

On 13:18 Sat 10 Jan     , Guodong Xu wrote:
> K3 Pico-ITX is a 2.5-inch single-board computer equipted with a SpacemiT
> K3 SoC.
> 
> This minimal device tree enables booting into a serial console with UART
> output.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v4: No change.
> v3: No change.
> v2: Add aliases node in this board DT.
>     Update the memory node to reflect the hardware truth. Address
>      starts at 0x100000000 (4G) boundary.
> ---
>  arch/riscv/boot/dts/spacemit/Makefile        |  1 +
>  arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 38 ++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
> index 95889e7269d1..7e2b87702571 100644
> --- a/arch/riscv/boot/dts/spacemit/Makefile
> +++ b/arch/riscv/boot/dts/spacemit/Makefile
> @@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-r2s.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
> +dtb-$(CONFIG_ARCH_SPACEMIT) += k3-pico-itx.dtb
> diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> new file mode 100644
> index 000000000000..037ce757e5bc
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
> + * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
strictly, should update to cover current year - which is 2026 now

> + */
> +
> +#include "k3.dtsi"
> +
> +/ {
> +	model = "SpacemiT K3 Pico-ITX";
> +	compatible = "spacemit,k3-pico-itx", "spacemit,k3";
> +
> +	aliases {
> +		serial0 = &uart0;
..
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +		serial6 = &uart6;
> +		serial7 = &uart7;
> +		serial8 = &uart8;
> +		serial9 = &uart9;
> +		serial10 = &uart10;
I think we only add aliases for devices which actually enabled

> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	memory@100000000 {
> +		device_type = "memory";
> +		reg = <0x1 0x00000000 0x4 0x00000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> 
> -- 
> 2.43.0
> 

-- 

Yixun Lan (dlan)
