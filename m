Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C37C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 04:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EF3207E8
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 04:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgEREuJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 00:50:09 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:49405 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgEREuJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 00:50:09 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id ABE22100C0585;
        Mon, 18 May 2020 06:50:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 39BDC31442D; Mon, 18 May 2020 06:50:06 +0200 (CEST)
Date:   Mon, 18 May 2020 06:50:06 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v3 3/5] serial: 8250: Support separate rs485 rx-enable
 GPIO
Message-ID: <20200518045006.s6e5aedgqwreqgd7@wunner.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517215610.2131618-4-heiko@sntech.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 17, 2020 at 11:56:08PM +0200, Heiko Stuebner wrote:
> @@ -1457,6 +1458,7 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p)
>  	 * Enable previously disabled RX interrupts.
>  	 */
>  	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> +		gpiod_set_value(port->rs485_re_gpio, 1);
>  		serial8250_clear_and_reinit_fifos(p);
>  
>  		p->ier |= UART_IER_RLSI | UART_IER_RDI;

The added line needs to be conditional on if (port->rs485_re_gpio)
because the gpiod could be NULL and gpiod_set_value() doesn't check
for that.


> @@ -1597,9 +1599,12 @@ static inline void __start_tx(struct uart_port *port)
>  void serial8250_em485_start_tx(struct uart_8250_port *up)
>  {
>  	unsigned char mcr = serial8250_in_MCR(up);
> +	struct uart_port *port = &up->port;
>  
> -	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
> +	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> +		gpiod_set_value(port->rs485_re_gpio, 0);
>  		serial8250_stop_rx(&up->port);
> +	}

Same here.


> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -253,6 +253,7 @@ struct uart_port {
>  	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
>  	struct serial_rs485     rs485;
>  	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
> +	struct gpio_desc	*rs485_re_gpio;		/* gpio RS485 receive enable */

Nit: I'd probably document this as "enable RS485 receiver" because it's
already apparent from the variable type and name that it's a gpio,
making it unnecessary to repeat that in the code comment.  But I guess
that's a matter of personal preference.


There's something else:  You need to amend serial8250_em485_config()
to toggle the GPIO depending on whether SER_RS485_RX_DURING_TX is
set.  Right now you enable the receiver by default and then disable
it when starting to transmit if half-duplex mode is selected and
likewise re-enable it when stopping to transmit.  But user space
may write some stuff to the tty while in half-duplex mode, then
immediately issue a TIOCSRS485 ioctl to switch to full-duplex mode.
If the ->rs485_config callback is executed while transmitting is
still ongoing, then you'll not re-enable the receiver when transmitting
finally stops.  The ->rs485_config callback is invoked under the
uart port spinlock but the lock may be briefly released and later
re-acquired by the IRQ handler if the TX FIFO is full.  (Unless
I'm missing something.)

Thanks,

Lukas
