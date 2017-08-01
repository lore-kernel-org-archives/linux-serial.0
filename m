From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/2] arm64: dts: Add Mediatek SoC MT2712 and evaluation
 board dts and Makefile
Date: Tue, 1 Aug 2017 14:46:28 +0200
Message-ID: <85f5d713-a599-e4cc-f1b4-2e0dedf2797f@gmail.com>
References: <1501241835-47849-1-git-send-email-yt.shen@mediatek.com>
 <1501241835-47849-3-git-send-email-yt.shen@mediatek.com>
 <1501577481.32089.3.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501577481.32089.3.camel@mtksdaap41>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org



On 08/01/2017 10:51 AM, Yingjoe Chen wrote:
> On Fri, 2017-07-28 at 19:37 +0800, YT Shen wrote:
>> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
>> new file mode 100644
>> index 0000000..1e135af
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> 
> <...>
> 
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupt-parent = <&gic>;
>> +		interrupts = <GIC_PPI 13
>> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14
>> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11
>> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10
>> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +
>> +	soc {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		compatible = "simple-bus";
>> +		ranges;
> 
> Matthias,
> 
> I notice this have soc node.
> Do we need to get rid of it?
> 

Good catch. Yes please get rid of it. We should avoid artificial bus nodes. As 
soc is no real bus, we should get rid of it.

Thanks,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
