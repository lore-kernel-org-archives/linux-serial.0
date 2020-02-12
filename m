Return-Path: <SRS0=7071=4A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F12C2BA83
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 11:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987532073C
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 11:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asC2bVXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBLLTh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:19:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51797 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLLTh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Feb 2020 06:19:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so1753498wmi.1;
        Wed, 12 Feb 2020 03:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HTAbsiExrv4QW5/STpGu+6w7JGxPZpOjJdCEoGEBulE=;
        b=asC2bVXdzvBx2cv631MWiOZTxgICbuneQqKi8jfIo5dqiZz0iQBe81K/qJOaxhm6Rs
         3Zw+GgWiVagyFqB07np+5rwwcH598FjsDyOChfSCPUsoC8IlWL5MusYCKHfZ+NSBG0Uy
         8Ypisw0s6+NJL73FtztJHvi84kXMdy+QLlq48H69RO5NeSFhgGpfv3uJY8ogDRPNQPl0
         CICVXNayohk4XXsQiP59rNGzOnXzIXcGr2JAf3fuQyj9ke8nBLUgWXwgY+v5u3RU9BD6
         Cp15qkrpgkjyEf4QKF83kFQBXnlnKZzzQk/0jaTeWhf+Pp/kzC1qCCWs9MZhScTZaWel
         KMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HTAbsiExrv4QW5/STpGu+6w7JGxPZpOjJdCEoGEBulE=;
        b=qDxEhOcnuCD6GF9rF4fa20WIQ0xb8+nKVllb8VTR5OHQTUw/uuN4ed6v/uEzU3xWTe
         BxtmRzrMxjKAmvkxh7zr/IVaY9ps/KSIrFclkrEOrdJ/vxkxw27LewIxS1mmbSwrrYPK
         5M5fadGYnEd7ZoxsY0MoK8UwY/kL0JloyQ666Usj64znv+c5G9yXMSzDo1O8DGwXHhAO
         e75qm4GnwRvji4rAAqoa2tUGj1BoArQdO5T3+aPggTAyzWJOiyVP54YaTu2ILwsItfQg
         esT3UVitLnPsJBRrB+iBcL1bJS6JI+zeY/kushlrAaitHP0/gkFNg36jakDt94OcQY61
         6YXw==
X-Gm-Message-State: APjAAAUr/V6nkLzVAy9qH7b2akyAPSDI1tU6GU/gfGrl3pUr9MUpAcZq
        k0nUf/NGXs3U0E5CcdVJEcg=
X-Google-Smtp-Source: APXvYqwkFBJvPdmgKxekMrEjI+4BX8KddY4MNX3CmIouqTPCRhht4uH4TzYx/UcbXZMVAfkKZRPdog==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr12685206wmi.51.1581506375637;
        Wed, 12 Feb 2020 03:19:35 -0800 (PST)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id m21sm300439wmi.27.2020.02.12.03.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:19:34 -0800 (PST)
Subject: Re: [PATCH] tty/serial: atmel: manage shutdown in case of RS485 or
 ISO7816 mode
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
References: <20200210152053.8289-1-nicolas.ferre@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <f40181d1-3781-2cd9-11b3-420ef0d29ce7@gmail.com>
Date:   Wed, 12 Feb 2020 12:19:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210152053.8289-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 10/02/2020 à 16:20, Nicolas Ferre a écrit :
> In atmel_shutdown() we call atmel_stop_rx() and atmel_stop_tx() functions.
> Prevent the rx restart that is implemented in RS485 or ISO7816 modes when
> calling atmel_stop_tx() by using the atomic information tasklet_shutdown
> that is already in place for this purpose.
> 
> Fixes: 98f2082c3ac4 ("tty/serial: atmel: enforce tasklet init and termination sequences")
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>  drivers/tty/serial/atmel_serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index c15c398c88a9..a39c87a7c2e1 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -570,7 +570,8 @@ static void atmel_stop_tx(struct uart_port *port)
>  	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
>  
>  	if (atmel_uart_is_half_duplex(port))
> -		atmel_start_rx(port);
> +		if (!atomic_read(&atmel_port->tasklet_shutdown))
> +			atmel_start_rx(port);
>  
>  }
>  
> 

