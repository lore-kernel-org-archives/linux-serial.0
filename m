From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH v2 07/10] ARM: dts: Add initial device tree support for Exynos5420
Date: Mon, 17 Jun 2013 16:38:55 +0530
Message-ID: <CANuQgHGh9briWaP7rAgQEY5n04Amfu9VGwMFUg5HioHPnGQe_Q@mail.gmail.com>
References: <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
	<1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
	<1371218572-8993-8-git-send-email-chander.kashyap@linaro.org>
	<20130617084648.GA6809@e106331-lin.cambridge.arm.com>
	<CAGOxZ51H_dtZN3Nx-=qU+gjHAEwgPA--SZrdiu-sBCANhdKtAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAGOxZ51H_dtZN3Nx-=qU+gjHAEwgPA--SZrdiu-sBCANhdKtAw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>
List-Id: linux-serial@vger.kernel.org

On 17 June 2013 14:22, Alim Akhtar <alim.akhtar@gmail.com> wrote:
> Hi Chander and Mark
>
>
> On Mon, Jun 17, 2013 at 2:16 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> Hi,
>>
>> > diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> > b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> > new file mode 100644
>> > index 0000000..43f0eb8
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> > @@ -0,0 +1,40 @@
>> > +/*
>> > + * SAMSUNG SMDK5420 board device tree source
>> > + *
>> > + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
>> > + *           http://www.samsung.com
>> > + *
>> > + * This program is free software; you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2 as
>> > + * published by the Free Software Foundation.
>> > +*/
>> > +
>> > +/dts-v1/;
>> > +#include "exynos5420.dtsi"
>> > +
>> > +/ {
>> > +     model = "Samsung SMDK5420 board based on EXYNOS5420";
>> > +     compatible = "samsung,smdk5420", "samsung,exynos5420";
>> > +
>> > +     memory {
>> > +             reg =   <0x20000000 0x10000000
>> > +                      0x30000000 0x10000000
>> > +                      0x40000000 0x10000000
>> > +                      0x50000000 0x10000000
>> > +                      0x60000000 0x10000000
>> > +                      0x70000000 0x10000000
>> > +                      0x80000000 0x10000000
>> > +                      0x90000000 0x10000000>;
>> > +     };
>>
>> As splitting these into 256MB banks is a workaround for an implementation
>> issue, there should at least be a comment to that effect.
>>
>> It would be far nicer if this were described as one bank and the kernel
>> could
>> split it up as necessary when using sparsemem.
>>
> Yes, I thing this is not needed at all, the bootloader should be setting
> this for us.
> Either remove this completly or just add as single bank of memory, like
> starting address and the size.

I will convert it to single bank and resend.
>
>> Thanks,
>> Mark.
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards,
> Alim



--
with warm regards,
Chander Kashyap
