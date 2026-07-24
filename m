Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58339021C;
	Fri, 24 Jul 2026 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876398; cv=none; b=ZQX1Et4FuRsGlTRZ71RN5JMXgQGR7s7jwI5KZVJaIEWpBPr1UttbilWbYNelbXB3vruId+etI9KpihtWj8WVwl0SiybvCwNO0p5CVg66DjBjrdN8lFaekyZaDPa1q2xdVoaD3xv220znehR/XrSAd/mUClFFPFZS9IlaSeXbDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876398; c=relaxed/simple;
	bh=fHx8pNdmwoklRN2RNxaIYqJUcmhw1LNxbFHUGbbP0eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asdgv/vyUss3aYiaXvrSWvN8p9BqE3a3DW0Td/vfKjLxNLappGU+yhDMbhwpp8zAQr03cTP9iRyh0EMfDkOt/UC+5RLa7sIT0eUsB4yw6WSWsc27SbsYmSyawlaHvBzwf7d28N6eGvqo9l40apQ+T2FsDBQjwfuKCXZdoaYmtis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ7+CdB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ7+CdB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D701F000E9;
	Fri, 24 Jul 2026 06:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784876396;
	bh=1P+YKRH7oEKm/7S1fZQeb6pspYaX4pWi3DXBCs4o13Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DJ7+CdB7cuu8RGteiJIxjlgqZPXuDupioLqiSlYx4ZdYHY34noTaS5M5zi9wOLOYf
	 laaLsbGDGPR57QjT1kJSPSo5MgRfFzsV2GA5/NJOk2TzK9ooq6GY+dEi/GkkOFBN1U
	 j44exzWbEqSabCtg2Mqa0QY/GI+DxgHZemz1LrkqWbIuaHpFmKvvlHJug7qiRHm4dE
	 eKgkpCp+tdkvAvhLl4K3Tc1umqioYmiPSF+d1p5+k1aJdY+zFZU0J1cW2K8sl45qgm
	 bV2fwbc22CzilX+kEs0tIZD8GgVSfnnAIJY/eSsfBueTg6KCi9tNwimgnIKfk+9ies
	 AvKyYzV34oBEA==
Date: Fri, 24 Jul 2026 08:59:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, 
	Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
	Brian Norris <briannorris@google.com>, William McVicker <willmcvicker@google.com>, 
	kernel-team@android.com
Subject: Re: [PATCH v2 4/5] arm64: dts: google: Add initial dts for
 frankel/blazer/mustang
Message-ID: <20260724-dancing-skunk-of-novelty-72c1b8@quoll>
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>

On Wed, Jul 22, 2026 at 10:55:55AM +0100, Peter Griffin wrote:
> diff --git a/arch/arm64/boot/dts/google/lga-pixel-common.dtsi b/arch/arm64/boot/dts/google/lga-pixel-common.dtsi
> new file mode 100644
> index 000000000000..57c318ab44c9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/google/lga-pixel-common.dtsi
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * Google Pixel 10 family common dtsi.
> + *
> + * Copyright 2024-2025 Google LLC.
> + */
> +
> +#include "lga.dtsi"
> +
> +&{/} {

This is overlay style, but the file is DTSI. Just use standard '/ {' -
that's simple and obvious enough path.

> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	aliases {
> +		serial0 = "/soc@0/serial@db62000";	/* &lsion_cli16_uart */
> +		ufs0 = "/ufs-placeholder";		/* &ufs - TODO "/soc@0/ufs@3c400000" */

UFS does not have aliases, please drop.

> +	};
> +};
> +
> +&osc {
> +	clock-frequency = <38400000>;
> +};
> diff --git a/arch/arm64/boot/dts/google/lga.dtsi b/arch/arm64/boot/dts/google/lga.dtsi
> new file mode 100644
> index 000000000000..343156a8c039
> --- /dev/null
> +++ b/arch/arm64/boot/dts/google/lga.dtsi
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * Google Tensor G5 (laguna) SoC rev B0
> + *
> + * Copyright 2024-2025 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&gic>;
> +
> +	osc: clock-38400000 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	cpus: cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		hayes_0: cpu@0 {
> +			compatible = "arm,cortex-a520";
> +			reg = <0x000>;
> +
> +			#cooling-cells = <2>;
> +			capacity-dmips-mhz = <258>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			power-domain-names = "psci";
> +			power-domains = <&cpu_pd0>;
> +		};
> +
> +		hayes_1: cpu@100 {
> +			compatible = "arm,cortex-a520";
> +			reg = <0x100>;
> +
> +			#cooling-cells = <2>;
> +			capacity-dmips-mhz = <258>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			power-domain-names = "psci";
> +			power-domains = <&cpu_pd1>;
> +		};
> +
> +		hunter_0: cpu@200 {
> +			compatible = "arm,cortex-a725";
> +			reg = <0x200>;
> +
> +			#cooling-cells = <2>;
> +			capacity-dmips-mhz = <891>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			power-domain-names = "psci";
> +			power-domains = <&cpu_pd2>;
> +		};
> +
> +		hunter_1: cpu@300 {
> +			compatible = "arm,cortex-a725";
> +			reg = <0x300>;
> +
> +			#cooling-cells = <2>;
> +			capacity-dmips-mhz = <891>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			power-domain-names = "psci";
> +			power-domains = <&cpu_pd3>;
> +		};
> +
> +		hunter_2: cpu@400 {
> +			compatible = "arm,cortex-a725";
> +			reg = <0x400>;
> +
> +			#cooling-cells = <2>;
> +			capacity-dmips-mhz = <891>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			power-domain-names = "psci";
> +			power-domains = <&cpu_pd4>;
> +		};
> +
> +		hunter_3: cpu@500 {
> +			compatible = "arm,cortex-a725";
> +			reg = <0x500>;
> +
> +			#cooling-cells = <2>;
> +			capacity-dmips-mhz = <891>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			power-domain-names = "psci";
> +			power-domains = <&cpu_pd5>;
> +		};
> +
> +		hunter_4: cpu@600 {
> +			compatible = "arm,cortex-a725";
> +			reg = <0x600>;
> +
> +			#cooling-cells = <2>;
> +			capacity-dmips-mhz = <891>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			power-domain-names = "psci";
> +			power-domains = <&cpu_pd6>;
> +		};
> +
> +		hunterelp_0: cpu@700 {
> +			compatible = "arm,cortex-x4";
> +			reg = <0x700>;
> +
> +			#cooling-cells = <2>;
> +			capacity-dmips-mhz = <1024>;
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			power-domain-names = "psci";
> +			power-domains = <&cpu_pd7>;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&hayes_0>;
> +				};
> +				core1 {
> +					cpu = <&hayes_1>;
> +				};
> +				core2 {
> +					cpu = <&hunter_0>;
> +				};
> +				core3 {
> +					cpu = <&hunter_1>;
> +				};
> +				core4 {
> +					cpu = <&hunter_2>;
> +				};
> +				core5 {
> +					cpu = <&hunter_3>;
> +				};
> +				core6 {
> +					cpu = <&hunter_4>;
> +				};
> +				core7 {
> +					cpu = <&hunterelp_0>;
> +				};
> +			};
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			cpu_lit_c2: cpu-lit-c2 {
> +				compatible = "arm,idle-state";
> +
> +				entry-latency-us = <132>;
> +				exit-latency-us = <296>;
> +				min-residency-us = <3610>;
> +
> +				idle-state-name = "cpu-lit-c2";
> +				local-timer-stop;
> +
> +				arm,psci-suspend-param = <0x40000003>;
> +			};
> +
> +			cpu_mid1_c2: cpu-mid1-c2 {
> +				compatible = "arm,idle-state";
> +
> +				entry-latency-us = <130>;
> +				exit-latency-us = <274>;
> +				min-residency-us = <2720>;
> +
> +				idle-state-name = "cpu-mid1-c2";
> +				local-timer-stop;
> +
> +				arm,psci-suspend-param = <0x40000003>;
> +			};
> +
> +			cpu_mid2_c2: cpu-mid2-c2 {
> +				compatible = "arm,idle-state";
> +
> +				entry-latency-us = <130>;
> +				exit-latency-us = <274>;
> +				min-residency-us = <2720>;
> +
> +				idle-state-name = "cpu-mid2-c2";
> +				local-timer-stop;
> +
> +				arm,psci-suspend-param = <0x40000003>;
> +			};
> +
> +			cpu_big_c2: cpu-big-c2 {
> +				compatible = "arm,idle-state";
> +
> +				entry-latency-us = <110>;
> +				exit-latency-us = <413>;
> +				min-residency-us = <3950>;
> +
> +				idle-state-name = "cpu-big-c2";
> +				local-timer-stop;
> +
> +				arm,psci-suspend-param = <0x40000003>;
> +			};
> +		};
> +
> +		domain-idle-states {
> +			cluster_1_c3: cluster-1-c3 {
> +				compatible = "domain-idle-state";
> +
> +				entry-latency-us = <325>;
> +				exit-latency-us = <553>;
> +				min-residency-us = <10000>;
> +
> +				idle-state-name = "cluster-1-c3";
> +
> +				arm,psci-suspend-param = <0x40010033>;
> +			};
> +
> +			cluster_2_c3: cluster-2-c3 {
> +				compatible = "domain-idle-state";
> +
> +				entry-latency-us = <345>;
> +				exit-latency-us = <673>;
> +				min-residency-us = <10000>;
> +
> +				idle-state-name = "cluster-2-c3";
> +
> +				arm,psci-suspend-param = <0x40010033>;
> +			};
> +
> +			cluster_c4_deep: cluster-c4-deep {
> +				compatible = "domain-idle-state";
> +
> +				entry-latency-us = <510>;
> +				exit-latency-us = <1027>;
> +				min-residency-us = <10000>;
> +
> +				idle-state-name = "cluster-c4-deep";
> +
> +				arm,psci-suspend-param = <0x40020333>;
> +			};
> +		};
> +	};
> +
> +	memory: memory@80000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0x0 0x80000000 0x0 0x0>;
> +	};

The memory node should go to the DTS (or common DTSI). It's not part of
SoC usually.

Also, add short comment why do you need label. It will cause
dt-style-check warning.


> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +
> +		cpu_pd0: power-domain-cpu0 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&cpu_lit_c2>;
> +			power-domains = <&cpu_top_cl>;
> +		};
> +
> +		cpu_pd1: power-domain-cpu1 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states =  <&cpu_lit_c2>;
> +			power-domains = <&cpu_top_cl>;
> +		};
> +
> +		cpu_pd2: power-domain-cpu2 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states =  <&cpu_mid1_c2>;
> +			power-domains = <&cpucl1>;
> +		};
> +
> +		cpu_pd3: power-domain-cpu3 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states =  <&cpu_mid1_c2>;
> +			power-domains = <&cpucl1>;
> +		};
> +
> +		cpu_pd4: power-domain-cpu4 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states =  <&cpu_mid1_c2>;
> +			power-domains = <&cpucl1>;
> +		};
> +
> +		cpu_pd5: power-domain-cpu5 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states =  <&cpu_mid2_c2>;
> +			power-domains = <&cpucl2>;
> +		};
> +
> +		cpu_pd6: power-domain-cpu6 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states =  <&cpu_mid2_c2>;
> +			power-domains = <&cpucl2>;
> +		};
> +
> +		cpu_pd7: power-domain-cpu7 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states =  <&cpu_big_c2>;
> +			power-domains = <&cpucl2>;
> +		};
> +
> +		cpucl1: power-domain-cluster-1 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&cluster_1_c3>;
> +			power-domains = <&cpu_top_cl>;
> +		};
> +
> +		cpucl2: power-domain-cluster-2 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&cluster_2_c3>;
> +			power-domains = <&cpu_top_cl>;
> +		};
> +
> +		cpu_top_cl: power-domain-top-cluster {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&cluster_c4_deep>;
> +		};
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/*
> +		 * Store ramoops at a known location in DRAM, for access by the ABL
> +		 * following a crash-reset.
> +		 */
> +		ramoops@95200000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0x95200000 0x0 0x400000>;
> +			console-size = <0x200000>;
> +			pmsg-size = <0x200000>;
> +		};
> +
> +		/* bootloader logs */
> +		bldr_log_reserved: bldr-log-reserved@95600000 {
> +			reg = <0x0 0x95600000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		/* gsa logs */
> +		gsa_reserved_log: gsa-reserved-log@a61b0000 {
> +			reg = <0x0 0xa61b0000 0x0 0x00004000>;
> +			no-map;
> +		};
> +
> +		/* Android BootLoader (ABL) for ramdump/coredump processing */
> +		abl@be000000 {
> +			reg = <0x0 0xbe000000 0x0 0x1000000>;
> +			no-map;
> +		};
> +	};
> +
> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		ranges = <0 0 0 0 0x10 0>;
> +
> +		dma-ranges = <0 0 0 0 0x10 0>;
> +
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		gic: interrupt-controller@5880000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0 0x05880000 0 0x10000>,
> +			      <0 0x05900000 0 0x200000>;

In some other places you use hex everywhere, also for '0' (so '0x0').
Switch to consistent 0x0 everywhere for new code.

> +			ranges;

Why ranges? There is no MSI child node with unit address.

> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +
> +			#interrupt-cells = <4>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> +
> +			ppi-partitions {
> +				ppi_cluster0: interrupt-partition-0 {
> +					affinity = <&hayes_0 &hayes_1
> +						    &hunter_0 &hunter_1 &hunter_2
> +						    &hunter_3 &hunter_4>;
> +				};
> +
> +				ppi_cluster1: interrupt-partition-1 {
> +					affinity = <&hunterelp_0>;
> +				};
> +			};
> +		};
> +
> +		lsion_cli16_uart: serial@db62000 {
> +			compatible = "google,lga-uart", "snps,dw-apb-uart";
> +			reg = <0 0x0db62000 0 0x100>;
> +
> +			clock-frequency = <200000000>;
> +			interrupts = <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH 0>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +
> +			status = "disabled";
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts =
> +			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,

Join line:

interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,

even if it goes beyond 80 char limit. That's fine, exceptions are
allowed and one line makes 'greps' or 'seds' easier.

> +			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,
> +			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,
> +			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>;
> +	};
> +
> +	/*
> +	 * The Pixel bootloader considers it a fatal error if it doesn't find
> +	 * a `ufs0` alias so it can add calibration data to the node. Until

Fake node is ok, but alias won't fly because aliases are not allowed for
ufs. Well, would work 10 years ago, but this is a device from ~2025 (so
SoC maybe a bit earlier), thus Google already knew that they MUST talk
with upstream open source maintainers before they ship such ABI.

They did not talk, so you reap what you sow.

There is no more excuse for a vendor to ignore open source and push
whatever-ABI-they-wish into their product, if they ever want to upstream
that product.

I know it is not your fault, obviously. And I know that not much you can
do, so that is not rant towards you nor towards Doug.

You will have to keep this part of patch out of tree or fix the Pixel
bootloader.

> +	 * the proper UFS controller node is added under the SoC, create a
> +	 * temporary node to make the bootloader happy.
> +	 */
> +	ufs: ufs-placeholder {
> +	};

Best regards,
Krzysztof

