Return-Path: <SRS0=CfSU=CE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0ACC433E1
	for <linux-serial@archiver.kernel.org>; Wed, 26 Aug 2020 13:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6537214F1
	for <linux-serial@archiver.kernel.org>; Wed, 26 Aug 2020 13:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHhyO1L8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgHZN3s (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbgHZN3l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Aug 2020 09:29:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AECC061574;
        Wed, 26 Aug 2020 06:29:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q14so1798780wrn.9;
        Wed, 26 Aug 2020 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M20VE+d1SyikYkPKQp699LgJh3dwsjKIjrFsf14di5g=;
        b=FHhyO1L8sY6MS5WHEtlc4/NqyzCjRgvoNYTuHP/1jtgFJVRj4V50vmQTTaPaHz6fJr
         HFs4AVo9mww7WCtJpbD5pwq8lPYEVdFdGAxBPUo2KoDz9srxOPAiiCRbXlBg6ZePDSVM
         xjJQR9XSizQnfbxfYmlisuuEVToUXVWPc0JBpErb0RPzCLVu3kXufV0Ix2PpaJ40eN43
         fKrkwXshFbA7VtqWVZ9q9ZQHCgOBqcPCgYFECsH+vSLNtttBxn5fWZZcWa+4ZLP+uNEU
         zxYyAtAGzcJp2JR8yrHKNX7/PdXgic78a0DYNbWwv4GeePrZHPU+Tz4hFJkOEyBezK4r
         ptFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M20VE+d1SyikYkPKQp699LgJh3dwsjKIjrFsf14di5g=;
        b=bAhI2rTO1bGIbqKdiSUp75jEDkJkS0zbOnf8YgJaYGfAmTJ+iVZePWpREnf1PqAw2/
         a7s9CBKOF5dmUUnVhM4nqfCP6PHmpMgFw3si+9UXZkwwcKBFjfoK9q9ZXUH3lO9to5ol
         78vSRA6TjiFWNHJD9T0GScGhp+LC1ZHZthr3aOIo+W84v9uIkEGa/UrvtOMdJICsWp6f
         ArG/zQMTO4An5/MhqRWtCLNkWtWyKGEdH/MYvV9exKywu/qVVFIIUPAeHCfTO1Hh2lW+
         JdeANzDfO9ck/c5B92MHXDHKIGeTq2/AId28WqqAjj+Wk+FE2s/KNPVZCzZ80cApanqc
         3COw==
X-Gm-Message-State: AOAM530fpxU46559lUOW7rvQ2DZaWoAEwXwI7g7dFtR7Oh9M1DskUb8h
        327Iu9lWCe7VMy9tSedtl5pE0YmjhS8=
X-Google-Smtp-Source: ABdhPJzPk54iIX/ihiy1jYrgubw5zGiw5BO3bEK5G402jVzuUDX27vGZrhSkq1vRpVx7mbIeReCj3Q==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr4287642wrs.121.1598448579894;
        Wed, 26 Aug 2020 06:29:39 -0700 (PDT)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id 5sm5874350wmg.32.2020.08.26.06.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 06:29:39 -0700 (PDT)
Subject: Re: [PATCH 2/4] tty: atmel_serial: convert tasklets to use new
 tasklet_setup() API
To:     Allen Pais <allen.cryptic@gmail.com>, gregkh@linuxfoundation.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
References: <20200817085921.26033-1-allen.cryptic@gmail.com>
 <20200817085921.26033-3-allen.cryptic@gmail.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <422885e6-9ffe-e525-1ea1-3cf4e6d3bf7c@gmail.com>
Date:   Wed, 26 Aug 2020 15:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817085921.26033-3-allen.cryptic@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 17/08/2020 à 10:59, Allen Pais a écrit :
> From: Allen Pais <allen.lkml@gmail.com>
> 
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>  drivers/tty/serial/atmel_serial.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index e43471b33710..a9c47f56e994 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1722,10 +1722,11 @@ static int atmel_prepare_rx_pdc(struct uart_port *port)
>  /*
>   * tasklet handling tty stuff outside the interrupt handler.
>   */
> -static void atmel_tasklet_rx_func(unsigned long data)
> +static void atmel_tasklet_rx_func(struct tasklet_struct *t)
>  {
> -	struct uart_port *port = (struct uart_port *)data;
> -	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	struct atmel_uart_port *atmel_port = from_tasklet(atmel_port, t,
> +							  tasklet_rx);
> +	struct uart_port *port = &atmel_port->uart;
>  
>  	/* The interrupt handler does not take the lock */
>  	spin_lock(&port->lock);
> @@ -1733,10 +1734,11 @@ static void atmel_tasklet_rx_func(unsigned long data)
>  	spin_unlock(&port->lock);
>  }
>  
> -static void atmel_tasklet_tx_func(unsigned long data)
> +static void atmel_tasklet_tx_func(struct tasklet_struct *t)
>  {
> -	struct uart_port *port = (struct uart_port *)data;
> -	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	struct atmel_uart_port *atmel_port = from_tasklet(atmel_port, t,
> +							  tasklet_tx);
> +	struct uart_port *port = &atmel_port->uart;
>  
>  	/* The interrupt handler does not take the lock */
>  	spin_lock(&port->lock);
> @@ -1911,10 +1913,8 @@ static int atmel_startup(struct uart_port *port)
>  	}
>  
>  	atomic_set(&atmel_port->tasklet_shutdown, 0);
> -	tasklet_init(&atmel_port->tasklet_rx, atmel_tasklet_rx_func,
> -			(unsigned long)port);
> -	tasklet_init(&atmel_port->tasklet_tx, atmel_tasklet_tx_func,
> -			(unsigned long)port);
> +	tasklet_setup(&atmel_port->tasklet_rx, atmel_tasklet_rx_func);
> +	tasklet_setup(&atmel_port->tasklet_tx, atmel_tasklet_tx_func);
>  
>  	/*
>  	 * Initialize DMA (if necessary)
> 

Thanks !
