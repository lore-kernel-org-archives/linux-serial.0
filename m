Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F009C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 05:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4740561450
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 05:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhDVGAH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 02:00:07 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:35669 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhDVGAH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 02:00:07 -0400
Received: by mail-ej1-f54.google.com with SMTP id u17so66984329ejk.2;
        Wed, 21 Apr 2021 22:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1GbdFrUpiMirOPKIjtQ91RsG3NmT5KsJZdYVvR1dRcE=;
        b=RcxsGUOLUkEJMKGebAMOFYn5HiMgZhqyaHLiA5XDAAOUAl6Z7RNVRFA7LnuAYw6r2F
         tRKDZ8Gskq9Tkg2bptGFeJnmHldO6h1kFmOeYTOw0WjxgCa2TvspETwSudL9juPcXpjJ
         B3GUFBnBi1bL0J6Yk9wkndKfSfYUEFrSGbZdyUHNcXfsigJibxK2n2W+JGNMA6n6yHTI
         J2gO62i8CQGD8wWaSpxg7XG2jaW0HnGI/RupLZ4K+howWikvu/m//QF6SVzASiWZRNnn
         uQdLXVblyR1fschYIQXfuAKdY1xBr4Ly9aizDvC8GxCsavA21ep6644oJLPqRKE5CraT
         49lw==
X-Gm-Message-State: AOAM531sbTW4HOZEmfQfxv/q99W2Yk3AT6DbcagWjUfIpx4+wBLkjXb+
        6BNq7E4x95c56s4ihDUXvnlsiV2pg80=
X-Google-Smtp-Source: ABdhPJwLGDTDDnNkEBbpW0jd1zeIC0qB/FPMnMqfYmGwZKHX8z/NX1CDdILB/kxc/VsT75H6QY6wpA==
X-Received: by 2002:a17:906:3a94:: with SMTP id y20mr1515073ejd.35.1619071171811;
        Wed, 21 Apr 2021 22:59:31 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id o8sm1111432ejm.18.2021.04.21.22.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 22:59:31 -0700 (PDT)
Subject: Re: [PATCH 01/26] tty: mxser: drop low-latency workaround
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210421095509.3024-1-johan@kernel.org>
 <20210421095509.3024-2-johan@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <0b470bd2-742f-0588-83e0-8a6748b37f7a@kernel.org>
Date:   Thu, 22 Apr 2021 07:59:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421095509.3024-2-johan@kernel.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21. 04. 21, 11:54, Johan Hovold wrote:
> Commit 67d2bc58afdd ("Char: mxser_new, fix recursive locking") worked
> around the infamous low_latency behaviour of tty_flip_buffer_push() by
> simply dropping and reacquiring the port lock in the interrupt handler.
> 
> Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
> tty_flip_buffer_push() always schedules a work item to push data to the
> line discipline and there's no need to keep any low_latency hacks around.
> 
> Link: https://lore.kernel.org/lkml/3018694794025219@wsc.cz/T/#m06b04c640a7b6f41afb3d34a4cf29b1df4935d3a
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/mxser.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> index 2d8e76263a25..16a852ecbe8a 100644
> --- a/drivers/tty/mxser.c
> +++ b/drivers/tty/mxser.c
> @@ -2155,14 +2155,7 @@ static void mxser_receive_chars(struct tty_struct *tty,
>   	port->mon_data.rxcnt += cnt;
>   	port->mon_data.up_rxcnt += cnt;
>   
> -	/*
> -	 * We are called from an interrupt context with &port->slock
> -	 * being held. Drop it temporarily in order to prevent
> -	 * recursive locking.
> -	 */
> -	spin_unlock(&port->slock);
>   	tty_flip_buffer_push(&port->port);
> -	spin_lock(&port->slock);
>   }
>   
>   static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port)
> 

thanks,
-- 
js
