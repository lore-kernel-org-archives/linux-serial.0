Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E578C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 07:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA11C611CA
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 07:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhEMHZa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 May 2021 03:25:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:32872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231690AbhEMHZP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 May 2021 03:25:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7371DAF0F;
        Thu, 13 May 2021 07:24:04 +0000 (UTC)
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>
References: <20210505091928.22010-35-jslaby@suse.cz>
 <20210510070054.5397-1-jslaby@suse.cz>
 <YJkBIm4IiaZSrSPw@hovoldconsulting.com>
From:   Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v2 34/35] tty: make tty_get_byte_size available
Message-ID: <f8f94397-14d8-60d0-f977-8bc982a00b7a@suse.cz>
Date:   Thu, 13 May 2021 09:24:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJkBIm4IiaZSrSPw@hovoldconsulting.com>
Content-Type:   text/plain; charset=US-ASCII;
        format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10. 05. 21, 11:47, Johan Hovold wrote:
>> --- a/drivers/tty/tty_ioctl.c
>> +++ b/drivers/tty/tty_ioctl.c
>> @@ -300,6 +300,48 @@ int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
...
>> +unsigned char tty_get_byte_size(unsigned int cflag, bool account_flags)
>> +{
>> +	unsigned char bits;
>> +
>> +	switch (cflag & CSIZE) {
>> +	case CS5:
>> +		bits = 5;
>> +		break;
>> +	case CS6:
>> +		bits = 6;
>> +		break;
>> +	case CS7:
>> +		bits = 7;
>> +		break;
>> +	case CS8:
>> +	default:
>> +		bits = 8;
>> +		break;
>> +	}
>> +
>> +	if (!account_flags)
>> +		return bits;
>> +
>> +	if (cflag & CSTOPB)
>> +		bits++;
>> +	if (cflag & PARENB)
>> +		bits++;
>> +
>> +	return bits + 2;
>> +}
>> +EXPORT_SYMBOL_GPL(tty_get_byte_size);
> 
> This should really be two functions rather than passing a bool argument.
> 
> I think naming them
> 
> 	tty_get_word_size()
> 
> and
> 
> 	tty_get_frame_size()
> 
> would be much more clear than than "byte size" + flag.

Maybe I am screwed, but word means exactly 2B here. So instead, I would 
go for:
s/word/char/ -- might be confused with C's char, 1B, or maybe not -- or
s/word/data/ -- more generic and generally used in serial terminology.

> I realise that the serial-driver interface only uses a cflag argument,
> but I think we should consider passing a pointer to the termios
> structure instead.

That's impossible as termios is not always at hand. Examples are:
pch_uart_startup -> uart_update_timeout
sunsab_console_setup -> sunsab_convert_to_sab -> uart_update_timeout
sunsu_kbd_ms_init -> sunsu_change_speed -> uart_update_timeout

Let me document that in the commit.

thanks,
-- 
js
suse labs
