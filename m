Return-Path: <SRS0=CAPS=56=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3DDC2BA19
	for <linux-serial@archiver.kernel.org>; Tue, 14 Apr 2020 09:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A282072D
	for <linux-serial@archiver.kernel.org>; Tue, 14 Apr 2020 09:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSpjTTrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437956AbgDNJvI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437953AbgDNJvC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Apr 2020 05:51:02 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4426C0613A7
        for <linux-serial@vger.kernel.org>; Tue, 14 Apr 2020 02:51:01 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w20so12561600iob.2
        for <linux-serial@vger.kernel.org>; Tue, 14 Apr 2020 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0/CVvjOvFR04PMmD7/UbpajuikPHIdXr5m8H1Y8WLs=;
        b=KSpjTTrjnVseZPIlEXjYAqRpg1coLZvRtiD3g3TsFK6h9O8+ldiaiwo+3PKMnSzjrs
         E8lvHPamryKO9qWw6o94SHIrKh7AUlAEKwCC/VthwOtdIWTOIpUkgSesEhpJN9HbjCFO
         FOe17BYOSYg3EZ3ZTW6gwT6X/4CD5C1YTAWBHPt79Je+WqoBsiAkKdgqB1rT2/HuHO7+
         nQwHxIqQG1PTiY/arqp0FcWJ5GDKlleBpSyruf9RkY8EEoXoKk0/drNNyXzA5S57sHNP
         Kwu6HC2ZB7cIif3S+Ht5dtUX/Nan1/TPhB1JymIJFfp2BnedC8CBG94QDv1fQ8+ZEVXs
         94Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0/CVvjOvFR04PMmD7/UbpajuikPHIdXr5m8H1Y8WLs=;
        b=mT899HyttF5iKxPqQ4AkXlTF9+vS4dt818ysISXu7C7srHRZnFDZ1dU6JZd4xzyBPE
         qEs8CoUlNA9dCyNaYowvZPuz+iEOGfTlBcd9S+uAiH4wHl5/GTPjlLzPt5iCuT72vQRy
         I5unJZr8X9mOfi0KbmDeb0Xc/8RRHniomzDJVMCCXW5Lxw3CZRbEqPQjgW7L0HyZnfxy
         9ATo/yuzRCeuoPKz1KaK9z+ZB9GyZs8WAxCcftXyprCWVLp7IdBWoclB/gPQXU1JQivF
         B/DXXeGW+raQ299RnqjU2kfT3RHfzE5ogB16SLCOHi6aKjz9GowKbjLuUZOcTbkV9DM6
         XsAQ==
X-Gm-Message-State: AGi0PuYheV5I0Ab5iu3aZjKSeZJrc1QbZgSOzYN6aEWYhZAFd0L6UXSP
        iZQh5TvU7rmkGY62GyuVB9KggJ50buHve0PtAyY9DQ==
X-Google-Smtp-Source: APiQypIAzHAPsZm6/YjzgBKdLxVwZRuN20BIzmxcNpHujHGNUUVN1cMBYBN2MAoSZfOMDtKxrXTJAU7Sx+l2ahgTmcE=
X-Received: by 2002:a6b:3989:: with SMTP id g131mr20437211ioa.202.1586857860947;
 Tue, 14 Apr 2020 02:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <87lfnq15vi.fsf@osv.gnss.ru> <aa0174f8-7cef-46c9-4164-605191393abd@suse.cz>
 <87ftdtzypi.fsf@osv.gnss.ru> <20200327232428.GT25745@shell.armlinux.org.uk>
In-Reply-To: <20200327232428.GT25745@shell.armlinux.org.uk>
From:   Sergey Organov <sorganov@gmail.com>
Date:   Tue, 14 Apr 2020 12:50:49 +0300
Message-ID: <CANp_pu1caHaGJbBR8sEoOER2SfMDO3eJKOVQz3K8jKKZACh7=w@mail.gmail.com>
Subject: Re: Serial console and interrupts latency.
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk>:

>
> On Fri, Mar 27, 2020 at 04:58:33PM +0300, Sergey Organov wrote:
> > Jiri Slaby <jslaby@suse.cz> writes:
> >
> > > On 24. 03. 20, 10:04, Sergey Organov wrote:
> > >> Hello,
> > >>
> > >> [Extended CC list to try to get some attention]
> > >>
> > >> I was investigating random serial overruns on my embedded board and
> > >> figured it strongly correlates with serial output (to another serial
> > >> port) from kernel printk() calls, that forced me to dig into the kernel
> > >> sources, and now I'm very confused.
> > >>
> > >> I'm reading drivers/tty/serial/8250/8250_port.c, and
> > >> serial8250_console_write() function in particular (being on tty-next
> > >> branch).
> > >>
> > >> What I see is that it locks interrupts
> > >>
> > >> 3141:              spin_lock_irqsave(&port->lock, flags);
> > >>
> > >> and then calls wait_for_xmitr() both indirectly here:
> > >>
> > >> 3159:      uart_console_write(port, s, count, serial8250_console_putchar);
> > >>
> > >> and then directly as well:
> > >>
> > >> 3165:      wait_for_xmitr(up, BOTH_EMPTY);
> > >>
> > >> before re-enabling interrupts at:
> > >>
> > >> 3179:              spin_unlock_irqrestore(&port->lock, flags);
> > >>
> > >> Now, wait_for_xmitr(), even according to comments, could busy-wait for
> > >> up to 10+1000 milliseconds, and in this case this huge delay will happen
> > >> at interrupts disabled?
> > >>
> > >> Does it mean any serial console output out of printk() could cause 10
> > >> milliseconds or even 1 second interrupts latency? Somehow I can't
> > >> believe it.
> > >>
> > >> What do I miss?
> > >
> > > 1 second _timeout_ is for flow-control-enabled consoles.
> >
> > Yeah, sure. So it does mean interrupts could be disabled for up to 1
> > second, on already up and running system. Too bad.
> >
> > Actually, I use 8250 only as a reference implementation, my actual
> > chip is handled by imx.c, and the latter even has no timeouts on this
> > path, so apparently may block (the entire kernel) indefinitely!
> >
> > > 10 ms is _timeout_ for a character. With slow 9600 baud console, sending
> > > one character takes 0.8 ms. With 115200, it is 70 us.
> >
> > 70us of disabled interrupts is a huge number, and for FIFO-enabled chips
> > the estimate should be multiplied by FIFO size (say, x16) that brings us
> > close to 1ms even on 115200, right?
> >
> > Anyway, it must cause receiving overruns on another port running at
> > higher or the same baud rate and no DMA, sooner or later, as it does
> > for me.
>
> So, don't use serial console then, it's unsuitable for your use case.

Well, I'd rather fix it, as serial console is otherwise very suitable
for my needs.

If nobody else interested, I'll simply disable the lock you've added
for non-smp builds
in my kernel version, rather than trying to fix the issue in general.

That said, finding generic solution would be an interesting quest.

>
> > > If you send one line (80 chars), it is really 66 and 5.5 ms, respectively.
> > >
> > > So yes, serial consoles can slow down the boot and add latency. Use
> > > faster speeds or faster devices for consoles, if you mind. And do not
> > > enable flow control. Serial is serial.
> >
> > I don't care about slowing-down boot. I care about huge interrupt
> > latency on up and running system, causing loss of characters  (overruns)
> > on other serial ports.
> >
> > To be sure, it is this code that works on already running system as
> > well, not only on boot-time, right? Or is my system somehow
> > misconfigured?
> >
> > I'm confused as this seems to be a major issue and nobody but me seems
> > to care or to suffer from it, and I can't figure why.
> >
> > For reference, I figured this locking was introduced by:
> >
> > commit d8a5a8d7cc32e4474326e0ecc1b959063490efc9
> > Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
> > Date:   Tue May 2 16:04:29 2006 +0100
> >
> >     [SERIAL] 8250: add locking to console write function
> >
> >     x86 SMP breaks as a result of the previous change, we have no real
> >     option other than to add locking to the 8250 console write function.
> >     If an oops is in progress, try to acquire the lock.  If we fail to
> >     do so, continue anyway.
>
> Correct, and what I said back then still applies - and more.

What bothers me is "we have no real option..." part of this, as it's rarely
happens to be the case.

>
> > It seems like I need to, and yeah, it'd be a somewhat tough task indeed,
> > but then there is one simple question: why isn't console output handled
> > through usual buffer/ISR paths?
>
> The "usual" paths may not be active, and, in the case of an oops, we
> want to see the output, which we wouldn't be able to if the oops
> occurred in interrupt context.

The oops part is already special-cased and could be left special-cased, one
way or another. What is important is not to keep interrupts disabled for long
during normal system operation.

If it could be achieved at all, it probably should then be implemented at the
upper level,  to save low-level drivers from these complexities.

Thanks,
-- Sergey
