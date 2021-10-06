Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DC7C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 04:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E02061151
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 04:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJFEsI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Oct 2021 00:48:08 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:33575 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhJFEsH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Oct 2021 00:48:07 -0400
Received: by mail-wr1-f47.google.com with SMTP id m22so4780931wrb.0;
        Tue, 05 Oct 2021 21:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kl8SHbFH3B0GLoIdNqSDcbwIEzSEiiAzvu57MfFIP6c=;
        b=A1nfBvZiYR3OOFbAVkJweYO0WYtCGvRqsFJwnXmV4BasqPtFRO5aUE3xf3Ic/MXOcC
         LSHZFl0r2TPF5a/dbxCxlQq7vuRZzE7UfAUJp+9noWzMQTSl5MWcrcRWiYqfo0dx51i5
         Zmv9Qa1dHXhIXfzK8okco2Jz19hhTrPQx8rdspcUJvlqZ1tx54LoQcJljGxf17OYIav9
         ilRRmlSYR0qsSDiW5ocFbk34G4XEbZyZVcuK7vENnpA1EFNHPt4I8FF/HlsqEwUm9OPg
         TDYW1lpkGNj6fVHe0AeZoJlFGlt4cHWbYYCzyGXeA30cquyKg0+6cNgXXHSIyjz7kNMY
         sYow==
X-Gm-Message-State: AOAM532xZ+xsgN/oMl9nPTVfrUehW0Vt0x5Ag1Uw8HSpivdzxybwbppc
        iji3NPCsqQhZRH2vpPBELrY=
X-Google-Smtp-Source: ABdhPJwgfDBH6Hf2UaY4xrDNvXseaJXLd+home/uFJopzqk2dmZ9/7Qgr7wlXkjIjbER2Ah4vs1Lng==
X-Received: by 2002:adf:97d4:: with SMTP id t20mr19710014wrb.174.1633495574740;
        Tue, 05 Oct 2021 21:46:14 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id q10sm3718778wmq.12.2021.10.05.21.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 21:46:14 -0700 (PDT)
Message-ID: <6cc7b75f-1606-2150-ab51-af2922108abf@kernel.org>
Date:   Wed, 6 Oct 2021 06:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 2/2] serial: 8250_lpss: Enable PSE UART Auto Flow
 Control
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aman Kumar <aman.kumar@intel.com>
References: <20211005133026.21488-1-andriy.shevchenko@linux.intel.com>
 <20211005133026.21488-2-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211005133026.21488-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05. 10. 21, 15:30, Andy Shevchenko wrote:
> From: Aman Kumar <aman.kumar@intel.com>
> 
> Add a call to the custom ->set_termios() which has implementation about
> changing the state of RTS and CTS.

Worth noting that:
   config SERIAL_8250_LPSS
already does:
         select SERIAL_8250_DWLIB

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Aman Kumar <aman.kumar@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: no changes
>   drivers/tty/serial/8250/8250_lpss.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 398d2c4a40e3..d3bafec7619d 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -164,6 +164,9 @@ static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
>   	 * matching with the registered General Purpose DMA controllers.
>   	 */
>   	up->dma = dma;
> +
> +	port->set_termios = dw8250_do_set_termios;
> +
>   	return 0;
>   }
>   
> 


-- 
js
suse labs
