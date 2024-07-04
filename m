Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1EF1DA58;
	Thu,  4 Jul 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103555; cv=none; b=aaAoY3g/EHs1/4NWD5kuu+dhYwWvm+GYWDsezdwXIJbb1v4qmrDEaTV7Ge9CgaBwu+4elxzr7mNgBoipg5TvdXH485w5hZ1+8O87R0CTZjmikmTaQveycFP8lG8z6nc6Re0Tq9Lu2iz6mE9zm6aSUsnKULsPjqhE4lf4Ds4Q41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103555; c=relaxed/simple;
	bh=qIIdd4Y2oSY8Kqi9SCeYIA0qIOCeR/Y3ZDNe/1fwS/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL5J8Zh7gojAQwsRgo52LYf+/9HSUVg9wJY0T4dzJiIE1i9krCZF8LBvyWK7HDuiBB+ZMCVg9uN6NU1WJC23PPGwYsT5/7bLJlEABkTV7K0g0liWzMf3o5Uth1FIpDDFjUKjF76an0ZkJ4Ppva+fZgUNteBn1hwjk9h8vEVAZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JclKHbiu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JclKHbiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EFBC3277B;
	Thu,  4 Jul 2024 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103555;
	bh=qIIdd4Y2oSY8Kqi9SCeYIA0qIOCeR/Y3ZDNe/1fwS/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JclKHbiulTCgPGr8fznFvQ5IC+es8m7ecL4fUPNuet/7E3qRXOrPYbOKvKF1WKXmw
	 GOJbYUthGWeq+FowyuJokOdkrGPwi2Q328AJZUIfqbEstrCTy/B3uszJzzxQKJsYgd
	 k3jsCzGYEttELvM72ydv6OGRjDR217kRFiNY6HEpnrdB7GN7gtlgS4TkM2eZZuusX+
	 Xl7uDcogSiISdbm+99VsBlau3Y4jLT0Bp4W+XnsIz9e6MLJsEsXfKl3auVE6CBAmDb
	 MA6H+7e2OgmBVis5yxP9P9a+Ca04sAL3f2ThS41cjVpySATHIu4xQty6m9Dx20J7iN
	 +I7Mkg5/TsB8A==
Date: Thu, 4 Jul 2024 22:18:26 +0800
From: Jisheng Zhang <jszhang@kernel.org>
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
Subject: Re: [PATCH v3 08/11] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <ZoavMt1zrVV5Urof@xhacker>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-8-12f73b47461e@gentoo.org>
 <Zoanxksn0nio4MPg@xhacker>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zoanxksn0nio4MPg@xhacker>

On Thu, Jul 04, 2024 at 09:48:01PM +0800, Jisheng Zhang wrote:
> On Wed, Jul 03, 2024 at 02:55:11PM +0000, Yixun Lan wrote:
> > From: Yangyu Chen <cyy@cyyself.name>
> > 
> > Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> > 
> > Key features:
> > - 4 cores per cluster, 2 clusters on chip
> > - UART IP is Intel XScale UART
> > 
> > Some key considerations:
> > - ISA string is inferred from vendor documentation[2]
> > - Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
> > - No coherent DMA on this board
> >     Inferred by taking vendor ethernet and MMC drivers to the mainline
> >     kernel. Without dma-noncoherent in soc node, the driver fails.
> > - No cache nodes now
> >     The parameters from vendor dts are likely to be wrong. It has 512
> >     sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
> >     When the size of the cache line is 64B, it is a directly mapped
> >     cache rather than a set-associative cache, the latter is commonly
> >     used. Thus, I didn't use the parameters from vendor dts.
> > 
> > Currently only support booting into console with only uart, other
> > features will be added soon later.
> > 
> > Link: https://docs.banana-pi.org/en/BPI-F3/SpacemiT_K1_datasheet [1]
> > Link: https://developer.spacemit.com/#/documentation?token=BWbGwbx7liGW21kq9lucSA6Vnpb [2]
> > Link: https://gitee.com/bianbu-linux/linux-6.1/blob/bl-v1.0.y/arch/riscv/boot/dts/spacemit/k1-x.dtsi [3]
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  arch/riscv/boot/dts/spacemit/k1.dtsi | 376 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 376 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > new file mode 100644
> > index 0000000000000..a076e35855a2e
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > @@ -0,0 +1,376 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > +/*
> > + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> > + */
> > +
> > +/dts-v1/;
> > +/ {
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +	model = "SpacemiT K1";
> > +	compatible = "spacemit,k1";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +		serial1 = &uart2;
> > +		serial2 = &uart3;
> > +		serial3 = &uart4;
> > +		serial4 = &uart5;
> > +		serial5 = &uart6;
> > +		serial6 = &uart7;
> > +		serial7 = &uart8;
> > +		serial8 = &uart9;
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		timebase-frequency = <24000000>;
> > +
> > +		cpu-map {
> > +			cluster0 {
> > +				core0 {
> > +					cpu = <&cpu_0>;
> > +				};
> > +				core1 {
> > +					cpu = <&cpu_1>;
> > +				};
> > +				core2 {
> > +					cpu = <&cpu_2>;
> > +				};
> > +				core3 {
> > +					cpu = <&cpu_3>;
> > +				};
> > +			};
> > +
> > +			cluster1 {
> > +				core0 {
> > +					cpu = <&cpu_4>;
> > +				};
> > +				core1 {
> > +					cpu = <&cpu_5>;
> > +				};
> > +				core2 {
> > +					cpu = <&cpu_6>;
> > +				};
> > +				core3 {
> > +					cpu = <&cpu_7>;
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu_0: cpu@0 {
> > +			compatible = "spacemit,x60", "riscv";
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> > +			riscv,isa-base = "rv64i";
> > +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> > +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> > +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> > +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> > +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> > +			riscv,cbom-block-size = <64>;
> > +			riscv,cbop-block-size = <64>;
> > +			riscv,cboz-block-size = <64>;
> > +			mmu-type = "riscv,sv39";
> > +
> > +			cpu0_intc: interrupt-controller {
> > +				compatible = "riscv,cpu-intc";
> > +				interrupt-controller;
> > +				#interrupt-cells = <1>;
> > +			};
> > +		};
> > +
> > +		cpu_1: cpu@1 {
> > +			compatible = "spacemit,x60", "riscv";
> > +			device_type = "cpu";
> > +			reg = <1>;
> > +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> > +			riscv,isa-base = "rv64i";
> > +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> > +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> > +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> > +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> > +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> > +			riscv,cbom-block-size = <64>;
> > +			riscv,cbop-block-size = <64>;
> > +			riscv,cboz-block-size = <64>;
> > +			mmu-type = "riscv,sv39";
> > +
> > +			cpu1_intc: interrupt-controller {
> > +				compatible = "riscv,cpu-intc";
> > +				interrupt-controller;
> > +				#interrupt-cells = <1>;
> > +			};
> > +		};
> > +
> > +		cpu_2: cpu@2 {
> > +			compatible = "spacemit,x60", "riscv";
> > +			device_type = "cpu";
> > +			reg = <2>;
> > +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> > +			riscv,isa-base = "rv64i";
> > +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> > +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> > +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> > +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> > +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> > +			riscv,cbom-block-size = <64>;
> > +			riscv,cbop-block-size = <64>;
> > +			riscv,cboz-block-size = <64>;
> > +			mmu-type = "riscv,sv39";
> > +
> > +			cpu2_intc: interrupt-controller {
> > +				compatible = "riscv,cpu-intc";
> > +				interrupt-controller;
> > +				#interrupt-cells = <1>;
> > +			};
> > +		};
> > +
> > +		cpu_3: cpu@3 {
> > +			compatible = "spacemit,x60", "riscv";
> > +			device_type = "cpu";
> > +			reg = <3>;
> > +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> > +			riscv,isa-base = "rv64i";
> > +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> > +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> > +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> > +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> > +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> > +			riscv,cbom-block-size = <64>;
> > +			riscv,cbop-block-size = <64>;
> > +			riscv,cboz-block-size = <64>;
> > +			mmu-type = "riscv,sv39";
> > +
> > +			cpu3_intc: interrupt-controller {
> > +				compatible = "riscv,cpu-intc";
> > +				interrupt-controller;
> > +				#interrupt-cells = <1>;
> > +			};
> > +		};
> > +
> > +		cpu_4: cpu@4 {
> > +			compatible = "spacemit,x60", "riscv";
> > +			device_type = "cpu";
> > +			reg = <4>;
> > +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> > +			riscv,isa-base = "rv64i";
> > +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> > +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> > +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> > +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> > +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> > +			riscv,cbom-block-size = <64>;
> > +			riscv,cbop-block-size = <64>;
> > +			riscv,cboz-block-size = <64>;
> > +			mmu-type = "riscv,sv39";
> > +
> > +			cpu4_intc: interrupt-controller {
> > +				compatible = "riscv,cpu-intc";
> > +				interrupt-controller;
> > +				#interrupt-cells = <1>;
> > +			};
> > +		};
> > +
> > +		cpu_5: cpu@5 {
> > +			compatible = "spacemit,x60", "riscv";
> > +			device_type = "cpu";
> > +			reg = <5>;
> > +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> > +			riscv,isa-base = "rv64i";
> > +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> > +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> > +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> > +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> > +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> > +			riscv,cbom-block-size = <64>;
> > +			riscv,cbop-block-size = <64>;
> > +			riscv,cboz-block-size = <64>;
> > +			mmu-type = "riscv,sv39";
> > +
> > +			cpu5_intc: interrupt-controller {
> > +				compatible = "riscv,cpu-intc";
> > +				interrupt-controller;
> > +				#interrupt-cells = <1>;
> > +			};
> > +		};
> > +
> > +		cpu_6: cpu@6 {
> > +			compatible = "spacemit,x60", "riscv";
> > +			device_type = "cpu";
> > +			reg = <6>;
> > +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> > +			riscv,isa-base = "rv64i";
> > +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> > +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> > +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> > +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> > +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> > +			riscv,cbom-block-size = <64>;
> > +			riscv,cbop-block-size = <64>;
> > +			riscv,cboz-block-size = <64>;
> > +			mmu-type = "riscv,sv39";
> > +
> > +			cpu6_intc: interrupt-controller {
> > +				compatible = "riscv,cpu-intc";
> > +				interrupt-controller;
> > +				#interrupt-cells = <1>;
> > +			};
> > +		};
> > +
> > +		cpu_7: cpu@7 {
> > +			compatible = "spacemit,x60", "riscv";
> > +			device_type = "cpu";
> > +			reg = <7>;
> > +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> > +			riscv,isa-base = "rv64i";
> > +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> > +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> > +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> > +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> > +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> > +			riscv,cbom-block-size = <64>;
> > +			riscv,cbop-block-size = <64>;
> > +			riscv,cboz-block-size = <64>;
> > +			mmu-type = "riscv,sv39";
> > +
> > +			cpu7_intc: interrupt-controller {
> > +				compatible = "riscv,cpu-intc";
> > +				interrupt-controller;
> > +				#interrupt-cells = <1>;
> > +			};
> > +		};
> > +
> > +	};
> > +
> > +	soc {
> > +		compatible = "simple-bus";
> > +		interrupt-parent = <&plic>;
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		dma-noncoherent;
> > +		ranges;
> > +
> > +		uart0: serial@d4017000 {
> > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> 
> no, this is not a correct hw modeling.

Vendor's linux kernel source code also clearly indicates the FIFO size
is 64B.

> 
> IIRC, 8250_pxa is a xscale uart with 64 bytes FIFO, so this should be
> "mrvl,pxa-uart" or "mrvl,mmp-uart"
> 
> > +			reg = <0x0 0xd4017000 0x0 0x100>;
> > +			interrupts = <42>;
> > +			clock-frequency = <14857000>;
> 
> once clk is ready, you will remove this property and add clk phandles,
> so why not bring clk, pinctrl, reset before hand?
> 

