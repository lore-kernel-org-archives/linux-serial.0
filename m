Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1832C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 15:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377965AbhKZPlJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 10:41:09 -0500
Received: from fieber.vanmierlo.com ([84.243.197.177]:39144 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354267AbhKZPjI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 10:39:08 -0500
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.3.1 patch 1) with ESMTPA;
        Fri, 26 Nov 2021 16:35:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 26 Nov 2021 16:35:24 +0100
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Ruediger Willenberg <r.willenberg@hs-mannheim.de>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        git@xilinx.com, shubhrajyoti.datta@xilinx.com
Subject: Re: [PATCH v2] serial: uartlite: Move out-of-range port-numbers into
 ULITE_NR_UARTS range
In-Reply-To: <7d46faa1-9a89-907e-bbb4-a03b91be86d0@xilinx.com>
References: <20211118211745.133778-1-r.willenberg@hs-mannheim.de>
 <be268f13-7299-b701-55a9-0942d4aeb1e2@xilinx.com>
 <fd919b8b-4348-df1f-05cb-93405f947dba@hs-mannheim.de>
 <7d46faa1-9a89-907e-bbb4-a03b91be86d0@xilinx.com>
Message-ID: <0ecd8ba236e18e580700b31ca415ba22@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-11-23 13:19, Michal Simek wrote:
> On 11/22/21 23:08, Ruediger Willenberg wrote:
>> Am 19.11.2021 um 13:21 schrieb Michal Simek:
>>> On 11/18/21 22:17, Ruediger Willenberg wrote:
>>>> Find free uart_port struct in range 0 <= id < ULITE_NR_UARTS when
>>>> the device tree port-number property is outside that range. This
>>>> happens when there are other UART types in the system because the
>>>> Xilinx device tree generator numbers all UARTs consecutively;
>>>> as a result, not as many Uartlites as specified by the
>>>> SERIAL_UARTLITE_NR_UARTS parameter could be successfully added.
>>>> 
>>>> Signed-off-by: Ruediger Willenberg <r.willenberg@hs-mannheim.de>
>>>> ---
>>>> Changes in v2:
>>>>   - give KERN_NOTICE when changing the id,
>>>>     with reference to the requested port-number
>>>> 
>>>> -    if (id < 0 || id >= ULITE_NR_UARTS) {
>>>> -        dev_err(dev, "%s%i too large\n", ULITE_NAME, id);
>>>> +    if (id == ULITE_NR_UARTS) {
>>>> +        dev_err(dev, "maximum number of %s assigned\n", 
>>>> ULITE_NAME);
>>>>           return -EINVAL;
>>>>       }
>>>> @@ -676,7 +678,11 @@ static int ulite_assign(struct device *dev, int 
>>>> id, u32 base, int irq,
>>>>           dev_set_drvdata(dev, NULL);
>>>>           return rc;
>>>>       }
>>> 
>>> nit: please keep this newline here.
>>> 
>>>> -
>>>> +    if (oor_id >= 0)
>>>> +        dev_notice(dev,
>>>> +            "assigned uartlite with device tree port-number=<%i> to 
>>>> %s%i\n",
>>>> +            oor_id, ULITE_NAME, id);
>>>> +
>>> 
>>> 
>>> 
>>> [linux](master)$ ./scripts/checkpatch.pl --strict 
>>> 0001-serial-uartlite-Move-out-of-range-port-numbers-into-.patch
>>> CHECK: Alignment should match open parenthesis
>> 
>> Thanks, I apparently didn't do "--strict" checking, sorry. Will fix 
>> both in PATCH v3
>> 
>> 
>>> And there is one more issue with this. If you start to mix serial IPs 
>>> which are partially recorded in aliases. For example like this.
>>> 
>>> aliases {
>>>      serial0 = &uart1;
>>> };
>>> 
>>> uart0 {
>>> ...
>>> };
>>> Uart0 is probed first. It is without alias and id 0 will be assigned 
>>> to it. Then uart1 is probed. It looks at aliases you get id 0 but it 
>>> is already taken and you end up with "cannot assign to %s%i; it is 
>>> already in use"
>> 
>> As I point out in the other thread
>>   "[PATCH v2] uartlite: Update the default for the 
>> SERIAL_UARTLITE_NR_UARTS"
>> (I don't feel crossposting all of it here would be good practice)
>> 
>> a) the Xilinx DTG gives "serial" aliases to _all_ Xilinx UARTs
>> b) the Xilinx DTG gives "port-number" properties to _all_ Xilinx UARTs
>> c) these two are not assigned in the same order by the Xilinx DTG, 
>> which is problematic
> 
> DTG/MSS logic should be solved in different mailing list that's why
> please move it there.

What mailing list? I'd like to be in on this.

>> 
>> uartlite.c currently looks at port-number properties, not aliases. So 
>> unassigned aliases are not the issue. A similar-looking but more 
>> complicated issue that COULD happen, to be transparent, is this:
> 
> port-number is optional and as I said in the second thread I think
> that this should be deprecated and removed. Most of DT drivers take
> care about serial alias that's why we should go that route too.
> 
> And I also remember that drivers shouldn't really use different names
> as ttyUL, ttyPS, ttyAMA, etc but all of them should use the same name
> as ttyUSB is doing.
> 
> Thanks,
> Michal

The port-number is optional, but currently automatically generated. The 
same goes
for the aliases. How can one remove them from the device-tree? Is 
overwriting the
only option? If so, what value would you recommend?

If, and only if, devices would start to use the same name would the 
serial alias
become a decent solution. But I'm sure that the 8250 driver currently 
does not
supports e.g. ttyS25 when SERIAL_8250_NR_UARTS is configured for only 4 
devices.

As a workaround I always patch the xilinx_uartps.c driver to also 
support
port-number. This way I can overwrite the port-number values in the 
device-tree
to get them numbered ttyPS0 and ttyPS1. And then I can use the serial 
alias for
my 16550's.

&uart0 {
         port-number = <0>;                      // this is a 
xilinx_uartps
};

&uart1 {
         port-number = <1>;                      // this is a 
xilinx_uartps
};

&liteuarts_axi_uartlite_0 {
         port-number = <0>;                      // this is a uartlite
};

&liteuarts_axi_uartlite_1 {
         port-number = <1>;                      // this is a uartlite
};
[...]
&liteuarts_axi_uartlite_10 {
         port-number = <10>;                     // this is a uartlite
};

The 16550's also received a port-number but the driver ignores that.

aliases {
         serial0 = &uart0;
         serial1 = &fulluarts_axi_uart16550_1;
         serial2 = &fulluarts_axi_uart16550_2;
         serial3 = &fulluarts_axi_uart16550_3;
         serial4 = &fulluarts_axi_uart16550_4;
         serial5 = &fulluarts_axi_uart16550_5;
         serial6 = &fulluarts_axi_uart16550_6;
         serial7 = &fulluarts_axi_uart16550_7;
         serial8 = &fulluarts_axi_uart16550_0;
};

Note how I had to abuse serial8 to get the 16550_0 at ttyS0 with
SERIAL_8250_NR_UARTS=8. This does leave me with several dangling serial 
aliases
in the final device tree.

The fact that I have to use this workaround to me means that the serial 
naming
and numbering system is broken.

If you ask me, the solution is not to start using the serial alias, but 
abandon it
and go for port-number entirely, at least for uartlite and 
xilinx_uartps. But
eventually also for the 8250 driver and all others.

Btw. the port-number and the MSS also don't sort natural, but purely 
alphabetical.
axi_uartlite_10 comes before axi_uartlite_2. Maybe I should have renamed 
them
with a leading zero myself.

Maarten

