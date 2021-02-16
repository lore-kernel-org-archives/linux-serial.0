Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C90CC433DB
	for <linux-serial@archiver.kernel.org>; Tue, 16 Feb 2021 11:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB9D64E08
	for <linux-serial@archiver.kernel.org>; Tue, 16 Feb 2021 11:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBPL3f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhBPL30 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Feb 2021 06:29:26 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19162C061574;
        Tue, 16 Feb 2021 03:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KUscxVs+rrWNv2kr6TsDxHeqHd9L/LtdwqhXLvBu+7w=; b=PoSxaYKW6vIzdysd+/slTJ2kaF
        AjV8jDph1Sw7Tdd3F1tXxNHDguiVMvl1tjdqhIjv60groA8DXOzGqbVHHaRj1QNkqqQBNa234H+Mm
        vbuKLf0VB41BwaoQ8opqZQkfcupfQdLHpR+oi5cj6LC30pPKH85k0dgTZYeTDrmNGCx5hNjqAI40A
        52JBu0kNQNczl/wTjmWVazOsyxMzg2fCTH1M3JX7N3+kN8O6a01Jt32IHXmikka0mxMc5fTSdDNCZ
        SbvDJ1oapIiNCW3OsjzRClo1Oz11qOXj3Tp2OOXaSDbUM5KcSjekJ8N8I/do7zp/jzDMxPbYy21Dt
        rORkFNeg==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1lByX4-0007AW-F7; Tue, 16 Feb 2021 13:28:42 +0200
Subject: Re: [PATCH] tty: serial: Add earlycon driver for Tegra Combined UART
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210213115824.3306965-1-mperttunen@nvidia.com>
 <YCpMF7MyJYB8x7Zi@ulmo.localdomain>
 <2cdba410-7cc8-6ad3-53ab-d9c24e58a028@kapsi.fi>
 <YCpkeJKs/ZnTwgXJ@ulmo.localdomain>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <afcd39a4-84f3-eabb-4444-12325230d9a6@kapsi.fi>
Date:   Tue, 16 Feb 2021 13:28:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YCpkeJKs/ZnTwgXJ@ulmo.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2/15/21 2:09 PM, Thierry Reding wrote:
> On Mon, Feb 15, 2021 at 12:35:31PM +0200, Mikko Perttunen wrote:
>> On 2/15/21 12:25 PM, Thierry Reding wrote:
>>> On Sat, Feb 13, 2021 at 01:58:24PM +0200, Mikko Perttunen wrote:
>>>> Add an earlycon driver for platforms with TCU, namely Tegra194.
>>>> The driver is compatible with boot parameters passed by NVIDIA
>>>> boot chains.
>>>
>>> I'm not sure I understand the latter part of this description. What boot
>>> parameters is this compatible with? Looking at the setup function there
>>> doesn't seem to be anything out of the ordinary here, so I'm wondering
>>> if that's just confusing. If there's anything special, it might be worth
>>> specifically pointing out what that is. Perhaps both in the commit
>>> message and in a code comment, so it's properly documented.
>>
>> It's that the name of the driver 'tegra_comb_uart' matches what the boot
>> chain passes; and that OF_EARLYCON_DECLARE is not used. (OF_EARLYCON_DECLARE
>> cannot anyway be used due to the mailbox indirection in device tree).
> 
> This is all not immediately obvious. Perhaps you can add more of this
> into the commit message and perhaps provide an example of how this would
> be used on the kernel command-line.

Will do.

> 
> You say "mailbox indirection" and looking at the implementation this
> does seem to use the mailbox's base address as a sort of TX FIFO, which
> I think is all good. However, I'm wondering if we couldn't somehow
> detect this all dynamically at runtime. Don't we have access to the
> device tree node at this point? If so, couldn't we parse all the
> necessary information from the DT instead of relying on the user
> providing the mailbox address on the command-line?

Sure, I will look at parsing the address from DT manually at init time.

> 
> I realize that this would all make things a bit more complicated in this
> driver, but at the same time it'd make life so much easier for users, so
> I think it's worth at least considering.
> 
> To elaborate on this a bit, I think it'd be much more useful if users
> could specify something like this:
> 
> 	earlycon=tegra-tcu
> 
> rather than:
> 
> 	earlycon=tegra_comb_uart,0xc150000
> 
> Note that I'm not even sure if that's a correct address. It'd be even
> better if all of this can just be derived from the device tree. My
> recollection is that earlycon always needs to be explicitly enabled, but
> I thought it was also possible to derive which console to use from the
> /chose/stdout-path property in device tree.

The reason I don't think this is that complicated is that that is what 
cboot is already passing to the kernel. Maybe we could support both 
options since it's just 2 or 3 extra lines.

> 
>>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>>> ---
>>>>    drivers/tty/serial/Kconfig              | 12 +++++
>>>>    drivers/tty/serial/Makefile             |  1 +
>>>>    drivers/tty/serial/tegra-tcu-earlycon.c | 72 +++++++++++++++++++++++++
>>>>    3 files changed, 85 insertions(+)
>>>>    create mode 100644 drivers/tty/serial/tegra-tcu-earlycon.c
>>>>
>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>>> index 34a2899e69c0..d941785e3f46 100644
>>>> --- a/drivers/tty/serial/Kconfig
>>>> +++ b/drivers/tty/serial/Kconfig
>>>> @@ -331,6 +331,18 @@ config SERIAL_TEGRA_TCU_CONSOLE
>>>>    	  If unsure, say Y.
>>>> +config SERIAL_TEGRA_TCU_EARLYCON
>>>> +	bool "Earlycon on NVIDIA Tegra Combined UART"
>>>> +	depends on ARCH_TEGRA || COMPILE_TEST
>>>> +	select SERIAL_EARLYCON
>>>> +	select SERIAL_CORE_CONSOLE
>>>> +	default y if SERIAL_TEGRA_TCU_CONSOLE
>>>> +	help
>>>> +	  If you say Y here, TCU output will be supported during the earlycon
>>>> +	  phase of the boot.
>>>> +
>>>> +	  If unsure, say Y.
>>>> +
>>>>    config SERIAL_MAX3100
>>>>    	tristate "MAX3100 support"
>>>>    	depends on SPI
>>>> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
>>>> index b85d53f9e9ff..408144326fed 100644
>>>> --- a/drivers/tty/serial/Makefile
>>>> +++ b/drivers/tty/serial/Makefile
>>>> @@ -72,6 +72,7 @@ obj-$(CONFIG_SERIAL_XILINX_PS_UART) += xilinx_uartps.o
>>>>    obj-$(CONFIG_SERIAL_SIRFSOC) += sirfsoc_uart.o
>>>>    obj-$(CONFIG_SERIAL_TEGRA) += serial-tegra.o
>>>>    obj-$(CONFIG_SERIAL_TEGRA_TCU) += tegra-tcu.o
>>>> +obj-$(CONFIG_SERIAL_TEGRA_TCU_EARLYCON) += tegra-tcu-earlycon.o
>>>>    obj-$(CONFIG_SERIAL_AR933X)   += ar933x_uart.o
>>>>    obj-$(CONFIG_SERIAL_EFM32_UART) += efm32-uart.o
>>>>    obj-$(CONFIG_SERIAL_ARC)	+= arc_uart.o
>>>> diff --git a/drivers/tty/serial/tegra-tcu-earlycon.c b/drivers/tty/serial/tegra-tcu-earlycon.c
>>>> new file mode 100644
>>>> index 000000000000..9decfbced0a7
>>>> --- /dev/null
>>>> +++ b/drivers/tty/serial/tegra-tcu-earlycon.c
>>>> @@ -0,0 +1,72 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (c) 2017-2021, NVIDIA CORPORATION.  All rights reserved.
>>>> + */
>>>> +
>>>> +#include <linux/console.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/serial_core.h>
>>>> +
>>>> +#define NUM_BYTES_FIELD_BIT	24
>>>> +#define FLUSH_BIT		26
>>>
>>> This one seems to be unused.
>>
>> True, I'll remove it.
>>
>>>
>>>> +#define INTR_TRIGGER_BIT	31
>>>
>>> I wonder if this could somehow be integrated with the existing TCU
>>> driver since we have these bits defined there already. And really this
>>> is basically a skeleton version of the same driver.
>>>
>>>> +/*
>>>> + * This function splits the string to be printed (const char *s) into multiple
>>>> + * packets. Each packet contains a max of 3 characters. Packets are sent to the
>>>> + * SPE-based combined UART server for printing. Communication with SPE is done
>>>> + * through mailbox registers which can generate interrupts for SPE.
>>>> + */
>>>> +static void early_tcu_write(struct console *console, const char *s, unsigned int count)
>>>> +{
>>>> +	struct earlycon_device *device = console->data;
>>>> +	u8 __iomem *addr = device->port.membase;
>>>> +	u32 mbox_val = BIT(INTR_TRIGGER_BIT);
>>>> +	unsigned int i;
>>>> +
>>>> +	/* Loop for processing each 3 char packet */
>>>> +	for (i = 0; i < count; i++) {
>>>> +		if (s[i] == '\n')
>>>> +			mbox_val = update_and_send_mbox(addr, mbox_val, '\r');
>>>> +		mbox_val = update_and_send_mbox(addr, mbox_val, s[i]);
>>>> +	}
>>>> +
>>>> +	if ((mbox_val >> NUM_BYTES_FIELD_BIT) & 0x3) {
>>>> +		while (readl(addr) & BIT(INTR_TRIGGER_BIT))
>>>> +			cpu_relax();
>>>> +		writel(mbox_val, addr);
>>>> +	}
>>>> +}
>>>
>>> For example this function already exists in the Tegra TCU driver and
>>> perhaps some of that could be refactored to work for both cases.
>>
>> This is very similar to the main tegra_tcu driver, but considering how
>> simple this driver is, and the main driver using the mailbox framework
>> making the actual implementation incompatible, I was thinking that it's
>> easier to just have this be independent.
> 
> I don't have a strong objection to keeping these functions separate,
> especially since they are fairly small and not likely to ever change, so
> the maintenance burden is going to be small in any case.
> 
> But even so it might be nice to stash this all into the same file. After
> all, people aren't going to enable this configuration option if they
> have the Tegra TCU driver disabled. Once these are integrated, it's also
> likely not worth even having a separate Kconfig option because the added
> code is so little.

Will look into integrating this into tegra-tcu.c.

> 
> Thierry
> 

Thanks!
Mikko
