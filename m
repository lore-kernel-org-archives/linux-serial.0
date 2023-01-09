Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1382C54EBD
	for <linux-serial@archiver.kernel.org>; Mon,  9 Jan 2023 10:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbjAIKOg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Jan 2023 05:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbjAIKOE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Jan 2023 05:14:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C1654E
        for <linux-serial@vger.kernel.org>; Mon,  9 Jan 2023 02:13:18 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:13:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673259197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFnYGz3uQ0ZPdkPZZNuXygm5ApMSSYWsgWYIkJd8NV8=;
        b=ceZrPFWU0BKTEN6iDyiA4MEYP4eYct7mjuR6n90DIua8FM3wgxVMaKSPhj2+aS/P0pV7X+
        0C0qDGz8wGCS8NYu35iQxlDAU9GwrmtagxVOFKjUQNYd5qyfR2lmizjx3hR5dqkvDPWXne
        TGGXdFhE560wYuDmLNmogcnSWp0CDuHSsoWh6Y07gtmw8CKFBUEUdZ/gJf7LByHxCeqCq8
        W8KXoF4hDvmVeUW3NfYE0kUOfxx36iX3JyATF50wE+C7r680ZaJUNCpc9GeNZccFW7OnHG
        zt9fBA/snsuBOwmRiXWY5PVpfUy/LXKYAPGzKuu5qoV9Kyjl9o6qB9RNO46X1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673259197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFnYGz3uQ0ZPdkPZZNuXygm5ApMSSYWsgWYIkJd8NV8=;
        b=flPEUkggKxOeUluO3V4bQQVDLUaQy8YQatp726WllHL4rmlWtB1n9mhc45txPwJ2fnljod
        wxhFrpOyHU34TiDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marek Vasut <marex@denx.de>, linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Message-ID: <Y7vou3wAeLP4X+TY@linutronix.de>
References: <20221216115338.7150-1-marex@denx.de>
 <Y6sHr5kuxUoahlzJ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6sHr5kuxUoahlzJ@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-12-27 15:56:47 [+0100], Johan Hovold wrote:
> On Fri, Dec 16, 2022 at 12:53:38PM +0100, Marek Vasut wrote:
> > Requesting an interrupt with IRQF_ONESHOT will run the primary handler
> > in the hard-IRQ context even in the force-threaded mode. The
> > force-threaded mode is used by PREEMPT_RT in order to avoid acquiring
> > sleeping locks (spinlock_t) in hard-IRQ context. This combination
> > makes it impossible and leads to "sleeping while atomic" warnings.
> > 
> > Use one interrupt handler for both handlers (primary and secondary)
> > and drop the IRQF_ONESHOT flag which is not needed.
> > 
> > Fixes: e359b4411c283 ("serial: stm32: fix threaded interrupt handling")
> 
> I don't think a Fixes tag is warranted as this is only needed due to
> this undocumented quirk of PREEMPT_RT.

It is not an undocumented quirk of PREEMPT_RT. The part that might not
be well documented is that IRQF_ONESHOT won't run the primary handler as
a threaded handler. This is also the case for IRQF_NO_THREAD and
IRQF_PERCPU but might be more obvious.
Anyway, if the primary handler is not threaded then it runs in HARDIRQ
context and here you must not use a spinlock_t. This is documented in
Documentation/locking/locktypes.rst and there is also a LOCKDEP warning
for this on !RT which is off by default because it triggers with printk
(and this is worked on).

> And this should not be backported in any case.

Such things have been backported via -stable in the past. If you
disagree, please keep me in loop while is merged so I can poke people to
backport it as part of the RT patch for the relevant kernels.

> Johan

Sebastian
