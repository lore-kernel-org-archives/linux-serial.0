Return-Path: <SRS0=8UUK=5M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB5CC43331
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08207206F1
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 14:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3rPSTSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgC0ODe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:03:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40210 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0ODe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Mar 2020 10:03:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so10289289ljj.7
        for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2020 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UfIQs+7lqCopP5dK0khcjqJtVAZG68BtANU7rVBHHwQ=;
        b=d3rPSTSWhglFGhLXbQ8CUMah13QVlMykUiWCF/FJ65la86xACrwMxBQRdSvDHt5YDO
         Qcv1e7shqRUTF5MXPg4dahQMWRrjfh3axvGPEYODA93noAu6IXUkf2Aiw5YTuSBSfRew
         +q0Stf5sQ66ngoxRQ/pj9nHCPrs7Yi8lX3tWpFjGgCJ9vjFM30aaqx01ITGMFUdJVVfI
         fs974bajn6xNkl9XA7LDJ5noJ68Jx/RCgdsqgwTnK32jStz8dnKlwnV1ACByxZ141NuP
         xUF8tIX4wxLBmf2sCErXm+GVYqeGDtUsAh1gZnW0nbxQKam8VLLOvxvovmzWvSjPHVWU
         CjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=UfIQs+7lqCopP5dK0khcjqJtVAZG68BtANU7rVBHHwQ=;
        b=O2ZSFWp2fB1Rnn6B51FogzQyHkP8Jr4tZt3IJzbgoUSGTvXE4Mstbw0VCRlT6pNlGH
         2hINjiruXxBRHrMrnfZOOsd+ON6xj1yPplMJoBP4gYFfeENJcUyWg12u4aQicKh+yJPM
         N5mxe134dUL34GPYNsRDDYUrM9qeFSsZ9HSDcSw8eaUlMlb15UjG3w0/jLxyudDEpJ1i
         RKr03dGpdb0YzfQkYD0I/mDiAMXQCBJFjWk6Noa0CealaByquTtEINU0swKdKc7HFWke
         gNlclU60xeEQrxWNEK0g0/oRHfvHt5LM8+MLiNzSKSRbFCekKWfn0aN+30tf3iOrgyOC
         QLIw==
X-Gm-Message-State: AGi0PuZUCwXt0zz5yCOvEkxSW9qP98bk4J5gqaBmX+zgD2ZP9nphgCPw
        4b2mzb3LK8Zf9lar8FCrs/Q=
X-Google-Smtp-Source: APiQypKPGqGDWaIvRoevH2Ye9c0OhHk+Haqsn/wuHgMWuzbZr/V/qV56aaRD1zuBw4iaA4JU8Q9mQA==
X-Received: by 2002:a2e:b175:: with SMTP id a21mr6682775ljm.213.1585317812579;
        Fri, 27 Mar 2020 07:03:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r21sm2929973ljp.29.2020.03.27.07.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 07:03:24 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Serial console and interrupts latency.
References: <87lfnq15vi.fsf@osv.gnss.ru>
        <aa0174f8-7cef-46c9-4164-605191393abd@suse.cz>
        <20200327133858.GL25745@shell.armlinux.org.uk>
Date:   Fri, 27 Mar 2020 17:03:12 +0300
In-Reply-To: <20200327133858.GL25745@shell.armlinux.org.uk> (Russell King's
        message of "Fri, 27 Mar 2020 13:38:58 +0000")
Message-ID: <87blohzyhr.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:

> On Fri, Mar 27, 2020 at 02:13:12PM +0100, Jiri Slaby wrote:
>> On 24. 03. 20, 10:04, Sergey Organov wrote:
>> > Hello,
>> > 
>> > [Extended CC list to try to get some attention]
>> > 
>> > I was investigating random serial overruns on my embedded board and
>> > figured it strongly correlates with serial output (to another serial
>> > port) from kernel printk() calls, that forced me to dig into the kernel
>> > sources, and now I'm very confused.
>> > 
>> > I'm reading drivers/tty/serial/8250/8250_port.c, and
>> > serial8250_console_write() function in particular (being on tty-next
>> > branch).
>> > 
>> > What I see is that it locks interrupts
>> > 
>> > 3141:		spin_lock_irqsave(&port->lock, flags);
>> > 
>> > and then calls wait_for_xmitr() both indirectly here:
>> > 
>> > 3159:	uart_console_write(port, s, count, serial8250_console_putchar);
>> > 
>> > and then directly as well:
>> > 
>> > 3165:	wait_for_xmitr(up, BOTH_EMPTY);
>> > 
>> > before re-enabling interrupts at:
>> > 
>> > 3179:		spin_unlock_irqrestore(&port->lock, flags);
>> > 
>> > Now, wait_for_xmitr(), even according to comments, could busy-wait for
>> > up to 10+1000 milliseconds, and in this case this huge delay will happen
>> > at interrupts disabled?
>> > 
>> > Does it mean any serial console output out of printk() could cause 10
>> > milliseconds or even 1 second interrupts latency? Somehow I can't
>> > believe it.
>> > 
>> > What do I miss?
>> 
>> 1 second _timeout_ is for flow-control-enabled consoles.
>> 
>> 10 ms is _timeout_ for a character. With slow 9600 baud console, sending
>> one character takes 0.8 ms. With 115200, it is 70 us.
>> 
>> If you send one line (80 chars), it is really 66 and 5.5 ms, respectively.
>> 
>> So yes, serial consoles can slow down the boot and add latency. Use
>> faster speeds or faster devices for consoles, if you mind. And do not
>> enable flow control. Serial is serial.
>> 
>> You can also try to eliminate the interrupts disablement, but that would
>> be a bit tough task, IMO.
>
> ... and likely difficult to implement, since the spinlock is there to
> prevent coincident usage from userspace and kernel space to the port.
> If userspace is outputting a message in unison with a kernel console
> message, there must be exclusivity, otherwise the two messages will
> either be intermingled, or completely corrupted due to TX FIFO
> overflow, making the console quite useless.
>
> Higher latency is something that IMHO has to be accepted as a result
> of using serial console.

This (local) interrupts disabling might be not a big problem on SMP, I
dunno, as another core could still handle IRQs, but for non-SMP case
this is too bad as it causes missed data on other ports.

Can we disable this locking on non-SMP configs as a work-around?

> As Jiri says, the way around that is to use as fast a baud rate as
> possible on the serial console.

Unfortunately, this is entirely impractical for an application that
utilizes maximum baud rates on other serial ports.

Thanks,
-- Sergey
