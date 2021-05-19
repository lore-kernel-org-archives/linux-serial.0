Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7816AC433B4
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 06:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439AF611AE
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 06:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhESGPi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 02:15:38 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40783 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhESGPh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 02:15:37 -0400
Received: by mail-wr1-f45.google.com with SMTP id z17so12614173wrq.7;
        Tue, 18 May 2021 23:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eM8EQdorm7mWG5o19XHqVGANwvQx7NCTQwR5Sava/sg=;
        b=RM4jwaeYbBUIgNQDlRxeqj0JO9OTU+py8tLHT5SdBYgIsVfsKiRp5xWEKnbtsCllar
         EsRVpzhKWtjX8ozcjMSp3eRltO1nUK17pKwEuzS5g7Vur8w75f5EpDzWy269+s77Y0qr
         Omr6bzGkFiwd/n3i0HcYowdjkvIdbs4P90a2iZbdBkfqh6fz4Hzkc0t5Xpv8o60YX1WI
         WDIrTZtkJTyIDmZsV/oPg92nKfbWixfUwSG6RtuDwYHEnIG527HVA6Ahe0IV61prULXT
         H4E92ZAd5Zp+7A6lo/ypYcsGZe2lMVN5EGISRvRr1iGEAbeoJ+LjPfi6Q+910po81sZE
         7VOg==
X-Gm-Message-State: AOAM533BvLlyey/kSa8gYPD7I2W5NC8ER0sL9Mrb9WABsykXD8CMgjPH
        TJjh7HevO4nyjhj/Yah3URw=
X-Google-Smtp-Source: ABdhPJz6iPXnZ1bVZfGhblaiVWq7jqmsaA0sDVHC70vQOG+pEbSsL5Jmu31ST2PpHeuV1k01nEMjiA==
X-Received: by 2002:adf:f9ce:: with SMTP id w14mr12479031wrr.387.1621404857559;
        Tue, 18 May 2021 23:14:17 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i1sm13181697wrp.51.2021.05.18.23.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 23:14:17 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*
To:     Andrew Jeffery <andrew@aj.id.au>, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, ryan_chen@aspeedtech.com,
        miltonm@us.ibm.com
References: <20210519000704.3661773-1-andrew@aj.id.au>
 <20210519000704.3661773-3-andrew@aj.id.au>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <56ec152a-560b-1eed-97e2-c12e4fed171a@kernel.org>
Date:   Wed, 19 May 2021 08:14:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519000704.3661773-3-andrew@aj.id.au>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19. 05. 21, 2:07, Andrew Jeffery wrote:
> BIT(x) improves readability and safety with respect to shifts.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>   drivers/tty/serial/8250/8250.h | 33 +++++++++++++++++----------------
>   1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 34aa2714f3c9..4fbf1088fad8 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -7,6 +7,7 @@
>    *  Copyright (C) 2001 Russell King.
>    */
>   
> +#include <linux/bitops.h>
>   #include <linux/serial_8250.h>
>   #include <linux/serial_reg.h>
>   #include <linux/dmaengine.h>
> @@ -70,25 +71,25 @@ struct serial8250_config {
>   	unsigned int	flags;
>   };
>   
> -#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
> -#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
> -#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
> -#define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
> -#define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
> -#define UART_CAP_RTOIE	(1 << 13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
> -#define UART_CAP_HFIFO	(1 << 14)	/* UART has a "hidden" FIFO */
> -#define UART_CAP_RPM	(1 << 15)	/* Runtime PM is active while idle */
> -#define UART_CAP_IRDA	(1 << 16)	/* UART supports IrDA line discipline */
> -#define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
> +#define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
> +#define UART_CAP_EFR	BIT(9)	/* UART has EFR */
> +#define UART_CAP_SLEEP	BIT(10)	/* UART has IER sleep */


Perfect, except the include: BIT is not defined in bitops.h, but in 
bits.h (which includes vdso/bits.h). In fact, bitops.h includes bits.h 
too, but it's superfluous to include all those bitops.

thanks,
-- 
-- 
js
suse labs
