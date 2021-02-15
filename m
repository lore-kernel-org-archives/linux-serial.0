Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1775C433E9
	for <linux-serial@archiver.kernel.org>; Mon, 15 Feb 2021 10:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830E364E02
	for <linux-serial@archiver.kernel.org>; Mon, 15 Feb 2021 10:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBOKgX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Feb 2021 05:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhBOKgR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Feb 2021 05:36:17 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB89C0613D6;
        Mon, 15 Feb 2021 02:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A39YtV79I6NX6ufmEzrnH6OOB8AgR/dyKZIOsgzEBUM=; b=RW7MxplHc81e6ZbgnD4g+ysHaz
        aBTUncu5RxM5/hSHxgX4dibaEXnjNUBPhCycOoMl56ZeAPwb+MKF/lBRqxvvdJVB26fBj1GbUL1NC
        Kk8wRDCULJ+pugLZKwlhdIdq96bilg0aEtCSZkXDPPP7ynBGg6ULDEk4fLgEv6fAV9GYo/jX5Vq66
        Qlj8GTzUM0NruNdZEoSHpT5dJ0Rm4T+2Co7Xa7biHy2joXvItVWHNfqYvsMq2upbEF3zmSzK2aJ00
        2kOsTE/aFy5U+5lTLuwn4hB8O0jIwwMi+6Ur6SdnpuhQ/2zKdlQeeEgk5V7bJzDS/WQczIqLkJcMT
        iZDRPgWA==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1lBbE4-0000JP-FN; Mon, 15 Feb 2021 12:35:32 +0200
Subject: Re: [PATCH] tty: serial: Add earlycon driver for Tegra Combined UART
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210213115824.3306965-1-mperttunen@nvidia.com>
 <YCpMF7MyJYB8x7Zi@ulmo.localdomain>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <2cdba410-7cc8-6ad3-53ab-d9c24e58a028@kapsi.fi>
Date:   Mon, 15 Feb 2021 12:35:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YCpMF7MyJYB8x7Zi@ulmo.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2/15/21 12:25 PM, Thierry Reding wrote:
> On Sat, Feb 13, 2021 at 01:58:24PM +0200, Mikko Perttunen wrote:
>> Add an earlycon driver for platforms with TCU, namely Tegra194.
>> The driver is compatible with boot parameters passed by NVIDIA
>> boot chains.
> 
> I'm not sure I understand the latter part of this description. What boot
> parameters is this compatible with? Looking at the setup function there
> doesn't seem to be anything out of the ordinary here, so I'm wondering
> if that's just confusing. If there's anything special, it might be worth
> specifically pointing out what that is. Perhaps both in the commit
> message and in a code comment, so it's properly documented.

It's that the name of the driver 'tegra_comb_uart' matches what the boot 
chain passes; and that OF_EARLYCON_DECLARE is not used. 
(OF_EARLYCON_DECLARE cannot anyway be used due to the mailbox 
indirection in device tree).

> 
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   drivers/tty/serial/Kconfig              | 12 +++++
>>   drivers/tty/serial/Makefile             |  1 +
>>   drivers/tty/serial/tegra-tcu-earlycon.c | 72 +++++++++++++++++++++++++
>>   3 files changed, 85 insertions(+)
>>   create mode 100644 drivers/tty/serial/tegra-tcu-earlycon.c
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 34a2899e69c0..d941785e3f46 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -331,6 +331,18 @@ config SERIAL_TEGRA_TCU_CONSOLE
>>   
>>   	  If unsure, say Y.
>>   
>> +config SERIAL_TEGRA_TCU_EARLYCON
>> +	bool "Earlycon on NVIDIA Tegra Combined UART"
>> +	depends on ARCH_TEGRA || COMPILE_TEST
>> +	select SERIAL_EARLYCON
>> +	select SERIAL_CORE_CONSOLE
>> +	default y if SERIAL_TEGRA_TCU_CONSOLE
>> +	help
>> +	  If you say Y here, TCU output will be supported during the earlycon
>> +	  phase of the boot.
>> +
>> +	  If unsure, say Y.
>> +
>>   config SERIAL_MAX3100
>>   	tristate "MAX3100 support"
>>   	depends on SPI
>> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
>> index b85d53f9e9ff..408144326fed 100644
>> --- a/drivers/tty/serial/Makefile
>> +++ b/drivers/tty/serial/Makefile
>> @@ -72,6 +72,7 @@ obj-$(CONFIG_SERIAL_XILINX_PS_UART) += xilinx_uartps.o
>>   obj-$(CONFIG_SERIAL_SIRFSOC) += sirfsoc_uart.o
>>   obj-$(CONFIG_SERIAL_TEGRA) += serial-tegra.o
>>   obj-$(CONFIG_SERIAL_TEGRA_TCU) += tegra-tcu.o
>> +obj-$(CONFIG_SERIAL_TEGRA_TCU_EARLYCON) += tegra-tcu-earlycon.o
>>   obj-$(CONFIG_SERIAL_AR933X)   += ar933x_uart.o
>>   obj-$(CONFIG_SERIAL_EFM32_UART) += efm32-uart.o
>>   obj-$(CONFIG_SERIAL_ARC)	+= arc_uart.o
>> diff --git a/drivers/tty/serial/tegra-tcu-earlycon.c b/drivers/tty/serial/tegra-tcu-earlycon.c
>> new file mode 100644
>> index 000000000000..9decfbced0a7
>> --- /dev/null
>> +++ b/drivers/tty/serial/tegra-tcu-earlycon.c
>> @@ -0,0 +1,72 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2017-2021, NVIDIA CORPORATION.  All rights reserved.
>> + */
>> +
>> +#include <linux/console.h>
>> +#include <linux/io.h>
>> +#include <linux/serial_core.h>
>> +
>> +#define NUM_BYTES_FIELD_BIT	24
>> +#define FLUSH_BIT		26
> 
> This one seems to be unused.

True, I'll remove it.

> 
>> +#define INTR_TRIGGER_BIT	31
> 
> I wonder if this could somehow be integrated with the existing TCU
> driver since we have these bits defined there already. And really this
> is basically a skeleton version of the same driver.
> 
>> +/*
>> + * This function splits the string to be printed (const char *s) into multiple
>> + * packets. Each packet contains a max of 3 characters. Packets are sent to the
>> + * SPE-based combined UART server for printing. Communication with SPE is done
>> + * through mailbox registers which can generate interrupts for SPE.
>> + */
>> +static void early_tcu_write(struct console *console, const char *s, unsigned int count)
>> +{
>> +	struct earlycon_device *device = console->data;
>> +	u8 __iomem *addr = device->port.membase;
>> +	u32 mbox_val = BIT(INTR_TRIGGER_BIT);
>> +	unsigned int i;
>> +
>> +	/* Loop for processing each 3 char packet */
>> +	for (i = 0; i < count; i++) {
>> +		if (s[i] == '\n')
>> +			mbox_val = update_and_send_mbox(addr, mbox_val, '\r');
>> +		mbox_val = update_and_send_mbox(addr, mbox_val, s[i]);
>> +	}
>> +
>> +	if ((mbox_val >> NUM_BYTES_FIELD_BIT) & 0x3) {
>> +		while (readl(addr) & BIT(INTR_TRIGGER_BIT))
>> +			cpu_relax();
>> +		writel(mbox_val, addr);
>> +	}
>> +}
> 
> For example this function already exists in the Tegra TCU driver and
> perhaps some of that could be refactored to work for both cases.

This is very similar to the main tegra_tcu driver, but considering how 
simple this driver is, and the main driver using the mailbox framework 
making the actual implementation incompatible, I was thinking that it's 
easier to just have this be independent.

> 
> Thierry
> 

Thanks,
Mikko
