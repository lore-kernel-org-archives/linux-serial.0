Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3086631;
	Mon,  5 Aug 2024 05:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722835002; cv=none; b=cUtiNYYdeWykfYru4kqBN6/Oyi1QhcllV0UrIoDbwwUllvPLIJmW+AlAILSAHo45GqmcTfr3iWB7sUaq1nW7an6lb9kd1zxHhBgJIU7dspCLEkBGHLfP5ASR2VJmFJcMYfwY937iMoTTO3ilYex00dpNQi+sPAA2vWDejfQW+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722835002; c=relaxed/simple;
	bh=m3gU1OlTZ8095LDUuHrD0vdOwEUtiIdxYNOczF0Rm1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECy35LquP2JZaivb81E8FaMpkaENT2gFPjMp5Iy0c97pmpuUK1O/I+DsXGYK7sVv19GMPgCij5Fbn+Hae0eUXWPhZs1n6Oi8/qt+RF7AlWahVL9RiezWJWIdTMe3kitXlnHzStiwoo1GsQTCt0BaxdALy6rJpMujllXQ0+zOdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZSj1jTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZSj1jTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51298C32782;
	Mon,  5 Aug 2024 05:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722835002;
	bh=m3gU1OlTZ8095LDUuHrD0vdOwEUtiIdxYNOczF0Rm1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iZSj1jTcCpX4fW/UukuFfXOZRKhombezWVZMsrA6BVpUEemHRdUGAFRJRhjpRZMT8
	 PC0i352AXbG0C+2rtvmcwuuMrUq0YwvRH/0UDCodzxSFx4bEvBXDnHpxiFEhZWa4av
	 OBW5dFugr27f7s9kuBCVQ8jKs9Kvs56rywrgVCXAq8MR2GBZfvlgN1SqLhuZ8gPGG6
	 sS0CPZZvOak27w2kCT2/Pl4fZAYOts3zY3WcYL9ojKQGsgLcEiMRMElODGW5Hs6FKk
	 IYl8VP3Q7QuNUEWO8eDhR2bAWRH8K7px+C0XGOCBYqa224jgFMkmUjN/B6hBCNHEXA
	 dFUtVuMDmUaVQ==
Message-ID: <6fe0d3de-3885-43dd-97f3-b181ef1386d5@kernel.org>
Date: Mon, 5 Aug 2024 07:16:35 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Dragan Simic <dsimic@manjaro.org>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
 Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman <megi@xff.cz>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20240803125510.4699-2-ziyao@disroot.org>
 <2408413.9XhxPE3A7Q@diego> <81147f0205c2a9555c9c64e4f7a69b6b@manjaro.org>
 <10256980.nnTZe4vzsl@diego>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <10256980.nnTZe4vzsl@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/08/2024 17:51, Heiko Stübner wrote:
> Am Sonntag, 4. August 2024, 15:59:19 CEST schrieb Dragan Simic:
>> On 2024-08-04 15:44, Heiko Stübner wrote:
>>> Am Sonntag, 4. August 2024, 15:25:47 CEST schrieb Dragan Simic:
>>>> On 2024-08-04 15:20, Yao Zi wrote:
>>>>> On Sun, Aug 04, 2024 at 12:05:11PM +0200, Krzysztof Kozlowski wrote:
>>>>>> On 03/08/2024 14:55, Yao Zi wrote:
>>>>>>> This initial device tree describes CPU, interrupts and UART on the chip
>>>>>>> and is able to boot into basic kernel with only UART. Cache information
>>>>>>> is omitted for now as there is no precise documentation. Support for
>>>>>>> other features will be added later.
>>>>>>>
>>>>>>> Signed-off-by: Yao Zi <ziyao@disroot.org>
>>>>>>> ---
>>>>>>>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 182 +++++++++++++++++++++++
>>>>>>>  1 file changed, 182 insertions(+)
>>>>>>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..77687d9e7e80
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>>>>>> @@ -0,0 +1,182 @@
>>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
>>>>>>> + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>>>>>> +
>>>>>>> +/ {
>>>>>>> +	compatible = "rockchip,rk3528";
>>>>>>> +
>>>>>>> +	interrupt-parent = <&gic>;
>>>>>>> +	#address-cells = <2>;
>>>>>>> +	#size-cells = <2>;
>>>>>>> +
>>>>>>> +	aliases {
>>>>>>> +		serial0 = &uart0;
>>>>>>> +		serial1 = &uart1;
>>>>>>> +		serial2 = &uart2;
>>>>>>> +		serial3 = &uart3;
>>>>>>> +		serial4 = &uart4;
>>>>>>> +		serial5 = &uart5;
>>>>>>> +		serial6 = &uart6;
>>>>>>> +		serial7 = &uart7;
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	cpus {
>>>>>>> +		#address-cells = <1>;
>>>>>>> +		#size-cells = <0>;
>>>>>>> +
>>>>>>> +		cpu-map {
>>>>>>> +			cluster0 {
>>>>>>> +				core0 {
>>>>>>> +					cpu = <&cpu0>;
>>>>>>> +				};
>>>>>>> +				core1 {
>>>>>>> +					cpu = <&cpu1>;
>>>>>>> +				};
>>>>>>> +				core2 {
>>>>>>> +					cpu = <&cpu2>;
>>>>>>> +				};
>>>>>>> +				core3 {
>>>>>>> +					cpu = <&cpu3>;
>>>>>>> +				};
>>>>>>> +			};
>>>>>>> +		};
>>>>>>> +
>>>>>>> +		cpu0: cpu@0 {
>>>>>>> +			device_type = "cpu";
>>>>>>> +			compatible = "arm,cortex-a53";
>>>>>>> +			reg = <0x0>;
>>>>>>> +			enable-method = "psci";
>>>>>>> +		};
>>>>>>> +
>>>>>>> +		cpu1: cpu@1 {
>>>>>>> +			device_type = "cpu";
>>>>>>> +			compatible = "arm,cortex-a53";
>>>>>>> +			reg = <0x1>;
>>>>>>> +			enable-method = "psci";
>>>>>>> +		};
>>>>>>> +
>>>>>>> +		cpu2: cpu@2 {
>>>>>>> +			device_type = "cpu";
>>>>>>> +			compatible = "arm,cortex-a53";
>>>>>>> +			reg = <0x2>;
>>>>>>> +			enable-method = "psci";
>>>>>>> +		};
>>>>>>> +
>>>>>>> +		cpu3: cpu@3 {
>>>>>>> +			device_type = "cpu";
>>>>>>> +			compatible = "arm,cortex-a53";
>>>>>>> +			reg = <0x3>;
>>>>>>> +			enable-method = "psci";
>>>>>>> +		};
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	psci {
>>>>>>> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
>>>>>>> +		method = "smc";
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	timer {
>>>>>>> +		compatible = "arm,armv8-timer";
>>>>>>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>>>>>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>>>>>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>>>>>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	xin24m: xin24m {
>>>>>>
>>>>>> Please use name for all fixed clocks which matches current format
>>>>>> recommendation: 'clock-([0-9]+|[a-z0-9-]+)+'
>>>>>
>>>>> Will be fixed in next revision.
>>>>
>>>> Hmm, why should we apply that rule to the xin24m clock, which is
>>>> named exactly like that everywhere else in Rockchip SoC dtsi files?
>>>> It's much better to remain consistent.
>>>
>>> bindings or how we write devicetrees evolve over time ... similarly the
>>> xin24m name comes from more than 10 years ago.
>>>
>>> We also name all those regulator nodes regulator-foo now, which in turn
>>> automatically does enforce a nice sorting rule to keep all the 
>>> regulators
>>> around the same area ;-)
>>>
>>> So I don't see a problem of going with xin24m: clock-xin24m {}
>>
>> I agree that using "clock-xin24m" makes more sense in general, but the
>> trouble is that we can't rename the already existing instances of 
>> "xin24m",
>> because that has become part of the ABI.  Thus, I'm not sure that 
>> breaking
>> away from the legacy brings benefits in this particular case.
> 
> In the regulator case, we have _new_ boards using the new _node_-names
> but I don't see any renaming of old boards and also don't think we should.
> 
> But that still does not keep us from using the nicer naming convention in
> new boards ;-) .
> 
> 
> Same with xin24m. We're talking only about the node-name here. The
> phandle stays the same and also the actual clock name stays the same and
> really only the actual node name you need to look for in /proc/device-tree
> changes ;-) .
> 
> So I don't see the need to go about changing all the old socs, but new
> additions should use improved naming conventions.
> 
> xin24m: clock-xin24m {
> 	compatible = "fixed-clock";
> 	#clock-cells = <0>;
> 	clock-frequency = <24000000>;
> 	clock-output-names = "xin24m";

Just to make it clear - doc clearly says the preferred name is:
"clock-frequency".

Best regards,
Krzysztof

