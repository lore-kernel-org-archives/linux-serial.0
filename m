Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6769DC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 16 Dec 2022 08:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLPIAV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Dec 2022 03:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPIAU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Dec 2022 03:00:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F67B1B
        for <linux-serial@vger.kernel.org>; Fri, 16 Dec 2022 00:00:16 -0800 (PST)
Date:   Fri, 16 Dec 2022 09:00:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671177614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=haMrg3cSn4JG+JIsDhxYwfXeGVpv9hVWuMvV7CLbK+E=;
        b=xfymhPfW2NUsIsIF4o18XwKxr4oqo/bl2bMzWTVFTa4NJT12HI6dSHRBhuetZEqd82mKYo
        ufiKeBAMKdSYCFcGs8PDj8KjErpJS3dPEo5XKjUQhadBv57biYKI0JKIeGJ3ffbIEP/apQ
        7fC63ZV17EpvMTSyd+odq0GaBcDwIsAjDX2KptI75IZzDVPO1CBzRNTHazZuAqTgbFxN+Y
        n1Qcmw/2KndklrR3uV3Z58emtNGaKDvu8fgQPWd+5BkP7hA8EgbDigrV2s0agEzw4jp1ZC
        gFZc3y2UtmL6Grre2N7XmWiBe9CLU4q3NFGnKqFXzN6CGe3gOz1nGmGDeGIJ5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671177614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=haMrg3cSn4JG+JIsDhxYwfXeGVpv9hVWuMvV7CLbK+E=;
        b=5TtzE+xaSu1JFFgyFJuLWjat+xCCfbN7ald+pvMR15sPgkOGbK0RAFXEX06PPaADg02M0z
        p9Kh3ma473n134CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Message-ID: <Y5wljLfx4bj1R9kl@linutronix.de>
References: <20221216021504.457699-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221216021504.457699-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-12-16 03:15:04 [+0100], Marek Vasut wrote:
> Avoid locking in hard interrupt context, move the entirety of hard IRQ
> context code into single IRQ handler, preempt-rt would move the handler
> into thread. This fixes the following splat with preempt-rt enabled:
> 
>  BUG: scheduling while atomic: (mount)/1289/0x00010001
>  Modules linked in:
>  Preemption disabled at:
>  [<c0119127>] irq_enter_rcu+0xb/0x42
>  CPU: 0 PID: 1289 Comm: (mount) Not tainted 6.1.0-rc7-rt5-stable-standard-00006-gd70aeccb9f0f #17
>  Hardware name: STM32 (Device Tree Support)
>   unwind_backtrace from show_stack+0xb/0xc
>   show_stack from dump_stack_lvl+0x2b/0x34
>   dump_stack_lvl from __schedule_bug+0x53/0x80
>   __schedule_bug from __schedule+0x47/0x404
>   __schedule from schedule_rtlock+0x15/0x34
>   schedule_rtlock from rtlock_slowlock_locked+0x1d7/0x57e
>   rtlock_slowlock_locked from rt_spin_lock+0x29/0x3c
>   rt_spin_lock from stm32_usart_interrupt+0xa9/0x110
>   stm32_usart_interrupt from __handle_irq_event_percpu+0x73/0x14e
>   __handle_irq_event_percpu from handle_irq_event_percpu+0x9/0x22
>   handle_irq_event_percpu from handle_irq_event+0x53/0x76
>   handle_irq_event from handle_fasteoi_irq+0x65/0xa8
>   handle_fasteoi_irq from handle_irq_desc+0xf/0x18
>   handle_irq_desc from gic_handle_irq+0x45/0x54
>   gic_handle_irq from generic_handle_arch_irq+0x19/0x2c
>   generic_handle_arch_irq from call_with_stack+0xd/0x10

Could this be replaced maybe with a proper description instead of
slapping the backtrace into the patch description?

  Requesting an interrupt with IRQF_ONESHOT will run the primary handler
  in the hard-IRQ context even in the force-threaded mode. The
  force-threaded mode is used by PREEMPT_RT in order to avoid acquiring
  sleeping locks (spinlock_t) in hard-IRQ context. This combination
  makes it impossible and leads to "sleeping while atomic" warnings.

  Use one interrupt handler for both handlers (primary and secondary)
  and drop the IRQF_ONESHOT flag which is not needed.

  Fixes: e359b4411c283 ("serial: stm32: fix threaded interrupt handling")

As for your change, this should work.
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Should this DMA-mode need to be outsourced (due to $REASON) you can
request two handlers but then you need to avoid IRQF_ONESHOT and the
primary handler needs to disable the interrupt source in the UART
hardware.

Also it might be worth checking if the DMA mode makes any sense if the
FIFO is so small.

> Signed-off-by: Marek Vasut <marex@denx.de>

Sebastian
