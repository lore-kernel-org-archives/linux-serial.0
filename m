Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DDFC4361B
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 11:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6E623A22
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 11:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgLIL1B (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:27:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39417 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgLIL1B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 06:27:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id o24so1868439ljj.6
        for <linux-serial@vger.kernel.org>; Wed, 09 Dec 2020 03:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9QFflH57QDpVKtVXRpM2FYGqW9VKRNM315cIGdtSARA=;
        b=tvkJCNjDnAQpiqdCamSl/0eK43rJL7ceP4r6ht87kWYoVy4i7Us0wvnzRBGltV0WL6
         qaG//vkS2SMBAeHWIEfqvobwLaXn06o5Md849uwMGf6Aqb1+Hz+mlaAR5OlFx68P0/O/
         e/KoqU6+yzZZMFyBWbFfYFv8imgz9XzznPRA6nfJ/V35stzYmCjo6QSxODUC8Xmcc4Gw
         2bHhR2CI+RhhlcGHtbyk1pplk+iwoGtdT1D2M39ysKajYyJD7JXAqHnhslaeqOZey+tx
         0wF6NsaKtZzfbPmm2CzPUxUcO5648EHPpKx/cP3t7GcyU4dW9G7DMJbVfuGE42nHClhK
         aQTA==
X-Gm-Message-State: AOAM533WVLeN2Tlht1F173Yqzlqy5+fhJaZgFIkhJp96d5L3rtdLvMOs
        u99myYiiMwYDOPocqWPrRuE=
X-Google-Smtp-Source: ABdhPJznrg2aOJ8+AovdyaplBjwOTjoJCzrDwr1YZFznFAYSKWJ46WqbU1EIxvOYhRenR3en/GCDWw==
X-Received: by 2002:a2e:6c04:: with SMTP id h4mr894404ljc.391.1607513178636;
        Wed, 09 Dec 2020 03:26:18 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id c14sm141429lfr.105.2020.12.09.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:26:17 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kmxcY-0003cM-Qa; Wed, 09 Dec 2020 12:26:58 +0100
Date:   Wed, 9 Dec 2020 12:26:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: serial: 8250: wait till transmitter is empty
Message-ID: <X9C0gs9VBqBaxdzj@localhost>
References: <20201209091728.2357-1-s.trumtrar@pengutronix.de>
 <20201209091728.2357-2-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209091728.2357-2-s.trumtrar@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 09, 2020 at 10:17:28AM +0100, Steffen Trumtrar wrote:
> When only one single character is sent and RS485 signaling is used,
> the driver runs into timing issues.
> 
> When serial8250_tx_chars is called the single character is transmitted.
> The check on uart_circ_empty will be positive and __stop_tx is called.
> The check on UART_LSR_TEMT in BOTH_EMPTY will then be negativ and the
> function will return. On the next call to serial8250_tx_chars
> uart_circ_empty will still be true but the check on BOTH_EMPTY in
> __stop_tx might still fail. This leads to a deadlock.
> 
> Use readx_poll_timeout_atomic to allow the shift register to be emptied
> before checking on BOTH_EMPTY.
> 
> The timeout value is copied from 8250_dw.c.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/tty/serial/8250/8250_port.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 3310c2b70138..87daf3758ff0 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -18,6 +18,7 @@
>  #include <linux/console.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/sysrq.h>
> +#include <linux/iopoll.h>
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
>  #include <linux/tty.h>
> @@ -1519,18 +1520,27 @@ static inline void __do_stop_tx(struct uart_8250_port *p)
>  		serial8250_rpm_put_tx(p);
>  }
>  
> +static unsigned char serial8250_read_lsr(struct uart_8250_port *p)
> +{
> +	return serial_in(p, UART_LSR);
> +}
> +
>  static inline void __stop_tx(struct uart_8250_port *p)
>  {
>  	struct uart_8250_em485 *em485 = p->em485;
>  
>  	if (em485) {
> -		unsigned char lsr = serial_in(p, UART_LSR);
> +		unsigned char lsr;
> +
>  		/*
>  		 * To provide required timeing and allow FIFO transfer,
>  		 * __stop_tx_rs485() must be called only when both FIFO and
>  		 * shift register are empty. It is for device driver to enable
>  		 * interrupt on TEMT.
>  		 */
> +		readx_poll_timeout_atomic(serial8250_read_lsr, p, lsr,
> +					  lsr & UART_LSR_TEMT, 1, 20000);

Tight polling (1 us) for 20 ms with interrupts disabled?!

Without having looked at the details, there's got to be a better way to
handle this.

> +
>  		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
>  			return;

Johan
