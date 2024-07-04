Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532BF1946C0;
	Thu,  4 Jul 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093177; cv=none; b=R1mK0HIKLw0A/Pl0LOgZP430MdgU7HyMPgQ5aw2rh2drMmg4QVqTmx0SocK7n5LGY7L9teAyDe5lVqgGP13pn1fhNqmz1A1LgLIw4oTCoVlMIF4JDxxaRby6FOMhK6IvIuPrMxY1H83irTJ66ILv3m+9Q5gLenAM/HLe5gni47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093177; c=relaxed/simple;
	bh=uKws6f/4xMvwUFbk04SOJ1F70Mxyk79PZasCzGo0r/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzc+9LcsSiiJ3chS5qr6LsJDYhKrNcfyMrZ+nytpjoKOoCmc1FkVUWyrN0rgfupNNV/jDv0x84J4DTfKI+8/qa7/4logUhd9rUzMFg5A/5ac/UJvcLqfIWExTy6ViXqW9fC19XZmo1KU7cEtdD/aUgS8x+mx+kX+3t24lvOVD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Thu, 4 Jul 2024 11:39:22 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Jesse Taube <jesse@rivosinc.com>
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
Message-ID: <20240704113922.GA2889185@ofsar>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-8-12f73b47461e@gentoo.org>
 <dd619ad4-86f4-4ddd-be16-fbbaa197d551@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd619ad4-86f4-4ddd-be16-fbbaa197d551@rivosinc.com>

Hi Jesse

On 21:17 Wed 03 Jul     , Jesse Taube wrote:
> On 7/3/24 10:55, Yixun Lan wrote:
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
> >      Inferred by taking vendor ethernet and MMC drivers to the mainline
> >      kernel. Without dma-noncoherent in soc node, the driver fails.
> > - No cache nodes now
> >      The parameters from vendor dts are likely to be wrong. It has 512
> >      sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
> >      When the size of the cache line is 64B, it is a directly mapped
> >      cache rather than a set-associative cache, the latter is commonly
> >      used. Thus, I didn't use the parameters from vendor dts.
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
> >   arch/riscv/boot/dts/spacemit/k1.dtsi | 376 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 376 insertions(+)
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
> 
> Is there a reson not to add the I and D cache sizes.
No specific reason..

For "not adding those properties", I think it's largely due to Yangyu is kind of
skeptical about the info from vendor dts, and he do want to test/verify before
adding them..

so, did you test all these info, and confirm they are correct?

> 
> 			i-cache-block-size = <64>;
> 			i-cache-size = <32768>;
> 			i-cache-sets = <512>;
> 			d-cache-block-size = <64>;
> 			d-cache-size = <32768>;
> 			d-cache-sets = <512>;
> 			next-level-cache = <&cluster0_l2_cache>;
> ......
> 
> 		cluster0_l2_cache: l2-cache0 {
> 			compatible = "cache";
> 			cache-block-size = <64>;
> 			cache-level = <2>;
> 			cache-size = <524288>;
> 			cache-sets = <1024>;
> 			cache-unified;
> 		};
> 
I think we probably have two options, 1) including this info in next version bump
2) leave it alone, and sending via another independent patch

I do not have strong preference, but do want to confirm before adding them.

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
    we have interrrupt-parent info here

> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		dma-noncoherent;
> > +		ranges;
> > +
> > +		uart0: serial@d4017000 {
> > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > +			reg = <0x0 0xd4017000 0x0 0x100>;
> > +			interrupts = <42>;
> 
> 			interrupt-parent = <&plic>;
I think if we omit this info, then this node's interrupt parent property will
inherit from its device tree parent?

But I'm not sure if this is the right way to do from dt maintainer's
perspective? or should we specify interrupt-parent explicitly?

thanks for raising this question
> 
> Thanks,
> Jesse Taube
> 
> > +			clock-frequency = <14857000>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart2: serial@d4017100 {
> > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > +			reg = <0x0 0xd4017100 0x0 0x100>;
> > +			interrupts = <44>;
> > +			clock-frequency = <14857000>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart3: serial@d4017200 {
> > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > +			reg = <0x0 0xd4017200 0x0 0x100>;
> > +			interrupts = <45>;
> > +			clock-frequency = <14857000>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart4: serial@d4017300 {
> > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > +			reg = <0x0 0xd4017300 0x0 0x100>;
> > +			interrupts = <46>;
> > +			clock-frequency = <14857000>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart5: serial@d4017400 {
> > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > +			reg = <0x0 0xd4017400 0x0 0x100>;
> > +			interrupts = <47>;
> > +			clock-frequency = <14857000>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart6: serial@d4017500 {
> > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > +			reg = <0x0 0xd4017500 0x0 0x100>;
> > +			interrupts = <48>;
> > +			clock-frequency = <14857000>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart7: serial@d4017600 {
> > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > +			reg = <0x0 0xd4017600 0x0 0x100>;
> > +			interrupts = <49>;
> > +			clock-frequency = <14857000>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart8: serial@d4017700 {
> > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > +			reg = <0x0 0xd4017700 0x0 0x100>;
> > +			interrupts = <50>;
> > +			clock-frequency = <14857000>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart9: serial@d4017800 {
> > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > +			reg = <0x0 0xd4017800 0x0 0x100>;
> > +			interrupts = <51>;
> > +			clock-frequency = <14857000>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		plic: interrupt-controller@e0000000 {
> > +			compatible = "spacemit,k1-plic", "sifive,plic-1.0.0";
> > +			reg = <0x0 0xe0000000 0x0 0x4000000>;
> > +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
> > +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> > +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> > +					      <&cpu3_intc 11>, <&cpu3_intc 9>,
> > +					      <&cpu4_intc 11>, <&cpu4_intc 9>,
> > +					      <&cpu5_intc 11>, <&cpu5_intc 9>,
> > +					      <&cpu6_intc 11>, <&cpu6_intc 9>,
> > +					      <&cpu7_intc 11>, <&cpu7_intc 9>;
> > +			interrupt-controller;
> > +			#address-cells = <0>;
> > +			#interrupt-cells = <1>;
> > +			riscv,ndev = <159>;
> > +		};
> > +
> > +		clint: timer@e4000000 {
> > +			compatible = "spacemit,k1-clint", "sifive,clint0";
> > +			reg = <0x0 0xe4000000 0x0 0x10000>;
> > +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> > +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> > +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> > +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> > +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> > +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> > +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> > +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> > +		};
> > +	};
> > +};
> > 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
