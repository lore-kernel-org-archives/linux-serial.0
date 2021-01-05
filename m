Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5497AC433DB
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 10:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0861222515
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 10:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbhAEKj2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 05:39:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:38056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbhAEKj2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 05:39:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609843120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8hbp1X28kMlwRrkIXbIWfN3PTDt7BUk0pAQp+zaIsfY=;
        b=AMmqYTfpEtG+FF7naM3edeuU7N7Q0jzl0U78OZVgA8bexprRPCba6kJ1KIaHj3n2/Dbnug
        DCPTqr+fx7KPSTx2eGue9OMaGwUn3e3QI4gs6hy25RbFOfEM4gxalKKK1sob4x+OW6hG5n
        6ItyssRdlIzWc4dvBtcunvuHnuK7qsw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D0FEAA35;
        Tue,  5 Jan 2021 10:38:40 +0000 (UTC)
Subject: Re: [PATCH] tty: serial: amba-pl011: added RS485 support [v3]
To:     Ivan Sistik <sistik@3ksolutions.sk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     suravee.suthikulpanit@amd.com, sbranden@broadcom.com,
        wahrenst@gmx.net, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20201230031642.118872-1-sistik@3ksolutions.sk>
From:   Jiri Slaby <jslaby@suse.com>
Message-ID: <cfb11ff3-e482-59fc-9f01-c19f9b23bc65@suse.com>
Date:   Tue, 5 Jan 2021 11:38:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201230031642.118872-1-sistik@3ksolutions.sk>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30. 12. 20, 4:16, Ivan Sistik wrote:
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -75,6 +75,17 @@ config SERIAL_AMBA_PL011_CONSOLE
>   	  your boot loader (lilo or loadlin) about how to pass options to the
>   	  kernel at boot time.)
>   
> +config SERIAL_AMBA_PL011_SOFT_RS485
> +	bool "RS485 software direction switching for ARM AMBA PL011 serial"
> +	depends on SERIAL_AMBA_PL011=y
> +	help
> +	  Enable RS485 software direction switching of driver enable (RTS pin)
> +	  for ARM AMBA PL011 serial. AMBA PL011 does not have HW support for
> +	  RS485. This driver use 2 hrtimers. One is used for rs485 delays.

"uses"

> +	  Second one is used for polling of TX FIFO. There is not TX FIFO

"The second one"

"There is no"

> +	  empty interrupt in PL011. Secondary timer is started by empty

"The secondary". But I am confused, 2 timers: one, second, and secondary 
  -- three timers?

> +	  transmit buffer.
> +
>   config SERIAL_EARLYCON_ARM_SEMIHOST
>   	bool "Early console using ARM semihosting"
>   	depends on ARM64 || ARM
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 16720c97a..6a40e5bc5 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -46,6 +46,7 @@
>   #include <linux/sizes.h>
>   #include <linux/io.h>
>   #include <linux/acpi.h>
> +#include <linux/math64.h>
>   
>   #include "amba-pl011.h"
>   
> @@ -60,6 +61,18 @@
>   #define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
>   #define UART_DUMMY_DR_RX	(1 << 16)
>   
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +/*
> + * Enum with current status
> + */
> +enum rs485_status {
> +	rs485_receiving,
> +	rs485_delay_before_send,
> +	rs485_sending,
> +	rs485_delay_after_send

These are too generic names.

> +};
> +#endif

You don't have to add ifdeffery to declarations.

> +
>   static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
>   	[REG_DR] = UART01x_DR,
>   	[REG_FR] = UART01x_FR,
> @@ -270,6 +283,16 @@ struct uart_amba_port {
>   	unsigned int		old_cr;		/* state during shutdown */
>   	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
>   	char			type[12];
> +
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	enum rs485_status	rs485_current_status; /* status used for RTS */
> +	enum rs485_status	rs485_next_status; /* this status after tick */
> +	struct hrtimer		rs485_delay_timer;
> +	struct hrtimer		rs485_tx_empty_poll_timer;
> +	unsigned long		send_char_time;	/* send char (nanoseconds) */
> +	bool			rs485_last_char_sending;
> +#endif
> +
>   #ifdef CONFIG_DMA_ENGINE
>   	/* DMA stuff */
>   	bool			using_tx_dma;
> @@ -306,6 +329,36 @@ static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
>   		writew_relaxed(val, addr);
>   }
>   
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +
> +static void pl011_rs485_start_rts_delay(struct uart_amba_port *uap);
> +
> +static void rs485_set_rts_signal(struct uart_amba_port *uap, bool value)
> +{
> +	unsigned int rts_temp_cr;
> +
> +	rts_temp_cr = pl011_read(uap, REG_CR);
> +
> +	if (!value)
> +		rts_temp_cr |= UART011_CR_RTS;
> +	else
> +		rts_temp_cr &= ~UART011_CR_RTS;
> +
> +	pl011_write(rts_temp_cr, uap, REG_CR);
> +}
> +
> +void rs485_cancel_timers(struct uart_amba_port *uap)

Why not static? And too generic name. The same above.

> +{
> +	hrtimer_try_to_cancel(&(uap->rs485_delay_timer));
> +	hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));

No need for the parentheses. They occur on many places in the patch. 
Have you run the patch through checkpatch?

> +}
> +
> +bool rs485_tx_fifo_empty(struct uart_amba_port *uap)
> +{
> +	return (pl011_read(uap, REG_FR) & UART011_FR_TXFE);

detto.

> +}
> +#endif
> +
>   /*
>    * Reads up to 256 characters from the FIFO or until it's empty and
>    * inserts them into the TTY layer. Returns the number of characters
> @@ -1301,6 +1354,11 @@ static void pl011_stop_tx(struct uart_port *port)
>   	uap->im &= ~UART011_TXIM;
>   	pl011_write(uap->im, uap, REG_IMSC);
>   	pl011_dma_tx_stop(uap);
> +
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	if (uap->port.rs485.flags & SER_RS485_ENABLED)
> +		pl011_rs485_start_rts_delay(uap);

Could you do the check inside pl011_rs485_start_rts_delay and remove the 
ifdef completely?

> +#endif
>   }
>   
>   static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
> @@ -1319,8 +1377,113 @@ static void pl011_start_tx(struct uart_port *port)
>   	struct uart_amba_port *uap =
>   	    container_of(port, struct uart_amba_port, port);
>   
> -	if (!pl011_dma_tx_start(uap))
> -		pl011_start_tx_pio(uap);
> +#define START_PL011_TX()				\
> +	do {						\
> +		if (!pl011_dma_tx_start(uap))		\
> +			pl011_start_tx_pio(uap);	\
> +	} while (0)

Defining a macro inside a function? No. This should be a separate 
function as well as the code below anyway.

> +#ifndef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	START_PL011_TX();
> +#else
> +
> +	if (uap->port.rs485.flags & SER_RS485_ENABLED) {
> +		ktime_t ktime;
> +
> +		switch (uap->rs485_current_status) {
> +		case rs485_delay_after_send:
> +
> +			rs485_cancel_timers(uap);
> +
> +			/* check if timer expired */
> +			if (uap->rs485_current_status
> +					!= rs485_delay_after_send) {
> +				/* Timer expired and RTS is in wrong state.*/
> +				uap->rs485_current_status
> +					= rs485_delay_before_send;
> +				uap->rs485_next_status = rs485_sending;
> +
> +				rs485_set_rts_signal(uap,
> +					uap->port.rs485.flags
> +						& SER_RS485_RTS_ON_SEND);
> +
> +				ktime = ktime_set(0,
> +					  uap->port.rs485
> +						.delay_rts_before_send
> +					  * 1000000L);
> +
> +				hrtimer_start(
> +					&(uap->rs485_delay_timer),
> +					ktime,
> +					HRTIMER_MODE_REL);

SPaghetti code. It will be eliminated by moving to a separate function 
suggested above.

> +				return;
> +			}
> +
> +			/* timer was stopped and driver can continue sending */
> +			uap->rs485_current_status = rs485_sending;
> +			uap->rs485_next_status = rs485_sending;
> +
> +			/* driver is already in sending state */
> +			START_PL011_TX();
> +			break;
> +
> +
> +		case rs485_sending:
> +			/* stop old timer. There can be running timer	*/
> +			/* which is checking TX FIFO empty flag		*/
> +			rs485_cancel_timers(uap);
> +
> +			/* driver is already in sending state */
> +			START_PL011_TX();
> +			break;
> +
> +		case rs485_receiving:
> +		default:
> +			/* stop old timer. There can be running timer	*/
> +			/* which is checking TX FIFO empty flag		*/
> +			rs485_cancel_timers(uap);
> +
> +			/* Set RTS */
> +			rs485_set_rts_signal(uap,
> +				     uap->port.rs485.flags
> +					     & SER_RS485_RTS_ON_SEND);
> +
> +			if (uap->port.rs485.delay_rts_before_send == 0) {
> +				/* Change state */
> +				uap->rs485_current_status
> +					= rs485_sending;
> +				uap->rs485_next_status
> +					= rs485_sending;
> +
> +				/* driver is in sending state */
> +				START_PL011_TX();
> +				break;
> +			}
> +
> +			/* Change state */
> +			uap->rs485_current_status
> +				= rs485_delay_before_send;
> +			uap->rs485_next_status = rs485_sending;
> +
> +			/* Start timer */
> +			ktime = ktime_set(0,
> +				  uap->port.rs485.delay_rts_before_send
> +				  * 1000000L);

This is overcomplicated ms_to_ktime().

> +			hrtimer_start(&(uap->rs485_delay_timer),
> +				ktime,
> +				HRTIMER_MODE_REL);
> +			break;
> +
> +		case rs485_delay_before_send:
> +			/* do nothing because delay timer should be running */
> +			break;
> +		}
> +	} else {
> +		START_PL011_TX();
> +	}
> +#endif
> +
> +#undef START_PL011_TX
>   }
>   
>   static void pl011_stop_rx(struct uart_port *port)
> @@ -1476,6 +1639,166 @@ static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
>   	dummy_read = pl011_read(uap, REG_ICR);
>   }
>   
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +
> +/*
> + * Change state according to pending delay
> + * Locking: port is locked in this function
> + */
> +static enum hrtimer_restart
> +pl011_rs485_tx_poll_timer(struct hrtimer *timer)
> +{
> +	unsigned long flags;
> +	ktime_t ktime;
> +
> +	struct uart_amba_port *uap =
> +		container_of(timer, struct uart_amba_port,
> +			     rs485_tx_empty_poll_timer);
> +
> +	spin_lock_irqsave(&uap->port.lock, flags);
> +
> +	if (!(uart_circ_empty(&uap->port.state->xmit))) {
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +		return HRTIMER_NORESTART;

Create a label at the end and goto from here.

> +	}
> +
> +	if (!rs485_tx_fifo_empty(uap) || !uap->rs485_last_char_sending) {
> +		/*
> +		 *  FIFO is empty but there is last char in transmit shift
> +		 * register so we need one more tick
> +		 */
> +		uap->rs485_last_char_sending = rs485_tx_fifo_empty(uap);
> +
> +		hrtimer_forward_now(timer, ktime_set(0, uap->send_char_time));

ns_to_ktime()

> +
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +		return HRTIMER_RESTART;
> +	}
> +
> +	/* Check if delay after send is set*/
> +	if (uap->port.rs485.delay_rts_after_send == 0) {
> +		/* Change state */
> +		uap->rs485_current_status = rs485_receiving;
> +		uap->rs485_next_status = rs485_receiving;
> +
> +		/* if there is no delay after send change RTS value*/
> +		rs485_set_rts_signal(uap,
> +			     uap->port.rs485.flags
> +				     & SER_RS485_RTS_AFTER_SEND);
> +
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +		return HRTIMER_NORESTART;
> +	}
> +
> +	/* Change state */
> +	uap->rs485_current_status = rs485_delay_after_send;
> +	uap->rs485_next_status = rs485_receiving;
> +
> +	/* RTS will be set in timer handler */
> +
> +	/* Start delay timer */
> +	ktime = ktime_set(0, (uap->port.rs485.delay_rts_after_send
> +			* 1000000L));

ms_to_ktime().

> +	hrtimer_start(&(uap->rs485_delay_timer), ktime, HRTIMER_MODE_REL);
> +
> +	spin_unlock_irqrestore(&uap->port.lock, flags);
> +	return HRTIMER_NORESTART;
> +}
...
> +static void pl011_rs485_start_rts_delay(struct uart_amba_port *uap)
> +{
> +	ktime_t ktime;
> +
> +	if (uap->rs485_current_status == rs485_receiving)
> +		return;
> +
> +	/* if there is timeout in progress cancel it and start new */
> +	hrtimer_try_to_cancel(&(uap->rs485_delay_timer));
> +	hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));
> +
> +
> +	if (!rs485_tx_fifo_empty(uap)
> +			|| uap->port.rs485.delay_rts_after_send == 0) {
> +		/*
> +		 * Schedule validation timer if there is data in TX FIFO
> +		 * because there is not TX FIFO empty interrupt
> +		 */
> +
> +		uap->rs485_current_status = rs485_sending;
> +		uap->rs485_next_status = rs485_sending;
> +
> +		uap->rs485_last_char_sending = false;
> +
> +		ktime = ktime_set(0, uap->send_char_time);

ns_to_ktime()

> +		hrtimer_start(&(uap->rs485_tx_empty_poll_timer),
> +			ktime,
> +			HRTIMER_MODE_REL);
> +		return;
> +	}
> +
> +	/* Change state */
> +	uap->rs485_current_status = rs485_delay_after_send;
> +	uap->rs485_next_status = rs485_receiving;
> +
> +	/* RTS will be set in timer handler */
> +
> +	/* Start timer */
> +	ktime = ktime_set(0, (uap->port.rs485.delay_rts_after_send
> +			* 1000000L));

ms_to_ktime().

> +
> +	hrtimer_start(&(uap->rs485_delay_timer),
> +		ktime,
> +		HRTIMER_MODE_REL);
> +}
> +#endif
> +
>   static irqreturn_t pl011_int(int irq, void *dev_id)
>   {
>   	struct uart_amba_port *uap = dev_id;
> @@ -1618,6 +1941,11 @@ static void pl011_quiesce_irqs(struct uart_port *port)
>   	 */
>   	pl011_write(pl011_read(uap, REG_IMSC) & ~UART011_TXIM, uap,
>   		    REG_IMSC);
> +
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	if (uap->port.rs485.flags & SER_RS485_ENABLED)
> +		pl011_rs485_start_rts_delay(uap);
> +#endif

The same as above.

>   }
>   
>   static int pl011_get_poll_char(struct uart_port *port)
> @@ -1690,6 +2018,27 @@ static int pl011_hwinit(struct uart_port *port)
>   		if (plat->init)
>   			plat->init();
>   	}
> +
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485

Do this in a separate function and eliminate such ifdefs in the code.

> +	/*
> +	 * Initialize timers used for RS485
> +	 */
> +	hrtimer_init(&(uap->rs485_delay_timer),
> +		CLOCK_MONOTONIC,
> +		HRTIMER_MODE_REL);
> +
> +	uap->rs485_delay_timer.function = &pl011_rs485_timer;
> +
> +	hrtimer_init(&(uap->rs485_tx_empty_poll_timer),
> +		CLOCK_MONOTONIC,
> +		HRTIMER_MODE_REL);
> +
> +	uap->rs485_tx_empty_poll_timer.function = &pl011_rs485_tx_poll_timer;
> +
> +	uap->rs485_current_status = rs485_receiving;
> +	rs485_set_rts_signal(uap, false);
> +#endif
> +
>   	return 0;
>   }
>   
> @@ -1873,6 +2222,16 @@ static void pl011_shutdown(struct uart_port *port)
>   	struct uart_amba_port *uap =
>   		container_of(port, struct uart_amba_port, port);
>   
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	if (uap->port.rs485.flags & SER_RS485_ENABLED) {
> +		hrtimer_try_to_cancel(&(uap->rs485_delay_timer));
> +		hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));
> +
> +		uap->rs485_current_status = rs485_receiving;
> +		rs485_set_rts_signal(uap, true);
> +	}
> +#endif

Separate function + no ifdef.

> +
>   	pl011_disable_interrupts(uap);
>   
>   	pl011_dma_shutdown(uap);
> @@ -1955,6 +2314,24 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>   	unsigned long flags;
>   	unsigned int baud, quot, clkdiv;
>   
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	unsigned int transfer_bit_count;
> +	unsigned long char_transfer_time;
> +
> +	/*
> +	 * Calculate bit count which will be send

"sent"

> +	 * by UART. It is used for calculation of
> +	 * time required to start timer until TX FIFO (HW) is empty

Dot at the end.

> +	 * There is not interrupt for FIFO empty in PL011.

"There is not an"
or
"There is no"

> +	 * There is only FIFO empty flag in REG_FR.
> +	 */
> +	transfer_bit_count = 0;
> +
> +#define	ADD_DATA_BITS(bits)	(transfer_bit_count += bits)

This is ugly.
1) it's a macro.
2) it hides uses of transfer_bit_count from the reader.

> +#else
> +#define	ADD_DATA_BITS(bits)
> +#endif
> +
>   	if (uap->vendor->oversampling)
>   		clkdiv = 8;
>   	else
> @@ -1981,29 +2358,53 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>   	switch (termios->c_cflag & CSIZE) {
>   	case CS5:
>   		lcr_h = UART01x_LCRH_WLEN_5;
> +		ADD_DATA_BITS(7);
>   		break;
>   	case CS6:
>   		lcr_h = UART01x_LCRH_WLEN_6;
> +		ADD_DATA_BITS(8);
>   		break;
>   	case CS7:
>   		lcr_h = UART01x_LCRH_WLEN_7;
> +		ADD_DATA_BITS(9);
>   		break;
>   	default: // CS8
>   		lcr_h = UART01x_LCRH_WLEN_8;
> +		ADD_DATA_BITS(10);
>   		break;
>   	}
> -	if (termios->c_cflag & CSTOPB)
> +
> +	if (termios->c_cflag & CSTOPB) {
>   		lcr_h |= UART01x_LCRH_STP2;
> +		ADD_DATA_BITS(1);
> +	}
> +
>   	if (termios->c_cflag & PARENB) {
>   		lcr_h |= UART01x_LCRH_PEN;
> +		ADD_DATA_BITS(1);
> +
>   		if (!(termios->c_cflag & PARODD))
>   			lcr_h |= UART01x_LCRH_EPS;
> +
>   		if (termios->c_cflag & CMSPAR)
>   			lcr_h |= UART011_LCRH_SPS;
>   	}
> +
> +#undef ADD_DATA_BITS
> +
>   	if (uap->fifosize > 1)
>   		lcr_h |= UART01x_LCRH_FEN;
>   
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	/* Calculate time required to send one char (nanoseconds) */
> +	char_transfer_time =
> +		(unsigned long) div_u64(
> +				mul_u32_u32(
> +					(u32)transfer_bit_count,
> +					(u32)NSEC_PER_SEC),
> +				(u32)baud);

Wny do you cast all that?

> +#endif
> +
>   	spin_lock_irqsave(&port->lock, flags);
>   
>   	/*
> @@ -2020,6 +2421,11 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>   	old_cr = pl011_read(uap, REG_CR);
>   	pl011_write(0, uap, REG_CR);
>   
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	/* Update send_char_time in locked context */
> +	uap->send_char_time = char_transfer_time;
> +#endif
> +
>   	if (termios->c_cflag & CRTSCTS) {
>   		if (old_cr & UART011_CR_RTS)
>   			old_cr |= UART011_CR_RTSEN;
> @@ -2122,6 +2528,47 @@ static void pl011_config_port(struct uart_port *port, int flags)
>   	}
>   }
>   
> +/*
> + * Configure RS485
> + * Locking: called with port lock held and IRQs disabled
> + */
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +static int pl011_config_rs485(struct uart_port *port,
> +			      struct serial_rs485 *rs485)
> +{
> +	bool was_disabled;
> +	struct uart_amba_port *uap =
> +			container_of(port, struct uart_amba_port, port);
> +
> +	was_disabled = !(port->rs485.flags & SER_RS485_ENABLED);

Where is this used?

> +	port->rs485.flags = rs485->flags;
> +	port->rs485.delay_rts_after_send = rs485->delay_rts_after_send;
> +	port->rs485.delay_rts_before_send = rs485->delay_rts_before_send;
> +
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		unsigned int cr;
> +
> +		hrtimer_try_to_cancel(&(uap->rs485_delay_timer));
> +		hrtimer_try_to_cancel(&(uap->rs485_tx_empty_poll_timer));
> +
> +		/* If RS485 is enabled, disable auto RTS */
> +		cr = pl011_read(uap, REG_CR);
> +		cr &= ~UART011_CR_RTSEN;
> +		pl011_write(cr, uap, REG_CR);
> +
> +		uap->rs485_current_status = rs485_receiving;
> +		rs485_set_rts_signal(uap,
> +			     port->rs485.flags
> +				     & SER_RS485_RTS_AFTER_SEND);
> +	} else {
> +		rs485_set_rts_signal(uap, true);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>   /*
>    * verify the new serial_struct (for TIOCSSERIAL).
>    */
> @@ -2647,6 +3094,11 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>   	uap->port.irq = dev->irq[0];
>   	uap->port.ops = &amba_pl011_pops;
>   
> +#ifdef CONFIG_SERIAL_AMBA_PL011_SOFT_RS485
> +	uap->port.rs485_config = &pl011_config_rs485;
> +	uap->port.rs485.flags = 0;	/* RS485 is not enabled by default */
> +#endif
> +
>   	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
>   
>   	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
> @@ -2819,10 +3271,15 @@ static struct amba_driver pl011_driver = {
>   
>   static int __init pl011_init(void)
>   {
> +#if IS_ENABLED(CONFIG_SERIAL_AMBA_PL011_SOFT_RS485)
> +	printk(KERN_INFO "Serial: AMBA PL011 UART driver with soft RS485 support\n");
> +#else
>   	printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
> +#endif

Didn't Stefan already commented on this?

You can actually remove the print completely (in a separate patch).

>   	if (platform_driver_register(&arm_sbsa_uart_platform_driver))
>   		pr_warn("could not register SBSA UART platform driver\n");
> +

And I saw a comment about added whitespace too.

>   	return amba_driver_register(&pl011_driver);
>   }
>   
> 

thanks,
-- 
js
suse labs
