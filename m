Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A16DC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 05:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhKWFaU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 00:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhKWFaU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 00:30:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C12C061574
        for <linux-serial@vger.kernel.org>; Mon, 22 Nov 2021 21:27:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so1161631pjb.5
        for <linux-serial@vger.kernel.org>; Mon, 22 Nov 2021 21:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E7BbUIlesfkOhayyB12efR7YDMQTb0W3aniIiAUcvHM=;
        b=SomYGoXSVxHg+hmlfO/ZiuiXrk5Dp9suJdRpTAEnRqg7qpYTKsa+fzYqz47VIf2CQc
         vHQ6wV8n7qsH+GSYngpdje+dvMmcOWXeng0U8txg+8Ds5/64OLQQ/2se+20+msZ5X0+C
         0E/WGSkWgATl8R3Hi1FPjq2uGLTrRAQPcKPUgC1ypNES2cf3jMAuv10l8KbP7JN9vv2D
         z3xSo2ndgXECG+GIJoPJoowG2fhWEV5YhvVguwARWbfFa9SeTzV+8XIpBufrBYrgQlsy
         7X8M3HLS++Ewt3E0tNkK0SSdmvrCLLGZte+9pY8b1Z85pt+rL6zgKEjvPF1Ll0swSBHJ
         KVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E7BbUIlesfkOhayyB12efR7YDMQTb0W3aniIiAUcvHM=;
        b=XBR/ubkTElS/lYw0c723LF7kHSuXf8ZybwCK4g4FYbK2blBsWGJ/8u+H5WRuYcrfm1
         ggXj/V6S/lRDEqLUW4RFfl1YXUdBdJE0xJHkG0igyey90XBdO6ujQuTK5buWN23VG15O
         Fe/cg6KqUVZCiLXwolNgdRNeixNhq5Fu/CXZ35JZGKkcFhfW1ju5GIvYL9pbFVWozn2+
         5hGwIpXF63Y4Wyb1BuYNk2HkzY/rzf1lHJSDHnaWPymbKoRVG2/pw82pahVgKQvCqYNE
         KGAAXWHJ14zUZG+CVRpNd9crZNCi6zvHYomxMrKc6mvyJFO3bo9Aw9eMVz8a3IN+ABqU
         4VFA==
X-Gm-Message-State: AOAM530WoFmC4Z6iFj7jfRTf77H/FPOpVqlYxkaWgRTz7nRAL3DNNaOH
        2QkNFmFwWZzzB9l6arfQHdtM
X-Google-Smtp-Source: ABdhPJxWJepKH8ODF6LwA9EiM5IvxrnwXyb3CGSPxc6p/GHYEzkfZyrqnPdt6r0dJdMJ5Rv1RLhrkQ==
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr3417551pjb.22.1637645232221;
        Mon, 22 Nov 2021 21:27:12 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id e11sm9105899pjl.20.2021.11.22.21.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 21:27:11 -0800 (PST)
Subject: Re: [PATCH v2 3/3] serial: 8250_pericom: Use serial_dl_write()
 instead of open coded
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
References: <20211122133512.8947-1-andriy.shevchenko@linux.intel.com>
 <20211122133512.8947-4-andriy.shevchenko@linux.intel.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <d7809017-f544-c60c-728b-4f9015fbad43@accesio.com>
Date:   Mon, 22 Nov 2021 21:27:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122133512.8947-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/22/21 5:35 AM, Andy Shevchenko wrote:
> It's better to stick with standard API to write and read DL value
> when the hardware is compatible with it. In case any quirks are
> needed it may be easily added in one place rather than modifying
> code here and there.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_pericom.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
> index f0d026325f17..025b055363c3 100644
> --- a/drivers/tty/serial/8250/8250_pericom.c
> +++ b/drivers/tty/serial/8250/8250_pericom.c
> @@ -70,11 +70,11 @@ static void pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
>   		/* Update delta due to possible divisor change */
>   		delta = maxrate / divisor - baud;
>   		if (abs(delta) < baud / 50) {
> +			struct uart_8250_port *up = up_to_u8250p(port);
>   			int lcr = serial_port_in(port, UART_LCR);
>   
>   			serial_port_out(port, UART_LCR, lcr | 0x80);
> -			serial_port_out(port, UART_DLL, divisor & 0xff);
> -			serial_port_out(port, UART_DLM, (divisor >> 8) & 0xff);
> +			serial_dl_write(up, divisor);
>   			serial_port_out(port, 2, 16 - scr);
>   			serial_port_out(port, UART_LCR, lcr);
>   			return;
> 

I tested this change with a few baud rates in my current tree, and I saw 
the correct speeds coming out on the scope.
