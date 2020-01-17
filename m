Return-Path: <SRS0=tu6m=3G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA2C33CAF
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jan 2020 00:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E272072E
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jan 2020 00:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=3ksolutions.sk header.i=@3ksolutions.sk header.b="tD0DF0Jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbgAQA67 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:58:59 -0500
Received: from mail.prewas.sk ([212.5.209.170]:65480 "EHLO mail.prewas.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730151AbgAQA67 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 19:58:59 -0500
dkim-signature: v=1; a=rsa-sha256; d=3ksolutions.sk; s=mail.prewas.sk;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=joY66v7Mt3fGNDLPvMmR7lEkVuZrgs2jMtaE6jZ8mCk=;
        b=tD0DF0Jw9lF5zWH+nIiIBYGVDFfn8ar+Kk2PyWQlWUE8+7+Uq3gvSum4Ko11j+v2lyLbrj71grDti0uH52ncIFVT99KNPOA/T66BQpPk7nw71mhow4kFDlB4M9yuXrfiWXXslIHFDQdFkRLaZ9yW5nqy83Fw5qEq8AntrQXjNzeEJNcpq+t5LC5bYTvLyQGNwNQow+4I1O1v6NK7DTpot8zUYtOqAsRtoaLUg256TKywQrhUsmO4IVgcw4
        cUbVnyB7BKU5xGsTjaM8ou4lS/MIAqbnonWvr2wFKBkXYq8jwLl1BO2kXyvHWralWU/3r+tcqttv/PKmlBXJ0rQjjLjw==
Received: from [10.0.1.61] (pcfilo.vital.sk [10.0.1.61])
        by mail.prewas.sk with ESMTPSA
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128)
        ; Fri, 17 Jan 2020 01:58:57 +0100
From:   =?UTF-8?B?SXZhbiDFoGnFoXTDrWsgLSAzSyBTb2x1dGlvbnMsIHMuIHIuIG8u?= 
        <sistik@3ksolutions.sk>
Subject: Re: [PATCH] tty: serial: amba-pl011: added RS485 support
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20200106235203.27256-1-sistik@3ksolutions.sk>
 <20200116132954.5tcxmezs5qhseiem@wunner.de>
Message-ID: <4e082c29-9a47-accc-425b-8d1854fb6ac6@3ksolutions.sk>
Date:   Fri, 17 Jan 2020 01:58:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116132954.5tcxmezs5qhseiem@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16. 1. 2020 at 14:29 Lukas Wunner wrote:

> So I've implemented rs485 support for amba-pl011.c two years ago
> but the patches need a little more polishing before they can be
> upstreamed and I haven't gotten around to that yet.  I apologize
> that it meant you had to reinvent the wheel.
> You can find my implementation on this branch:
> https://github.com/RevolutionPi/linux/commits/revpi-4.19
> 
> Specifically this commit:
> https://github.com/RevolutionPi/linux/commit/0099313962a5

The wheel with octagonal shape is still not perfect. I made it more
smoother. Your implementation in recommended commit use an active
waiting (pl011_rs485_tx_start, pl011_rs485_tx_stop) and that could
cause lots of problems in upper layers of tty driver or application.
I think you forgot to implement possibility to start TX during
"delay after send", too.


> You've used hrtimers in case delays are necessary after assertion
> or before deassertion of RTS.  Note that 8250_port.c already contains
> code for that.  If one wants to go that route, it would probably be
> best to move that code into serial_core.c to make it available to
> non-8250 ports.

The 8250_port.c use DMA. Do you thin that it shoud be moved to
serial_core.c? If there will be default implementation of handling
RTS by serial_core.c using timers, than I will refactor this driver
to use it.


> I took a completely different approach:  I converted amba-pl011.c
> to threaded interrupt handling using two kthreads, one for sending,
> one for receiving.  This allows simultaneous writing to and reading
> from the FIFO.  The driver keeps track of the FIFO fill level,
> which allows writing to the FIFO blindly.  The hardirq handler
> updates the fill level counter and wakes either of the IRQ threads.

I do not see any used thread in link:
https://github.com/RevolutionPi/linux/commit/0099313962a5
I am not kernel thread expert but I think that thread is not as
lightweight as hrtimer. According to my knowledge the hrtimer use some
kind of interrupt. Compare to this the kthread is created as thread
with all its scheduling structures. Did you implemented proper thread
shutdown? Has the thread right priority? There are many questions
like this...


> Once the driver was converted to threaded interrupts, it became
> possible to sleep in the IRQ handler, so I just used msleep()
> for the RTS delays.

I think that thread with main purpose to wait is waist of resources.
This kind of task should be handled by timers. I saw this passion for
threads in Windows CE 6 drivers. Did you read some of them?


> The tty layer lets you know when there's nothing more to transmit by
> calling the ->stop_tx() hook.  Then you just busy-wait for the FIFO
> to empty before you deassert RTS.

This would be wasting of CPU time and as I mentioned above it can cause
problems in above layers. Busy-wait in any method require deep
knowledge of "caller".


> Another idea would be to set TXIFLSEL (TX interrupt FIFO level select)
> in the UARTIFLS register to the lowest possible setting.  Then you'll
> get an interrupt when the TX FIFO only contains 2 bytes (on a PL011
> with 16 byte FIFOs), thus minimizing the busy-wait duration.

TX interrupt is used by other parts of driver. I would not recommend to
change this behavior without complete analysis of buffer refill timing.
There can be some devices which can be "IDLE" sensitive. This devices
would not work properly on higher baud rates.
I do not use busy-wait in timer tick. If there is data in FIFO I do not
stop timer and let it tick one more time.


Thanks,

Ivan

