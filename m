Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6DB2144BF;
	Thu,  8 May 2025 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692142; cv=none; b=orwChVcg5lP+7DHKL9ffZFHiH/RKl0ECAiMLLgJy0OdU6d7UCIM1zwIPV0Xco7uBQnUIqyIs/45uF2ZWzgvQOWZWmjW05YY5ChMJYPgHn9RpzlzLM6XfVm33iQoWzqcWWhP77yjk4Bi2ptP/wls0x/2u4WCtGZLlh52FukPX54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692142; c=relaxed/simple;
	bh=lidTZ6yjuirDe4XS/TIVOyFXAWFcpUtoazDqf8uMVKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBPe4R2e1UmSuZRv92Qd221Sp1vnLewNaBAp/YYgYlISTMgyOwFkUxFDsGUcltRASQeKmJGSL4KfPZSPZRL37mJzcTozVZnU4cNBOn+4Ot4nk/jjxhPrKVPVqCR/V8tWsAht7tQVCShVJxPgoRuhI8WHYfM2ulmVzwvGB5qxF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OAM0Dqog; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OAM0Dqog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746692138;
	bh=lidTZ6yjuirDe4XS/TIVOyFXAWFcpUtoazDqf8uMVKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OAM0Dqog6E3cB9oB1/2eFKJkqWDJCs2Vhv5NTciopLc5Obf6y1oaVnp4Wx8IpRfYu
	 nymrwM37KVZnLNNu6ytXViKnRlvpbAp5GpsuGlR9azu5+b9AwLfWDyB/oNC0FpjanF
	 P4T+dnHQV8aLra6Q2Rti7sQqXF4z/RQYMIHrxal6VLJ/pU2Jnh1JFMyRafz+xgHBNZ
	 /oRH0f60y6QsmcxLmxt/PrqREJOjv3Pe7WMYg/4SVd5M65uEsUOoikgs3KN+S2mPEU
	 At2mJqucAk77LrIohY4BrNuaqs4vqbQBf5+ospreTpgjpXc9nPc/m0Z/q9lzeg31j8
	 j0yaFtYL8qcJA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6D82417E0E8E;
	Thu,  8 May 2025 10:15:37 +0200 (CEST)
Message-ID: <7abf1685-0dee-4ef4-8e8c-bc01509ed3e3@collabora.com>
Date: Thu, 8 May 2025 10:15:36 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: mt8189: Add mt8189 dts evaluation
 board and Mafefile
To: Sirius Wang <sirius.wang@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sean Wang <sean.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wenst@chromium.org,
 xavier.chang@mediatek.com
References: <20250508063546.289115-1-sirius.wang@mediatek.com>
 <20250508063546.289115-4-sirius.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250508063546.289115-4-sirius.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/05/25 08:35, Sirius Wang ha scritto:
> Add mt8189 dts evaluation board and Mafefile
> 
> Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8189-evb.dts |  20 +
>   arch/arm64/boot/dts/mediatek/mt8189.dtsi    | 430 ++++++++++++++++++++
>   3 files changed, 451 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8189.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 3aa06476c6c0..ad2ac9e1bb79 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -87,6 +87,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku4.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku5.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku6.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku7.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8189-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8189-evb.dts b/arch/arm64/boot/dts/mediatek/mt8189-evb.dts
> new file mode 100644
> index 000000000000..e5d9ce1b8e61
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8189-evb.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2025 MediaTek Inc.
> + * Author: Sirius Wang <sirius.wang@mediatek.com>
> + */
> +/dts-v1/;
> +#include "mt8189.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8189 evaluation board";
> +	compatible = "mediatek,mt8189-evb", "mediatek,mt8189";
> +
> +	chosen: chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8189.dtsi b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
> new file mode 100644
> index 000000000000..50c7a3811e0f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
> @@ -0,0 +1,430 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "mediatek,mt8189";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	clk32k: oscillator-clk32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32000>;
> +		clock-output-names = "clk32k";
> +	};
> +
> +	clk13m: oscillator-clk13m {
> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clocks = <&clk26m>;
> +		clock-mult = <1>;
> +		clock-div = <2>;
> +		clock-output-names = "clk13m";
> +	};
> +
> +	clk26m: oscillator-clk26m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "clk26m";
> +	};
> +
> +	clk104m: oscillator-clk104m {
> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clocks = <&clk26m>;
> +		clock-mult = <4>;
> +		clock-div = <1>;
> +		clock-output-names = "clk104m";
> +	};

ulposc and ulposc3 go here.

> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <742>;
> +			cpu-idle-states = <&cpu_off_l>, <&cpu_cluster_off_l>, <&cpu_mcusys_off_l>,
> +					  <&cpu_system_vcore>, <&cpu_s2idle>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <742>;
> +			cpu-idle-states = <&cpu_off_l>, <&cpu_cluster_off_l>, <&cpu_mcusys_off_l>,
> +					  <&cpu_system_vcore>, <&cpu_s2idle>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <742>;
> +			cpu-idle-states = <&cpu_off_l>, <&cpu_cluster_off_l>, <&cpu_mcusys_off_l>,
> +					  <&cpu_system_vcore>, <&cpu_s2idle>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <742>;
> +			cpu-idle-states = <&cpu_off_l>, <&cpu_cluster_off_l>, <&cpu_mcusys_off_l>,
> +					  <&cpu_system_vcore>, <&cpu_s2idle>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x400>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <742>;
> +			cpu-idle-states = <&cpu_off_l>, <&cpu_cluster_off_l>, <&cpu_mcusys_off_l>,
> +					  <&cpu_system_vcore>, <&cpu_s2idle>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x500>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <742>;
> +			cpu-idle-states = <&cpu_off_l>, <&cpu_cluster_off_l>, <&cpu_mcusys_off_l>,
> +					  <&cpu_system_vcore>, <&cpu_s2idle>;
> +			i-cache-size = <32768>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78";
> +			reg = <0x600>;
> +			enable-method = "psci";
> +			clock-frequency = <3000000000>;
> +			capacity-dmips-mhz = <958>;
> +			cpu-idle-states = <&cpu_off_m>, <&cpu_cluster_off_m>, <&cpu_mcusys_off_m>,
> +					  <&cpu_system_vcore>, <&cpu_s2idle>;
> +			i-cache-size = <65536>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <65536>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_1>;
> +			performance-domains = <&performance 1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78";
> +			reg = <0x700>;
> +			enable-method = "psci";
> +			clock-frequency = <3000000000>;
> +			capacity-dmips-mhz = <958>;
> +			cpu-idle-states = <&cpu_off_m>, <&cpu_cluster_off_m>, <&cpu_mcusys_off_m>,
> +					  <&cpu_system_vcore>, <&cpu_s2idle>;
> +			i-cache-size = <65536>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <65536>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2_1>;
> +			performance-domains = <&performance 1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +				core4 {
> +					cpu = <&cpu4>;
> +				};
> +				core5 {
> +					cpu = <&cpu5>;
> +				};
> +			};
> +
> +			cluster1 {

Is this really an old-style dual cluster SoC, or is this ARM DynamIQ?

If this is the latter (and I believe it is), this SoC features a "single, fully
integrated cluster".


> +				core0 {
> +					cpu = <&cpu6>;
> +				};
> +				core1 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			cpu_off_l: cpu-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010000>;
> +				local-timer-stop;
> +				entry-latency-us = <97>;
> +				exit-latency-us = <252>;
> +				min-residency-us = <6710>;
> +			};
> +
> +			cpu_off_m: cpu-off-m {

what does "m" stand for?

should this be cpu-off-b (where b==big and l==little) instead?

> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010000>;
> +				local-timer-stop;
> +				entry-latency-us = <53>;
> +				exit-latency-us = <143>;
> +				min-residency-us = <2120>;
> +			};
> +
> +			cpu_cluster_off_l: cpu-cluster-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010001>;
> +				local-timer-stop;
> +				entry-latency-us = <109>;
> +				exit-latency-us = <325>;
> +				min-residency-us = <6710>;
> +			};
> +
> +			cpu_cluster_off_m: cpu-cluster-off-m {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010001>;
> +				local-timer-stop;
> +				entry-latency-us = <59>;
> +				exit-latency-us = <188>;
> +				min-residency-us = <2120>;
> +			};
> +
> +			cpu_mcusys_off_l: cpu-mcusys-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x02010007>;
> +				local-timer-stop;
> +				entry-latency-us = <1357>;
> +				exit-latency-us = <835>;
> +				min-residency-us = <6710>;
> +			};
> +
> +			cpu_mcusys_off_m: cpu-mcusys-off-m {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x02010007>;
> +				local-timer-stop;
> +				entry-latency-us = <1202>;
> +				exit-latency-us = <679>;
> +				min-residency-us = <2120>;
> +			};
> +
> +			cpu_system_vcore: cpu-system-vcore {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x020100ff>;
> +				local-timer-stop;
> +				entry-latency-us = <940>;
> +				exit-latency-us = <3500>;
> +				min-residency-us = <35200>;
> +			};
> +
> +			cpu_s2idle: cpu-s2idle {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x020180ff>;
> +				local-timer-stop;
> +				entry-latency-us = <10000>;
> +				exit-latency-us = <10000>;
> +				min-residency-us = <4294967295>;
> +			};
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-size = <131072>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			next-level-cache = <&l3_0>;
> +			cache-unified;
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-size = <262144>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			next-level-cache = <&l3_0>;
> +			cache-unified;
> +		};
> +
> +		l3_0: l3-cache {
> +			compatible = "cache";
> +			cache-level = <3>;
> +			cache-size = <1048576>;
> +			cache-line-size = <64>;
> +			cache-sets = <2048>;
> +			cache-unified;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	memory: memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0xC0000000>;
> +	};
> +

psci goes here

Regards,
Angelo

> +	timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
> +
> +		performance: performance-controller@11bc10 {
> +			compatible = "mediatek,cpufreq-hw";
> +			reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
> +			#performance-domain-cells = <1>;
> +		};
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <4>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0xc000000 0 0x40000>, /* distributor */
> +			      <0 0xc040000 0 0x200000>; /* redistributor */
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> +
> +			ppi-partitions {
> +				ppi_cluster0: interrupt-partition-0 {
> +					affinity = <&cpu0 &cpu1 &cpu2 &cpu3 &cpu4 &cpu5>;
> +				};
> +
> +				ppi_cluster1: interrupt-partition-1 {
> +					affinity = <&cpu6 &cpu7>;
> +				};
> +			};
> +		};
> +
> +		uart0: serial@11001000 {
> +			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
> +			reg = <0 0x11001000 0 0x1000>;
> +			interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&clk26m>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +	};
> +
> +	ulposc: oscillator-ulposc {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <520000000>;
> +		clock-output-names = "ulposc";
> +	};
> +
> +	ulposc3: oscillator-ulposc3 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "ulposc3";
> +	};
> +};


