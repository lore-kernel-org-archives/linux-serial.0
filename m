Return-Path: <SRS0=8UUK=5M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D5BC43331
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F2E2074F
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 13:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWBTq17/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgC0N6j (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:58:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45336 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgC0N6j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Mar 2020 09:58:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id t17so10280252ljc.12
        for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2020 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=orb4amG580htNWX/t1pIa4IYD5zGLwwtvu1BmAA60/s=;
        b=gWBTq17/Dvt7wNi8lYoaJRbQTwQRn8JqOknyM0ql1W6kyKpe5cO/IatYwWl9aNnitx
         TIYs5TL3BJmn8JaFDOfHN7MrBIk6pUSkAtSY1m17Gvtak8gjt/A7UPY0Stw5cRRd90WK
         pO8OaOav+bcBuJDx7Y2tgsv927Eng5dQL91kWn+JzxuWD6wk+hiQGVccmsJCPmuTbEGc
         lxceYM/QUbYr2QxEkQgCIVSLIWvdvQ0EXfilXwtjaAE9vAwGY5GNY65T+f9K1iKcU5DQ
         Mc9g2Aizfj/XXFmzwKI4mr6/j4nRi8qlJTtwTbKcHglsGJTCJq7Xv8jiPcJrpelQh+br
         4RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=orb4amG580htNWX/t1pIa4IYD5zGLwwtvu1BmAA60/s=;
        b=Zqus3R3Ev6XyhadcBu9+h99xdFFJL0DUlntTQ6uqgrMt7sR4XGfuBunTXCl9ScCZCV
         m78qM2yDALXqbVHiIr7dieaiVJ3mvL2uWXxBJ4nKiioM/9Ao7ce9zCVnYhmotknBsBb5
         ZKCcnWWoLGghwd4vFp4xj+utKKfbytYRe4Qrvfqvuu/YyjfzpKln2iu1nQR9YYEZncon
         f3Fd5nch+h1yN8ITVCPfVSe90edRJgvoUbhUwiw+GNLd6FiRkaWiOkcnH64Yxn69ONrd
         bYGg5U7yrSbstJ+J+zKJIuI056+FgHht/G4DqpH5mYrb7UX63xEDUINy0Up9BbyNUady
         q+BQ==
X-Gm-Message-State: AGi0Puboey8M9QyE4ONaTPT0Wan7J+lGSj7HNlF6fSebRaKWKs1ZwAiD
        MQoyef57OzmL9YptoKueRmXm/hkb
X-Google-Smtp-Source: ADFU+vv1z535b9+TaoZ56jO9tJuuYEL7yIKac59IlKZ8STHfejS0N9SD6DtFU0VDsrRlG2t8kmbmiA==
X-Received: by 2002:a05:651c:110d:: with SMTP id d13mr8742850ljo.134.1585317515519;
        Fri, 27 Mar 2020 06:58:35 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t144sm3045948lff.94.2020.03.27.06.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 06:58:34 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Serial console and interrupts latency.
References: <87lfnq15vi.fsf@osv.gnss.ru>
        <aa0174f8-7cef-46c9-4164-605191393abd@suse.cz>
Date:   Fri, 27 Mar 2020 16:58:33 +0300
In-Reply-To: <aa0174f8-7cef-46c9-4164-605191393abd@suse.cz> (Jiri Slaby's
        message of "Fri, 27 Mar 2020 14:13:12 +0100")
Message-ID: <87ftdtzypi.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Jiri Slaby <jslaby@suse.cz> writes:

> On 24. 03. 20, 10:04, Sergey Organov wrote:
>> Hello,
>> 
>> [Extended CC list to try to get some attention]
>> 
>> I was investigating random serial overruns on my embedded board and
>> figured it strongly correlates with serial output (to another serial
>> port) from kernel printk() calls, that forced me to dig into the kernel
>> sources, and now I'm very confused.
>> 
>> I'm reading drivers/tty/serial/8250/8250_port.c, and
>> serial8250_console_write() function in particular (being on tty-next
>> branch).
>> 
>> What I see is that it locks interrupts
>> 
>> 3141:		spin_lock_irqsave(&port->lock, flags);
>> 
>> and then calls wait_for_xmitr() both indirectly here:
>> 
>> 3159:	uart_console_write(port, s, count, serial8250_console_putchar);
>> 
>> and then directly as well:
>> 
>> 3165:	wait_for_xmitr(up, BOTH_EMPTY);
>> 
>> before re-enabling interrupts at:
>> 
>> 3179:		spin_unlock_irqrestore(&port->lock, flags);
>> 
>> Now, wait_for_xmitr(), even according to comments, could busy-wait for
>> up to 10+1000 milliseconds, and in this case this huge delay will happen
>> at interrupts disabled?
>> 
>> Does it mean any serial console output out of printk() could cause 10
>> milliseconds or even 1 second interrupts latency? Somehow I can't
>> believe it.
>> 
>> What do I miss?
>
> 1 second _timeout_ is for flow-control-enabled consoles.

Yeah, sure. So it does mean interrupts could be disabled for up to 1
second, on already up and running system. Too bad.

Actually, I use 8250 only as a reference implementation, my actual
chip is handled by imx.c, and the latter even has no timeouts on this
path, so apparently may block (the entire kernel) indefinitely!

> 10 ms is _timeout_ for a character. With slow 9600 baud console, sending
> one character takes 0.8 ms. With 115200, it is 70 us.

70us of disabled interrupts is a huge number, and for FIFO-enabled chips
the estimate should be multiplied by FIFO size (say, x16) that brings us
close to 1ms even on 115200, right?

Anyway, it must cause receiving overruns on another port running at
higher or the same baud rate and no DMA, sooner or later, as it does
for me.

>
> If you send one line (80 chars), it is really 66 and 5.5 ms, respectively.
>
> So yes, serial consoles can slow down the boot and add latency. Use
> faster speeds or faster devices for consoles, if you mind. And do not
> enable flow control. Serial is serial.

I don't care about slowing-down boot. I care about huge interrupt
latency on up and running system, causing loss of characters  (overruns)
on other serial ports.

To be sure, it is this code that works on already running system as
well, not only on boot-time, right? Or is my system somehow
misconfigured?

I'm confused as this seems to be a major issue and nobody but me seems
to care or to suffer from it, and I can't figure why.

For reference, I figured this locking was introduced by:

commit d8a5a8d7cc32e4474326e0ecc1b959063490efc9
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Tue May 2 16:04:29 2006 +0100

    [SERIAL] 8250: add locking to console write function
    
    x86 SMP breaks as a result of the previous change, we have no real
    option other than to add locking to the 8250 console write function.
    If an oops is in progress, try to acquire the lock.  If we fail to
    do so, continue anyway.


> You can also try to eliminate the interrupts disablement, but that would
> be a bit tough task, IMO.

It seems like I need to, and yeah, it'd be a somewhat tough task indeed,
but then there is one simple question: why isn't console output handled
through usual buffer/ISR paths?

I have an idea to investigate the netconsole module to see how it does
similar job for networks. Hopefully it has no such problems and will
give some useful tips. 

Thanks,
-- Sergey
