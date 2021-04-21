Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5B9C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 17:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21B961422
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 17:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbhDURoy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243195AbhDURox (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 13:44:53 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9E2C06138A
        for <linux-serial@vger.kernel.org>; Wed, 21 Apr 2021 10:44:20 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so13721636otp.11
        for <linux-serial@vger.kernel.org>; Wed, 21 Apr 2021 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/BXgNj41Emp91IJeL0ZlkH3BYkvRGM2ZK7KMf3kiC2k=;
        b=h/C+48D3PWUs4Qa4ZPOAwY8TrqzbXXo7UVZV6OX3mmtt9fcljbqJW+5YzG9/DdCXPm
         hydSzJb6OP7nm+xP0El44tu2I3HBS5C9MXDNIrCx4uuvwluUwms2cNg94g/f+AWCs7fQ
         Q7T68Kx16FRshI4fuDH5e4RKj1+CkkeUKlJOAw297TuRdyZs8uzgoD4XWN3OyAyBdUJH
         3C2j5ojCgzwG6Z/5FCmNX7fv2ftms+ppXIEKE7ekqZXfs34nHv6vrQvNLXXXTO6jkBwM
         3+syuou8IO7MyN9zbrI+jGgiacAx/t5fh9uPXXTpeg8+oUeCuw7wpe0z7SbYiQY9QDvf
         8CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/BXgNj41Emp91IJeL0ZlkH3BYkvRGM2ZK7KMf3kiC2k=;
        b=IcDcFa8S3qCCToU8YlPaxd6jnGf5pSVl/EpjskLVTPgcdwicYeR3rnfFBCjWfYS0jB
         vDMY+H/DAsI6oqzWGQCJEv71m8ywSN+vQwSLpm40yJCJMSn7157IaM1Sg2Cf2uvW43L3
         OavEdV/dGc/KhocFO/g0Vg6UfNorqIJ6SEUmPvb2ejveK9UUmZ/LuoclJEqSxi1xNhYn
         b87QQIXwM67pqm0Mg6rNzpYNx/sJ+ufcMxdQO3lGYHTG/9FF4ZlW6kXYxA+60xbd+ohx
         4W56sfHMai57qvnurCPBPeVKDeCViWNX0h1Pu5daIpKvN9etEbCnuwuj3qauQfir0d4p
         bn0w==
X-Gm-Message-State: AOAM532m8HOOs8HZMx9r2do7JH89VQFh+tGReBQki83jh1MYWoB4nBkx
        tToUfT3e5+ukVL9MTnRGds5+fA==
X-Google-Smtp-Source: ABdhPJwN8IraGxuBnTNo7hsiM2YWM0ZjJ0I5M+X9SqgmTNPLdHgCZxVQJHgAT0mNWcp454SgFLSGCQ==
X-Received: by 2002:a9d:7342:: with SMTP id l2mr24289310otk.175.1619027060206;
        Wed, 21 Apr 2021 10:44:20 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t3sm59071ooa.18.2021.04.21.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:44:19 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:44:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 16/26] serial: msm_serial: drop low-latency workaround
Message-ID: <20210421174417.GA1908499@yoga>
References: <20210421095509.3024-1-johan@kernel.org>
 <20210421095509.3024-17-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421095509.3024-17-johan@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed 21 Apr 04:54 CDT 2021, Johan Hovold wrote:

> Commit f77232dab25b ("tty: serial: msm: drop uart_port->lock before
> calling tty_flip_buffer_push()") claimed to address a locking
> issue but only provided a dubious lockdep splat from an unrelated
> driver, which in the end turned out to be due a broken local change
> carried by the author.
> 
> Unfortunately these patches were merged before the issue had been
> analysed properly so the commit messages makes no sense whatsoever.
> 
> The real issue was first seen on RT which at the time effectively always
> set the low_latency flag for all serial drivers by patching
> tty_flip_buffer_push(). This in turn revealed that many drivers did not
> handle the infamous low_latency behaviour which meant that data was
> pushed immediately to the line discipline instead of being deferred to a
> work queue.
> 
> Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
> tty_flip_buffer_push() always schedules a work item to push data to the
> line discipline and there's no need to keep any low_latency hacks
> around.
> 
> Link: https://lore.kernel.org/linux-serial/cover.1376923198.git.viresh.kumar@linaro.org/
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/msm_serial.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 770c182e2208..fcef7a961430 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -757,9 +757,7 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
>  		count -= r_count;
>  	}
>  
> -	spin_unlock(&port->lock);
>  	tty_flip_buffer_push(tport);
> -	spin_lock(&port->lock);
>  
>  	if (misr & (UART_IMR_RXSTALE))
>  		msm_write(port, UART_CR_CMD_RESET_STALE_INT, UART_CR);
> @@ -819,9 +817,7 @@ static void msm_handle_rx(struct uart_port *port)
>  			tty_insert_flip_char(tport, c, flag);
>  	}
>  
> -	spin_unlock(&port->lock);
>  	tty_flip_buffer_push(tport);
> -	spin_lock(&port->lock);
>  }
>  
>  static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
> -- 
> 2.26.3
> 
