Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53147C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jan 2021 07:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE9C64DFF
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jan 2021 07:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhA2HYR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jan 2021 02:24:17 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:40756 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhA2HYQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jan 2021 02:24:16 -0500
Received: by mail-ej1-f51.google.com with SMTP id gx5so11506128ejb.7;
        Thu, 28 Jan 2021 23:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQJTX9tSzdtR6ydGyWHufCeqLWMiNPcRsNBvuTsrqnk=;
        b=US8FH8KqvAbJnx8V8zHvYLERtJz6KNcBdttdq6gm8Ir3n/T/hUQByCF2QgznIJG4ZD
         y+AIsG+7ycmcN3ya4SuIp5vDxDB/Z5/M1xvNL9bzndqQOsv7bqALGM8csF4wri1uwFSw
         7GSsKTVBSQ8jtzyvghTHx3hHtAQqQhSxc/GReBIO4yxjU8G4xDK/SWjFImOmxg1ZJ/7b
         xjYXSqU6KAxJuvq/Ob57Uyw8qv8QqgJJe0wUVCyHkDv8bbHt5TS3ZqQ+OXr5kDjTaw35
         /2ce9m1qLoGWlb3WyuLY7m3th/ret1uqGWblU96SFtHrSwuM/5BF1XK9fWjdd94TYgAc
         uYGw==
X-Gm-Message-State: AOAM5311y+aC9OLd/9WKJBVihgruYgF4acblBerC7TwOPbgy+M2a3t6L
        NcxNM966y9/QgQVH7r6zqZW+KP1zaR0=
X-Google-Smtp-Source: ABdhPJyz0E9Ys5HJ/kBfd8w8xTvow9g/W1ARFIVeIWNupQJgJKp7RbNPI+Pw0qV1vYWlT4mW5s5S2A==
X-Received: by 2002:a17:906:4451:: with SMTP id i17mr3088338ejp.436.1611905013413;
        Thu, 28 Jan 2021 23:23:33 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id o13sm3472676ejb.10.2021.01.28.23.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 23:23:32 -0800 (PST)
Subject: Re: [PATCH 1/3] serial: 8250: Handle UART without interrupt on TEMT
 using em485
To:     Eric Tremblay <etremblay@distech-controls.com>,
        gregkh@linuxfoundation.org
Cc:     andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
References: <20210128233629.4164-1-etremblay@distech-controls.com>
 <20210128233629.4164-2-etremblay@distech-controls.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <1c4f5095-e350-8cc6-daee-4a841b1373d2@kernel.org>
Date:   Fri, 29 Jan 2021 08:23:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210128233629.4164-2-etremblay@distech-controls.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 29. 01. 21, 0:36, Eric Tremblay wrote:
> The patch introduce the UART_CAP_TEMT capability which is by default
> assigned to all 8250 UART since the code assume that device has the
> interrupt on TEMT
> 
> In the case where the device does not support it, we calculate the
> maximum of time it could take for the transmitter to empty the
> shift register. When we get in the situation where we get the
> THRE interrupt but the TEMT bit is not set we start the timer
> and recall __stop_tx after the delay
> 
> Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
> ---
>   drivers/tty/serial/8250/8250.h            |  1 +
>   drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
>   drivers/tty/serial/8250/8250_omap.c       |  2 +-
>   drivers/tty/serial/8250/8250_port.c       | 89 ++++++++++++++++++++++-
>   include/linux/serial_8250.h               |  2 +
>   5 files changed, 93 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 52bb21205bb6..5361b761eed7 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -82,6 +82,7 @@ struct serial8250_config {
>   #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
>   					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>   					 */
> +#define UART_CAP_TEMT	(1 << 18)	/* UART have interrupt on TEMT */

What about the inversion _NOTEMT? You then set it only on uarts without 
TEMT and don't need to update every single driver.

> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index fd95860cd661..354faebce885 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -91,7 +91,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	/* initialize data */
> -	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
> +	data->uart.capabilities = UART_CAP_FIFO | UART_CAP_MINI | UART_CAP_TEMT;

This change looks weird and undocumented. Why do you set data->uart 
suddenly?

Actually, does this build?

>   	up.port.dev = &pdev->dev;
>   	up.port.regshift = 2;
>   	up.port.type = PORT_16550;
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 23e0decde33e..1c21ac68ff37 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1294,7 +1294,7 @@ static int omap8250_probe(struct platform_device *pdev)
>   	up.port.regshift = 2;
>   	up.port.fifosize = 64;
>   	up.tx_loadsz = 64;
> -	up.capabilities = UART_CAP_FIFO;
> +	up.capabilities = UART_CAP_FIFO | UART_CAP_TEMT;
>   #ifdef CONFIG_PM
>   	/*
>   	 * Runtime PM is mostly transparent. However to do it right we need to a
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index b0af13074cd3..44a54406e4b4 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -558,8 +558,41 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
>   	}
>   }
>   
> +static inline void serial8250_em485_update_temt_delay(struct uart_8250_port *p,
> +			unsigned int cflag, unsigned int baud)
> +{
> +	unsigned int bits;
> +
> +	if (!p->em485)
> +		return;
> +
> +	/* byte size and parity */
> +	switch (cflag & CSIZE) {
> +	case CS5:
> +		bits = 7;
> +		break;
> +	case CS6:
> +		bits = 8;
> +		break;
> +	case CS7:
> +		bits = 9;
> +		break;
> +	default:
> +		bits = 10;
> +		break; /* CS8 */
> +	}
> +
> +	if (cflag & CSTOPB)
> +		bits++;
> +	if (cflag & PARENB)
> +		bits++;
> +
> +	p->em485->no_temt_delay = bits*1000000/baud;
> +}
> +
>   static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
>   static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
> +static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t);
>   
>   void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
>   {
> @@ -618,6 +651,18 @@ static int serial8250_em485_init(struct uart_8250_port *p)
>   		     HRTIMER_MODE_REL);
>   	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
>   		     HRTIMER_MODE_REL);
> +
> +	if (!(p->capabilities & UART_CAP_TEMT)) {
> +		struct tty_struct *tty = p->port.state->port.tty;

Is this safe? Don't you need a tty reference? Or maybe you need to pass 
the tty from the TIOCSRS485 ioctl to here.

> +		serial8250_em485_update_temt_delay(p, tty->termios.c_cflag,
> +						   tty_get_baud_rate(tty));
> +		hrtimer_init(&p->em485->no_temt_timer, CLOCK_MONOTONIC,
> +			     HRTIMER_MODE_REL);
> +		p->em485->no_temt_timer.function =
> +			&serial8250_em485_handle_no_temt;
> +	}
> +
>   	p->em485->stop_tx_timer.function = &serial8250_em485_handle_stop_tx;
>   	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
>   	p->em485->port = p;
> @@ -649,6 +694,7 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
>   
>   	hrtimer_cancel(&p->em485->start_tx_timer);
>   	hrtimer_cancel(&p->em485->stop_tx_timer);
> +	hrtimer_cancel(&p->em485->no_temt_timer);
>   
>   	kfree(p->em485);
>   	p->em485 = NULL;
> @@ -1494,6 +1540,15 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
>   	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
>   }
>   
> +static void start_hrtimer_us(struct hrtimer *hrt, unsigned long usec)
> +{
> +	long sec = usec / 1000000;
> +	long nsec = (usec % 1000000) * 1000;
> +	ktime_t t = ktime_set(sec, nsec);

Why not ns_to_ktime without all those divisions?

> +
> +	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
> +}
> +
>   static void __stop_tx_rs485(struct uart_8250_port *p)
>   {
>   	struct uart_8250_em485 *em485 = p->em485;
> @@ -1531,8 +1586,18 @@ static inline void __stop_tx(struct uart_8250_port *p)
>   		 * shift register are empty. It is for device driver to enable
>   		 * interrupt on TEMT.
>   		 */
> -		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> +		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
> +			/*
> +			 * On devices with no interrupt on TEMT available
> +			 * start a timer for a byte time, the timer will recall
> +			 * __stop_tx
> +			 */
> +			if (!(p->capabilities & UART_CAP_TEMT) && (lsr & UART_LSR_THRE)) {
> +				em485->active_timer = &em485->no_temt_timer;

How does this interfere with the current handling of active_timer? You 
should explain the changed functionality in the commit log. And you 
don't reset it to NULL in the timer.

> +				start_hrtimer_us(&em485->no_temt_timer, em485->no_temt_delay);
> +			}
>   			return;
> +		}
>   
>   		__stop_tx_rs485(p);
>   	}
> @@ -1631,6 +1696,25 @@ static inline void start_tx_rs485(struct uart_port *port)
>   	__start_tx(port);
>   }
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
> +	if (em485->active_timer == &em485->no_temt_timer)
> +		__stop_tx(p);
> +
> +	spin_unlock_irqrestore(&p->port.lock, flags);
> +	serial8250_rpm_put(p);
> +	return HRTIMER_NORESTART;
> +}
> +
>   static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
>   {
>   	struct uart_8250_em485 *em485;
> @@ -2792,6 +2876,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>   
>   	serial8250_set_divisor(port, baud, quot, frac);
>   
> +	if (!(up->capabilities & UART_CAP_TEMT))
> +		serial8250_em485_update_temt_delay(up, termios->c_cflag, baud);
> +
>   	/*
>   	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
>   	 * is written without DLAB set, this mode will be disabled.
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index 9e655055112d..d2c66faff0dd 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -79,7 +79,9 @@ struct uart_8250_ops {
>   struct uart_8250_em485 {
>   	struct hrtimer		start_tx_timer; /* "rs485 start tx" timer */
>   	struct hrtimer		stop_tx_timer;  /* "rs485 stop tx" timer */
> +	struct hrtimer		no_temt_timer;  /* "rs485 no tempt interrupt" timer */
>   	struct hrtimer		*active_timer;  /* pointer to active timer */
> +	unsigned int		no_temt_delay;  /* Value of delay for no TEMT UART */
>   	struct uart_8250_port	*port;          /* for hrtimer callbacks */
>   	unsigned int		tx_stopped:1;	/* tx is currently stopped */
>   };
> 


-- 
js
suse labs
