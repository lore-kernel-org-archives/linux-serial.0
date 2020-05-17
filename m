Return-Path: <SRS0=Hdmd=67=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCFEC433DF
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9935D207D8
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 22:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgEQWBa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 May 2020 18:01:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45200 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgEQWBa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 May 2020 18:01:30 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaRLU-0002e6-TF; Mon, 18 May 2020 00:01:20 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com
Subject: Re: [PATCH v2 4/7] serial: 8250: Handle implementations not having TEMT interrupt using em485
Date:   Mon, 18 May 2020 00:01:20 +0200
Message-ID: <2596761.4mVKVPr5sX@diego>
In-Reply-To: <20200502134927.6sb7f3na3ff3rpoa@wunner.de>
References: <20200325231422.1502366-1-heiko@sntech.de> <20200325231422.1502366-5-heiko@sntech.de> <20200502134927.6sb7f3na3ff3rpoa@wunner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Lukas,

Am Samstag, 2. Mai 2020, 15:49:27 CEST schrieb Lukas Wunner:
> On Thu, Mar 26, 2020 at 12:14:19AM +0100, Heiko Stuebner wrote:
> > @@ -1529,11 +1535,22 @@ static inline void __stop_tx(struct uart_8250_port *p)
> >  		/*
> >  		 * To provide required timeing and allow FIFO transfer,
> >  		 * __stop_tx_rs485() must be called only when both FIFO and
> > -		 * shift register are empty. It is for device driver to enable
> > -		 * interrupt on TEMT.
> > +		 * shift register are empty. If 8250 port supports it,
> > +		 * it is for device driver to enable interrupt on TEMT.
> > +		 * Otherwise must loop-read until TEMT and THRE flags are set.
> >  		 */
> > -		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> > -			return;
> > +		if (p->capabilities & UART_CAP_TEMT) {
> > +			if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> > +				return;
> > +		} else {
> > +			int lsr;
> > +
> > +			if (readx_poll_timeout(__get_lsr, p, lsr,
> > +					(lsr & BOTH_EMPTY) == BOTH_EMPTY,
> > +					0, 10000) < 0)
> > +				pr_warn("%s: timeout waiting for fifos to empty\n",
> > +					p->port.name);
> > +		}
> 
> Do you actually need to check for the timeout?  How could this happen?
> Only if some other part of the driver would disable the transmitter
> I guess, which would be a bug.

Checking for a timeout was strongly suggested in v1 ;-)


> Also, note that __stop_tx() may be called from hardirq context via
> serial8250_tx_chars().  If the baudrate is low, you may spin for a
> fairly long time in IRQ context.  E.g. with 9600 8N1, it takes about
> 1 msec for one char to transmit.

I did play around with different baud rates and data amounts today
and even ran into the timeout with the current 10ms when doing a
"dmesg > /dev/ttyS3" ... combined with the hardirq issue you mentioned
I think I found a slightly better variant to do this ... by catching the first
100us in the interrupt handler and otherwise re-using the existing
stop-timer infrastructure to move this out of the actual __stop_tx function.

I've sent a v3 based on your new series just now ... if you find time
please have a look :-)

Thanks
Heiko


