From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH 04/13] ARM: dts: list the CPU nodes for Exynos5250
Date: Mon, 10 Jun 2013 14:48:15 +0530
Message-ID: <CANuQgHHxKNmr_ZUjszKu7XdpaBRJ+5Ky2B7YWreMODb639A5-A@mail.gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
	<1370516488-25860-4-git-send-email-chander.kashyap@linaro.org>
	<20130606165439.GC23311@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:63259 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab3FJJSP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Jun 2013 05:18:15 -0400
Received: by mail-oa0-f44.google.com with SMTP id n10so716700oag.17
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2013 02:18:15 -0700 (PDT)
In-Reply-To: <20130606165439.GC23311@e106331-lin.cambridge.arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>

Hi Mark,

On 6 June 2013 22:24, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Jun 06, 2013 at 12:01:18PM +0100, Chander Kashyap wrote:
>> Instead of having to specify the number for CPUs in Exynos5250 in platsmp.c
>> file, let the number of CPUs be determined by having this information listed
>> in Exynos5250 device tree file.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> ---
>>  arch/arm/boot/dts/exynos5250.dtsi |   14 ++++++++++++++
>>  arch/arm/mach-exynos/platsmp.c    |   10 +++++++---
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index e571d3b..7f6b1c7 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -50,6 +50,20 @@
>>               pinctrl3 = &pinctrl_3;
>>       };
>>
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             cpu@0 {
>> +                     compatible = "arm,cortex-a15";
>> +                     reg = <0>;
>> +             };
>> +             cpu@1 {
>> +                     compatible = "arm,cortex-a15";
>> +                     reg = <1>;
>> +             };
>> +     };
>> +
>
> It would be nice to have device_type = "cpu" on each of the cpu nodes.
Sure, i will populate the nodes.
thanks.
>
> Thanks,
> Mark.



--
with warm regards,
Chander Kashyap
