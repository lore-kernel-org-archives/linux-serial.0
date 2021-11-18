Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20A2C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 21:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24CE61A7D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 21:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhKRVYI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 16:24:08 -0500
Received: from mailnode.rz.hs-mannheim.de ([141.19.1.96]:47998 "EHLO
        hs-mannheim.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229633AbhKRVYG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 16:24:06 -0500
Received: from [176.199.209.39] (account willenberg@hs-mannheim.de HELO [192.168.0.240])
  by hs-mannheim.de (CommuniGate Pro SMTP 6.2.14)
  with ESMTPSA id 55642058; Thu, 18 Nov 2021 22:21:05 +0100
Message-ID: <e01371cd-de45-cf9d-191a-c088df43566a@hs-mannheim.de>
Date:   Thu, 18 Nov 2021 22:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] uartlite: Update the default for the
 SERIAL_UARTLITE_NR_UARTS
To:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-serial@vger.kernel.org
Cc:     git@xilinx.com, gregkh@linuxfoundation.org
References: <20211117051635.1316958-1-shubhrajyoti.datta@xilinx.com>
 <edf15265-548a-1315-9175-967dddb38d4b@hs-mannheim.de>
 <82ee1522-da4b-9fc6-bcf5-ceb94e307f96@xilinx.com>
From:   Ruediger Willenberg <r.willenberg@hs-mannheim.de>
In-Reply-To: <82ee1522-da4b-9fc6-bcf5-ceb94e307f96@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 18.11.2021 um 09:45 schrieb Michal Simek:
> On 11/17/21 10:53, Ruediger Willenberg wrote:
>> Am 17.11.2021 um 06:16 schrieb Shubhrajyoti Datta:
>>> "The uartlite is used by FPGAs that support a basically unlimited number
>>> of uarts so limiting it at 16 dosn't make sense as users might need more
>>> than that."
>>> the commit also said that number should be unlimited. However it set the
>>> default to 1 instead of 16.The original 16 written in driver should be
>>>   quite reasonable default to cover most of the cases.
>>>
>>> So change the default number of uarts back to 16.
>>
>> The DTG should number devices for each driver separately from 0;
>> serial_core.c checks for (0 <= uart_port->line < NR_UART_PORTS). As a
>> consequence, when a Zynq system has both a PS-UART and a Uartlite,
>> setting SERIAL_UARTLITE_NR_UARTS explicitly to 1 in Kconfig means
>> probing the uartlite fails, which is confusing to the unsuspecting
>> KConfig user. Setting the default to 16 just kicks the can down the
>> road because it will fail for more than 15 Uartlites (or less, if there
>> are more PS-UARTs or AXI 16550A UARTs).
> 
> I have no problem with your patch and it is correct (I would prefer a message to show for this 
> option). But it doesn't mean that default 1 was correct value to setup especially when range was 
> setup by Sam from 1-256. And originally number 16 was used.

> That's why I think this patch is still valid. If you don't like description it can be changed 
> because definitely people are using systems with more then one uartlite and 1 is not reasonable 
> default.
> We can also take a look at default for others serial drivers
> and none of them is using 1 as default. IIRC discussion about UARTPS it was said if number is not 


Clarification: I support changing the default up to 16. It will avoid problems for most cases where
a) there are only a few Uartlites in the system
AND
b) the Kconfig user doesn't explictly specify SERIAL_UARTLITE_NR_UARTS

I just wanted to point out that trouble ensues when
a) somebody wants 16 Uartlites in a system when there is also a PS UART (basically any Zynq)
OR
b) somebody explicitly sets the SERIAL_UARTLITE_NR_UARTS to the number she built into a Zynq system
(when the Uartlite driver is activated in menuconfig, the NR parameters pops right up, so it's 
mighty tempting to actually set it to the accurate number)

Moving the default up should just not be a band-aid for the cases where a single Uartlite can not be 
assigned, when really there is a fundamental inconsistency between how serial_core.c has limited 
line numbering since Kernel 2.6 (0 <= line_id < NR_UARTs) and what Xilinx DTG does with UARTs.


 > And using aliases for serial id identification is around for a while and Xilinx DTG is aligned with
 > it because via current dt you can't describe cases where you will have stable numbers for different
 > tty names like
 > ttyS0, ttyUL0, ttyPS0, ttyAMA0, etc.
 > That's why DTG generates it per all serial IDs.

Sincere apologies, I do not quite understand this explanation/argument. Would you be so kind to 
rephrase?

(As I'm a newbie to this list, I'm not sure how much back-and-forth is appropriate about a topic. 
Since my issue here is about the Xilinx DTG, not Linux kernel code per se, I'd also be fine to 
continue emailing off-list. There does not seem to be a similar list for device-tree-xlnx)

Best wishes,
Ruediger
