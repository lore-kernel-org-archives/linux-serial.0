Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87756C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 06:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCA8611AE
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 06:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhESGdg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 02:33:36 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:44651 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhESGdg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 02:33:36 -0400
Received: by mail-wm1-f51.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so2649283wmg.3;
        Tue, 18 May 2021 23:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j/woY3wUI9Ol7gIpKTK/4dqj6Jzmp8dptTJTfnXhBXM=;
        b=e1WreDt8/kg+/baWJNWaNosMmBmu24Uetvpbh8SFkjXhr55IvnuwdQoaxhefjYdbEf
         l4pCXskudSqmD8OIETuJtIOCttJjkXPB96t3HzkIBlkRAGwuZ1vzPOs6PzuYfCKyzE2K
         k+sy1+zxot5cTlkKLWYT0qqtngGkmL1pP4o6lhrazCObteU0BLl/fUh5QAS0S5nN0BVv
         F6wfN/28p/sc1Dldas51N5n/xdcQd9i1+b7kdsmY0wLz6czHEZBG2cqU1TiH8WA0221o
         SZpB/gNlrMkf1fvYEmlRO+Hyj7SrU81M4Gb5CyuZfmWqbvmqq2an7Eeipr2fgFejKEzW
         Zxcg==
X-Gm-Message-State: AOAM532dIdoM4PLgJogmO/fWHAFIxBfIc3G98IkHJPkgFXdHEc8S40ad
        uG/qjz9u190lXVSvi7ibJec=
X-Google-Smtp-Source: ABdhPJzqXzsWrot/yJuG9Dp9Wg69TTI5G9IYTHbq8MKYRdDD+NlPOP4/TQYQFmB0IgIwr+0Iq0Uq5A==
X-Received: by 2002:a1c:1f84:: with SMTP id f126mr9277306wmf.189.1621405935037;
        Tue, 18 May 2021 23:32:15 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id g11sm23779444wri.59.2021.05.18.23.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 23:32:14 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*
To:     Andrew Jeffery <andrew@aj.id.au>, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, Ryan Chen <ryan_chen@aspeedtech.com>,
        Milton Miller II <miltonm@us.ibm.com>
References: <20210519000704.3661773-1-andrew@aj.id.au>
 <20210519000704.3661773-3-andrew@aj.id.au>
 <56ec152a-560b-1eed-97e2-c12e4fed171a@kernel.org>
 <2bb7dfc4-a20e-4e3e-8fa5-74ff264c4e44@www.fastmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <a67f0c95-7708-569f-099b-db9e2ad9616d@kernel.org>
Date:   Wed, 19 May 2021 08:32:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2bb7dfc4-a20e-4e3e-8fa5-74ff264c4e44@www.fastmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19. 05. 21, 8:27, Andrew Jeffery wrote:
> 
> 
> On Wed, 19 May 2021, at 15:44, Jiri Slaby wrote:
>> On 19. 05. 21, 2:07, Andrew Jeffery wrote:
>>> BIT(x) improves readability and safety with respect to shifts.
>>>
>>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>>> ---
>>>    drivers/tty/serial/8250/8250.h | 33 +++++++++++++++++----------------
>>>    1 file changed, 17 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
>>> index 34aa2714f3c9..4fbf1088fad8 100644
>>> --- a/drivers/tty/serial/8250/8250.h
>>> +++ b/drivers/tty/serial/8250/8250.h
>>> @@ -7,6 +7,7 @@
>>>     *  Copyright (C) 2001 Russell King.
>>>     */
>>>    
>>> +#include <linux/bitops.h>
>>>    #include <linux/serial_8250.h>
>>>    #include <linux/serial_reg.h>
>>>    #include <linux/dmaengine.h>
>>> @@ -70,25 +71,25 @@ struct serial8250_config {
>>>    	unsigned int	flags;
>>>    };
>>>    
>>> -#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
>>> -#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
>>> -#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
>>> -#define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
>>> -#define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
>>> -#define UART_CAP_RTOIE	(1 << 13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
>>> -#define UART_CAP_HFIFO	(1 << 14)	/* UART has a "hidden" FIFO */
>>> -#define UART_CAP_RPM	(1 << 15)	/* Runtime PM is active while idle */
>>> -#define UART_CAP_IRDA	(1 << 16)	/* UART supports IrDA line discipline */
>>> -#define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
>>> +#define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
>>> +#define UART_CAP_EFR	BIT(9)	/* UART has EFR */
>>> +#define UART_CAP_SLEEP	BIT(10)	/* UART has IER sleep */
>>
>>
>> Perfect, except the include: BIT is not defined in bitops.h, but in
>> bits.h (which includes vdso/bits.h). In fact, bitops.h includes bits.h
>> too, but it's superfluous to include all those bitops.
> 
> Maybe the recommendation in the checkpatch documentation should be
> fixed then?

+1 since:

commit 8bd9cb51daac89337295b6f037b0486911e1b408
Author: Will Deacon <will@kernel.org>
Date:   Tue Jun 19 13:53:08 2018 +0100

     locking/atomics, asm-generic: Move some macros from 
<linux/bitops.h> to a new <linux/bits.h> file

So care to fix checkpatch too :)?

thanks,
-- 
js
suse labs
