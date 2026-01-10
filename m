Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E022F5A29
	for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768039222; cv=none; b=u0LgdrEhlWe/mvrws91izHVl1J/DsUOdkG6A3xmlQEmf6yFLBZhs2xbRiOu5C/uqK/mmAouCz4Ygb5EE2vnjCTkacc5sPzDoqXdhsMO+rI3buuq3YXmzsXQ6eP1zqrkQnspLve4OVFH7kqbJ+5LqhvNDevsb7QkOm02GGUvIVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768039222; c=relaxed/simple;
	bh=Kx25xwvOQV4ZGexx74tAKgjxf3f4YHrEYLh2iVNMWPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdzSsN3jMCD8fKXhZaeBW3F/9BDUrwxrPOYlpbewlfDX7AexTd6jY9D2W/pY5/H9Sz0E+JwgaexIKN/xg+KDc/jBuFVteONj6fId4g70Ej8pAM480Jhjp1/311av0kjli5DLboUaUPH4a8ar4KVzuMsDXQ3U+OEFcl5ta5zTPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lib0n6yl; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lib0n6yl"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b19939070fso3333823eec.0
        for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 02:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768039219; x=1768644019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0uei3FW57pxuQOaQrtXu7AmqZ3ReivJbfwZYctpgUc=;
        b=Lib0n6yl5CcebscH9RFCuFJH3x2CVeIfCKF9DwbClh1CSJFD/uIPKqxpQMp9UVFnlI
         XieIaDhnRYtEbFTSakoEI8SoFHwPe5JHjL7rPDSErW+ZepJJQFr17tpD9F+EnCrigx8w
         3z489m092YdTDcj25HRfbXu51DbPLzm01chl1msVhLAfLIV3ZtojLoZKRETsc/krknIl
         Dc4+REcYVe6jCqVRJwr32cU6995Ny/z69VeeGSsuocF9fgGr3T+tdiOy3psLe5Ey7VQu
         6CDoJGqpqSbbtZEVaR9wnTrFx/4RLc8cbpi14uUHsfFs2AAa9GIAoazvD62nt5nWT4Pa
         ow9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768039219; x=1768644019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0uei3FW57pxuQOaQrtXu7AmqZ3ReivJbfwZYctpgUc=;
        b=ZmgiIkWQ6W7m+OG93cKwaT4RQHIYuyjiQU/Cud+03wTNsSTVq3Tu9/4eesaLKnwPvN
         1PMaqmrz/2yolrCn7EUtUc9er9hMO7My/3Js9jkqW89f7mC36GjtT5LazU4rj/zMw895
         2F0xTsDH3AOjBH4huCN5gNsemAwkY92411IfBPSCKFdu/GmUuQ3Ha5dMLfGGSlyXVRqO
         sqQSEASGqsFv+z6VRfgiaehZh09IMrYa2jqZo/ejZW5KWNkWEiIMuhcmCn0NoZUXtPvX
         tI6snP/2cLZEZP13venXfxBBswZVlSHSXGz4TxLgfpgPP/grBTpf95TJSnbfmhOzwGot
         uktA==
X-Forwarded-Encrypted: i=1; AJvYcCUs5Ud9fgJakI8UfyUUD/7FrMoh1JD+Sap22vaNDpV3MP4ql7Yz0YRYxt+1HVtxyketHTT6whtdkYk4e3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtz2oF4K4xUeks2W7ik9Xkr2CoBxUF3tw1JHH2/c9vtYQ2KPAt
	/nRv9dqvEzFg3yhqfd1w80gogzUU99wuTWhD4/Ud/tmX28DCWVjesH2b
X-Gm-Gg: AY/fxX5QpPVn9D7J383YZNPd3QtqVBde1I3LwESomKAsZAhmEBrEwSiTmVlPwrzjKzp
	W9WWPV70N2uT4IvMxc47avAx+QaJ5OuN/tDxrqiOUOhRgdbv7CMEIAGNoCABCtujTWOsMVJMaLF
	RavK1Xr4WgUJOWT4dbdWmVt2w/s6mizJs4XhMX4Lq9H4BQUVDEOPPXWzshnmSo5Ihz4ACmDOM15
	byMAJQku+qWi0O8/8oBQhM8jmbFBjoZXSspvJLY2DSfXoig6GN/M99fwuCWPE3n+jAgUuImKr+L
	Yjds2UGjjvgEj3WihkEqR0/salwRQpCnJmUc6GdtCr+jH735qeUC/kukC/EutGOcQl7LBfBRdZl
	RmniIc8kwSCRFaiKrA76IdOZ4MgW/czZxpmK/KlL20ebBDugsEk0BB5UDyIw5fH13s+5UUSeGVt
	cJ9isJldA3IikEv/aMBr5/
X-Google-Smtp-Source: AGHT+IHkeKwXJmX2hAKm71gZdj66a0g5GsX46UDnqnvKvqji/PdSQqaaXliGLbIBUh0iYzUGrxethg==
X-Received: by 2002:a05:7300:559b:b0:2b0:5c2f:6bf8 with SMTP id 5a478bee46e88-2b17d2baba5mr8163996eec.23.1768039218641;
        Sat, 10 Jan 2026 02:00:18 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a6386sm12668198eec.14.2026.01.10.02.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 02:00:18 -0800 (PST)
Date: Sat, 10 Jan 2026 18:00:00 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, Andrew Jones <ajones@ventanamicro.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 10/11] riscv: dts: spacemit: add initial device tree
 of SpacemiT K3 SoC
Message-ID: <aWIi9LFdqSF3c-FP@inochi.infowork>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-10-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110-k3-basic-dt-v4-10-d492f3a30ffa@riscstar.com>

On Sat, Jan 10, 2026 at 01:18:22PM +0800, Guodong Xu wrote:
> SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
> Add nodes of uarts, timer and interrupt-controllers.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v4: Fix missing blank space after commas in compatible string.
>     Add m-mode imsic and aplic node.
>     Reorder properties in simsic, saplic, mimsic, and maplic nodes
>      to match DTS coding style.
> v3: Remove "supm" from the riscv,isa-extensions list.
> v2: Remove aliases from k3.dtsi, they should be in board DTS.
>     Updated riscv,isa-extensions with new extensions from the extensions.yaml.
> ---
>  arch/riscv/boot/dts/spacemit/k3.dtsi | 590 +++++++++++++++++++++++++++++++++++
>  1 file changed, 590 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
> new file mode 100644
> index 000000000000..a815f85cf5a6
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> @@ -0,0 +1,590 @@
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
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
> +					       "sha", "shcounterenw", "shgatpa", "shtvala",
> +					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
> +					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
> +					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
> +					       "sstvala", "sstvecd", "ssu64xl", "svade",
> +					       "svinval", "svnapot", "svpbmt", "za64rs",
> +					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
> +					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
> +					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
> +					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
> +					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> +					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
> +					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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

I think this should be riscv,sv48? IIRC K3 supports it.

Regards,
Inochi

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
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
> +					       "sha", "shcounterenw", "shgatpa", "shtvala",
> +					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
> +					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
> +					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
> +					       "sstvala", "sstvecd", "ssu64xl", "svade",
> +					       "svinval", "svnapot", "svpbmt", "za64rs",
> +					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
> +					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
> +					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
> +					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
> +					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> +					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
> +					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
> +					       "sha", "shcounterenw", "shgatpa", "shtvala",
> +					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
> +					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
> +					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
> +					       "sstvala", "sstvecd", "ssu64xl", "svade",
> +					       "svinval", "svnapot", "svpbmt", "za64rs",
> +					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
> +					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
> +					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
> +					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
> +					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> +					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
> +					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
> +					       "sha", "shcounterenw", "shgatpa", "shtvala",
> +					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
> +					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
> +					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
> +					       "sstvala", "sstvecd", "ssu64xl", "svade",
> +					       "svinval", "svnapot", "svpbmt", "za64rs",
> +					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
> +					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
> +					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
> +					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
> +					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> +					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
> +					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
> +					       "sha", "shcounterenw", "shgatpa", "shtvala",
> +					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
> +					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
> +					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
> +					       "sstvala", "sstvecd", "ssu64xl", "svade",
> +					       "svinval", "svnapot", "svpbmt", "za64rs",
> +					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
> +					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
> +					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
> +					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
> +					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> +					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
> +					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
> +					       "sha", "shcounterenw", "shgatpa", "shtvala",
> +					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
> +					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
> +					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
> +					       "sstvala", "sstvecd", "ssu64xl", "svade",
> +					       "svinval", "svnapot", "svpbmt", "za64rs",
> +					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
> +					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
> +					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
> +					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
> +					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> +					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
> +					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
> +					       "sha", "shcounterenw", "shgatpa", "shtvala",
> +					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
> +					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
> +					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
> +					       "sstvala", "sstvecd", "ssu64xl", "svade",
> +					       "svinval", "svnapot", "svpbmt", "za64rs",
> +					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
> +					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
> +					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
> +					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
> +					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> +					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
> +					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "h",
> +					       "sha", "shcounterenw", "shgatpa", "shtvala",
> +					       "shvsatpa", "shvstvala", "shvstvecd", "smaia",
> +					       "smstateen", "ssaia", "ssccptr", "sscofpmf",
> +					       "sscounterenw", "ssnpm", "ssstateen", "sstc",
> +					       "sstvala", "sstvecd", "ssu64xl", "svade",
> +					       "svinval", "svnapot", "svpbmt", "za64rs",
> +					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
> +					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> +					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> +					       "ziccamoa", "ziccif", "zicclsm", "zicntr",
> +					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
> +					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
> +					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> +					       "zvkned", "zvkng", "zvknha", "zvknhb", "zvks",
> +					       "zvksc", "zvksed", "zvksg", "zvksh", "zvkt";
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
> +
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
> +
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
> +
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
> +
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
> +
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
> +
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
> +
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
> +
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
> +
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
> +
> +			status = "disabled";
> +		};
> +
> +		simsic: interrupt-controller@e0400000 {
> +			compatible = "spacemit,k3-imsics", "riscv,imsics";
> +			reg = <0x0 0xe0400000 0x0 0x200000>;
> +			#interrupt-cells = <0>;
> +			#msi-cells = <0>;
> +			interrupt-controller;
> +			interrupts-extended = <&cpu0_intc 9>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 9>, <&cpu3_intc 9>,
> +					      <&cpu4_intc 9>, <&cpu5_intc 9>,
> +					      <&cpu6_intc 9>, <&cpu7_intc 9>;
> +			msi-controller;
> +			riscv,guest-index-bits = <6>;
> +			riscv,hart-index-bits = <4>;
> +			riscv,num-guest-ids = <511>;
> +			riscv,num-ids = <511>;
> +		};
> +
> +		saplic: interrupt-controller@e0804000 {
> +			compatible = "spacemit,k3-aplic", "riscv,aplic";
> +			reg = <0x0 0xe0804000 0x0 0x4000>;
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			msi-parent = <&simsic>;
> +			riscv,num-sources = <512>;
> +		};
> +
> +		clint: timer@e081c000 {
> +			compatible = "spacemit,k3-clint", "sifive,clint0";
> +			reg = <0x0 0xe081c000 0x0 0x4000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> +		};
> +
> +		mimsic: interrupt-controller@f1000000 {
> +			compatible = "spacemit,k3-imsics", "riscv,imsics";
> +			reg = <0x0 0xf1000000 0x0 0x10000>;
> +			#interrupt-cells = <0>;
> +			#msi-cells = <0>;
> +			interrupt-controller;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu1_intc 11>,
> +					      <&cpu2_intc 11>, <&cpu3_intc 11>,
> +					      <&cpu4_intc 11>, <&cpu5_intc 11>,
> +					      <&cpu6_intc 11>, <&cpu7_intc 11>;
> +			msi-controller;
> +			riscv,guest-index-bits = <6>;
> +			riscv,hart-index-bits = <4>;
> +			riscv,num-guest-ids = <511>;
> +			riscv,num-ids = <511>;
> +
> +			status = "disabled";
> +		};
> +
> +		maplic: interrupt-controller@f1800000 {
> +			compatible = "spacemit,k3-aplic", "riscv,aplic";
> +			reg = <0x0 0xf1800000 0x0 0x4000>;
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			msi-parent = <&mimsic>;
> +			riscv,children = <&saplic>;
> +			riscv,delegate = <&saplic 1 512>;
> +			riscv,num-sources = <512>;
> +
> +			status = "disabled";
> +		};
> +	};
> +};
> 
> -- 
> 2.43.0
> 
> 
