From: Subash Patel <subashrp@gmail.com>
Subject: Re: [PATCH 10/13] ARM: dts: Add initial device tree support for Exynos5420
Date: Wed, 12 Jun 2013 11:05:02 +0530
Message-ID: <51B80886.9010004@gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org> <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org> <20130606163411.GA23311@e106331-lin.cambridge.arm.com> <CANuQgHFndqWH5KYskuiqxWuVXEp+_=R=Tnfo5y_syreBFcGPbQ@mail.gmail.com> <20130611141121.GC22334@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130611141121.GC22334@e106331-lin.cambridge.arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hi Mark,

On 06/11/2013 07:41 PM, Mark Rutland wrote:
> On Tue, Jun 11, 2013 at 02:35:38PM +0100, Chander Kashyap wrote:
>> On 6 June 2013 22:04, Mark Rutland <mark.rutland@arm.com> wrote:
>>> Hi,
>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>>> new file mode 100644
>>>> index 0000000..b14e775
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>>> @@ -0,0 +1,40 @@
>>>> +/*
>>>> + * SAMSUNG SMDK5420 board device tree source
>>>> + *
>>>> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
>>>> + *           http://www.samsung.com
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> +*/
>>>> +
>>>> +/dts-v1/;
>>>> +/include/ "exynos5420.dtsi"
>>>> +
>>>> +/ {
>>>> +     model = "Samsung SMDK5420 board based on EXYNOS5420";
>>>> +     compatible = "samsung,smdk5420", "samsung,exynos5420";
>>>> +
>>>> +     memory {
>>>> +             reg =   <0x20000000 0x10000000
>>>> +                      0x30000000 0x10000000
>>>> +                      0x40000000 0x10000000
>>>> +                      0x50000000 0x10000000
>>>> +                      0x60000000 0x10000000
>>>> +                      0x70000000 0x10000000
>>>> +                      0x80000000 0x10000000
>>>> +                      0x90000000 0x10000000>;
>>>> +     };
>>>
>> As there are only 28 bits for memory bank size in memory.h.
>> Hence each bank is split into 256MB.
>
> I don't think a kernel implementation choice should affect the dts.
>
> If the kernel needs to carve up the memory, it should do it itself - it knows
> what it needs. Splitting the banks manually as above is papering over the
> problem.

I agree this looks a bit odd to split the memory regions into 256MiB 
banks. But we have had legacy systems which had a hole in the memory 
range, and we used sparse mem in the past for the same. If we modify 
this bank size now, we will break the functionality of those systems.

Also, with LPAE systems I changed this bank size to 2GiB in another 
patch. I think someone was working on cleaning up sparse mem for 
exynos(I was quite busy internally and didn't follow up much on mailing 
list). So I would like to keep this bank size as 256MiB for non-LPAE 
systems at the moment, until such a cleanup gets merged.

Copy: kgene - exynos maintainer

Mr. Kim, let us know your opinion on this.

Regards,
Subash


>
> Thanks,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
