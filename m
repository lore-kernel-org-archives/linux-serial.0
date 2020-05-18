Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CE3C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 15:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E66207D3
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 15:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgERPT3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 11:19:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:41250 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgERPT3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 11:19:29 -0400
IronPort-SDR: 5du6UNZm67WGDdjaoay2zBAu/WerH0Jy8smlnwrcBslXjftYr0wglQxuhib8WSbgUbfpy2GMqB
 JR+35kQ3iF/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:19:28 -0700
IronPort-SDR: U8tanuJZgItrxDVxI2EQNOWz4OZSaCzMnY/DJOBY0uYWX7O9+e3eSF+9xgdC8+5g0KD6f9giHY
 Ae5WAxSPTknQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="342825873"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2020 08:19:25 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jahY8-007S4o-AU; Mon, 18 May 2020 18:19:28 +0300
Date:   Mon, 18 May 2020 18:19:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v3 4/5] serial: 8250: Handle implementations not having
 TEMT interrupt using em485
Message-ID: <20200518151928.GH1634618@smile.fi.intel.com>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-5-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517215610.2131618-5-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 17, 2020 at 11:56:09PM +0200, Heiko Stuebner wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Some 8250 ports have a TEMT interrupt but it's not a part of the 8250
> standard, instead only available on some implementations.
> 
> The current em485 implementation does not work on ports without it.
> The only chance to make it work is to loop-read on LSR register.
> 
> So add UART_CAP_TEMT to mark 8250 uarts having this interrupt,
> update all current em485 users with that capability and add
> a loop-reading during  __stop_tx_rs485() on uarts not having it.
> 
> As __stop_tx_rs485() can also be called from a hard-irq context the
> loop-reading is split. If the fifo clears in under 100us in
> __stop_tx_rs485() itself just the regular stop calls get executed.
> If it takes longer, re-use the existing stop-timer infrastructure
> but with only a 10us timer to again poll the LSR registers.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

> [moved to use added UART_CAP_TEMT, use readx_poll_timeout]

I can't parse first part...

Also, shouldn't it be rather like
  [heiko: ...]
?

...

> +static inline int __get_lsr(struct uart_8250_port *p)
> +{
> +	return serial_in(p, UART_LSR);
> +}
> +
> +static inline int __wait_for_empty(struct uart_8250_port *p, u64 timeout_us)
> +{
> +	int lsr;
> +
> +	return readx_poll_timeout(__get_lsr, p, lsr,
> +				  (lsr & BOTH_EMPTY) == BOTH_EMPTY,
> +				  0, timeout_us);
> +}

...

> +			int ret = __wait_for_empty(p, 100);

Do you expect something different than 100? If no, perhaps for now just put it
inside the function as a constant?

> +			if (ret < 0) {
> +				restart = HRTIMER_RESTART;
> +				goto out;
> +			}

...

> +	} else if (!(p->capabilities & UART_CAP_TEMT) &&
> +		   __wait_for_empty(p, 100)) {

I would leave it on one line even if you leave 100 as a parameter, but it's up to you.

...

> +		if (p->capabilities & UART_CAP_TEMT) {
> +			if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> +				return;
> +		}

if (a) {
	if (b) {
		...
	}
}

is equivalent to 

if (a && b) {
	...
}

But it's up to you which one to choose.

-- 
With Best Regards,
Andy Shevchenko


