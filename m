Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BACC433E6
	for <linux-serial@archiver.kernel.org>; Wed, 17 Mar 2021 14:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9533664F45
	for <linux-serial@archiver.kernel.org>; Wed, 17 Mar 2021 14:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhCQOs2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:48:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50730 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhCQOsL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Mar 2021 10:48:11 -0400
Date:   Wed, 17 Mar 2021 15:48:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615992488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcMlrKQ8yLRxCoVIgpBVBSN2kwxzf9diVPyknQVta9o=;
        b=IG3t8ezX8AvUbDdi/Pw5dRrQx3ad0//I5eoJt0m1cKJaxMf8BjMA+Zo+y555RznMurTlIy
        DYJThR4DKi97LS/qsOktQejkLcpS6koR4CcWPGKl3VOCplhODtf6quadRjyz0ftfYTZdV7
        nCbi4PHxL9Pf3oxMGjuMqi935Mk/UB6nVnk6d518B1z/y1lBvlx2Z/BziWlJXa3swVrOR7
        mI5R3iGyuSSO96uG2hlrfDGbbOTishiOFT66JX7cuiCAA9A0PeUoIsKF/M695yZ6l64HVH
        SFmcFA7DkTCEb4dmqS/JHXbDHfsh/KQFZc4gPp53BYd/QbDhpgpYqEUuY2Yd5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615992488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcMlrKQ8yLRxCoVIgpBVBSN2kwxzf9diVPyknQVta9o=;
        b=YIpms+a1JKZJ5iTHxjcj6IZwqNgVxnZec8CSRPyNPui1WoqVF9PMNCBWykdUIWOyasL0ik
        opFS+5FHRVQLijBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org
Subject: Re: [patch 1/1] genirq: Disable interrupts for force threaded
 handlers
Message-ID: <20210317144806.y4dogv6n2s62fpnw@linutronix.de>
References: <20210317143859.513307808@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210317143859.513307808@linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-03-17 15:38:52 [+0100], Thomas Gleixner wrote:
> With interrupt force threading all device interrupt handlers are invoked
> from kernel threads. Contrary to hard interrupt context the invocation only
> disables bottom halfs, but not interrupts. This was an oversight back then
> because any code like this will have an issue:
> 
> thread(irq_A)
>   irq_handler(A)
>     spin_lock(&foo->lock);
> 
> interrupt(irq_B)
>   irq_handler(B)
>     spin_lock(&foo->lock);

It will not because both threads will wake_up(thread). It is an issue if
- if &foo->lock is shared between a hrtimer and threaded-IRQ
- if &foo->lock is shared between a non-threaded and thread-IRQ
- if &foo->lock is shared between a printk() in hardirq context and
  thread-IRQ as I learned today.

> This has been triggered with networking (NAPI vs. hrtimers) and console
> drivers where printk() happens from an interrupt which interrupted the
> force threaded handler.
> 
> Now people noticed and started to change the spin_lock() in the handler to
> spin_lock_irqsave() which affects performance or add IRQF_NOTHREAD to the
> interrupt request which in turn breaks RT.
> 
> Fix the root cause and not the symptom and disable interrupts before
> invoking the force threaded handler which preserves the regular semantics
> and the usefulness of the interrupt force threading as a general debugging
> tool.
> 
> For not RT this is not changing much, except that during the execution of
> the threaded handler interrupts are delayed until the handler
> returns. Vs. scheduling and softirq processing there is no difference.
> 
> For RT kernels there is no issue.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Fixes: 8d32a307e4fa ("genirq: Provide forced interrupt threading")
> Reported-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: netdev <netdev@vger.kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-serial@vger.kernel.org
> Cc: netdev <netdev@vger.kernel.org>
> ---
>  kernel/irq/manage.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1142,11 +1142,15 @@ irq_forced_thread_fn(struct irq_desc *de
>  	irqreturn_t ret;
>  
>  	local_bh_disable();
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		local_irq_disable();
>  	ret = action->thread_fn(action->irq, action->dev_id);
>  	if (ret == IRQ_HANDLED)
>  		atomic_inc(&desc->threads_handled);
>  
>  	irq_finalize_oneshot(desc, action);
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		local_irq_enable();
>  	local_bh_enable();
>  	return ret;
>  }

Sebastian
