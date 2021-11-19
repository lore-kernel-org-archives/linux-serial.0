Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45775C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 08:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB0F61AF0
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 08:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhKSIqT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:46:19 -0500
Received: from goliath.siemens.de ([192.35.17.28]:44996 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhKSIqT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 03:46:19 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AJ8hDvq003802
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 09:43:13 +0100
Received: from [167.87.1.34] ([167.87.1.34])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AJ8hCRQ008108;
        Fri, 19 Nov 2021 09:43:12 +0100
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control while
 in rs485 mode"
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Su Bao Cheng <baocheng_su@163.com>, Lukas Wunner <lukas@wunner.de>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, chao.zeng@siemens.com
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
 <20211027113938.GA9373@wunner.de>
 <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
 <61ace2ea-e0b3-599a-3098-8e8a2a4772fa@siemens.com>
Message-ID: <68b02a33-6cfb-5139-f8b3-20f289c2befc@siemens.com>
Date:   Fri, 19 Nov 2021 09:43:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <61ace2ea-e0b3-599a-3098-8e8a2a4772fa@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19.11.21 09:00, Jan Kiszka wrote:
> On 12.11.21 07:14, Su Bao Cheng wrote:
>> On 2021/10/27 下午7:39, Lukas Wunner wrote:
>>> On Wed, Oct 27, 2021 at 07:16:44PM +0800, Su Bao Cheng wrote:
>>>> This reverts commit f45709df7731ad36306a28a3e1af7309d55c35f5.
>>>>
>>>> The `serial8250_do_set_mctrl` not only used by userspace ioctl but
>>>> also the kernel itself.
>>>>
>>>> During tty_open, the uart_port_startup sets the MCR to 0, and then use
>>>> set_mctrl to restore the MCR, so at this time, the MCR read does not
>>>> reflect the desired value.
>>>
>>> I don't quite follow.  Where is uart_port_startup() setting the MCR to 0?
>>> Are you referring to the call to uart_port_dtr_rts()?  That function should
>>> set RTS correctly according to RS485 state, so I don't see where any
>>> breakage may occur.
>>>
>>> What is the user-visible issue that you seek to fix with the revert?
>>>
>>
>> Sorry for the late response, the company exchange server does not work
>> for me at this moment, so I have to use the private email instead.
>>
>> The issue is observed on omap8250 hardware (CPU: AM6548). the use case
>> is RS485 half-duplex (2 wire mode), in this mode the RTS pin is used to
>> control the direction and is software controller via the MCR[1]
>> register. The problem is that the RS485 transmitting is OK, but the
>> receiving is not working. Similar issue also exists for the RS422, i.e.
>> the 4-wire full-duplex mode of RS485, but this time the TX does not
>> work, RX is fine.
>>
>> The MCR is set to 0 at this line within uart_port_startup():
>> 	retval = uport->ops->startup(uport);
>>
>> On omap8250, the startup() points to omap_8250_startup(), within it:
>> 	up->mcr = 0;
>>
>> For software controlled RTS pin of RS485 half-duplex, when not in the
>> transmitting, the MCR[1] should be constant to indicate the current
>> direction is receiving. This is set in serial8250_em485_stop_tx().
>>
>> So after this point of setting the MCR to 0, this up->mcr register
>> mirror does not reflect the actual desired value anymore. Further
>> checking against it leads to false result.
>>
>> Another possible fix could be, instead of setting the mcr to 0 blindly,
>> one could check if the current operating mode is RS485 half-duplex, and
>> if so, mask the MCR[1], so that this bit is not changed. Because the
>> MCR[1] will be changed to the correct value before TX in
>> serial8250_em485_start_tx(), this change would not impact the transmitting.
>>
> 
> From this description, it seems like we have a rather fundamental
> regression here. Was RS485-half-duplex / RS422 tested after this change,
> Lukas?
> 
> A revert is just a workaround, I would say. But unless we have a quick
> idea for the proper fix, it may be the option for stable at least.
> 
> Jan
> 

Digging a bit deeper: One issue of the original patch was definitely
that it tried to sanitized mctrl inside serial8250_do_set_mctrl, rather
than serial8250_set_mctrl. That caused alternative set_mctrl handler to
become out of sync /wrt mctrl. Just look at omap8250_set_mctrl, how it
will work on the unsanitized value.

That may or may not yet explain all issues Baocheng is seeing with the
patch.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
