Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F8CC07545
	for <linux-serial@archiver.kernel.org>; Tue, 24 Oct 2023 14:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjJXOxy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Oct 2023 10:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjJXOxv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Oct 2023 10:53:51 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B0FB9
        for <linux-serial@vger.kernel.org>; Tue, 24 Oct 2023 07:53:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E3A82FF81B;
        Tue, 24 Oct 2023 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698159227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pjE0JZ5DnH13QO7oclCWg6eZma/WFKZzK0X5d8+ozDw=;
        b=mDu+1YSWzXltDiCYQNsxnVgGjYeKa7qw3GxS4cESmhXfdy+Nt4Qo/z1Ss0nEmLx06Qfx82
        6AsjpztuZwLPWFnFX4ChYeIxB/DRcAFZQBG6d0sNRmsDGjs6PxzgHXvgTRdk1GAXpr80pz
        chRpc5u12CKzAWYIzw5u/oNnw5OXR2paImgfYQj3yoqJY98WdBajCGKAqgqyfDRc075XGh
        6v0KY96Z63WFRlnwxocS8RLVrt4hsFL4DYB6x/Fd/ul3QgClJJ+3ckwocv4lojB+yw04W4
        E8e66njVraEUzxMmxaloSMX2GEytiRo9oEqTIG4GePSUgwW5M6A8nX6lYjJYKQ==
Message-ID: <7ad9f0a2-053e-4df1-8b2d-e9a9716eb259@bootlin.com>
Date:   Tue, 24 Oct 2023 16:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
To:     Tony Lindgren <tony@atomide.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
        u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com,
        Vignesh R <vigneshr@ti.com>,
        Kevin Hilman <khilman@baylibre.com>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <20231023074440.GS27774@atomide.com>
Content-Language: en-US
From:   Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231023074440.GS27774@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/23/23 09:44, Tony Lindgren wrote:
> Hi,
> 
> Adding Kevin and Vignesh too in case they have better ideas on how to
> prevent the power domain from suspending for no_console_suspend kernel
> parameter.
> 
> * Thomas Richard <thomas.richard@bootlin.com> [231017 13:05]:
>> If the console suspend is disabled, the genpd of the console shall not
>> be powered-off during suspend.
>> Set the flag GENPD_FLAG_ALWAYS_ON to the corresponding genpd during
>> suspend, and restore the original value during the resume.
>>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>>  drivers/tty/serial/8250/8250_omap.c | 33 ++++++++++++++++++++++++-----
>>  1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
>> index ca972fd37725..91a483dc460c 100644
>> --- a/drivers/tty/serial/8250/8250_omap.c
>> +++ b/drivers/tty/serial/8250/8250_omap.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/pm_wakeirq.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/sys_soc.h>
>> +#include <linux/pm_domain.h>
>>  
>>  #include "8250.h"
>>  
>> @@ -114,6 +115,12 @@
>>  /* RX FIFO occupancy indicator */
>>  #define UART_OMAP_RX_LVL		0x19
>>  
>> +/*
>> + * Copy of the genpd flags for the console.
>> + * Only used if console suspend is disabled
>> + */
>> +static unsigned int genpd_flags_console;
> 
> This should be priv->genpd_flags_console or something similar as the
> uarts in an always-on power domain may have different flags from other
> power domains.

Ok I'll move genpd_flags_console to the priv struct.

@Greg, as you already added the patch to your tty git tree, do you
prefer a new version of the patch or a fixup ?

Regards,

Thomas

> 
> Other than that I'm fine with with unless other people have better ideas
> on how to handle this.
> 
> Regards,
> 
> Tony
> 
