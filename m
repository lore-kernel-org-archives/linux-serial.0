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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4250FC10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 16:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13506222C3
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 16:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4IqOM8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCJQlC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:41:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46123 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgCJQlC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 12:41:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so16718925wrw.13
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2020 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aOKjYR4VAMIOrBTE94cm5uPVu1EbOcBlTopUOCLhCLE=;
        b=b4IqOM8DXLMaEczT43wBOeGzAfD4kDZl6bPtwZrKcNw22OsLxPHray0oVI/5vk2Tnw
         FwEvntA762V/7tA8l///ipIqDACr6TzuNTy8Vz31xZCecdTEJthAyzaZjzCyDGJjSM7E
         OdwPPu57JlGNq27w1pvG2q6gTwNljPZ9ki4Ts4TCzZm42G9h0cS485BlATAu9EyH3eAU
         oW6Ys1Uho0x6+Fz5NH4NhYclZpRtlhXrJwsifFuyGLSWhlcVNxpAj20Z3Fs4bjd/4nyS
         Uu0UfLkkCNUijFA9jArJ4rebySvS3jdq9wHQFwV0pf+69Mo7PTrCBvpeQFamz+RGmTkl
         cWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aOKjYR4VAMIOrBTE94cm5uPVu1EbOcBlTopUOCLhCLE=;
        b=hUryiJD0SNFFyyQpZ9UKUtCYA7oipAENal6u9OFcQz1d/zxvGlaeLmavaRkGaQMJfv
         k4rcu0H9yG7gclNRtmurKcyZ5Fw9IDSxnfxWItO+uKXTrG+kbKFbmGBLFp7omIqRTeaz
         IdIYVV61qPXvuQvC+y6eYGIVt6c062Q7mXGZNUOvfkoDB6biEbCOVWoq6D9rI7r3B+/Q
         Tj6OQgH98FeQUTtGhd+WiQXwPvWryBCZbTLkpHWMvGGuNaVWxJDdJYumXZbUUijLuwxr
         ppdDc9ExrVYEUI4waO0WA3mNffy169USh9Jq/ncgPUdqNqawUE/RUNt1CoxQtXDHsv1f
         b1gg==
X-Gm-Message-State: ANhLgQ2eS/t4DbFHpwpUP/gCBDbLhtHyEim1Jhi2fRxpPcXjp12KdHNV
        F+Ob6KIvfqcpKe0sgIN/PY3fbsQO
X-Google-Smtp-Source: ADFU+vuxn+oMhu1XF9VugNle/akYO9Mq3Mu4FD7fRzbfoO96aSf4zwYKaFg6h9YpgLjZrJeaB47g5w==
X-Received: by 2002:adf:fe84:: with SMTP id l4mr28304889wrr.1.1583858460458;
        Tue, 10 Mar 2020 09:41:00 -0700 (PDT)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id r3sm4769527wmg.19.2020.03.10.09.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 09:40:59 -0700 (PDT)
Subject: Re: [PATCH v1] tty/serial: atmel: Use uart_console() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200310133057.86840-1-andriy.shevchenko@linux.intel.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <6dc75333-5e7b-8e3f-d60e-4bdeb8c686b2@gmail.com>
Date:   Tue, 10 Mar 2020 17:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310133057.86840-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 10/03/2020 à 14:30, Andy Shevchenko a écrit :
> Use uart_console() helper in instead of open coded variant.
> 
> Note, SERIAL_CORE_CONSOLE is selected by SERIAL_ATMEL_CONSOLE,
> thus no functional changes expected.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>  drivers/tty/serial/atmel_serial.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 187987a5b707..53b1d135f53b 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2640,18 +2640,8 @@ static struct console atmel_console = {
>  
>  #define ATMEL_CONSOLE_DEVICE	(&atmel_console)
>  
> -static inline bool atmel_is_console_port(struct uart_port *port)
> -{
> -	return port->cons && port->cons->index == port->line;
> -}
> -
>  #else
>  #define ATMEL_CONSOLE_DEVICE	NULL
> -
> -static inline bool atmel_is_console_port(struct uart_port *port)
> -{
> -	return false;
> -}
>  #endif
>  
>  static struct uart_driver atmel_uart = {
> @@ -2680,14 +2670,14 @@ static int atmel_serial_suspend(struct platform_device *pdev,
>  	struct uart_port *port = platform_get_drvdata(pdev);
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  
> -	if (atmel_is_console_port(port) && console_suspend_enabled) {
> +	if (uart_console(port) && console_suspend_enabled) {
>  		/* Drain the TX shifter */
>  		while (!(atmel_uart_readl(port, ATMEL_US_CSR) &
>  			 ATMEL_US_TXEMPTY))
>  			cpu_relax();
>  	}
>  
> -	if (atmel_is_console_port(port) && !console_suspend_enabled) {
> +	if (uart_console(port) && !console_suspend_enabled) {
>  		/* Cache register values as we won't get a full shutdown/startup
>  		 * cycle
>  		 */
> @@ -2723,7 +2713,7 @@ static int atmel_serial_resume(struct platform_device *pdev)
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  	unsigned long flags;
>  
> -	if (atmel_is_console_port(port) && !console_suspend_enabled) {
> +	if (uart_console(port) && !console_suspend_enabled) {
>  		atmel_uart_writel(port, ATMEL_US_MR, atmel_port->cache.mr);
>  		atmel_uart_writel(port, ATMEL_US_IER, atmel_port->cache.imr);
>  		atmel_uart_writel(port, ATMEL_US_BRGR, atmel_port->cache.brgr);
> @@ -2877,7 +2867,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
>  		goto err_add_port;
>  
>  #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
> -	if (atmel_is_console_port(&atmel_port->uart)
> +	if (uart_console(&atmel_port->uart)
>  			&& ATMEL_CONSOLE_DEVICE->flags & CON_ENABLED) {
>  		/*
>  		 * The serial core enabled the clock for us, so undo
> @@ -2920,7 +2910,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
>  	kfree(atmel_port->rx_ring.buf);
>  	atmel_port->rx_ring.buf = NULL;
>  err_alloc_ring:
> -	if (!atmel_is_console_port(&atmel_port->uart)) {
> +	if (!uart_console(&atmel_port->uart)) {
>  		clk_put(atmel_port->clk);
>  		atmel_port->clk = NULL;
>  	}
> 

Thanks !
