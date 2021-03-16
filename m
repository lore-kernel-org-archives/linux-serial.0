Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C3DC43381
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7128A6502D
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 11:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhCPLZM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Mar 2021 07:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232994AbhCPLY7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Mar 2021 07:24:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 129D26501D;
        Tue, 16 Mar 2021 11:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615893898;
        bh=Dk4y8iGJZZIjb3solFCTMP0GpGYj5vgAXWPhsjVPmNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RV6uE8jz8lDq+x+yBjJEBLn8VIYSb5deFoou+Z4qUyBNFUyhPOywUC9efGSjTube+
         s3/zR8mG6wb/PXyEChG+WSfj09KqgmQj3bsoptJ0/CDD1JJv80blR8VAFXB9og9j9G
         oDS4Ay5uAQVwvbMtUrF4CpoFBHcSx9Q75Tx3psmzviN3+thRtAxd5igMTIHGpslzdW
         +h2G69Xc3M2PVsAF8qQ8IBIAgpn5+PKjUDdjG7MCkH3bjAcp44IId/swcdFNrwAdr3
         J+wp4GRzQnIF5AmidL+R7istxqUb6DosKfu25Wz+TveVVXOBpLySocjIriEQOa8JT/
         bwm1MUQrVFrvA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lM7oz-0000xf-2v; Tue, 16 Mar 2021 12:25:09 +0100
Date:   Tue, 16 Mar 2021 12:25:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcan@marcan.st, arnd@kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
Message-ID: <YFCVldHS7CTf4j2f@hovoldconsulting.com>
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
 <YFB0OcBg3Vj555eA@hovoldconsulting.com>
 <7f348e4c-3051-13cf-d461-eeda0ef53fdd@canonical.com>
 <YFCA5jFLV0Cu9YNe@hovoldconsulting.com>
 <816834ba-8dc2-05cd-9c81-a11d65980cfd@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <816834ba-8dc2-05cd-9c81-a11d65980cfd@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 16, 2021 at 11:11:43AM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2021 10:56, Johan Hovold wrote:
> > On Tue, Mar 16, 2021 at 10:47:53AM +0100, Krzysztof Kozlowski wrote:
> >> On 16/03/2021 10:02, Johan Hovold wrote:
> >>> On Mon, Mar 15, 2021 at 07:12:12PM +0100, Krzysztof Kozlowski wrote:
> >>>> Since interrupt handler is called with disabled local interrupts, there
> >>>> is no need to use the spinlock primitives disabling interrupts as well.
> >>>
> >>> This isn't generally true due to "threadirqs" and that can lead to
> >>> deadlocks if the console code is called from hard irq context.
> >>>
> >>> Now, this is *not* the case for this particular driver since it doesn't
> >>> even bother to take the port lock in console_write(). That should
> >>> probably be fixed instead.
> >>>
> >>> See https://lore.kernel.org/r/X7kviiRwuxvPxC8O@localhost.
> >>
> >> Thanks for the link, quite interesting! For one type of device we have
> >> two interrupts (RX and TX) so I guess it's a valid point/risk. However
> >> let me try to understand it more.
> >>
> >> Assuming we had only one interrupt line, how this interrupt handler with
> >> threadirqs could be called from hardirq context?
> > 
> > No, it's console_write() which can end up being called in hard irq
> > context and if that path takes the port lock after the now threaded
> > interrupt handler has been preempted you have a deadlock.
> 
> Thanks, I understand now. I see three patterns shared by serial drivers:
> 
> 1. Do not take the lock in console_write() handler,
> 2. Take the lock like:
> if (port->sysrq)
>     locked = 0;
> else if (oops_in_progress)
>     locked = spin_trylock_irqsave(&port->lock, flags);
> else
>     spin_lock_irqsave(&port->lock, flags)
> 
> 3. Take the lock like above but preceded with local_irq_save().
> 
> It seems the choice of pattern depends which driver was used as a base.

Right, this is messy and we've been playing whack-a-mole with this for
years (as usual) it seems.

Some version of 2 above is probably what we want but the sysrq bits
aren't handled uniformly either (e.g. since 596f63da42b9 ("serial: 8250:
Process sysrq at port unlock time")).

Johan
