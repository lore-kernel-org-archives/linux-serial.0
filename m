Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916B0C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 17 Mar 2021 13:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FC264F45
	for <linux-serial@archiver.kernel.org>; Wed, 17 Mar 2021 13:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCQNYW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:24:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhCQNYF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Mar 2021 09:24:05 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615987444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FsC2NWZVyQTIHkn6v/zVO7fICB/cBhGynvclYmJUo2Y=;
        b=xNYt07/nHp4zDi8WV0B2YyirsX6XPCgCBqR5YbIbwcXWm2vpjSHGw1ASHSlI6O6z4XjGL8
        UGlucQzh30nXIzOE99S8tb1FIr/nzSQmeCYKPUeq+GwZBZNafCcI94FN9cA37Li+uTyGnp
        luk48zJCwfw45bajZb1YCX6sRL0xHiGD+Gg8d7HNwmnpuCx+FgPcz1jIyc4ByZwxRyeyez
        HZZ0bOkFCaKrgA+8VSmrofOMdM+UUnSY43OpysikJ54ARvTcofgA7Ot6pApLI69Ty0zbt8
        rmjek/wds0ZoyhAKj3xSHqv35qO/HQFlwJd+yaxirr1m/DQTrYRhFEKQ0O4Yfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615987444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FsC2NWZVyQTIHkn6v/zVO7fICB/cBhGynvclYmJUo2Y=;
        b=vUCaLIQPEVZuiZXfKWwaKAJcVBlSNPBEoQN+1L9JN4jFj2z6ec3vps9E748SyE7u/egxXU
        yUDySZQKQSKPj6Dg==
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: threadirqs deadlocks
In-Reply-To: <YFCO+FEjWPGytb2W@hovoldconsulting.com>
References: <YFCO+FEjWPGytb2W@hovoldconsulting.com>
Date:   Wed, 17 Mar 2021 14:24:04 +0100
Message-ID: <87eegdzzez.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Johan,

On Tue, Mar 16 2021 at 11:56, Johan Hovold wrote:
> We've gotten reports of lockdep splats correctly identifying a potential
> deadlock in serial drivers when running with forced interrupt threading.
>
> Typically, a serial driver takes the port spin lock in its interrupt
> handler, but unless also disabling interrupts the handler can be
> preempted by another interrupt which can end up calling printk. The
> console code takes then tries to take the port lock and we deadlock.
>
> It seems to me that forced interrupt threading cannot generally work
> without updating drivers that expose locks that can be taken by other
> interrupt handlers, for example, by using spin_lock_irqsave() in their
> interrupt handlers or marking their interrupts as IRQF_NO_THREAD.

The latter is the worst option because that will break PREEMPT_RT.

> What are your thoughts on this given that forced threading isn't that
> widely used and was said to be "mostly a debug option". Do we need to
> vet all current and future drivers and adapt them for "threadirqs"?
>
> Note that we now have people sending cleanup patches for interrupt
> handlers by search-and-replacing spin_lock_irqsave() with spin_lock()
> which can end up exposing this more.

It's true that for !RT it's primarily a debug option, but occasionaly a
very valuable one because it does not take the whole machine down when
something explodes in an interrupt handler. Used it just a couple of
weeks ago successfully :)

So we have several ways out of that:

  1) Do the lock() -> lock_irqsave() dance

  2) Delay printing from hard interrupt context (which is what RT does)

  3) Actually disable interrupts before calling the force threaded
     handler.

I'd say #3 is the right fix here. It's preserving the !RT semantics
and the usefulness of threadirqs for debugging and spare us dealing with
the script kiddies.

Something like the below.

Thanks,

        tglx
---
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1142,11 +1142,15 @@ irq_forced_thread_fn(struct irq_desc *de
 	irqreturn_t ret;
 
 	local_bh_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
 	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
 		atomic_inc(&desc->threads_handled);
 
 	irq_finalize_oneshot(desc, action);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_enable();
 	local_bh_enable();
 	return ret;
 }
