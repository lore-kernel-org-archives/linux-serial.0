Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13F4C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 21:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1CAA61A70
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 21:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhKRVTZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 16:19:25 -0500
Received: from mailnode.rz.hs-mannheim.de ([141.19.1.96]:46078 "EHLO
        hs-mannheim.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229521AbhKRVTV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 16:19:21 -0500
Received: from [176.199.209.39] (account willenberg@hs-mannheim.de HELO [192.168.0.240])
  by hs-mannheim.de (CommuniGate Pro SMTP 6.2.14)
  with ESMTPSA id 55641576; Thu, 18 Nov 2021 22:16:18 +0100
Message-ID: <e93eeb46-8018-87f8-c753-cdb42f22a193@hs-mannheim.de>
Date:   Thu, 18 Nov 2021 22:16:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, git@xilinx.com,
        shubhrajyoti.datta@xilinx.com
References: <20211117221510.11959-1-r.willenberg@hs-mannheim.de>
 <01610e0c-998a-85b3-17b4-5a495c2974bf@xilinx.com>
From:   Ruediger Willenberg <r.willenberg@hs-mannheim.de>
In-Reply-To: <01610e0c-998a-85b3-17b4-5a495c2974bf@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 18.11.2021 um 09:34 schrieb Michal Simek:
> 
> 
> On 11/17/21 23:15, Ruediger Willenberg wrote:
>> Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
>> the device tree port-number property is outside that range. This
>> can happen because the Xilinx device tree generator does not start
>> enumerating Uartlites at 0 when there are PS-UARTs or AXI 16550A
>> UARTs in the system; it then enumerates all UARTs consecutively
>> despite them having separate drivers with separate structures.
>> This has become more problematic since the Kconfig property
>> SERIAL_UARTLITE_NR_UARTS enables precise allocation of uart_port
>> structs, which can't be used if the port-number doesn't start at 0
>>
>> Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
>> ---
>>   drivers/tty/serial/uartlite.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
>> index d3d9566e5dbd..546eecdb6033 100644
>> --- a/drivers/tty/serial/uartlite.c
>> +++ b/drivers/tty/serial/uartlite.c
>> @@ -632,14 +632,14 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
>>       struct uart_port *port;
>>       int rc;
>> -    /* if id = -1; then scan for a free id and use that */
>> -    if (id < 0) {
>> +    /* if id -1 or out of range; then scan for a free id and use that */
>> +    if (id < 0 || id >= ULITE_NR_UARTS) {
>>           for (id = 0; id < ULITE_NR_UARTS; id++)
>>               if (ulite_ports[id].mapbase == 0)
>>                   break;
>>       }
>> -    if (id < 0 || id >= ULITE_NR_UARTS) {
>> -        dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
>> +    if (id == ULITE_NR_UARTS) {
>> +        dev_err(dev, "maximum number of %s assigned\n", ULITE_NAME);
>>           return -EINVAL;
>>       }
>>
> 
> Don't you want to also inform user about it? They can expect that serial10 is going to be ttyUL10 
> but if ULITE_NR_UARTS is less you will get different number and user will have no idea why.
> 
> Thanks,
> Michal

Good catch, thanks! Will add a dev_notice() and repost.
-Ruediger
