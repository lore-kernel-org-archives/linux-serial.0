Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59776C433DB
	for <linux-serial@archiver.kernel.org>; Wed, 17 Mar 2021 14:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F195064F5E
	for <linux-serial@archiver.kernel.org>; Wed, 17 Mar 2021 14:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhCQOAp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhCQOAP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Mar 2021 10:00:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 925C564F5E;
        Wed, 17 Mar 2021 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615989614;
        bh=OyS3oC04KBkh4JqkYzeeIdskNg7vnpTYMPs3/WweXD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3ibAKFDdkLJdciif5Qo6Ci0ePTyCmsgQD2Hb/gRIIcUAsy4qMK1LQQCwfBLWElQh
         rwFaHowNVQng/hAqvILNfRC38OJJwkSggGuR7m12nXy+67jR1ItyMtxuZttAbAcDJc
         ceRusiHWs5H8YiDQKjxRmP1ZwNapJeEHdx34+45mGZs+I5jOUCRfFKWupVy8IbZbXz
         xmmLzdWP3gci8iwm4JxsIu9iDDMyb4oOvOM5a+ueOiVYZlU117bF/2gzokjgx1UhEn
         hyQ+6BlYnil7GaUD3ZYuF0PVLp8WD6HMk/Dd5ptYw+aBMCKCuEOFOn/TQbMW31uwNS
         gxdil78fAY6AA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lMWiq-0001JR-PN; Wed, 17 Mar 2021 15:00:29 +0100
Date:   Wed, 17 Mar 2021 15:00:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: threadirqs deadlocks
Message-ID: <YFILfPT1SFypmOAj@hovoldconsulting.com>
References: <YFCO+FEjWPGytb2W@hovoldconsulting.com>
 <87eegdzzez.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eegdzzez.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 17, 2021 at 02:24:04PM +0100, Thomas Gleixner wrote:

> On Tue, Mar 16 2021 at 11:56, Johan Hovold wrote:

> > It seems to me that forced interrupt threading cannot generally work
> > without updating drivers that expose locks that can be taken by other
> > interrupt handlers, for example, by using spin_lock_irqsave() in their
> > interrupt handlers or marking their interrupts as IRQF_NO_THREAD.
> 
> The latter is the worst option because that will break PREEMPT_RT.
> 
> > What are your thoughts on this given that forced threading isn't that
> > widely used and was said to be "mostly a debug option". Do we need to
> > vet all current and future drivers and adapt them for "threadirqs"?
> >
> > Note that we now have people sending cleanup patches for interrupt
> > handlers by search-and-replacing spin_lock_irqsave() with spin_lock()
> > which can end up exposing this more.
> 
> It's true that for !RT it's primarily a debug option, but occasionaly a
> very valuable one because it does not take the whole machine down when
> something explodes in an interrupt handler. Used it just a couple of
> weeks ago successfully :)
> 
> So we have several ways out of that:
> 
>   1) Do the lock() -> lock_irqsave() dance
> 
>   2) Delay printing from hard interrupt context (which is what RT does)

While this is probably mostly an issue for console drivers, the problem
is more general and we'd need to identify and add workarounds for any
lock that could be taken by a second interrupt handler.

>   3) Actually disable interrupts before calling the force threaded
>      handler.
> 
> I'd say #3 is the right fix here. It's preserving the !RT semantics
> and the usefulness of threadirqs for debugging and spare us dealing with
> the script kiddies.

I was hoping you'd say that. :) Just wasn't sure whether it would
cripple threadirqs too much.

> Something like the below.

Looks good to me. Do you want to spin that into a patch or shall I do
it after some testing?

Johan
