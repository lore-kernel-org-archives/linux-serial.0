From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: Add Mediatek SoC MT2712 and evaluation
 board dts and Makefile
Date: Fri, 21 Jul 2017 13:52:39 +0200
Message-ID: <727069a0-7dd0-9d90-15bd-9005ecc793f7@gmail.com>
References: <1498123975-9748-1-git-send-email-yt.shen@mediatek.com>
 <1498123975-9748-3-git-send-email-yt.shen@mediatek.com>
 <ddfb5e58-520f-1ef5-2351-d7545e17a429@gmail.com>
 <1500446884.14021.12.camel@mtksdaap41>
 <a470dfc9-71a4-6574-f342-fbd8d60aafce@gmail.com>
 <1500618746.14868.13.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500618746.14868.13.camel@mtksdaap41>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-serial@vger.kernel.org



On 07/21/2017 08:32 AM, YT Shen wrote:
> On Wed, 2017-07-19 at 11:26 +0200, Matthias Brugger wrote:
>>
>> On 07/19/2017 08:48 AM, YT Shen wrote:
>>> On Tue, 2017-07-18 at 18:29 +0200, Matthias Brugger wrote:
>>>>
>>>> On 06/22/2017 11:32 AM, YT Shen wrote:
>>>>> This adds basic chip support for Mediatek 2712
>>
>> [...]
>>
>>>>> +
>>>>> +	uart_clk: dummy26m {
>>>>> +		compatible = "fixed-clock";
>>>>> +		clock-frequency = <26000000>;
>>>>> +		#clock-cells = <0>;
>>>>> +	};
>>>>> +
>>
>> [...]
>>
>>>>> +
>>>>> +	soc {
>>>>> +		#address-cells = <2>;
>>>>> +		#size-cells = <2>;
>>>>> +		compatible = "simple-bus";
>>>>> +		ranges;
>>>>> +
>>>>> +		uart5: serial@1000f000 {
>>>>> +			compatible = "mediatek,mt2712-uart",
>>>>> +				     "mediatek,mt6577-uart";
>>>>> +			reg = <0 0x1000f000 0 0x400>;
>>>>> +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
>>>>> +			clocks = <&uart_clk>, <&uart_clk>;
>>>>> +			clock-names = "baud", "bus";
>>>>> +			status = "disabled";
>>>>> +		};
>>>>
>>>> So baud and bus clock are both 26 MHz?
>>> We didn't have CCF clock support in this series.
>>> After we have clock source support, we could use the correct clocks to
>>> the UARTs and drop the 26MHz fixed rate UART clock.
>>>
>>> The bus clock is 26MHz.  The baud clock could be from another clock
>>> source, using the same 26MHz fixed clock works also.
>>>
>>>
>>> [1] https://patchwork.kernel.org/patch/9670877/
>>> [2] https://patchwork.kernel.org/patch/6436021/
>>>
>>
>> Yes, just using one 26 MHz clock works, but it uses an deprecated
>> binding, so we should not do this, as through copying from the source of
>> other SoCs we will keep it alive forever. Anyway that's not your case,
>> as you defined the two clocks.
>>
>> The device tree should reflect the HW, that's why I asked for the clock
>> frequency of both clocks. I searched the git history and it was never
>> done right before. So you could be the first :)
>>
>> Thanks,
>> Matthias
> Ok, I want to make it clear.  The following example
> 
>          baud_clk: dummy26m {
>                  compatible = "fixed-clock";
>                  clock-frequency = <26000000>;
>                  #clock-cells = <0>;
>          };
> 
>          sys_clk: dummyclk {
>                  compatible = "fixed-clock";
>                  clock-frequency = <26000000>;
>                  #clock-cells = <0>;
>          };
> 
> 	uart0: serial@11002000 {
> [...]
>                  clocks = <&baud_clk>, <&sys_clk>;
> [...]
> 	}
> 
> Do you think it is clear to reflect the HW that the baud clock and sys
> clock can be different source or we need to choose another frequency?
> Thanks.
> 

Best would be to choose the frequency you expect from both clocks. E.g. 
the frequency set by the bootloader. If the clock is the same, then we 
can leave the patch as-is.

Thanks,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
