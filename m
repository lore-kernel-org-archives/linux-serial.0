Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECDA61FC5;
	Sun,  4 Aug 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722779965; cv=none; b=qaVr/vivB2cuDEK0DCtWBMMNo5ueYb3qQQBrfCjxnPIQ5KNYFX/XDW4xw7zoeyA2zvL8DKfgbsU/gIV1x+eWUwXxG+la8VgIgeL8S0JjURTxOX+tkNpzL+gTtfaf8qbQS2DGaK7kEg2ND8+2KFcquQCDEErgHdhBNa0BRGF9vCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722779965; c=relaxed/simple;
	bh=CzZVRvKkwnduhr0NmLRfGJG0MZf1gDyLhDc0o7kewuI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nEvpmEq3Z8ifMLj872yQMsI5Ppsp4SMrydOzgpQZWtKIyIepa9Et6IjHu9T8++jA1uiSXyPeVDfTLfplXOm3aAIkowL6XxdpSebLKptxpCSEjOAU0St56hvPey71y+VvecO4xCMIguOndy2ZoQc3ZYuoIElNthjNUhXUVYYBEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vgQ+2HYZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vgQ+2HYZ"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722779960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDVqqHMfaEEHTE2gaEMvlP1sQ1gDIa9tG2Se9OHSLL8=;
	b=vgQ+2HYZKDw4h1vlBLtCMPbZ4yaTxEJdh60Kdl3VWWnjnoL5vUCaK/zb6VrebWIG9+GYeo
	aFAS1Bv5KMFQqf2eHeAo+ZFYCGrJjNUVn8pBlUiIzRjLX1Vyt914QjzkMfJk0FMeWBlIb9
	212lI9iLb7DKhRTVeBnYgr1yowupkX6eiIP8yW/qjIfO4smuid9SBp367nrPyy1/Pu6B5T
	3W0JRaaH1KtfT8g5Qz+Kkj7dUosQdDlXWs4eKbWgkSbAwvY6yyqd1A4E2218GNpe/Ve3Lu
	zOPwvmTedWvTO9D2LKX3RzbT/uYnh/PnIE3GXLLR1lKc/DKhzFChKzo82CjygQ==
Date: Sun, 04 Aug 2024 15:59:19 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Tim Lunn
 <tim@feathertop.org>, Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin
 <efectn@protonmail.com>, Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman
 <megi@xff.cz>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
In-Reply-To: <2408413.9XhxPE3A7Q@diego>
References: <20240803125510.4699-2-ziyao@disroot.org>
 <Zq-AFWYaqu7zGuz-@ziyaolaptop.my.domain>
 <88dd5910904c03280f37ca0051f5de4e@manjaro.org> <2408413.9XhxPE3A7Q@diego>
Message-ID: <81147f0205c2a9555c9c64e4f7a69b6b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-04 15:44, Heiko Stübner wrote:
> Am Sonntag, 4. August 2024, 15:25:47 CEST schrieb Dragan Simic:
>> On 2024-08-04 15:20, Yao Zi wrote:
>> > On Sun, Aug 04, 2024 at 12:05:11PM +0200, Krzysztof Kozlowski wrote:
>> >> On 03/08/2024 14:55, Yao Zi wrote:
>> >> > This initial device tree describes CPU, interrupts and UART on the chip
>> >> > and is able to boot into basic kernel with only UART. Cache information
>> >> > is omitted for now as there is no precise documentation. Support for
>> >> > other features will be added later.
>> >> >
>> >> > Signed-off-by: Yao Zi <ziyao@disroot.org>
>> >> > ---
>> >> >  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 182 +++++++++++++++++++++++
>> >> >  1 file changed, 182 insertions(+)
>> >> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> >> >
>> >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> >> > new file mode 100644
>> >> > index 000000000000..77687d9e7e80
>> >> > --- /dev/null
>> >> > +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> >> > @@ -0,0 +1,182 @@
>> >> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> >> > +/*
>> >> > + * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
>> >> > + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
>> >> > + */
>> >> > +
>> >> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> >> > +#include <dt-bindings/interrupt-controller/irq.h>
>> >> > +
>> >> > +/ {
>> >> > +	compatible = "rockchip,rk3528";
>> >> > +
>> >> > +	interrupt-parent = <&gic>;
>> >> > +	#address-cells = <2>;
>> >> > +	#size-cells = <2>;
>> >> > +
>> >> > +	aliases {
>> >> > +		serial0 = &uart0;
>> >> > +		serial1 = &uart1;
>> >> > +		serial2 = &uart2;
>> >> > +		serial3 = &uart3;
>> >> > +		serial4 = &uart4;
>> >> > +		serial5 = &uart5;
>> >> > +		serial6 = &uart6;
>> >> > +		serial7 = &uart7;
>> >> > +	};
>> >> > +
>> >> > +	cpus {
>> >> > +		#address-cells = <1>;
>> >> > +		#size-cells = <0>;
>> >> > +
>> >> > +		cpu-map {
>> >> > +			cluster0 {
>> >> > +				core0 {
>> >> > +					cpu = <&cpu0>;
>> >> > +				};
>> >> > +				core1 {
>> >> > +					cpu = <&cpu1>;
>> >> > +				};
>> >> > +				core2 {
>> >> > +					cpu = <&cpu2>;
>> >> > +				};
>> >> > +				core3 {
>> >> > +					cpu = <&cpu3>;
>> >> > +				};
>> >> > +			};
>> >> > +		};
>> >> > +
>> >> > +		cpu0: cpu@0 {
>> >> > +			device_type = "cpu";
>> >> > +			compatible = "arm,cortex-a53";
>> >> > +			reg = <0x0>;
>> >> > +			enable-method = "psci";
>> >> > +		};
>> >> > +
>> >> > +		cpu1: cpu@1 {
>> >> > +			device_type = "cpu";
>> >> > +			compatible = "arm,cortex-a53";
>> >> > +			reg = <0x1>;
>> >> > +			enable-method = "psci";
>> >> > +		};
>> >> > +
>> >> > +		cpu2: cpu@2 {
>> >> > +			device_type = "cpu";
>> >> > +			compatible = "arm,cortex-a53";
>> >> > +			reg = <0x2>;
>> >> > +			enable-method = "psci";
>> >> > +		};
>> >> > +
>> >> > +		cpu3: cpu@3 {
>> >> > +			device_type = "cpu";
>> >> > +			compatible = "arm,cortex-a53";
>> >> > +			reg = <0x3>;
>> >> > +			enable-method = "psci";
>> >> > +		};
>> >> > +	};
>> >> > +
>> >> > +	psci {
>> >> > +		compatible = "arm,psci-1.0", "arm,psci-0.2";
>> >> > +		method = "smc";
>> >> > +	};
>> >> > +
>> >> > +	timer {
>> >> > +		compatible = "arm,armv8-timer";
>> >> > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> >> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> >> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> >> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> >> > +	};
>> >> > +
>> >> > +	xin24m: xin24m {
>> >>
>> >> Please use name for all fixed clocks which matches current format
>> >> recommendation: 'clock-([0-9]+|[a-z0-9-]+)+'
>> >
>> > Will be fixed in next revision.
>> 
>> Hmm, why should we apply that rule to the xin24m clock, which is
>> named exactly like that everywhere else in Rockchip SoC dtsi files?
>> It's much better to remain consistent.
> 
> bindings or how we write devicetrees evolve over time ... similarly the
> xin24m name comes from more than 10 years ago.
> 
> We also name all those regulator nodes regulator-foo now, which in turn
> automatically does enforce a nice sorting rule to keep all the 
> regulators
> around the same area ;-)
> 
> So I don't see a problem of going with xin24m: clock-xin24m {}

I agree that using "clock-xin24m" makes more sense in general, but the
trouble is that we can't rename the already existing instances of 
"xin24m",
because that has become part of the ABI.  Thus, I'm not sure that 
breaking
away from the legacy brings benefits in this particular case.

>> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=v6.11-rc1
>> >>
>> >> > +		compatible = "fixed-clock";
>> >> > +		#clock-cells = <0>;
>> >> > +		clock-frequency = <24000000>;
>> >> > +		clock-output-names = "xin24m";
>> >> > +	};
>> >> > +
>> >> > +	gic: interrupt-controller@fed01000 {
>> >>
>> >> Why this all is outside of SoC?
>> >
>> > Just as Heiko says, device tree for all other Rockchip SoCs don't have
>> > a "soc" node. I didn't know why before but just follow the style.
>> >
>> > If you prefer add a soc node, I am willing to.
>> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
