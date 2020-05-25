Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B07C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 17:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4462B20776
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 17:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbgEYRt6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 13:49:58 -0400
Received: from mail.h3q.com ([213.73.89.199]:35372 "EHLO mail.h3q.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYRt5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 13:49:57 -0400
Received: (qmail 86805 invoked from network); 25 May 2020 17:49:54 -0000
Received: from mail.h3q.com (HELO mail.h3q.com) (mail.h3q.com)
  by mail.h3q.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 25 May 2020 17:49:54 -0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] 16C950 UART enable Hardware Flow Control
From:   Denis Ahrens <denis@h3q.com>
In-Reply-To: <20200525082750.GB5276@localhost>
Date:   Mon, 25 May 2020 19:49:54 +0200
Cc:     Johan Hovold <johan@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B7715399-667F-4DB7-A19D-4CB037ECE64A@h3q.com>
References: <BACA4F76-3D51-4854-894B-2E69272B5676@h3q.com>
 <20200525082750.GB5276@localhost>
To:     linux-serial@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> On 25. May 2020, at 10:27, Johan Hovold <johan@kernel.org> wrote:
> 
> On Sun, May 24, 2020 at 06:31:44PM +0200, Denis Ahrens wrote:
>> From: Denis Ahrens <denis@h3q.com>
>> 
>> Enable Automatic RTS/CTS flow control for the 16C950 UART in Enhanced Mode
>> like described in the Data Sheet Revision 1.2 page 28 and 29.
>> 
>> Without this change normal console output works, but everything putting
>> a little more pressure on the UART simply overruns the FIFO.
>> 
>> Signed-off-by: Denis Ahrens <denis@h3q.com>
>> ---
>> 
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index f77bf820b7a3..024235946f4d 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -2168,7 +2168,9 @@ int serial8250_do_startup(struct uart_port *port)
>>                serial_port_out(port, UART_LCR, 0);
>>                serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
>>                serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
>> -               serial_port_out(port, UART_EFR, UART_EFR_ECB);
>> +               serial_port_out(port, UART_EFR, UART_EFR_ECB |
>> +                                               UART_EFR_RTS |
>> +                                               UART_EFR_CTS);
>>                serial_port_out(port, UART_LCR, 0);
>>        }
> 
> This doesn't look right as you're now enabling automatic flow control
> for everyone.
> 
> Try adding this to set_termios() instead when enabling flow control.

The part in set_termios() is never reached because the UART_CAP_EFR
capability was removed ca. 10 years ago. The code fails to preserve
the UART_EFR_ECB bit which is in the same register as UART_EFR_CTS.
Also for some reason UART_EFR_RTS is not set.

So lets fix the code instead of disabling a feature.

I could write a patch which adds UART_CAP_EFR back to the 16C950 and
fixes the code in set_termios only for the 16C950. I would also add
another line which adds RTS hardware flow control only for the 16C950.

The change would look like this:
(I will write another mail with a real patch if I get the OK)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f77bf820b7a3..ac7efc43b392 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -122,8 +122,7 @@ static const struct serial8250_config uart_config[] = {
                .fifo_size      = 128,
                .tx_loadsz      = 128,
                .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
-               /* UART_CAP_EFR breaks billionon CF bluetooth card. */
-               .flags          = UART_CAP_FIFO | UART_CAP_SLEEP,
+               .flags          = UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
        },
        [PORT_16654] = {
                .name           = "ST16654",
@@ -2723,13 +2722,18 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
        if (up->capabilities & UART_CAP_EFR) {
                unsigned char efr = 0;
+               if (port->type == PORT_16C950)
+                       efr |= UART_EFR_ECB;
                /*
                 * TI16C752/Startech hardware flow control.  FIXME:
                 * - TI16C752 requires control thresholds to be set.
                 * - UART_MCR_RTS is ineffective if auto-RTS mode is enabled.
                 */
-               if (termios->c_cflag & CRTSCTS)
+               if (termios->c_cflag & CRTSCTS) {
                        efr |= UART_EFR_CTS;
+                       if (port->type == PORT_16C950)
+                               efr |= UART_EFR_RTS;
+               }
 
                serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
                if (port->flags & UPF_EXAR_EFR)

