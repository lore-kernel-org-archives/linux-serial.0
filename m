Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF2C433E3
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 05:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B246D20709
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597729354;
	bh=nAs17kp1y9OHZ3MsLK2pOcWJA+U0AXsIdOQeLq58/+U=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=avuc7fXiuu6xy3sovCVZYFnTdppLqlYu3ZzLr+zgmykUU57NT8AYgdtb1/KViw+Rq
	 OuYuWai+4rXBa937kiUGfEoxiTyFZyC4OS7DSo8YLMXuK17bK2Ww/1S3uEA+UMeQME
	 qqHtuIhm6c0uiKqto97E+Herp57bf7UOrEPw7LvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHRFme (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:42:34 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37018 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRFmd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 01:42:33 -0400
Received: by mail-ej1-f67.google.com with SMTP id qc22so20577054ejb.4;
        Mon, 17 Aug 2020 22:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1tVz7UT+SvsNDotol38wN9NUomwuxLq4eSOdjboG+OY=;
        b=eII3H7oLNtReXuSTcSLRJbono5IJ5z1Dbt033YzmNIrFhrEOh6DF1keS2mZDP1NrsW
         UGnW8jVScgSD6wn58LXhRMurD7mgIn46OxEnkNotK5k5zlHgGELmeqIaNu46nT6ORvEF
         YZalgzTmMctNVuaVx+/bZxitH1nqFWVZw10W/Cderv6mkqed9MHAam2GXJMy1nFsBa9J
         pitZwTWAQg8ht/RiH7k9UCjUX+EFtG4P5Axmd+/KKAXMACUDo/Z8761M23iE8xAWAnMY
         +45dXczc4AXuFkWG8GMHrdbx78j3Tz0qchcLcI+W4hX9Kz4c1XmK7P1cH/CzyYhoVYV5
         sWAA==
X-Gm-Message-State: AOAM532/DIX+CoblL+1Od8t/BYGsUU6WZ12UpqHIPcwvAeyJP25sTfiF
        pkLrE/BbR50UvskB4q7Oq9qAF/65OlE=
X-Google-Smtp-Source: ABdhPJwDhpmTxHUv/rAR858626yDAWiLDUAqQgeA5SJPCXuVD9+jaHiH0SIIZAKI5WxInsWGT+HVjw==
X-Received: by 2002:a17:906:3cc:: with SMTP id c12mr17804853eja.222.1597729351225;
        Mon, 17 Aug 2020 22:42:31 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i9sm15678045ejb.48.2020.08.17.22.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 22:42:30 -0700 (PDT)
Subject: Re: [PATCH v2] Fixes: tty: serial: earlycon dependency
To:     Tong Zhang <ztong0001@gmail.com>, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Hurley <peter@hurleysoftware.com>
References: <20200817170038.GA725471@kroah.com>
 <20200817185419.1133596-1-ztong0001@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <603a20ef-fe09-c4ae-11d0-3f1dc7b87580@kernel.org>
Date:   Tue, 18 Aug 2020 07:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817185419.1133596-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 17. 08. 20, 20:54, Tong Zhang wrote:
> parse_options() in drivers/tty/serial/earlycon.c calls uart_parse_earlycon
> in drivers/tty/serial/serial_core.c therefore selecting SERIAL_EARLYCON
> should automatically select SERIAL_CORE, otherwise will result in symbol
> not found error during linking if SERIAL_CORE is not configured as builtin
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

The "Fixes:" keyword should not have been in the Subject but here.
According to your findings something like this:

Fixes: 73abaf87f01b (serial: earlycon: Refactor parse_options into
serial core)

I am not sure:
1) it should be "select" (and not "depends")
2) serial earlycon should depend on serial core. But it's likely OK.

>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 8a0352eb337c..42e844314cbb 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -8,6 +8,7 @@ menu "Serial drivers"
>  
>  config SERIAL_EARLYCON
>  	bool
> +	select SERIAL_CORE
>  	help
>  	  Support for early consoles with the earlycon parameter. This enables
>  	  the console before standard serial driver is probed. The console is
> 

thanks,
-- 
js
suse labs
