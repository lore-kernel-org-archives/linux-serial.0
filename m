Return-Path: <SRS0=pZl0=7J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50F2C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 27 May 2020 20:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE36C2084C
	for <linux-serial@archiver.kernel.org>; Wed, 27 May 2020 20:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgE0Utq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 May 2020 16:49:46 -0400
Received: from mail.h3q.com ([213.73.89.199]:41478 "EHLO mail.h3q.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgE0Utq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 May 2020 16:49:46 -0400
Received: (qmail 36698 invoked from network); 27 May 2020 20:49:45 -0000
Received: from mail.h3q.com (HELO mail.h3q.com) (mail.h3q.com)
  by mail.h3q.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 27 May 2020 20:49:45 -0000
From:   Denis Ahrens <denis@h3q.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] 16C950 UART enable Hardware Flow Control
Message-Id: <E6FC8A25-70D3-4574-AECF-B0E8FC60A2F2@h3q.com>
Date:   Wed, 27 May 2020 22:49:44 +0200
To:     linux-serial@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> On 27. May 2020, at 09:55, Johan Hovold <johan@kernel.org> wrote:
> 
> [ Adding Pavel who disabled EFR at one point to CC. ]
> 
> On Mon, May 25, 2020 at 07:49:54PM +0200, Denis Ahrens wrote:
>> 
>> 
>>> On 25. May 2020, at 10:27, Johan Hovold <johan@kernel.org> wrote:
>>> 
>>> On Sun, May 24, 2020 at 06:31:44PM +0200, Denis Ahrens wrote:
>>>> From: Denis Ahrens <denis@h3q.com>
>>>> 
>>>> Enable Automatic RTS/CTS flow control for the 16C950 UART in Enhanced Mode
>>>> like described in the Data Sheet Revision 1.2 page 28 and 29.
>>>> 
>>>> Without this change normal console output works, but everything putting
>>>> a little more pressure on the UART simply overruns the FIFO.
>>> 
>>> This doesn't look right as you're now enabling automatic flow control
>>> for everyone.
>>> 
>>> Try adding this to set_termios() instead when enabling flow control.
>> 
>> The part in set_termios() is never reached because the UART_CAP_EFR
>> capability was removed ca. 10 years ago. The code fails to preserve
>> the UART_EFR_ECB bit which is in the same register as UART_EFR_CTS.
>> Also for some reason UART_EFR_RTS is not set.
> 
> The EFR capability was added by commit 7a56aa45982b ("serial: add
> UART_CAP_EFR and UART_CAP_SLEEP flags to 16C950 UARTs definition") and
> then removed half a year later by commit 0694e2aeb81 ("serial: unbreak
> billionton CF card") -- you should mention that in the commit message
> too.
> 
> I guess you need to determine how to enable this feature without
> breaking something else.
> 
>> So lets fix the code instead of disabling a feature.
>> 
>> I could write a patch which adds UART_CAP_EFR back to the 16C950 and
>> fixes the code in set_termios only for the 16C950. I would also add
>> another line which adds RTS hardware flow control only for the 16C950.
> 
> Nah, auto-RTS should probably have been enabled from the start.

UARTS with UART_CAP_EFR activates auto-RTS with UART_EFR_RTS and that is
not used anywhere. Setting this bit fixes my problem.

> And just make sure not clear any other bits in that register when
> updating the flow-control settings for example by reading it back first.

I can read the EFR register before using it (it was simply cleared before).
But then I change things for the XR17V35x too. But I don’t want to touch
that one because this UART has UART_CAP_AFE set and tries to set
auto-RTSCTS in two places. But someone with access to that hardware should
take a look, it seems it has the same problems. No auto-RTS and enhanced
mode is disabled in set_termios().

I think the code below is the safest way. It fixes things I can test
and does not change anything else.

summary for reviewers:

1. this patch keeps the enhanced mode activated for the 16C950 instead
of deactivating it in set_termios(). 
2. it activates auto-RTS for the 16C950
3. reenables UART_CAP_EFR for the 16C950 because of fix 1 and 2

Denis

> 
>> The change would look like this:
>> (I will write another mail with a real patch if I get the OK)
>> 
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index f77bf820b7a3..ac7efc43b392 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -122,8 +122,7 @@ static const struct serial8250_config uart_config[] = {
>>               .fifo_size      = 128,
>>               .tx_loadsz      = 128,
>>               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>> -               /* UART_CAP_EFR breaks billionon CF bluetooth card. */
>> -               .flags          = UART_CAP_FIFO | UART_CAP_SLEEP,
>> +               .flags          = UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
>>       },
>>       [PORT_16654] = {
>>               .name           = "ST16654",
>> @@ -2723,13 +2722,18 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>> 
>>       if (up->capabilities & UART_CAP_EFR) {
>>               unsigned char efr = 0;
>> +               if (port->type == PORT_16C950)
>> +                       efr |= UART_EFR_ECB;
>>               /*
>>                * TI16C752/Startech hardware flow control.  FIXME:
>>                * - TI16C752 requires control thresholds to be set.
>>                * - UART_MCR_RTS is ineffective if auto-RTS mode is enabled.
>>                */
>> -               if (termios->c_cflag & CRTSCTS)
>> +               if (termios->c_cflag & CRTSCTS) {
>>                       efr |= UART_EFR_CTS;
>> +                       if (port->type == PORT_16C950)
>> +                               efr |= UART_EFR_RTS;
>> +               }
>> 
>>               serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
>>               if (port->flags & UPF_EXAR_EFR)
>> 
> 
> Johan
