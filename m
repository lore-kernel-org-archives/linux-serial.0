Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A113791C;
	Fri,  5 Jul 2024 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161527; cv=none; b=fU1JW+0sWXVHS3HLNHBaKSCu00aMyRP1tdMSi3GrKLGfcDL9/dD7I9ZsYFk9U07jVgBjq1cZLVAB1mkAZ5qLP5XyM784OtRBiXeTL1wgXK5u7pGBGE9YZ0QHX2HCmxxO/3TkvkDpAzr98NfZ1oVPufT5TNvV3LCDIrwNFxFLrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161527; c=relaxed/simple;
	bh=kdH8halGy+gunnKXeuUui3NGUp2HJvl+znuYTEqUXFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isE3ZeKtcIT80L7T49gSukuvfHwu/bGs9Bd+tr7JDX73zv62I29c4nKtqOYwnuhxiSOKFFwijU6NcUhwZAtqKiJ9ruKCS6bdbQoFUmzoTs4jdqCr88tCzCQVC7fFKln7tWhdMFCEa4ZSVbS/snBZd4KnpPWXIERfhMTKmnOu4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 5 Jul 2024 06:38:39 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Jisheng Zhang <jszhang@kernel.org>
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
Message-ID: <20240705063839.GA3042186@ofsar>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-8-12f73b47461e@gentoo.org>
 <Zoanxksn0nio4MPg@xhacker>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoanxksn0nio4MPg@xhacker>


On 21:46 Thu 04 Jul     , Jisheng Zhang wrote:
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
> no, this is not a correct hw modeling. The doc on spacemit says
> all the uart support 64 bytes FIFO, declaring xscale only makes
> use of 32 bytes FIFO.
yes, I also noticed it's 64 bytes FIFO

> 
> IIRC, 8250_pxa is a xscale uart with 64 bytes FIFO, so this should be
> "mrvl,pxa-uart" or "mrvl,mmp-uart"


for mrvl,pxa-uart, I think you imply to use drivers/tty/serial/8250/8250_pxa.c,
which turn out doesn't work on k1 SoC, for the record, we need to adjust
 drivers/tty/serial/8250/Kconfig to enable the driver for ARCH_SPACEMIT,
 and change uart compatible to "spacemit,k1-uart", "mrvl,pxa-uart"

for mrvl,mmp-uart, I see two choices, one using 8250_pxa.c which has same result
as mrvl,pxa-uart, another choice would using the driver of 8250_of.c 
and it work as same as "intel,xscale-uart", I don't see any difference..

P.S: there is possibly a side problem that "mrvl,mmp-uart" from 8250_of.c doesn't 
really compatile with "mrvl,mmp-uart" from 8250_pxa.c, but I think it's another story

> 
> > +			reg = <0x0 0xd4017000 0x0 0x100>;
> > +			interrupts = <42>;
> > +			clock-frequency = <14857000>;
> 
> once clk is ready, you will remove this property and add clk phandles,
yes, this is exactly the plan

> so why not bring clk, pinctrl, reset before hand?
> 
No, we want to have an initial minimal working environment with initramfs + console,
and start from there to work with clk, pinctrl, reset, it will help us to debug and 
work in parallel

Note, I have no objection, if maintainer consider to merge this patch series on condition that
clk, pinctrl, reset are also ready..


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
> > -- 
> > 2.45.2
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
