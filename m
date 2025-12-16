Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2B3446A6
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895067; cv=none; b=GOsjMyyQITc2SVoeG/Y75vleoDXLUC0qzuggJ9zoeVhlRMUH8FGVMZlerrxI/qNRMD9enMHQ5zL7J+IsGL2e6XvUUJ/aAS4ZQLU2lYyYbRCtcqdDrEnmnhLnEtXKb6Mm/cl9t4co8+XWE8dvEj3i88ImLoY9sY0n0TQRuVzKilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895067; c=relaxed/simple;
	bh=od17nMEvzsTFH2HeSiuStNC7NPy9wB5VOrBvuHbW75M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrNZ6QN1sk+zOdIgxrShFHVd3mWA/gYfdioHR797bFiPw6GELCnT0LPGNLSbYFqr6jWVxAh/M4nQ1QZn2QP/x6tsQ4KHNJYhXVJpaEOfO3/XXiHevqdkoVPBhh0w0owUso7dzXk57T80VkJtYMJ41ByFG3PvdCYzU3MIDyfFvM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=rQngKjx0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="rQngKjx0"
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2C9A83FCA0
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765895052;
	bh=DeBKVqet2G7JfUg3904XUfDizhOtR0zCo3pShlOQvu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=rQngKjx0EeQprXIXiwF1xTL0cImT38Qj/rMsABb+q98RhjYQj567EHMiDWqfy0tYE
	 JtjBAaAVUTKjbtOuihBnVL+rrzcw3GKS5if0+sv6aEsSV7wpr1KoN+K4PcQBD0TRqq
	 jgJSBG6VkZbuoIxMB8A4s8RZdiAvmN2YAd51IN2DOlJkrDHCN0r96XquUaIwpCCCUl
	 HalnR13jY881reOGHTPsnZ5uiONfInPQro8Wint9v6Sw8XN5VM14OLNen2wY5J4XiZ
	 Fq1SIIFcRuUumw4dj78Fj6Y3+8Oygxvz+L2H3ievCuDvOWgShHUy7wl/AmksypfK/Z
	 JW4ScXpR9R73t+2Le7mTYn5cXDJFp81nwSnV/F68KqRnPFQRytToXrq25LqvW3C8y1
	 BVLWhPcOyXEQ+4f3QcIaNBpqrxtuWr7sV/SVoRU4MAhD8Ji+5Qxdh5QPkkLdV9rVxO
	 pGv77ww5puVznRYyTuMmfF06KaQtYhBapZtsFkCaxsEC+d+yZzhc5Gtnko1shqZk+5
	 T0csiTgBK3Y3FUivpN+DFZH02P9U+30r1axlEvukWOysA7mKE4/cTw3Yg2dsTtMXwh
	 2rovXcChekd7oncidUnc1qOgCgCNOfU9a3k79X3xvq9RLGvCf4qv/RdZhf00MOjeyj
	 cZ4wuzfX324hNCx52/mcYKT0=
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b79fd0cc12eso292951766b.3
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 06:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765895049; x=1766499849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeBKVqet2G7JfUg3904XUfDizhOtR0zCo3pShlOQvu8=;
        b=nXr7fKgYAddz5h9PcZ7yVH4v3XXQMit64uwcynF6Q/CtJP8AJyU6JXZwaGyE0Uj5Lv
         gP6Pk2Delr9hKy9ganSQ67mgsERtvG8rsfozxh1tQvsRXEFnjuJUV/oH31rZul8K9kXU
         hnYm2Uq8TEEMEi65xaqu4Az0lSKWyoInWpQcts4Y+ADnZXgKHwRHQZxBJUWtJJWvS8xR
         BbnB3LEjqRoBeJAqAwoJ7vDVd4/V5kFiryA88T5aVI0NuDkb7KWzsAnFCPjdtzCnrtaB
         V4Mak/WEWncCFPXjD52w8Idul3z41wSRsvUgw/7ONWR5yYMpX3NUWM4VCY+jMpXwLQEm
         l6HA==
X-Forwarded-Encrypted: i=1; AJvYcCUmlIyh6GxSgzxyD6XRoSEypnWBXTbW551gIH8CYFkdLN99qcOlCkl1vv70hkJGAeXprtBS2rbGiQ0Kpf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxE2ftUHAQ/gI/pxnfRTDQvEAmrSXKgdOKew6DQeaexdE3fCD
	V+NriK1qEu+eZAZ/9jNRo176RpgeSoC+U7k0CVdvFvPbWd2vLKX6hg7YDz/Jz98aOuCLnNz8BgD
	xraKCvOjdqyG1iwNwO6+Nlne2UUAPoVXf4dPLuTDn5Fi44RhM93oCNOrkWuKrGURWz3pX1CC5oG
	w3yRBVGw==
X-Gm-Gg: AY/fxX69Dz+moB0/xfoh0q7f1obAlFdGmlBzyTIid+pchkR8HZjmIZgUNSSJAdlUxGQ
	aQn/Dyp8+IZ5cinOH+ctBWUiEzQZ9G6iNBdtdv2+m9Z+bAs9t5Df6kLrGYq+mBcA1xhk5VtSze3
	3ZkDV1TMG1ZYK0g68UjBUOY0XPUO2nVpQvr3LQ4fnk/ugux5glJBmP6nGy3t7Mnbq+cmraspNg9
	8aOdc03InB2N79y0a6Yp/HnAGfnjRSgUviw6DCo9nr8zNiUCOr1mPnRAr21PJT8IWNtfMY0Y/Qx
	nJmEVE8dD0DunkuSDSGcHAiIUj74ICgayWS1Y0PFcupLJ9hIQIFU+BQ4KoDpra5EVC2abCTVrtb
	mXNZqrNQfFPzQAgoO2DrnTbFpAT53seSeA9fPTzgxtA9E1IZkPx7XNeCN+/HnqYPQrC6+3bJ/rR
	ewU0uKFt4=
X-Received: by 2002:a17:907:cd07:b0:b7a:1b9c:ba5a with SMTP id a640c23a62f3a-b7d238ba8cdmr1366982966b.32.1765895049433;
        Tue, 16 Dec 2025 06:24:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHi8U3ire58qlr5lfvSspx1MheSPYOV5do1qJVrNR5GUwWevCdrfEa6hTxlrpOZ1LReoGe3w==
X-Received: by 2002:a17:907:cd07:b0:b7a:1b9c:ba5a with SMTP id a640c23a62f3a-b7d238ba8cdmr1366978166b.32.1765895048802;
        Tue, 16 Dec 2025 06:24:08 -0800 (PST)
Received: from [192.168.103.125] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa570167sm1661625066b.57.2025.12.16.06.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 06:24:08 -0800 (PST)
Message-ID: <60948ca2-ed3d-485b-9b11-15df7ef8791d@canonical.com>
Date: Tue, 16 Dec 2025 15:24:05 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Guodong Xu <guodong@riscstar.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
 linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 14:32, Guodong Xu wrote:
> SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
> Add nodes of uarts, timer and interrupt-controllers.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>   arch/riscv/boot/dts/spacemit/k3.dtsi | 529 +++++++++++++++++++++++++++++++++++
>   1 file changed, 529 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..cb27b790716fdd6dc2bc89c28dd2588a596a5af9
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> @@ -0,0 +1,529 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
> + * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	model = "SpacemiT K3";
> +	compatible = "spacemit,k3";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +		serial6 = &uart6;
> +		serial7 = &uart7;
> +		serial8 = &uart8;
> +		serial9 = &uart9;
> +		serial10 = &uart10;
> +	};
> +
> +	cpus: cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <24000000>;
> +
> +		cpu_0: cpu@0 {
> +			compatible = "spacemit,x100", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
> +					       "smaia", "smstateen", "ssaia", "sscofpmf",
> +					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
> +					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
> +					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "zicntr", "zicond", "zicsr", "zifencei",
> +					       "zihintntl", "zihintpause", "zihpm", "zimop",
> +					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
> +					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
> +					       "zvknc", "zvkned", "zvkng", "zvknha",
> +					       "zvknhb", "zvks", "zvksc", "zvksed",
> +					       "zvksg", "zvksh", "zvkt";

This not the description of an RVA23S64 cpu. It is not even RVA23U64, 
e.g. `supm` is missing.

Is the description incomplete or is the CPU not compliant?

Best regards

Heinrich

> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <256>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_cache0>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu_1: cpu@1 {
> +			compatible = "spacemit,x100", "riscv";
> +			device_type = "cpu";
> +			reg = <1>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
> +					       "smaia", "smstateen", "ssaia", "sscofpmf",
> +					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
> +					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
> +					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "zicntr", "zicond", "zicsr", "zifencei",
> +					       "zihintntl", "zihintpause", "zihpm", "zimop",
> +					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
> +					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
> +					       "zvknc", "zvkned", "zvkng", "zvknha",
> +					       "zvknhb", "zvks", "zvksc", "zvksed",
> +					       "zvksg", "zvksh", "zvkt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <256>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_cache0>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu1_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu_2: cpu@2 {
> +			compatible = "spacemit,x100", "riscv";
> +			device_type = "cpu";
> +			reg = <2>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
> +					       "smaia", "smstateen", "ssaia", "sscofpmf",
> +					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
> +					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
> +					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "zicntr", "zicond", "zicsr", "zifencei",
> +					       "zihintntl", "zihintpause", "zihpm", "zimop",
> +					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
> +					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
> +					       "zvknc", "zvkned", "zvkng", "zvknha",
> +					       "zvknhb", "zvks", "zvksc", "zvksed",
> +					       "zvksg", "zvksh", "zvkt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <256>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_cache0>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu2_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu_3: cpu@3 {
> +			compatible = "spacemit,x100", "riscv";
> +			device_type = "cpu";
> +			reg = <3>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
> +					       "smaia", "smstateen", "ssaia", "sscofpmf",
> +					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
> +					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
> +					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "zicntr", "zicond", "zicsr", "zifencei",
> +					       "zihintntl", "zihintpause", "zihpm", "zimop",
> +					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
> +					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
> +					       "zvknc", "zvkned", "zvkng", "zvknha",
> +					       "zvknhb", "zvks", "zvksc", "zvksed",
> +					       "zvksg", "zvksh", "zvkt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <256>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_cache0>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu3_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu_4: cpu@4 {
> +			compatible = "spacemit,x100", "riscv";
> +			device_type = "cpu";
> +			reg = <4>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
> +					       "smaia", "smstateen", "ssaia", "sscofpmf",
> +					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
> +					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
> +					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "zicntr", "zicond", "zicsr", "zifencei",
> +					       "zihintntl", "zihintpause", "zihpm", "zimop",
> +					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
> +					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
> +					       "zvknc", "zvkned", "zvkng", "zvknha",
> +					       "zvknhb", "zvks", "zvksc", "zvksed",
> +					       "zvksg", "zvksh", "zvkt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <256>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_cache1>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu4_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu_5: cpu@5 {
> +			compatible = "spacemit,x100", "riscv";
> +			device_type = "cpu";
> +			reg = <5>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
> +					       "smaia", "smstateen", "ssaia", "sscofpmf",
> +					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
> +					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
> +					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "zicntr", "zicond", "zicsr", "zifencei",
> +					       "zihintntl", "zihintpause", "zihpm", "zimop",
> +					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
> +					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
> +					       "zvknc", "zvkned", "zvkng", "zvknha",
> +					       "zvknhb", "zvks", "zvksc", "zvksed",
> +					       "zvksg", "zvksh", "zvkt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <256>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_cache1>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu5_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu_6: cpu@6 {
> +			compatible = "spacemit,x100", "riscv";
> +			device_type = "cpu";
> +			reg = <6>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
> +					       "smaia", "smstateen", "ssaia", "sscofpmf",
> +					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
> +					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
> +					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "zicntr", "zicond", "zicsr", "zifencei",
> +					       "zihintntl", "zihintpause", "zihpm", "zimop",
> +					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
> +					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
> +					       "zvknc", "zvkned", "zvkng", "zvknha",
> +					       "zvknhb", "zvks", "zvksc", "zvksed",
> +					       "zvksg", "zvksh", "zvkt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <256>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_cache1>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu6_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu_7: cpu@7 {
> +			compatible = "spacemit,x100", "riscv";
> +			device_type = "cpu";
> +			reg = <7>;
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
> +					       "smaia", "smstateen", "ssaia", "sscofpmf",
> +					       "ssnpm", "sstc", "svade", "svinval", "svnapot",
> +					       "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
> +					       "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "zicntr", "zicond", "zicsr", "zifencei",
> +					       "zihintntl", "zihintpause", "zihpm", "zimop",
> +					       "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
> +					       "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
> +					       "zvknc", "zvkned", "zvkng", "zvknha",
> +					       "zvknhb", "zvks", "zvksc", "zvksed",
> +					       "zvksg", "zvksh", "zvkt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			i-cache-block-size = <64>;
> +			i-cache-size = <65536>;
> +			i-cache-sets = <256>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <65536>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_cache1>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu7_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		l2_cache0: cache-controller-0 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <4194304>;
> +			cache-sets = <4096>;
> +			cache-unified;
> +		};
> +
> +		l2_cache1: cache-controller-1 {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <4194304>;
> +			cache-sets = <4096>;
> +			cache-unified;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu_0>;
> +				};
> +				core1 {
> +					cpu = <&cpu_1>;
> +				};
> +				core2 {
> +					cpu = <&cpu_2>;
> +				};
> +				core3 {
> +					cpu = <&cpu_3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu_4>;
> +				};
> +				core1 {
> +					cpu = <&cpu_5>;
> +				};
> +				core2 {
> +					cpu = <&cpu_6>;
> +				};
> +				core3 {
> +					cpu = <&cpu_7>;
> +				};
> +			};
> +		};
> +	};
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&saplic>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		uart0: serial@d4017000 {
> +			compatible = "spacemit,k3-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017000 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <14700000>;
> +			interrupts = <42 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@d4017100 {
> +			compatible = "spacemit,k3-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017100 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <14700000>;
> +			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@d4017200 {
> +			compatible = "spacemit,k3-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017200 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <14700000>;
> +			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@d4017300 {
> +			compatible = "spacemit,k3-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017300 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <14700000>;
> +			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart5: serial@d4017400 {
> +			compatible = "spacemit,k3-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017400 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <14700000>;
> +			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart6: serial@d4017500 {
> +			compatible = "spacemit,k3-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017500 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <14700000>;
> +			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart7: serial@d4017600 {
> +			compatible = "spacemit,k3-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017600 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <14700000>;
> +			interrupts = <49 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart8: serial@d4017700 {
> +			compatible = "spacemit,k3-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017700 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <14700000>;
> +			interrupts = <50 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart9: serial@d4017800 {
> +			compatible = "spacemit,k3-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd4017800 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <14700000>;
> +			interrupts = <51 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart10: serial@d401f000 {
> +			compatible = "spacemit,k3-uart", "intel,xscale-uart";
> +			reg = <0x0 0xd401f000 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <14700000>;
> +			interrupts = <281 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		simsic: interrupt-controller@e0400000 {
> +			compatible = "spacemit,k3-imsics","riscv,imsics";
> +			reg = <0x0 0xe0400000 0x0 0x00200000>;
> +			interrupt-controller;
> +			#interrupt-cells = <0>;
> +			msi-controller;
> +			#msi-cells = <0>;
> +			interrupts-extended = <&cpu0_intc 9>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 9>, <&cpu3_intc 9>,
> +					      <&cpu4_intc 9>, <&cpu5_intc 9>,
> +					      <&cpu6_intc 9>, <&cpu7_intc 9>;
> +			riscv,num-ids = <511>;
> +			riscv,num-guest-ids = <511>;
> +			riscv,hart-index-bits = <4>;
> +			riscv,guest-index-bits = <6>;
> +		};
> +
> +		saplic: interrupt-controller@e0804000 {
> +			compatible = "spacemit,k3-aplic", "riscv,aplic";
> +			reg = <0x0 0xe0804000 0x0 0x4000>;
> +			msi-parent = <&simsic>;
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			riscv,num-sources = <512>;
> +		};
> +
> +		clint: timer@e081c000 {
> +			compatible = "spacemit,k3-clint", "sifive,clint0";
> +			reg = <0x0 0xe081c000 0x0 0x0004000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> +		};
> +	};
> +};
> 

