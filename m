From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] TTY: serial_core, fix dtr_rts NULL dereference
Date: Tue, 29 Mar 2011 17:10:31 +0200
Message-ID: <4D91F667.3060603@suse.cz>
References: <4D8C7253.3040204@suse.cz>	<1301049956-6933-1-git-send-email-jslaby@suse.cz>	<20110325110040.6866d671@lxorguk.ukuu.org.uk>	<4D8CAA0F.9040204@suse.cz> <20110325204922.7ed9fd8c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37217 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1C2PKf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Mar 2011 11:10:35 -0400
Received: by fxm17 with SMTP id 17so289186fxm.19
        for <linux-serial@vger.kernel.org>; Tue, 29 Mar 2011 08:10:34 -0700 (PDT)
In-Reply-To: <20110325204922.7ed9fd8c@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jirislaby@gmail.com>, gregkh@suse.de, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 03/25/2011 09:49 PM, Alan Cox wrote:
>>> The uart helper layer assumes here (and a couple of other spots) that the
>>> IRQ handler for the tty takes the port lock.
>>
>> The oopsing path is through open BTW:
>> -> uart_open
>>  -> tty_port_block_til_ready
>>   -> tty_port_raise_dtr_rts
>>    -> uart_dtr_rts
>>
>>> I think the *right* fix is probably to pass port not port->tty into the
>>> helper in the first place but that seems to ripple into a lot of drivers.
>>>
>>> (passing port->tty to things that then go tty->port is braindead and
>>> causes half the mess in the tty/serial code)
>>
>> I seem to miss the point. uart_update_termios needs tty, not port.
> 
> 
> Actually I think it needs shooting having looked more closely

Hmm, looking more closely, it's broken and should be converted to
tty_port in full. I'll take a look if I can do something about that.

> It does 3 things
> 
> 1. It copies a flag across as part of a console hack. That should be done
> elsewhere - eg in uart_startup

Perhaps.

> 2. It sets the speed, which was already done by uart_startup

Note that uart_startup is called with init_hw = 0 from uart_open. So the
speed is not set yet. So we should set the speed in uart_startup
unconditionally, I guess.

> 3. It goes poking around in the CBAUD flag before playing with DTR and
> RTS which will have no effect as we *already* set the flags in
> uart_dtr_rts

ACK

.dtr_rts did only dtr_rts when added by you. Then Arnd moved
uart_update_termios into that in 3f582b8c11.

I'll post a patch as a short-term fix shortly.

thanks,
-- 
js
suse labs
