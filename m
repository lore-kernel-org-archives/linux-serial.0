Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631D7C2D0E4
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 09:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C182100A
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 09:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgKSJDf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:03:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35584 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSJDf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Nov 2020 04:03:35 -0500
Received: by mail-ed1-f67.google.com with SMTP id cf17so1464230edb.2;
        Thu, 19 Nov 2020 01:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4EQbK8dZn3wmlGNgXi+byhifmTHWQPZyV9gwXQJzxwQ=;
        b=CN5/QZaGd+rDpapRyXs+Nfn4ucDGnmcsY/bSSk3RiDLU1LeSMmAqvYne5NiSzO2VZo
         NgYSWSDq0lw84nVUCPd9pFBEybn9il6yz0gL2KN3bYYTEYeXejKLH28Ufdxpo9XGmYEM
         xB70tvy3URsDyUNrs5HiHzgAw/LwZtcA3qp09bMM2eAhU8PmV1MtvvtPg06mw7ufsbOQ
         gNmB6pqrnTcTa/eOMxhVd1ZPmZ4Hyi98tSxSh5ItFWBpXHGw+AkcHroX5V/bB9awwcS4
         wpGyVlKPc5YRvHvW9vOZ6smIWhMQ3Hu7E1b1s/dNG2+0msxpheUyBe6jU0K+VR3RJtf6
         z81g==
X-Gm-Message-State: AOAM530oXhMs/bVom1ssLJqIdYEwqWeVSW7j3rEbmpBqNU2BZzLgKLmp
        2EiQ39IiqyzJMrG4UStjzZw1FXhVjJA=
X-Google-Smtp-Source: ABdhPJyCVoDl/4U59qZyrK2bLtGHzj2zS5F1Zh8a7W02AHfggCa6dmkvPIt3f3ZK0lWvU6+O11/LYw==
X-Received: by 2002:aa7:c886:: with SMTP id p6mr28956302eds.352.1605776612681;
        Thu, 19 Nov 2020 01:03:32 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id n22sm773330edo.43.2020.11.19.01.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 01:03:31 -0800 (PST)
Subject: Re: [PATCH] tty: serial: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>, gregkh@linuxfoundation.org,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1605776489-16283-1-git-send-email-tiantao6@hisilicon.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <5d722862-f0a8-629e-b01e-5269350762e5@kernel.org>
Date:   Thu, 19 Nov 2020 10:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1605776489-16283-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19. 11. 20, 10:01, Tian Tao wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/owl-uart.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> index c149f8c3..472fdaf 100644
> --- a/drivers/tty/serial/owl-uart.c
> +++ b/drivers/tty/serial/owl-uart.c
> @@ -251,10 +251,9 @@ static void owl_uart_receive_chars(struct uart_port *port)
>   static irqreturn_t owl_uart_irq(int irq, void *dev_id)
>   {
>   	struct uart_port *port = dev_id;
> -	unsigned long flags;
>   	u32 stat;
>   
> -	spin_lock_irqsave(&port->lock, flags);
> +	spin_lock(&port->lock);
>   
>   	stat = owl_uart_read(port, OWL_UART_STAT);
>   
> @@ -268,7 +267,7 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
>   	stat |= OWL_UART_STAT_RIP | OWL_UART_STAT_TIP;
>   	owl_uart_write(port, stat, OWL_UART_STAT);
>   
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	spin_unlock(&port->lock);
>   
>   	return IRQ_HANDLED;
>   }
> 


-- 
js
suse labs
