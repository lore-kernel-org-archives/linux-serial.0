Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA77C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 11 Mar 2022 09:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347460AbiCKJY3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347438AbiCKJY2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Mar 2022 04:24:28 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1764ECD7;
        Fri, 11 Mar 2022 01:23:25 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id x15so11908721wru.13;
        Fri, 11 Mar 2022 01:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HkaluDRfIBgPKvM5VP2e7TcfJa7Yexe98WuSeo75eJA=;
        b=DaWE3cu/q8wRuAqtUNOzekYduNr0G5Jyb5TxrwToZqMwFee3CIvShRJwRtjBDAtvvv
         22BqTfxuIuA1u+KJyHjUdPCZBu6YIgf1ETepGcJA/gH2OxecAP5oEhS8QoGMDG8HYDkO
         88a28RE9hjXbaMcDQKh7dFiu50F8/fFHLArZZfLj5WhcuQ44ui7bnfwMGEIzVd6b8OqA
         yemfAMm+6fXNvend6MXbPWyOic9PBO5ydyPVHpx9XHHVx3HJZxGefkNZNV6n6kbxrcWA
         5XhLxKWWusCNIG60V9YEH2V2lVDNXfPc1oSbSvTMVEpt459N7bymKUjRdHj29A+06vvF
         wXMw==
X-Gm-Message-State: AOAM533Hb39HM2ZM+AXNLwmPeHQValTTQPlwyKi7KpecmU/oFGLeVmIk
        nGp4cR2q4F5YxxweEE9O6QMuHQ8SwOo=
X-Google-Smtp-Source: ABdhPJx1LC3qeZRIdaAk2hWg0bJlaMqaXA1BdM2YRReg/Tc9LSJBwJm4W850U3kly9zm6Ad9zrpU+A==
X-Received: by 2002:a5d:5606:0:b0:1f0:2d8b:2ff6 with SMTP id l6-20020a5d5606000000b001f02d8b2ff6mr6445208wrv.433.1646990604405;
        Fri, 11 Mar 2022 01:23:24 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id u4-20020adfed44000000b0020373d356f8sm6133400wro.84.2022.03.11.01.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:23:23 -0800 (PST)
Message-ID: <7bf43ee7-549e-c98c-1ca9-b5060124c94b@kernel.org>
Date:   Fri, 11 Mar 2022 10:23:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/3] serial: 8250_fintek.c: Clean up set_termios() message
Content-Language: en-US
To:     Trevor Woerner <twoerner@gmail.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
References: <20220311070203.18159-3-twoerner@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220311070203.18159-3-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11. 03. 22, 8:02, Trevor Woerner wrote:
> Clean up the status message that is given in the case where a custom
> termios() is not installed.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   drivers/tty/serial/8250/8250_fintek.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> index 03ad2354d808..dcab23d1965e 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -333,7 +333,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
>   	default:
>   		/* Don't change clocksource with unknown PID */
>   		dev_warn(port->dev,
> -			"%s: pid: %x Not support. use default set_termios.\n",
> +			"%s: chipID: %x not supported; using default set_termios.\n",
>   			__func__, pdata->pid);

So the variable calls it PID, the comment calls it PID and you change 
the report to chipID. Why?

thanks,
-- 
js
suse labs
