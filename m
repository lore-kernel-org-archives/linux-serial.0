Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4DCC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 11 Feb 2022 11:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbiBKLIM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Feb 2022 06:08:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiBKLIL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Feb 2022 06:08:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605E3B77
        for <linux-serial@vger.kernel.org>; Fri, 11 Feb 2022 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644577691; x=1676113691;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aLzWE5vfxOolW4FYoX8ZvynZO5To349ovXQl8lUg8C0=;
  b=MLfn0QP+v3uNAE0V+/v+ggC5bbxk8FF3DBi+4NKUtkHTvo9x0Tivd36h
   zZY+zqgABnd3XJSN0R3I4uoF38zyLjXg0xq5c3X0cGRHyW1SVRNZPBaKG
   U+YvwJlVt6l+/A/8wbuk8nB4yUH1ZtoaX9ADLWexxoiH9ZmSzm+1Nciy2
   bhOc6gOerIY2Hawqq/QeHQnfiw69XCuhy52SNrwW4vCG33MoAYGkyhtro
   RR5zVXUZYZcv0tw/5lYSttWJWtMbeVfL4/olT87/gqK76wzoiHe0llM46
   Agtv3rmi9MNVjeDSPgGOqkV2IxW+R7Caz3LIgirrqpKgfRp5eutuHiDhC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="233268233"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="233268233"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:08:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="542046146"
Received: from nkosecih-mobl1.ger.corp.intel.com ([10.251.211.81])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:08:08 -0800
Date:   Fri, 11 Feb 2022 13:08:02 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Eric Tremblay <etremblay@distech-controls.com>,
        linux-serial <linux-serial@vger.kernel.org>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/3] serial: 8250: Handle UART without interrupt on
 TEMT using em485
In-Reply-To: <20210204161158.643-2-etremblay () distech-controls ! com>
Message-ID: <91154b2-e3ce-78c2-d74-bcd8aba9a3fe@linux.intel.com>
References: <20210204161158.643-2-etremblay () distech-controls ! com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 4 Feb 2021, Eric Tremblay wrote:

> The patch introduce the UART_CAP_NOTEMT capability. The capability
> indicate that the UART doesn't have an interrupt available on TEMT.
> 
> In the case where the device does not support it, we calculate the
> maximum time it could take for the transmitter to empty the
> shift register. When we get in the situation where we get the
> THRE interrupt, we check if the TEMT bit is set. If it's not, we start
> the a timer and recall __stop_tx() after the delay.
> 
> The transmit sequence is a bit modified when the capability is set. The
> new timer is used between the last interrupt(THRE) and a potential
> stop_tx timer.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> [moved to use added UART_CAP_TEMT]
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> [moved to use added UART_CAP_NOTEMT, improve timeout]
> Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
> ---

> @@ -1531,8 +1560,19 @@ static inline void __stop_tx(struct uart_8250_port *p)
>  		 * shift register are empty. It is for device driver to enable
>  		 * interrupt on TEMT.
>  		 */
> -		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> +		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
> +			if (!(p->capabilities & UART_CAP_NOTEMT))
> +				return;
> +
> +			/*
> +			 * On devices with no TEMT interrupt available, start
> +			 * a timer for a byte time. The timer will recall
> +			 * __stop_tx().
> +			 */
> +			em485->active_timer = &em485->no_temt_timer;
> +			start_hrtimer_ns(&em485->no_temt_timer, em485->no_temt_delay);

Is it ok to start the timer here without first confirming UART_LSR_THRE?

>  			return;
> +		}
>  
>  		__stop_tx_rs485(p);
>  	}
> @@ -1631,6 +1671,27 @@ static inline void start_tx_rs485(struct uart_port *port)
>  	__start_tx(port);
>  }
>  
> +static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t)
> +{
> +	struct uart_8250_em485 *em485;
> +	struct uart_8250_port *p;
> +	unsigned long flags;
> +
> +	em485 = container_of(t, struct uart_8250_em485, no_temt_timer);
> +	p = em485->port;
> +
> +	serial8250_rpm_get(p);
> +	spin_lock_irqsave(&p->port.lock, flags);
> +	if (em485->active_timer == &em485->no_temt_timer) {
> +		__stop_tx(p);
> +		em485->active_timer = NULL;

If BOTH_EMPTY is still not set when calling __stop_tx from here,
__stop_tx ends up just starting the timer again and the timer won't do 
anything useful when expiring because active_timer is now NULL.

> +	}
> +
> +	spin_unlock_irqrestore(&p->port.lock, flags);
> +	serial8250_rpm_put(p);
> +	return HRTIMER_NORESTART;
> +}


-- 
 i.

