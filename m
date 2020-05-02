Return-Path: <SRS0=4P1W=6Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CE2C3A5A9
	for <linux-serial@archiver.kernel.org>; Sat,  2 May 2020 13:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DC9216FD
	for <linux-serial@archiver.kernel.org>; Sat,  2 May 2020 13:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgEBNtd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 2 May 2020 09:49:33 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:60693 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgEBNtd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 2 May 2020 09:49:33 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 047A62800B48B;
        Sat,  2 May 2020 15:49:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D0F212781E5; Sat,  2 May 2020 15:49:27 +0200 (CEST)
Date:   Sat, 2 May 2020 15:49:27 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 4/7] serial: 8250: Handle implementations not having
 TEMT interrupt using em485
Message-ID: <20200502134927.6sb7f3na3ff3rpoa@wunner.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
 <20200325231422.1502366-5-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231422.1502366-5-heiko@sntech.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 26, 2020 at 12:14:19AM +0100, Heiko Stuebner wrote:
> Some 8250 ports have a TEMT interrupt but it's not a part of the 8250
> standard, instead only available on some implementations.
> 
> The current em485 implementation does not work on ports without it.
> The only chance to make it work is to loop-read on LSR register.
> 
> So add UART_CAP_TEMT to mark 8250 uarts having this interrupt,
> update all current em485 users with that capability and make
> the stop_tx function loop-read on uarts not having it.

Just to get a better understanding:  According to the Dw_apb_uart_db.pdf
databook I've found, the UART does have a "THR empty" interrupt.  So you
get an interrupt once the Transmit Holding Register (and by consequence
the FIFO) has been drained.  Then what do you need a TEMT interrupt for?
Why is the THR interrupt not sufficient?


> @@ -1529,11 +1535,22 @@ static inline void __stop_tx(struct uart_8250_port *p)
>  		/*
>  		 * To provide required timeing and allow FIFO transfer,
>  		 * __stop_tx_rs485() must be called only when both FIFO and
> -		 * shift register are empty. It is for device driver to enable
> -		 * interrupt on TEMT.
> +		 * shift register are empty. If 8250 port supports it,
> +		 * it is for device driver to enable interrupt on TEMT.
> +		 * Otherwise must loop-read until TEMT and THRE flags are set.
>  		 */
> -		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> -			return;
> +		if (p->capabilities & UART_CAP_TEMT) {
> +			if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> +				return;
> +		} else {
> +			int lsr;
> +
> +			if (readx_poll_timeout(__get_lsr, p, lsr,
> +					(lsr & BOTH_EMPTY) == BOTH_EMPTY,
> +					0, 10000) < 0)
> +				pr_warn("%s: timeout waiting for fifos to empty\n",
> +					p->port.name);
> +		}

Do you actually need to check for the timeout?  How could this happen?
Only if some other part of the driver would disable the transmitter
I guess, which would be a bug.

Also, note that __stop_tx() may be called from hardirq context via
serial8250_tx_chars().  If the baudrate is low, you may spin for a
fairly long time in IRQ context.  E.g. with 9600 8N1, it takes about
1 msec for one char to transmit.

Thanks,

Lukas
