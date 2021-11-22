Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA262C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 22:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhKVWLd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:11:33 -0500
Received: from mailnode.rz.hs-mannheim.de ([141.19.1.96]:45844 "EHLO
        hs-mannheim.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231256AbhKVWLc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 17:11:32 -0500
Received: from [176.199.208.88] (account willenberg@hs-mannheim.de HELO [192.168.0.240])
  by hs-mannheim.de (CommuniGate Pro SMTP 6.2.14)
  with ESMTPSA id 55699867; Mon, 22 Nov 2021 23:08:23 +0100
Message-ID: <fd919b8b-4348-df1f-05cb-93405f947dba@hs-mannheim.de>
Date:   Mon, 22 Nov 2021 23:08:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, git@xilinx.com,
        shubhrajyoti.datta@xilinx.com
References: <20211118211745.133778-1-r.willenberg@hs-mannheim.de>
 <be268f13-7299-b701-55a9-0942d4aeb1e2@xilinx.com>
From:   Ruediger Willenberg <r.willenberg@hs-mannheim.de>
In-Reply-To: <be268f13-7299-b701-55a9-0942d4aeb1e2@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 19.11.2021 um 13:21 schrieb Michal Simek:
> On 11/18/21 22:17, Ruediger Willenberg wrote:
>> Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
>> the device tree port-number property is outside that range. This
>> happens when there are other UART types in the system because the
>> Xilinx device tree generator numbers all UARTs consecutively;
>> as a result, not as many Uartlites as specified by the
>> SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.
>>
>> Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
>> ---
>> Changes in v2:
>>   - give KERN_NOTICE when changing the id,
>>     with reference to the requested port-number
>>
>> -    if (id < 0 || id >= ULITE_NR_UARTS) {
>> -        dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
>> +    if (id == ULITE_NR_UARTS) {
>> +        dev_err(dev, "maximum number of %s assigned\n", ULITE_NAME);
>>           return -EINVAL;
>>       }
>> @@ -676,7 +678,11 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
>>           dev_set_drvdata(dev, NULL);
>>           return rc;
>>       }
> 
> nit: please keep this newline here.
> 
>> -
>> +    if (oor_id >= 0)
>> +        dev_notice(dev,
>> +            "assigned uartlite with device tree port-number=<%i> to %s%i\n",
>> +            oor_id, ULITE_NAME, id);
>> +
> 
> 
> 
> [linux](master)$ ./scripts/checkpatch.pl --strict 
> 0001-serial-uartlite-Move-out-of-range-port-numbers-into-.patch
> CHECK: Alignment should match open parenthesis

Thanks, I apparently didn't do "--strict" checking, sorry. Will fix both in PATCH v3


> And there is one more issue with this. If you start to mix serial IPs which are partially recorded 
> in aliases. For example like this.
> 
> aliases {
>      serial0 = &uart1;
> };
> 
> uart0 {
> ...
> };
> Uart0 is probed first. It is without alias and id 0 will be assigned to it. Then uart1 is probed. It 
> looks at aliases you get id 0 but it is already taken and you end up with "cannot assign to %s%i; it 
> is already in use"

As I point out in the other thread
  "[PATCH v2] uartlite: Update the default for the SERIAL_UARTLITE_NR_UARTS"
(I don't feel crossposting all of it here would be good practice)

a) the Xilinx DTG gives "serial" aliases to _all_ Xilinx UARTs
b) the Xilinx DTG gives "port-number" properties to _all_ Xilinx UARTs
c) these two are not assigned in the same order by the Xilinx DTG, which is problematic

uartlite.c currently looks at port-number properties, not aliases. So unassigned aliases are not the 
issue. A similar-looking but more complicated issue that COULD happen, to be transparent, is this:

* I have 1 ps_uart ("psuart1") and 2 uartlites ("uartlite0" and "uartlite1")
* The second uartlite is configured in MSS to be the OS console_device
* SERIAL_UARTLITE_NR_UARTS = 2
* The current Xilinx DTG could assign like this:
   uartlite1: port-number=<0> (because console)
   psuart1:   port-number=<1>
   uartlite0: port-number=<2>

* uartlite0 gets probed first, gets reassigned line 0, uartlite1 is probed, gets reassigned line 1, 
which means it's not the console

Except MSS seems to list uartps after uartlite, so even that does not happen. So yeah, this 
convoluted scenario could only be fixed by a much bigger change (see your next point below and my 
reply) OR by fixing the Xilinx DTG. "serial" alias order as currently generated by the Xilinx DTG is 
also a bit of a mess, as I explain in the other thread.

> It would be IMHO better to use of_alias_get_highest_id().
> In xilinx_uartps I used in past of_alias_get_alias_list() to get bitfield of aliases which are taken 
> and use only that one which are free but up2you. Having the same behavior across drivers would be good.

Right now it seems xilinx_uartps.c is only using
   id = of_alias_get_id(pdev->dev.of_node, "serial");
and then checking
   if (id >= CDNS_UART_NR_PORTS) {

Which means it's relying on
a) CDNS_UART_NR_PORTS being high enough and
b) the Xilinx DTG giving ps_uarts preferential treatment (i.e. always starting alias enumeration 
from serial0 with ps_uarts first).
I can envision in principle changing uartlite.c to the mechanism you suggest but it is a much bigger 
change, with the potential to break more stuff.

This is currently a minimal fix to the issue of the DTG not being compatible with the proper use of 
SERIAL_UARTLITE_NR_UARTS; it won't even be required anymore if Xilinx accepts my DTG patch. As the 
current DTG does not evenly hold "serial" aliases and "port-numbers" the same, I really don't see 
why they should not.

Thank you,
Ruediger

