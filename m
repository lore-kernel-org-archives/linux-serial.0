Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BEEC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 14:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhKWPC2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:02:28 -0500
Received: from mailnode.rz.hs-mannheim.de ([141.19.1.96]:33228 "EHLO
        hs-mannheim.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231387AbhKWPC1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 10:02:27 -0500
Received: from [141.19.156.17] (account willenberg@hs-mannheim.de [141.19.156.17] verified)
  by hs-mannheim.de (CommuniGate Pro SMTP 6.2.14)
  with ESMTPSA id 55715064; Tue, 23 Nov 2021 15:59:18 +0100
Message-ID: <1eb4b718-dc7e-047f-1fa3-0ec1ab52e787@hs-mannheim.de>
Date:   Tue, 23 Nov 2021 15:59:17 +0100
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
 <fd919b8b-4348-df1f-05cb-93405f947dba@hs-mannheim.de>
 <7d46faa1-9a89-907e-bbb4-a03b91be86d0@xilinx.com>
From:   =?UTF-8?Q?R=c3=bcdiger_Willenberg?= <r.willenberg@hs-mannheim.de>
In-Reply-To: <7d46faa1-9a89-907e-bbb4-a03b91be86d0@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 23.11.2021 um 13:19 schrieb Michal Simek:
> 
> 
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
>>>> +        dev_err(dev, "maximum number of %s assigned\n", ULITE_NAME);
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
>>   "[PATCH v2] uartlite: Update the default for the 
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

I agree in principle. Michal, since you have an @xilinx.com domain could 
you please share where that place to discuss is?

The Linux "devicetree" list doesn't not seem the right place either for 
a company-managed, separate repo. If this goes your suggested way 
(completely changing the uartlite driver to use the "serial" alias, the 
Xilinx DTG _needs_ to be improved, including respecting the serial0 
alias for the designated console. I'd be glad to contribute to the 
discussion there. Right not there's a mess that's not solved by throwing 
out the port-number property alone.

>>
>> uartlite.c currently looks at port-number properties, not aliases. So 
>> unassigned aliases are not the issue. A similar-looking but more 
>> complicated issue that COULD happen, to be transparent, is this:
> 
> port-number is optional and as I said in the second thread I think that 
> this should be deprecated and removed. Most of DT drivers take care 
> about serial alias that's why we should go that route too.
> 
> And I also remember that drivers shouldn't really use different names as 
> ttyUL, ttyPS, ttyAMA, etc but all of them should use the same name as 
> ttyUSB is doing.

Big improvements are good and well, but they tend to break things and 
again it does mean the Xilinx DTG needs to move with that.
I'd be immensely grateful if you could indicate _where_ to discuss those 
changes, and who has the authority to speak for Xilinx. Off-list, if you 
think that is more appropriate.

Thank you,
Ruediger
