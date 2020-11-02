Return-Path: <SRS0=k0O3=EI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AA8C388F2
	for <linux-serial@archiver.kernel.org>; Mon,  2 Nov 2020 08:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54F1206B7
	for <linux-serial@archiver.kernel.org>; Mon,  2 Nov 2020 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604305239;
	bh=FVegyoQJBoXw0WzVfGKZ6LKuCHHeaF0aAhVJrpvHLJs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Z4oaF3e4Yy0gqL3luK/OpWPwgC7QdnojLqaz/KSviAyMTzrZe8hMNtsfjlTJY6yl3
	 xl4M1CwU+5gEnbFtijhPAEFmMoyjA3sR8RnRG8kcGAXgCQZe3mvBXkOzPoLtiSCEfC
	 qaqLZ8ZcDjrhDQbyj51DjIYLKxGr0JsKKcbptHqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgKBIUi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Nov 2020 03:20:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45736 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKBIUi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Nov 2020 03:20:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id dg9so13410667edb.12;
        Mon, 02 Nov 2020 00:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JFdWs1n+nOMQPwW9LaFw1RnZSb9E99wPePrYCo/tsdE=;
        b=ATsXiJXGkylTV3evoIEbdeq+ViyYagu4gG5Gy+8Tn449wqhHUZ+bVYBSdSQLPN8eh0
         p4ZqNTwX1VeQyUj9zGVrPNdYdYrMNzvBvUp5UwTWXAjcIXHFBrDS3ZSxb5beI520arNU
         0aPd+frWcNssFmwLJW5AsLpHeIjvSjtVDEjtn5R5sg5l+O2JWV4mIVeuAWdh9MNV4f1Y
         qFda+zcDlnpbIEYtYA3vD6WgJACu1Ik/o26IhaVg2Q3EtTOEd+oV1OK9i4iZv88aBQWw
         BogVo5fzuTnP16jUHoGNe2G/32fgs+pNjlTUDJ7CfZlya80fMkgvSVMGY6wNlg9qrCF4
         Do3g==
X-Gm-Message-State: AOAM533xlGuGZ14Aecxalgp7Jsu1z2V7S7fw61w6GkYjN/JXzJ6gQsSI
        c5x1sp1srQe2XfR/NW6+YafpI5yvROA=
X-Google-Smtp-Source: ABdhPJy5/j95eHs+Q7mErgm1AEVXD0PAOp8St/ciecRQIdQ/VEQdW1FSk7WFVB3euMEfT5w3vhUDhA==
X-Received: by 2002:a05:6402:78b:: with SMTP id d11mr15831823edy.82.1604305236211;
        Mon, 02 Nov 2020 00:20:36 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id f24sm770365edx.90.2020.11.02.00.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 00:20:35 -0800 (PST)
Subject: Re: [PATCH] serial: mctrl_gpio: Fix passing zero to 'ERR_PTR' warning
To:     YueHaibing <yuehaibing@huawei.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201031030530.1304-1-yuehaibing@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <e8d9c560-dfd4-8419-a768-6a832114e7ea@kernel.org>
Date:   Mon, 2 Nov 2020 09:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201031030530.1304-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31. 10. 20, 4:05, YueHaibing wrote:
> drivers/tty/serial/serial_mctrl_gpio.c:214
>   mctrl_gpio_init() warn: passing zero to 'ERR_PTR'
> 
> gpiod_to_irq() never return 0, so remove the useless test
> and make code more clear.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/serial_mctrl_gpio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index fb4781292d40..c41d8911ce95 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -207,7 +207,7 @@ struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx)
>   			continue;
>   
>   		ret = gpiod_to_irq(gpios->gpio[i]);
> -		if (ret <= 0) {
> +		if (ret < 0) {
>   			dev_err(port->dev,
>   				"failed to find corresponding irq for %s (idx=%d, err=%d)\n",
>   				mctrl_gpios_desc[i].name, idx, ret);
> 


-- 
js
suse labs
