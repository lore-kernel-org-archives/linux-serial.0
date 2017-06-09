From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: Add Mediatek SoC MT2712 and evaluation
 board dts and Makefile
Date: Fri, 9 Jun 2017 15:44:20 +0100
Message-ID: <3ac6fe47-9e56-b88a-4bab-efddc886ec76@arm.com>
References: <1496230773-22633-1-git-send-email-yt.shen@mediatek.com>
 <1496230773-22633-3-git-send-email-yt.shen@mediatek.com>
 <92e438b3-4e9c-421b-5398-5aad2541524c@gmail.com>
 <1497016569.29586.36.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497016569.29586.36.camel@mtksdaap41>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 09/06/17 14:56, YT Shen wrote:
> On Wed, 2017-05-31 at 14:42 +0200, Matthias Brugger wrote:

[...]

>>> +		cpu0: cpu@0 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a35";
>>
>> do you mean cortex-a53?
> No, the cpu is cortex-a35.
> Although I cannot find other cortex-a35 description in mainline kernel.

We usually don't keep track of individual cores if we don't need to
(errata workarounds, for example). And for the record, here's some blurb
about Cortex-A35:

https://www.arm.com/products/processors/cortex-a/cortex-a35-processor.php

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
