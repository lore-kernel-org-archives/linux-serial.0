Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BB3C433E0
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jan 2021 11:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A1F21D93
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jan 2021 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbhADLmt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Jan 2021 06:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADLmt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Jan 2021 06:42:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1562CC061574
        for <linux-serial@vger.kernel.org>; Mon,  4 Jan 2021 03:42:09 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] helo=leviathan.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <s.trumtrar@pengutronix.de>)
        id 1kwOFT-0007tp-IS; Mon, 04 Jan 2021 12:42:07 +0100
References: <20201209091728.2357-1-s.trumtrar@pengutronix.de>
 <X9CzrUVgyqeuREKK@localhost>
User-agent: mu4e 1.4.12; emacs 28.0.50
From:   Steffen Trumtrar <s.trumtrar@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: 8250: always call tx_chars under spinlock
In-reply-to: <X9CzrUVgyqeuREKK@localhost>
Date:   Mon, 04 Jan 2021 12:42:06 +0100
Message-ID: <87eej1dj3l.fsf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Hi!

Johan Hovold <johan@kernel.org> writes:

> On Wed, Dec 09, 2020 at 10:17:27AM +0100, Steffen Trumtrar wrote:
>> In most cases serial8250_tx_chars is called with spinlock held.
>> Fix the remaining location, too.
>
> Please explain where __start_tx() is called without holding the port
> lock and consider fixing that up.
>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> ---
>>  drivers/tty/serial/8250/8250_port.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index b0af13074cd3..3310c2b70138 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -1559,6 +1559,7 @@ static void serial8250_stop_tx(struct uart_port *port)
>>  static inline void __start_tx(struct uart_port *port)
>>  {
>>  	struct uart_8250_port *up = up_to_u8250p(port);
>> +	unsigned long flags;
>>
>>  	if (up->dma && !up->dma->tx_dma(up))
>>  		return;
>> @@ -1569,8 +1570,11 @@ static inline void __start_tx(struct uart_port *port)
>>
>>  			lsr = serial_in(up, UART_LSR);
>>  			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
>> -			if (lsr & UART_LSR_THRE)
>> +			if (lsr & UART_LSR_THRE) {
>> +				spin_lock_irqsave(&port->lock, flags);
>>  				serial8250_tx_chars(up);
>> +				spin_unlock_irqrestore(&port->lock, flags);
>> +			}
>
> Since several callers of __start_tx() do hold the lock, this change will
> introduce a deadlock.
>

Meh, yeah :(

Seem like the correct solution would be to fix start_tx_rs485 and
serial8250_start_tx instead.


Best regards,
Steffen Trumtrar

--
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
