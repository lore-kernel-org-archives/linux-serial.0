Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8CAC433B4
	for <linux-serial@archiver.kernel.org>; Thu, 29 Apr 2021 09:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B72D6143F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Apr 2021 09:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhD2J2l (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Apr 2021 05:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237366AbhD2J2k (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Apr 2021 05:28:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77463C06138C;
        Thu, 29 Apr 2021 02:27:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x7so66082576wrw.10;
        Thu, 29 Apr 2021 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sHv+t9w1wAMsbIM5VHr+smQOf+tyPUMFdSQ+YdNerTg=;
        b=LlBSVRTCtVIOrBU1AIHYSFyCjDUySKyzOG6CAIS1yFRuE4b9MBvYh4XrbWfO32IdYG
         6g1jPO/861wrXyU4AYIUETm+iHqGgrwaPSfkLr5q41S4xP1o0zzlBLCCKKTDRKxONCAE
         XsBoRal7KdvVIsIeVk8xb9xvc7hlRFDNeA03Sf0+4ohBIotHstEe+cuW6nJsalBtL67D
         y36ktx1RoVBsKu3pkhg4DxZpCWdAQzr4TngGd0WaQookUL52Y4BUD8Cb5YjeiNcnv8WJ
         RY0zUTcdkusDaN/tFeJPuI6//wa7cY1hj55jmkbwxfYm1t0psTcEHv2URpXdqex9cmrh
         B+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHv+t9w1wAMsbIM5VHr+smQOf+tyPUMFdSQ+YdNerTg=;
        b=MfDcHsSvymdj8/wnWhvY3rvelOt66e1k9jNODJ+zmeataJR3ADkpSS4bQBHo6ctuJe
         9hHZVtcLzhtkLRT0bnUdltZhyXVtDfM+E1HxmRexgKKvR/67CesFVirClg3JpqEekC7T
         9WWBY2DJvBQDCLqfq6M5fpfK/7vn3nBPoxRju9y+p4/3pjYsxnuXy3XY5GFTwRc/ABmU
         6o5dHYzjXuKwzPQxBxhjmpyp7M+CjHUNTFE7/QKUQyIPk4lvQRUBsJh6tEsi2aqw5d/c
         yT7J2pVaookbATKj9R364H/m3wG3dg5YXz+Q+zatYjhVAiNrnrROg/KXRMCaYJ2OclNt
         2sJw==
X-Gm-Message-State: AOAM532th5d3I8f2ZecE6A0ZPipoj6SvEiIdOccQXGRCYmQA/kpTMtMu
        eR6pOMT+hOG9bEOoEBLn3noyQCGmDms=
X-Google-Smtp-Source: ABdhPJw40X1ijqMJIItMnswZOauNBA6lQ0H59WZMpduPH4NU8O7YAHx9dhQnilWfYMRsXurU0YoHIQ==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr9063889wrj.75.1619688472301;
        Thu, 29 Apr 2021 02:27:52 -0700 (PDT)
Received: from [192.168.1.20] ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id m2sm9194674wmq.15.2021.04.29.02.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 02:27:51 -0700 (PDT)
Subject: Re: [PATCH] serial: 8250_omap: fix a timeout loop condition
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YIpd+kOpXKMpEXPf@mwanda>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <960e9d26-8840-d6b6-b368-0ca79fc52544@gmail.com>
Date:   Thu, 29 Apr 2021 11:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIpd+kOpXKMpEXPf@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Dan!

On 29/04/2021 09:19, Dan Carpenter wrote:
> This loop ends on -1 so the error message will never be printed.
> 
> Fixes: 4bcf59a5dea0 ("serial: 8250: 8250_omap: Account for data in flight during DMA teardown")

Looks good to me!
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 8ac11eaeca51..c06631ced414 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -813,7 +813,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
>  			       poll_count--)
>  				cpu_relax();
>  
> -			if (!poll_count)
> +			if (poll_count == -1)
>  				dev_err(p->port.dev, "teardown incomplete\n");
>  		}
>  	}
