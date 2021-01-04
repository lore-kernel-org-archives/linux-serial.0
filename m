Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA5C433E0
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jan 2021 11:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA32221F9
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jan 2021 11:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbhADLsJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Jan 2021 06:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbhADLsJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Jan 2021 06:48:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDBC061574
        for <linux-serial@vger.kernel.org>; Mon,  4 Jan 2021 03:47:28 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] helo=leviathan.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <s.trumtrar@pengutronix.de>)
        id 1kwOKd-00005p-7M; Mon, 04 Jan 2021 12:47:27 +0100
References: <20201209091728.2357-1-s.trumtrar@pengutronix.de>
 <20201209091728.2357-2-s.trumtrar@pengutronix.de>
 <X9C0gs9VBqBaxdzj@localhost>
User-agent: mu4e 1.4.12; emacs 28.0.50
From:   Steffen Trumtrar <s.trumtrar@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: serial: 8250: wait till transmitter is empty
In-reply-to: <X9C0gs9VBqBaxdzj@localhost>
Date:   Mon, 04 Jan 2021 12:47:26 +0100
Message-ID: <87ble4exf5.fsf@pengutronix.de>
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

> On Wed, Dec 09, 2020 at 10:17:28AM +0100, Steffen Trumtrar wrote:
>> When only one single character is sent and RS485 signaling is used,
>> the driver runs into timing issues.
>>
>> When serial8250_tx_chars is called the single character is transmitted.
>> The check on uart_circ_empty will be positive and __stop_tx is called.
>> The check on UART_LSR_TEMT in BOTH_EMPTY will then be negativ and the
>> function will return. On the next call to serial8250_tx_chars
>> uart_circ_empty will still be true but the check on BOTH_EMPTY in
>> __stop_tx might still fail. This leads to a deadlock.
>>
>> Use readx_poll_timeout_atomic to allow the shift register to be emptied
>> before checking on BOTH_EMPTY.
>>
>> The timeout value is copied from 8250_dw.c.
>>
>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> ---
>>  drivers/tty/serial/8250/8250_port.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 3310c2b70138..87daf3758ff0 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/console.h>
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/sysrq.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/delay.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/tty.h>
>> @@ -1519,18 +1520,27 @@ static inline void __do_stop_tx(struct uart_8250_port *p)
>>  		serial8250_rpm_put_tx(p);
>>  }
>>
>> +static unsigned char serial8250_read_lsr(struct uart_8250_port *p)
>> +{
>> +	return serial_in(p, UART_LSR);
>> +}
>> +
>>  static inline void __stop_tx(struct uart_8250_port *p)
>>  {
>>  	struct uart_8250_em485 *em485 = p->em485;
>>
>>  	if (em485) {
>> -		unsigned char lsr = serial_in(p, UART_LSR);
>> +		unsigned char lsr;
>> +
>>  		/*
>>  		 * To provide required timeing and allow FIFO transfer,
>>  		 * __stop_tx_rs485() must be called only when both FIFO and
>>  		 * shift register are empty. It is for device driver to enable
>>  		 * interrupt on TEMT.
>>  		 */
>> +		readx_poll_timeout_atomic(serial8250_read_lsr, p, lsr,
>> +					  lsr & UART_LSR_TEMT, 1, 20000);
>
> Tight polling (1 us) for 20 ms with interrupts disabled?!
>
> Without having looked at the details, there's got to be a better way to
> handle this.
>

I'm sure there is. I just "copied" from 8250_dw.c O:-)


Best regards,
Steffen Trumtrar

--
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
