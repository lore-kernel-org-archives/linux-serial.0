Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E81C10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E4A20727
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 17:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8x9MPHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCJRpy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:45:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38717 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJRpy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 13:45:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id t11so17042096wrw.5
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2020 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=d/psDyluLfP8VAnyoMEYUqJfPwvyShiYm+45UmmHdLQ=;
        b=j8x9MPHQetz6fADEyfehSxKYV0FcqE8n6fArfJSHhLEiFolTmkSmgDNXG/9F7iZwYj
         /jdT61WDymSC61AJe6DVJiy4u8DaXRlgddVidkVPFhJmpVF1AINdRd8Dph5HIUFWcDvi
         e1G8UT1gq6nqzUuNNGwR1MEzkziIhF8hWqlofP5XnvjVtPNZ6bSnDBmZuUTVsnio2xeL
         dJ74Bi6vaJ3uicfZipVyYPqLat9aG2Ous9Edsq+JBRYg6im1opMfnTjF1Y9mC0m8EzWb
         KoJ+pO4QoXPp0qAif2YABwOKIFMTMr/jtgxt306KunlYTQXw/U7xraeKWYT1RAwTpF/9
         +qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/psDyluLfP8VAnyoMEYUqJfPwvyShiYm+45UmmHdLQ=;
        b=e+zZK/uVNapNigsf/f9DBIAKIcRziwdxkrNoOzIHhP7V3QpA/zuuzFs/feei8SVIIS
         0EbA+203fdrgV9mhDlxahnkOSOsDHEEtjTgOW+VBmo5syDe/OifgaZKq0JF8ATQPE9k5
         d7PkFWoqUrQ7VBTE4DJ60Nd/cbmvHp0MmEApM6E65xxN+y3RCyFYZHYXVS6bdInbeOUD
         g4ICvqqypnQljQDCQDlzH2nIYazBuv+hwS4QcMwtrP23qxR5cIOdN/zvBZ/fb7fRxDbY
         r4+NeNrv5dy8/uQq+LweiL4Ep26rfCsGomMvCglbvHeq/uhJ6n3HC+U+NLjzxAXr5m8d
         A2Lg==
X-Gm-Message-State: ANhLgQ2K7/O+vkEEF66DafOaA/CfE04B2Z26CXz0NCmAcAmhIdTjUyuJ
        U+roBhf8j826P2EAmxqE7mA=
X-Google-Smtp-Source: ADFU+vuv8sf3SPncgVRM4YcSn2dRkoPzGBRyvrRDJbZeh/v0ikvaBuNr50qUk4GcjyxeqUNjd5ICIA==
X-Received: by 2002:adf:fc82:: with SMTP id g2mr29972762wrr.117.1583862351957;
        Tue, 10 Mar 2020 10:45:51 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r28sm70331565wra.16.2020.03.10.10.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 10:45:51 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] serial: core: Refactor
 uart_unlock_and_check_sysrq()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <20200310174337.74109-1-andriy.shevchenko@linux.intel.com>
 <20200310174337.74109-4-andriy.shevchenko@linux.intel.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <42c6b5b9-af15-ef7d-ea55-2fca0fd6ae18@gmail.com>
Date:   Tue, 10 Mar 2020 17:45:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200310174337.74109-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 3/10/20 5:43 PM, Andy Shevchenko wrote:
> Refactor uart_unlock_and_check_sysrq() to:
> 
>   - explicitly show that we release a port lock which makes
>     static analyzers happy:
> 
> CHECK   drivers/tty/serial/serial_core.c
> .../serial_core.c:3290:17: warning: context imbalance in 'uart_unlock_and_check_sysrq' - unexpected unlock
> 
>   - use flags instead of irqflags to avoid confusion with IRQ flags
> 
>   - provide one return point
> 
>   - be more compact
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

> ---
> v2: move sysrq_ch declaration inside branch (Dmitry)
>  drivers/tty/serial/serial_core.c | 23 ++++++++++-------------
>  include/linux/serial_core.h      |  3 +--
>  2 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index e3f8e641e3a7..203697465afc 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3286,22 +3286,19 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
>  }
>  EXPORT_SYMBOL_GPL(uart_prepare_sysrq_char);
>  
> -void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
> +void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long flags)
> +__releases(&port->lock)
>  {
> -	int sysrq_ch;
> +	if (port->has_sysrq) {
> +		int sysrq_ch = port->sysrq_ch;
>  
> -	if (!port->has_sysrq) {
> -		spin_unlock_irqrestore(&port->lock, irqflags);
> -		return;
> +		port->sysrq_ch = 0;
> +		spin_unlock_irqrestore(&port->lock, flags);
> +		if (sysrq_ch)
> +			handle_sysrq(sysrq_ch);
> +	} else {
> +		spin_unlock_irqrestore(&port->lock, flags);
>  	}
> -
> -	sysrq_ch = port->sysrq_ch;
> -	port->sysrq_ch = 0;
> -
> -	spin_unlock_irqrestore(&port->lock, irqflags);
> -
> -	if (sysrq_ch)
> -		handle_sysrq(sysrq_ch);
>  }
>  EXPORT_SYMBOL_GPL(uart_unlock_and_check_sysrq);
>  
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 7a025042e0bb..cab896c60e35 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -447,8 +447,7 @@ extern void uart_insert_char(struct uart_port *port, unsigned int status,
>  
>  extern int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch);
>  extern int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch);
> -extern void uart_unlock_and_check_sysrq(struct uart_port *port,
> -					unsigned long irqflags);
> +extern void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long flags);
>  extern int uart_handle_break(struct uart_port *port);
>  
>  /*
> 

-- 
          Dima
