Return-Path: <SRS0=VfF8=BB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED11C433E5
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 16:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40501206F5
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 16:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGVQvX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:51:23 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:51583 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbgGVQvX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jul 2020 12:51:23 -0400
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.12 patch 1) with ESMTPA;
        Wed, 22 Jul 2020 18:50:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 22 Jul 2020 18:50:58 +0200
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Helmut Grohne <helmut.grohne@intenta.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jan Kiszka <jan.kiszka@web.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH] tty: xilinx_uartps: Really fix id assignment
In-Reply-To: <c652674b-97c1-c333-0d75-ae40c3c7de49@xilinx.com>
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
 <20200709074849.GA28968@laureti-dev>
 <a3b9df28-8142-fc04-317f-44d65a24f38e@xilinx.com>
 <20200713071123.GA1994@laureti-dev>
 <e7b766ab-8c99-d30c-2352-6d7b09033537@xilinx.com>
 <20200713121019.GA6920@laureti-dev>
 <2db78149ae9ffb205f02ca4919b50d88@vanmierlo.com>
 <c652674b-97c1-c333-0d75-ae40c3c7de49@xilinx.com>
Message-ID: <775b7fc75f27513f70df63854ddccf58@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-07-22 09:18, Michal Simek wrote:
> On 13. 07. 20 18:08, Maarten Brock wrote:
>> On 2020-07-13 14:10, Helmut Grohne wrote:
>>> Hi Michal,
>>> 
>>> On Mon, Jul 13, 2020 at 01:49:38PM +0200, Michal Simek wrote:
>>>> On 13. 07. 20 9:11, Helmut Grohne wrote:
>>>> > Let me try to enumerate those I know:
>>>> >
>>>> > uart0    | uart1    | console | remark
>>>> > ---------+----------+---------+----------
>>>> > serial0  | serial1  | ttyPS0  | regular case
>>>> > serial0  | serial1  | ttyPS1  | normal assignment, second console
>>>> > serial1  | serial0  | ttyPS0  | -> Jan Kiszka, broken since revert
>>>> > disabled | serial0  | ttyPS0  | use only uart1 as serial0
>>>> > serial0  | disabled | ttyPS0  | regular case with uart1 disabled
>>>> >
>>>> > Out of these, I'm actively using configurations 3 and 4.
>>>> >
>>>> > Which of these scenarios do you test already?
>>>> 
>>>> For above we are missing also others
>>>> serial1 | serial0 | ttyPS1
>>>> disabled| serial1 | ttyPS1
>>> 
>>> Is it actually possible to have ttyPS1, but no ttyPS0? I think I 
>>> tried
>>> doing that earlier and it resulted in there being ttyPS0, but no 
>>> ttyPS1.
>> 
>> What if you also have a 16550 (in the PL) and give it the serial0 
>> alias?
>> Or a UARTlite? The serialN alias is inappropriate to set the number 
>> for
>> ttyPSn. How are you supposed to create all of ttyPS0, ttyS0 and ttyUL0
>> using a single serial0 alias?
> 
> yes this combination is not possible and I don't think this is xilinx
> specific issue.
> I expect the same problem you have with ttyAMA, ttyS and others.

Well, it is very easy to add a 16550 in the programmable logic of a 
Zynq.
Worse, it's impossible to only add uartps devices as the IP for it is
not available to the public.
It is less easy to add a 16550 to a CPU with ttyAMA but no external bus.
But if you add e.g. an I2C/SPI based SC16IS7xx which generates ttySCx 
you
might have the same problems.

But the problem is worse. What happens if you give the serial0 alias to
a xilinx_uartps and the 16550 driver has already taken ttyS0? (Or vice
versa?) Will the uartps still use ttyPS0 or will it ignore the serial0
alias? I predict the latter.

I see only two ways out.
* Let uartps generate ttySx device names, or
* Do not use serialN alias to set the number.

It was already stated that it is impossible to have ttyPS1 and no 
ttyPS0.
That would mean we cannot give serial0 to ttyS0 and serial1 to ttyPS1.
This makes me wonder if the opposite is valid: to give serial0 to ttyPS0
and serial1 to ttyS1. Probably not either.

There really needs to be a way to create deterministic names for the
devices!

>>>> serial1 | disables | ttyPS0
>>> 
>>> I'm not sure what this is supposed to mean. When there is no serial0
>>> alias, I'd expect ttyPS0 to be missing. However as indicated above 
>>> that
>>> is not what happens in practice. So either of these two 
>>> configurations
>>> seems invalid to me.
>>> 
>>>> All of these above are just not setting any console= on bootargs.
>>> 
>>> We usually set the console= assignment on bootargs.
>>> 
>>>> It means mix of these combinations is tested regularly but not all 
>>>> of
>>>> them. Do you see any other combination which is not supported?
>>> 
>>> I'm not aware of further relevant combinations.
>>> 
>>> Can we maybe trim down the matrix somehow? In my context, the need 
>>> for
>>> swapping the serial aliases arises from a limitation in u-boot-xlnx 
>>> and
>>> the desire to use one dtb for both linux and u-boot. It requires that
>>> the serial0 alias is the console. Are there other reasons to swap 
>>> them?
>>> If not, maybe fixing u-boot would be an option?
>>> 
>>> Helmut
>> 
>> I think that it would be better if u-boot used a "console" alias.
> 
> console is defined in bootargs which is OS specific feature. U-Boot has
> no idea what ttyPS, ttyS, etc means. That's why I don't think there is
> something wrong in this in u-boot. But please elaborate more on this
> because I am not aware about any issue on u-boot configuration.
> 
> Thanks,
> Michal

What I meant to say is that apparently U-boot requires serial0 to point 
to
the user-interface. This limits your options when assigning aliases. If
U-boot would use a different entry (e.g. "console" or better yet
"earlycon") things might be easier. serial0 should not be special IMHO.

But let's not diverge too much here.

Maarten

