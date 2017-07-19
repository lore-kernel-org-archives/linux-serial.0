From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: Add Mediatek SoC MT2712 and evaluation
 board dts and Makefile
Date: Wed, 19 Jul 2017 11:26:30 +0200
Message-ID: <a470dfc9-71a4-6574-f342-fbd8d60aafce@gmail.com>
References: <1498123975-9748-1-git-send-email-yt.shen@mediatek.com>
 <1498123975-9748-3-git-send-email-yt.shen@mediatek.com>
 <ddfb5e58-520f-1ef5-2351-d7545e17a429@gmail.com>
 <1500446884.14021.12.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500446884.14021.12.camel@mtksdaap41>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YT Shen <yt.shen@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mars Cheng <mars.cheng@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-serial@vger.kernel.org



On 07/19/2017 08:48 AM, YT Shen wrote:
> On Tue, 2017-07-18 at 18:29 +0200, Matthias Brugger wrote:
>>
>> On 06/22/2017 11:32 AM, YT Shen wrote:
>>> This adds basic chip support for Mediatek 2712

[...]

>>> +
>>> +	uart_clk: dummy26m {
>>> +		compatible = "fixed-clock";
>>> +		clock-frequency = <26000000>;
>>> +		#clock-cells = <0>;
>>> +	};
>>> +

[...]

>>> +
>>> +	soc {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		compatible = "simple-bus";
>>> +		ranges;
>>> +
>>> +		uart5: serial@1000f000 {
>>> +			compatible = "mediatek,mt2712-uart",
>>> +				     "mediatek,mt6577-uart";
>>> +			reg = <0 0x1000f000 0 0x400>;
>>> +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
>>> +			clocks = <&uart_clk>, <&uart_clk>;
>>> +			clock-names = "baud", "bus";
>>> +			status = "disabled";
>>> +		};
>>
>> So baud and bus clock are both 26 MHz?
> We didn't have CCF clock support in this series.
> After we have clock source support, we could use the correct clocks to
> the UARTs and drop the 26MHz fixed rate UART clock.
> 
> The bus clock is 26MHz.  The baud clock could be from another clock
> source, using the same 26MHz fixed clock works also.
> 
> 
> [1] https://patchwork.kernel.org/patch/9670877/
> [2] https://patchwork.kernel.org/patch/6436021/
> 

Yes, just using one 26 MHz clock works, but it uses an deprecated 
binding, so we should not do this, as through copying from the source of 
other SoCs we will keep it alive forever. Anyway that's not your case, 
as you defined the two clocks.

The device tree should reflect the HW, that's why I asked for the clock 
frequency of both clocks. I searched the git history and it was never 
done right before. So you could be the first :)

Thanks,
Matthias
